indexing

	description:

		"Objects that filter an event stream according to an XPointer"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2009-01-23 22:42:51 +0100 (Fri, 23 Jan 2009) $"
	revision: "$Revision: 6579 $"

class XM_XPOINTER_EVENT_FILTER

inherit

	XM_DTD_CALLBACKS_FILTER
		rename
			make_null as make_dtd_null,
			set_next as set_next_dtd,
			next as dtd_callbacks
		redefine
			on_attribute_declaration
		end

	XM_CALLBACKS_FILTER
		rename
			make_null as make_filter_null,
			set_next as set_next_filter,
			next as callbacks
		redefine
			on_start, on_finish, on_processing_instruction, on_comment, on_start_tag,
			on_attribute, on_start_tag_finish, on_end_tag, on_content
		end

	XM_MARKUP_CONSTANTS

	KL_IMPORTED_STRING_ROUTINES

	UC_SHARED_STRING_EQUALITY_TESTER

	UT_SHARED_MEDIA_TYPE_EQUALITY_TESTER

	-- TODO: Extend the filter to accept element() scheme. (?)

create

	make

feature {NONE} -- Initialization

	make (an_xpointer: STRING; a_media_type: UT_MEDIA_TYPE; a_resolver: XM_RESOLVER_MEDIA_TYPE; a_callback: XM_CALLBACKS; a_dtd_callback: XM_DTD_CALLBACKS) is
			-- Establish invariant.
		require
			xpointer_not_void: an_xpointer /= Void
			callbacks_not_void: a_callback /= Void
			dtd_callbacks_not_void: a_dtd_callback /= Void
			resolver_not_void: a_resolver /= Void
		do
			default_media_type := a_media_type
			set_next_filter (a_callback)
			set_next_dtd (a_dtd_callback)
			if an_xpointer.count > 0 then
				set_xpointer (an_xpointer)
			else
				set_no_filtering
			end
			resolver := a_resolver
		ensure
			resolver_set: resolver = a_resolver
			default_media_type_set: default_media_type = a_media_type
		end

feature -- Access

	media_type: ?UT_MEDIA_TYPE
		-- Media type of document entity

	Unacceptable_media_type: STRING is "Media type is not acceptable for fragment processing"
			-- Unaaceptable media type error message

feature -- Status report

	is_filtering: BOOLEAN
			-- Are we actually doing any XPointer filtering?

	has_media_type (a_media_type: ?UT_MEDIA_TYPE): BOOLEAN is
			-- Is `a_media_type' acceptable for fragment processing?
		require
			filtering: is_filtering
			media_type_not_void: a_media_type /= Void
		local
			l_acceptable_media_types: like acceptable_media_types
		do
			l_acceptable_media_types := acceptable_media_types
			check l_acceptable_media_types /= Void end -- implied by `is_filtering'
			Result := l_acceptable_media_types.has (a_media_type)
		end

	any_types_added: BOOLEAN is
			-- Have any acceptable media types been declared?
		require
			filtering: is_filtering
		local
			l_acceptable_media_types: like acceptable_media_types
		do
			l_acceptable_media_types := acceptable_media_types
			check l_acceptable_media_types /= Void end -- implied by `is_filtering'
			Result := l_acceptable_media_types.count > 0
		end

	generic_xml_types_allowed: BOOLEAN
			-- Are media types of form "application/*+xml" allowed?

	are_media_type_ignored: BOOLEAN
			-- Do we ignore the media type?

feature -- Status setting

	set_no_filtering is
			-- Change this into a pure pass-through filter.
		do
			is_filtering := False
			is_error := False
			attribute_types := Void
			acceptable_media_types := Void
		ensure
			not_filtering: not is_filtering
		end

	set_xpointer (an_xpointer: STRING) is
			-- Use `an_xpointer' as the XPointer.
		require
			xpointer_not_void: an_xpointer /= Void
		local
			a_parser: XM_XPOINTER_PARSER
			l_acceptable_media_types: like acceptable_media_types
		do
			is_error := False
			create a_parser.make
			a_parser.parse (an_xpointer)
			if a_parser.is_error or else not a_parser.is_shorthand then
				is_error := True
				error_message := STRING_.concat (an_xpointer, " is not a shorthand pointer")
			else
				shorthand := a_parser.shorthand
			end
			create attribute_types.make_with_equality_testers (7, Void, string_equality_tester)
			is_filtering := True
			create l_acceptable_media_types.make_default
			acceptable_media_types := l_acceptable_media_types
			l_acceptable_media_types.set_equality_tester (media_type_tester)
			are_media_type_ignored := False
			create namespace_bindings_stack.make
		ensure
			filtering: is_filtering
			acceptable_media_types_table_created: acceptable_media_types /= Void
			media_types_not_ignored: are_media_type_ignored = False
			attribute_types_not_void: attribute_types /= Void
			namespace_bindings_stack_not_void: namespace_bindings_stack /= Void
		end

	add_media_type (a_media_type: UT_MEDIA_TYPE) is
			-- Add `a_media_type' to list of acceptable media types
		require
			filtering: is_filtering
			media_type_not_void: a_media_type /= Void
			not_previously_added: not has_media_type (a_media_type)
		local
			l_acceptable_media_types: like acceptable_media_types
		do
			l_acceptable_media_types := acceptable_media_types
			check l_acceptable_media_types /= Void end -- implied by `is_filtering'
			l_acceptable_media_types.force_new (a_media_type)
		ensure
			media_type_added: has_media_type (a_media_type)
		end

	add_standard_media_types is
			-- Add standard XPointer media types to list of acceptable media types
		require
			filtering: is_filtering
			no_acceptable_types: not any_types_added
		local
			a_media_type: UT_MEDIA_TYPE
		do
			create a_media_type.make ("text", "xml")
			add_media_type (a_media_type)
			create a_media_type.make ("text", "xml-external-parsed-entity")
			add_media_type (a_media_type)
			create a_media_type.make ("application", "xml")
			add_media_type (a_media_type)
			create a_media_type.make ("application", "xml-external-parsed-entity")
			add_media_type (a_media_type)
			create a_media_type.make ("application", "xhtml+xml")
			add_media_type (a_media_type)
			create a_media_type.make ("application", "xslt+xml")
			add_media_type (a_media_type)
		end

	allow_generic_xml_types (yes_or_no: BOOLEAN) is
			-- Allow or disallow all media types of form "application/*+xml"
		require
			filtering: is_filtering
		do
			generic_xml_types_allowed := yes_or_no
		ensure
			generic_types_set: generic_xml_types_allowed = yes_or_no
		end

	ignore_media_types is
			-- Ignore `media_type'.
		require
			filtering: is_filtering
		do
			are_media_type_ignored := True
		ensure
			media_types_ignored: are_media_type_ignored = True
		end

feature -- Document type definition callbacks

	on_attribute_declaration (an_element_name, a_name: STRING; a_model: XM_DTD_ATTRIBUTE_CONTENT) is
			-- Attribute declaration, one event per attribute.
		local
			an_attribute_table: ?DS_HASH_TABLE [XM_DTD_ATTRIBUTE_CONTENT, STRING]
			a_message: STRING
			l_attribute_types: like attribute_types
		do
			if is_filtering then
				l_attribute_types := attribute_types
				check l_attribute_types /= Void end -- implied by `is_filtering'
				if not l_attribute_types.has (an_element_name) then
					create an_attribute_table.make_with_equality_testers (7, Void, string_equality_tester)
					l_attribute_types.force_new (an_attribute_table, an_element_name)
				end
				an_attribute_table := l_attribute_types.item (an_element_name)
				check
					attribute_table_not_void: an_attribute_table /= Void
					-- because has() returned `True'
				end
				if an_attribute_table.has (a_name) then
					a_message := "Attribute "
					a_message.append_string (a_name)
					a_message.append_string (" already present for element ")
					a_message.append_string (an_element_name)
					on_error (a_message)
				else
					an_attribute_table.force_new (a_model, a_name)
				end
			end
			Precursor (an_element_name, a_name, a_model)
		end

feature -- Document

	on_start is
			-- Called when parsing starts.
		local
			ok_to_filter: BOOLEAN
			l_error_message: like error_message
			l_media_type: like media_type
		do
			if resolver.has_media_type then
				l_media_type := resolver.last_media_type
			else
				l_media_type := default_media_type -- which may still be `Void'
			end
			media_type := l_media_type
			if is_filtering then
				is_forwarding := False
				is_forwarding_processing_instructions := True
				is_shorthand_found := False
				if is_error then
					l_error_message := error_message
					check l_error_message /= Void end -- implied by `is_error' and invariant `is_error_with_message'
					on_error (l_error_message)
				else
					ok_to_filter := are_media_type_ignored
					if not ok_to_filter then
						l_media_type := media_type --| Should not be needed to reaccess attribute, but let's be safe
						if l_media_type /= Void then
							if has_media_type (l_media_type) then
								ok_to_filter := True
							elseif generic_xml_types_allowed then
								if l_media_type.subtype.count > 4 and then STRING_.same_string (l_media_type.type, "application") then
									ok_to_filter := STRING_.same_string (l_media_type.subtype.substring (l_media_type.subtype.count - 4, l_media_type.subtype.count), "+xml")
								end
							end
						end
					end
					if ok_to_filter then
						Precursor

						-- We forward comments PIs prior to the document element,
						--  as they might be needed for other purposes.

						is_forwarding := True
					else
						is_error := True
						l_error_message := Unacceptable_media_type
						error_message := l_error_message
						on_error (l_error_message)
					end
				end
			else
				Precursor
			end
		end

	on_finish is
			-- Called when parsing finished
		do
			if not is_error then Precursor end
			is_shorthand_found := False
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING) is
			-- Processing instruction.
		do

			-- Processing Instructions prior to the document element, and those within
			--  the selected element, will not be filtered out.

			if not is_filtering or else (is_forwarding_processing_instructions and then not is_error) then
				Precursor (a_name, a_content)
			end
		end

	on_comment (a_content: STRING) is
			-- Processing a comment.
		do
			if not is_filtering or else (is_forwarding and then is_shorthand_found and then not is_error) then
				Precursor (a_content)
			end
		end

feature -- Tag

	on_start_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- Start of start tag.
		local
			l_element_qname, l_prefix: STRING
			l_namespace_bindings_stack: like namespace_bindings_stack
			l_namespace_bindings: like namespace_bindings
		do
			if is_filtering then
				is_forwarding_processing_instructions := is_forwarding
				if not is_shorthand_found or is_shorthand_element then
					create l_namespace_bindings.make
					namespace_bindings := l_namespace_bindings
					l_namespace_bindings_stack := namespace_bindings_stack
					check l_namespace_bindings_stack /= Void end -- implied by `is_filtering'
					l_namespace_bindings_stack.put (l_namespace_bindings)
				end
			end
			if not is_filtering then
				Precursor (a_namespace, a_prefix, a_local_part)
			elseif not is_error then
				pending_namespace := Void
				pending_prefix := Void
				pending_local_part := Void
				if not is_shorthand_found then
					if a_prefix = Void then
						l_prefix := ""
					else
						l_prefix := a_prefix
					end
					is_forwarding := False; is_forwarding_processing_instructions := False
					pending_namespace := a_namespace
					pending_prefix := a_prefix
					pending_local_part := a_local_part
					create pending_attribute_namespaces.make
					create pending_attribute_prefixes.make
					create pending_attribute_local_parts.make
					create pending_attribute_values.make
					if l_prefix.count = 0 then
						l_element_qname := a_local_part
					else
						l_element_qname := STRING_.cloned_string (l_prefix)
						l_element_qname := STRING_.appended_string (l_element_qname, ":")
						l_element_qname := STRING_.appended_string (l_element_qname, a_local_part)
					end
					current_element_name := l_element_qname
				elseif is_forwarding then
					Precursor (a_namespace, a_prefix, a_local_part)
				end
			end
		end

	on_attribute (a_namespace, a_prefix: ?STRING; a_local_part: STRING; a_value: STRING) is
			-- Start of attribute.
		local
			an_attribute_table: ?DS_HASH_TABLE [XM_DTD_ATTRIBUTE_CONTENT, STRING]
			an_attribute_model: XM_DTD_ATTRIBUTE_CONTENT
			an_attribute_qname, an_xml_prefix: STRING
			l_shorthand: like shorthand
			l_pending_local_part: like pending_local_part
			l_pending_attribute_namespaces: like pending_attribute_namespaces
			l_pending_attribute_prefixes: like pending_attribute_prefixes
			l_pending_attribute_values: like pending_attribute_values
			l_pending_attribute_local_parts: like pending_attribute_local_parts
			l_namespace_bindings: like namespace_bindings
			l_attribute_types: like attribute_types
			l_current_element_name: like current_element_name
		do
			if is_filtering and (not is_shorthand_found or is_shorthand_element) then
				l_namespace_bindings := namespace_bindings
				check l_namespace_bindings /= Void end -- implied by previous condition
				if a_namespace = Void and a_prefix = Void and STRING_.same_string (Xmlns, a_local_part) then
					l_namespace_bindings.bind ("", a_value)
				elseif a_namespace = Void and a_prefix /= Void and then STRING_.same_string (Xmlns, a_prefix) then
					l_namespace_bindings.bind (a_local_part, a_value)
				end
			end
			if not is_filtering or else is_forwarding then
				Precursor (a_namespace, a_prefix, a_local_part, a_value)
			elseif not is_error and then not is_shorthand_found then
				if a_prefix /= Void and then Xml_prefix.is_equal (a_prefix) and then Xml_id.is_equal (a_local_part) then
					l_shorthand := shorthand
					is_shorthand_found := l_shorthand /= Void and then STRING_.same_string (l_shorthand, a_value)
					if is_shorthand_found then
						is_shorthand_element := True
					end
				else
					l_attribute_types := attribute_types
					check l_attribute_types /= Void end -- implied by `is_filtering' (and logical)
					l_current_element_name := current_element_name
					check l_current_element_name /= Void end -- implied by being in `on_attribute'
					if l_attribute_types.has (l_current_element_name) then
						an_attribute_table := l_attribute_types.item (l_current_element_name)
						check
							attribute_table_not_void: an_attribute_table /= Void
							-- because `has' returned `True'
						end
						if a_prefix = Void then
							an_xml_prefix := ""
						else
							an_xml_prefix := a_prefix
						end
						if an_xml_prefix.count = 0 then
							an_attribute_qname := STRING_.cloned_string (a_local_part)
						else
							an_attribute_qname := STRING_.cloned_string (an_xml_prefix)
							an_attribute_qname := STRING_.appended_string (an_attribute_qname, ":")
							an_attribute_qname := STRING_.appended_string (an_attribute_qname, a_local_part)
						end
						if an_attribute_table.has (an_attribute_qname) then
							an_attribute_model := an_attribute_table.item (an_attribute_qname)
							check
								attribute_model_not_void: an_attribute_model /= Void
								-- because `has' returned `True'
							end
							if an_attribute_model.is_id then
								l_shorthand := shorthand
								is_shorthand_found := l_shorthand /= Void and then STRING_.same_string (l_shorthand, a_value)
								if is_shorthand_found then
									is_shorthand_element := True
								end
							end
						end
					end
				end
				l_pending_attribute_namespaces := pending_attribute_namespaces
				l_pending_attribute_prefixes := pending_attribute_prefixes
				l_pending_attribute_values := pending_attribute_values
				l_pending_attribute_local_parts := pending_attribute_local_parts
				check
					l_pending_attribute_namespaces /= Void and
					l_pending_attribute_values /= Void and
					l_pending_attribute_local_parts /= Void and
					l_pending_attribute_prefixes /= Void
				end -- implied by `not is_error'

				if is_shorthand_found then
					is_forwarding := True
					l_pending_local_part := pending_local_part
					check l_pending_local_part /= Void end -- implied by `not is_error'
					on_start_tag (pending_namespace, pending_prefix, l_pending_local_part)
					from
					until
						l_pending_attribute_namespaces.is_empty
					loop
						on_attribute (l_pending_attribute_namespaces.item, l_pending_attribute_prefixes.item, l_pending_attribute_local_parts.item, l_pending_attribute_values.item)
						l_pending_attribute_namespaces.remove; l_pending_attribute_prefixes.remove; l_pending_attribute_local_parts.remove; l_pending_attribute_values.remove
					end
					Precursor (a_namespace, a_prefix, a_local_part, a_value)
				else
					l_pending_attribute_namespaces.force (a_namespace)
					l_pending_attribute_prefixes.force (a_prefix)
					l_pending_attribute_local_parts.force (a_local_part)
					l_pending_attribute_values.force (a_value)
				end
			end
		end

	on_start_tag_finish is
			-- End of start tag.
		local
			l_namespaces: XM_XPOINTER_NAMESPACE_CONTEXT
			l_cursor: DS_HASH_TABLE_CURSOR [STRING, STRING]
			l_prefix, l_uri: STRING
			l_namespace_bindings_stack: like namespace_bindings_stack
		do
			if is_shorthand_element then
				l_namespace_bindings_stack := namespace_bindings_stack
				check l_namespace_bindings_stack /= Void end -- implied by the fact is_shorthand_found can be True only if `is_filtering'  FIXME:jfiat
				l_namespaces := l_namespace_bindings_stack.item
				from
					l_namespace_bindings_stack.remove
				until
					l_namespace_bindings_stack.is_empty
				loop
					l_cursor := l_namespace_bindings_stack.item.namespace_cursor
					from l_cursor.start until l_cursor.after loop
						l_prefix := l_cursor.key
						l_uri := l_cursor.item
						if not l_namespaces.is_prefix_declared (l_prefix) then
							if l_prefix.is_empty then
								on_attribute (Void, Void, Xmlns, l_uri)
							else
								on_attribute (Void, Xmlns, l_prefix, l_uri)
							end
						end
						l_cursor.forth
					end
					l_namespace_bindings_stack.remove
				end
			end
			if not is_filtering or else is_forwarding then Precursor end
		end

	on_end_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- End tag.
		local
			an_element_qname, an_xml_prefix: STRING
			l_current_element_name: like current_element_name
			l_namespace_bindings_stack: like namespace_bindings_stack
		do
			if not is_filtering then
				Precursor (a_namespace, a_prefix, a_local_part)
			else
				if not is_shorthand_found then
					l_namespace_bindings_stack := namespace_bindings_stack
					check l_namespace_bindings_stack /= Void end -- implied by `is_filtering'
					l_namespace_bindings_stack.remove
				end
				if is_forwarding then
					Precursor (a_namespace, a_prefix, a_local_part)
					if a_prefix = Void then
						an_xml_prefix := ""
					else
						an_xml_prefix := a_prefix
					end
					if an_xml_prefix.count = 0 then
						an_element_qname := a_local_part
					else
						an_element_qname := STRING_.cloned_string (an_xml_prefix)
						an_element_qname := STRING_.appended_string (an_element_qname, ":")
						an_element_qname := STRING_.appended_string (an_element_qname, a_local_part)
					end
					l_current_element_name := current_element_name
					check l_current_element_name /= Void end -- implied by being in `on_end_tag'
					if STRING_.same_string (an_element_qname, l_current_element_name) then
						is_forwarding := False
						is_forwarding_processing_instructions := False
					end
				end
			end
			is_shorthand_element := False
		end

feature -- Content

	on_content (a_content: STRING) is
			-- Text content.
		do
			if not is_filtering or else is_forwarding then Precursor (a_content) end
		end

feature {NONE} -- Implementation

	error_message: ?STRING
			-- Error message from XPointer processing

	attribute_types: ?DS_HASH_TABLE [DS_HASH_TABLE [XM_DTD_ATTRIBUTE_CONTENT, STRING], STRING]
			-- Stored attribute-type definitions per element name

	current_element_name: ?STRING
			-- QName of the current element;
			-- Used for tracking attribute types

	pending_namespace, pending_prefix, pending_local_part: ?STRING
			-- Start tag of shorthand element

	pending_attribute_namespaces: ?DS_LINKED_QUEUE [?STRING]
			-- Namespaces of pending attributes


	pending_attribute_prefixes: ?DS_LINKED_QUEUE [?STRING]
			-- prefixes of pending attributes


	pending_attribute_local_parts: ?DS_LINKED_QUEUE [STRING]
			-- Local parts of pending attributes

	pending_attribute_values: ?DS_LINKED_QUEUE [STRING]
			-- Values of pending attributes

	default_media_type: UT_MEDIA_TYPE
			-- Media type to use if resolver does not provide it

	resolver: XM_RESOLVER_MEDIA_TYPE
			-- Resolver for media type

	shorthand: ?STRING
			-- parsed shorthand pointer

	is_forwarding, is_forwarding_processing_instructions: BOOLEAN
			-- Are we forwarding non-DTD events?

	is_shorthand_found: BOOLEAN
			-- Have we found the shorthand element?

	is_shorthand_element: BOOLEAN
			-- Are we currently processing the shorthand-selected element?

	is_error: BOOLEAN
			-- Did XPointer processing flag an error?

	acceptable_media_types: ?DS_HASH_SET [UT_MEDIA_TYPE]
			-- Acceptable media types for current fragment-processing semantics

	namespace_bindings_stack: ?DS_LINKED_STACK [XM_XPOINTER_NAMESPACE_CONTEXT]
			-- Namespace declarations in scope

	namespace_bindings: ?XM_XPOINTER_NAMESPACE_CONTEXT
			-- Current namespace binding context

invariant

	resolver_not_void: resolver /= Void
	xpointer_error: is_error implies error_message /= Void
	attribute_types_not_void: is_filtering implies attribute_types /= Void
	acceptable_media_types: is_filtering implies {ot_acceptable_media_types: like acceptable_media_types} acceptable_media_types and then ot_acceptable_media_types.equality_tester = media_type_tester
	namespace_bindings_stack_not_void: is_filtering implies namespace_bindings_stack /= Void
	is_error_with_message: is_error implies error_message /= Void

end

