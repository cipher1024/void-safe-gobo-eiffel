indexing

	description:

		"Pretty print filter with indentation; for tags not separated by content (see XM_WHITESPACE_NORMALIZER)"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2003, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-02-22 20:52:56 +0100 (jeu., 22 févr. 2007) $"
	revision: "$Revision: 5906 $"

class XM_INDENT_PRETTY_PRINT_FILTER

inherit

	XM_PRETTY_PRINT_FILTER
		redefine
			on_start,
			on_attribute,
			on_start_tag,
			on_end_tag,
			on_content
		end

create

	make_null,
	set_next

feature -- Indent

	indent: ?STRING
			-- Indentation string.

	set_indent (an_indent: STRING) is
			-- Set indent string.
		require
			an_indent_not_void: an_indent /= Void
		do
			indent := an_indent
		end

	Default_indent: STRING is " "
			-- Default indent.

feature -- Events

	on_start is
			-- Start of document.
		local
			l_space_preserved: like space_preserved
		do
			if indent = Void then
				indent := Default_indent
			end
			create l_space_preserved.make_default
			space_preserved := l_space_preserved
			l_space_preserved.force (Default_space_preserve)

			has_content := False

			is_root := True

			Precursor
		ensure then
			space_preserved_not_void: space_preserved /= Void
			indent_not_void: indent /= Void
		end

	on_start_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- Start of start tag.
		do
			check space_preserved_not_void: space_preserved /= Void end

			if not has_content then
				if is_root then
					is_root := False
				else
					output_indent_new_line
				end
				output_indent
			end
			has_content := False

			depth := depth + 1

			Precursor (a_namespace, a_prefix, a_local_part)

			attached_space_preserved.force (attached_space_preserved.item)
		end

	on_attribute (a_namespace, a_prefix: ?STRING; a_local_part: STRING; a_value: STRING) is
			-- Handle xml:space.
		do
			check space_preserved_not_void: space_preserved /= Void end

			if has_xml_space (a_prefix, a_local_part) then
					--Replace value for current element.
				attached_space_preserved.remove
				attached_space_preserved.force (STRING_.same_string (Xml_space_preserve, a_value))
			end
			Precursor (a_namespace, a_prefix, a_local_part, a_value)
		end

	on_end_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- End tag.
		do
			depth := depth - 1

			if not has_content then
				output_indent_new_line
				output_indent
			end
			has_content := False

			Precursor (a_namespace, a_prefix, a_local_part)

			attached_space_preserved.remove
		end

	on_content (a_content: STRING) is
			-- Test if we had a content event.
		do
			has_content := True
			Precursor (a_content)
		end

feature {NONE} -- Implementation

	has_content: BOOLEAN
			-- Was there a content event since last tag?

	is_root: BOOLEAN
			-- Are we before the root element?

feature {NONE} -- Space preserve

	has_xml_space (a_prefix: ?STRING; a_local_part: STRING): BOOLEAN is
			-- Is this attribute xml:space?
		do
			if has_prefix (a_prefix) then
				check a_prefix /= Void end -- implied by `has_prefix (a_prefix)'
				Result := STRING_.same_string (Xml_prefix, a_prefix)
					and then STRING_.same_string (Xml_space, a_local_part)
			end
		end

	space_preserved: ?DS_ARRAYED_STACK [BOOLEAN]
			-- Space preserved value.

	attached_space_preserved: !like space_preserved
		require
			space_preserved_attached: space_preserved /= Void
		local
			v: like space_preserved
		do
			v := space_preserved
			check v /= Void end -- implied by `space_preserved_attached'
			Result := v
		end

	Default_space_preserve: BOOLEAN is
			-- Initial space preserve value.
			-- May be redefined.
			-- Default: False.
		do
		end

feature {NONE} -- Indent

	depth: INTEGER
			-- Depth.

	output_indent is
			-- Append indent before element.
		require
			space_preserve_not_void: space_preserved /= Void
			space_preserve_not_empty: not attached_space_preserved.is_empty
			indent_not_void: indent /= Void
		local
			i: INTEGER
			l_indent: like indent
		do
			if not attached_space_preserved.item then
				l_indent := indent
				check l_indent /= Void end -- implied by `indent_not_void'
				from
					i := 1
				until
					i > depth
				loop
					output (l_indent)
					i := i + 1
				end
			end
		end

	output_indent_new_line is
			-- Append indent after element.
		require
			space_preserve_not_void: space_preserved /= Void
		do
			if not attached_space_preserved.item then
				output (Lf_s)
			end
		end

end
