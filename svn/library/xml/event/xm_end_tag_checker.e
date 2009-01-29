indexing

	description:

		"Checks that end tag name balances"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class XM_END_TAG_CHECKER

inherit

	XM_CALLBACKS_FILTER
		redefine
			on_start,
			on_start_tag,
			on_end_tag
		end

	XM_UNICODE_STRUCTURE_FACTORY
		export {NONE} all end

create

	make_null,
	set_next

feature -- Document

	on_start is
			-- Initialize.
		do
			prefixes := new_detachable_string_stack
			local_parts := new_string_stack
			Precursor
		end

feature -- Tag

	on_start_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- Start of start tag.
		local
			l_prefixes: like prefixes
			l_local_parts: like local_parts
		do
			l_prefixes := prefixes
			check l_prefixes /= Void end -- implied by `on_start'
			l_prefixes.force (a_prefix)

			l_local_parts := local_parts
			check l_local_parts /= Void end -- implied by `on_start'
			l_local_parts.force (a_local_part)
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_end_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- End tag.
		local
			l_prefixes: like prefixes
			l_local_parts: like local_parts
			l_prefixes_item: ?STRING
		do
			l_prefixes := prefixes
			check l_prefixes /= Void end -- implied by `on_start'
			if l_prefixes.count >= 0 then
				l_local_parts := local_parts
				check l_local_parts /= Void end -- implied by `on_start'
				l_prefixes_item := l_prefixes.item
				if not (
					l_prefixes_item = a_prefix
					or else ((a_prefix /= Void and l_prefixes_item /= Void)
						and then same_string (l_prefixes_item, a_prefix)))
				or
					not same_string (l_local_parts.item, a_local_part)
				then
					on_error (End_tag_mismatch_error)
				end
				l_prefixes.remove
				l_local_parts.remove
			else
				on_error (Extra_end_tag_error)
			end
			Precursor (a_namespace, a_prefix, a_local_part)
		end

feature {NONE} -- Mean version of STACK [PREFIX+NAME]

	prefixes: ?DS_LINKED_STACK [?STRING]
	local_parts: ?DS_LINKED_STACK [STRING]

feature {NONE} -- Errors

	End_tag_mismatch_error: STRING is "End tag does not match start tag"
	Extra_end_tag_error: STRING is "End tag without start tag"
			-- Error messages

end
