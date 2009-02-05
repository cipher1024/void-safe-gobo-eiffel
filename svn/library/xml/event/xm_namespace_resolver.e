indexing

	description:

		"Callbacks filter that resolves namespaces"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class XM_NAMESPACE_RESOLVER

inherit

	XM_CALLBACKS_FILTER
		redefine
			on_finish,
			on_start,
			on_start_tag,
			on_attribute,
			on_start_tag_finish,
			on_end_tag
		end

	XM_MARKUP_CONSTANTS
		export {NONE} all end

	XM_UNICODE_STRUCTURE_FACTORY
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create

	make_null,
	set_next

feature -- Document

	on_finish is
			-- Forward to `next'.
		do
			next.on_finish
		end

	on_start is
			-- Initialize document variables.
		do
			create context.make
			attributes_make
			next.on_start
		end

feature -- Forwarding policy

	forward_xmlns: BOOLEAN
			-- Should xmlns[:] attributes be forwarded to next filter?

	set_forward_xmlns (a_boolean: BOOLEAN) is
			-- Set forwarding of xmlns[:] attributes policy.
			-- Default (False): do not forward.
		do
			forward_xmlns := a_boolean
		ensure
			set: forward_xmlns = a_boolean
		end

feature -- Element

	on_start_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- Process start of start tag.
		do
			attached_context.push
			check empty_attributes: attributes_is_empty end
				-- Save for when we can resolve it, event deferred.
			element_prefix := a_prefix
			element_local_part := a_local_part
		end

	on_attribute (a_namespace, a_prefix: ?STRING; a_local_part: STRING; a_value: STRING) is
			-- Process attribute.
		local
			l_context: like attached_context
		do
			l_context := attached_context
			if not has_prefix (a_prefix) and is_xmlns (a_local_part) then
					-- Default declaration.
				l_context.add_default (a_value)
					-- Optionally do not eat xmlns attributes
				if forward_xmlns then
					attributes_force (a_prefix, a_local_part, a_value)
				end
			elseif is_xmlns (a_prefix) then
					-- Prefix declaration.
				check a_prefix /= Void end -- implied by `is_xmlns'
				if l_context.shallow_has (a_prefix) then
					on_error (Duplicate_namespace_declaration_error)
				else
					l_context.add (a_value, a_local_part)
				end
					-- Optionally do not eat xmlns: attributes
				if forward_xmlns then
					attributes_force (a_prefix, a_local_part, a_value)
				end
			else
					-- Queue ordinary attribute for when all namespace
					-- declarations have been seen as they can be used
					-- to declare attributes prefixes.
				attributes_force (a_prefix, a_local_part, a_value)
			end
		end

	on_start_tag_finish is
			-- Process end of start tag.
		local
			error_msg: STRING
			l_element_prefix: like element_prefix
			l_element_local_part: like element_local_part
			l_context: like attached_context
		do
			l_element_prefix := element_prefix
			l_element_local_part := element_local_part
			l_context := attached_context
			check l_element_local_part /= Void end -- implied by being in `on_start_tag_finish', thus after `on_start_tag'
			if has_prefix (l_element_prefix) then
				check l_element_prefix /= Void end -- implied by  `has_prefix'
				if l_context.has (l_element_prefix) then
					next.on_start_tag (l_context.resolve (l_element_prefix),
							l_element_prefix, l_element_local_part)
					on_delayed_attributes
				else
					error_msg := STRING_.cloned_string (Undeclared_namespace_error)
					error_msg := STRING_.appended_string (error_msg, " in tag <")
					error_msg := STRING_.appended_string (error_msg, l_element_prefix)
					error_msg := STRING_.appended_string (error_msg, ":")
					error_msg := STRING_.appended_string (error_msg, l_element_local_part)
					error_msg := STRING_.appended_string (error_msg, ">")
					on_error (error_msg)
				end
			else
				next.on_start_tag (l_context.resolve_default,
						l_element_prefix, l_element_local_part)
				on_delayed_attributes
			end
			Precursor
		end

	on_end_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- Process end tag.
		local
			l_context: like attached_context
		do
			l_context := attached_context
			if has_prefix (a_prefix) then
				check a_prefix /= Void end -- implied by `has_prefix'
				Precursor (l_context.resolve (a_prefix), a_prefix, a_local_part)
			else
				Precursor (l_context.resolve_default, a_prefix, a_local_part)
			end
			l_context.pop
		end

feature {NONE} -- Attribute events

	on_delayed_attributes is
			-- Resolve attributes.
		local
			l_attributes_prefix: like attributes_prefix
			l_attributes_local_part: like attributes_local_part
			l_attributes_value: like attributes_value
			l_context: like attached_context
			l_prefix: ?STRING
		do
			from
			until
				attributes_is_empty
			loop
				l_attributes_prefix := attributes_prefix
				l_attributes_local_part := attributes_local_part
				l_attributes_value := attributes_value
				check
					l_attributes_prefix /= Void and
					l_attributes_local_part /= Void and
					l_attributes_value /= Void
				end -- implied by `not attributes_is_empty'

				if has_prefix (l_attributes_prefix.item) then
					l_prefix := l_attributes_prefix.item
					check l_prefix /= Void end -- implied by `has_prefix'
					-- Resolve the attribute's prefix if it has any.
					l_context := attached_context
					if l_context.has (l_prefix) then
						next.on_attribute (l_context.resolve (l_prefix),
							l_prefix, l_attributes_local_part.item,
							l_attributes_value.item)
					elseif is_xml (l_prefix) then
							-- xml: prefix has implicit namespace
						next.on_attribute (Xml_prefix_namespace,
							l_prefix,
							l_attributes_local_part.item,
							l_attributes_value.item)
					elseif is_xmlns (l_prefix) then
							-- xmlns: prefix has implicit namespace
						next.on_attribute (Xmlns_namespace,
							l_prefix,
							l_attributes_local_part.item,
							l_attributes_value.item)
					else
						on_error (Undeclared_namespace_error)
					end
				else
					next.on_attribute (Unprefixed_attribute_namespace,
						l_attributes_prefix.item, l_attributes_local_part.item,
						l_attributes_value.item)
				end
					-- Forth:
				attributes_remove
			end
		end

feature {NONE} -- Context

	context: ?XM_NAMESPACE_RESOLVER_CONTEXT
			-- Context
			-- FIXME:jfiat: why not creating the context on creation
			-- this is not a big object, and this would help for void-safety

	attached_context: !like context
			-- Attached `context' for ease of void-safe usage
			-- FIXME:jfiat: ease of conversion to void-safety
		require
			context_attached: context /= Void
		local
			c: like context
		do
			c := context
			check c /= Void end
			Result := c
		end

feature {NONE} -- Context

	is_xmlns (a: ?STRING): BOOLEAN is
			-- Is this an xmlns[:] declaration?
		do
			Result := a /= Void and then same_string (Xmlns, a)
		end

	is_xml (a: ?STRING): BOOLEAN is
			-- Is this a xml: declaration?
		do
			Result := a /= Void and then same_string (Xml_prefix, a)
		end

	Unprefixed_attribute_namespace: STRING is
			-- Namespace used for unprefixed attributes.
		do
			Result := Default_namespace
		end

feature {NONE} -- Element

	element_prefix: ?STRING
	element_local_part: ?STRING

feature {NONE} -- Attributes

	-- mean version of:
	-- attributes: DS_QUEUE [PREFIX_LOCALPART_VALUE]

	attributes_make is
			-- Intialize queue.
		do
			attributes_prefix := new_string_queue
			attributes_local_part := new_string_queue
			attributes_value := new_string_queue
		end

	attributes_force (a_prefix: ?STRING; a_local_part: STRING; a_value: STRING) is
			-- Like attributes.force.
		local
			l_attributes_prefix: like attributes_prefix
			l_attributes_local_part: like attributes_local_part
			l_attributes_value: like attributes_value
		do
			l_attributes_prefix := attributes_prefix
			l_attributes_local_part := attributes_local_part
			l_attributes_value := attributes_value
			check
				l_attributes_prefix /= Void and
				l_attributes_local_part /= Void and
				l_attributes_value /= Void
			end -- implied by `not attributes_is_empty'
			l_attributes_prefix.force (a_prefix)
			l_attributes_local_part.force (a_local_part)
			l_attributes_value.force (a_value)
		end

	attributes_remove is
			-- Like attributes.remove.
		require
			not_empty: not attributes_is_empty
		local
			l_attributes_prefix: like attributes_prefix
			l_attributes_local_part: like attributes_local_part
			l_attributes_value: like attributes_value
		do
			l_attributes_prefix := attributes_prefix
			l_attributes_local_part := attributes_local_part
			l_attributes_value := attributes_value
			check
				l_attributes_prefix /= Void and
				l_attributes_local_part /= Void and
				l_attributes_value /= Void
			end -- implied by `not attributes_is_empty'

			l_attributes_prefix.remove
			l_attributes_local_part.remove
			l_attributes_value.remove
		end

	attributes_is_empty: BOOLEAN is
			-- Like attributes.is_empty.
		local
			l_attributes_prefix: like attributes_prefix
		do
			l_attributes_prefix := attributes_prefix
			check l_attributes_prefix /= Void end -- implied by `not attributes_is_empty'
			Result := l_attributes_prefix.is_empty
		end

	attributes_prefix: ?DS_QUEUE [?STRING]
	attributes_local_part: ?DS_QUEUE [STRING]
	attributes_value: ?DS_QUEUE [STRING]

feature {NONE} -- Error

	Undeclared_namespace_error: STRING is "Undeclared namespace error"
	Duplicate_namespace_declaration_error: STRING is "Namespace declared twice"
			-- Error messages

end
