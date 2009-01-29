indexing

	description:

		"Event filters to share identical strings (clients should not later change strings)"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class XM_SHARED_STRINGS_FILTER

inherit

	XM_CALLBACKS_FILTER
		redefine
			on_start,
			on_processing_instruction,
			on_comment,
			on_start_tag,
			on_attribute,
			on_end_tag,
			on_content
		end

	XM_UNICODE_STRUCTURE_FACTORY
		export {NONE} all end

create

	make_null,
	set_next

feature -- Document events

	on_start is
			-- Called when parsing starts.
		do
			strings := new_string_set
			Precursor
		end

feature -- Meta information

	on_processing_instruction (a_name: STRING; a_content: STRING) is
			-- Processing instruction.
		do
			attached_next.on_processing_instruction (shared_attached_string (a_name), shared_attached_string (a_content))
		end

	on_comment (a_content: STRING) is
			-- Process comment.
			-- Atomic: single comment produces single event
		do
			attached_next.on_comment (shared_attached_string (a_content))
		end

feature -- Tag

	on_start_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- Start of start tag.
		do
			attached_next.on_start_tag (shared_string (a_namespace),
				shared_string (a_prefix),
				shared_attached_string (a_local_part))
		end

	on_attribute (a_namespace, a_prefix: ?STRING; a_local_part: STRING; a_value: STRING) is
			-- Start of start tag.
		do
			attached_next.on_attribute (shared_string (a_namespace),
				shared_string (a_prefix),
				shared_attached_string (a_local_part),
				shared_attached_string (a_value))
		end

	on_end_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- End tag.
		do
			attached_next.on_end_tag (shared_string (a_namespace),
				shared_string (a_prefix),
				shared_attached_string (a_local_part))
		end

feature -- Content

	on_content (a_content: STRING) is
			-- Text content.
			-- NOT atomic: successive content may be different.
			-- Default: forward event to 'next'.
		do
			check a_content /= Void end -- implied by inherit precondition FIXME:by_compiler
			attached_next.on_content (shared_attached_string (a_content))
		end

feature {NONE} -- Share

	strings: ?DS_HASH_SET [STRING]
			-- Strings to be shared

	shared_string (a_string: ?STRING): ?STRING is
			-- If string known return the previous occurrence
		do
			if a_string /= Void then
				Result := shared_attached_string (a_string)
			end
		end

	shared_attached_string (a_string: STRING): STRING is
			-- If string known return the previous occurrence
		require
			a_string_attached: a_string /= Void
		local
			l_strings: like strings
			s: ?STRING
		do
			l_strings := strings
			if l_strings /= Void then
				l_strings.search (a_string)
				if l_strings.found then
					s := l_strings.found_item
					check s /= Void end -- implied by `.found'
				else
					l_strings.force_new (a_string)
					s := a_string
				end
			else
				s := a_string
			end
			Result := s
		ensure
			Result_attached: Result /= Void
		end


end
