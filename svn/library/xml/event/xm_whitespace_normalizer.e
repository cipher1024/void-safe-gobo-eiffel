indexing

	description:

		"Remove head and tail whitespace (as defined by XML) from content; accounting for xml:space"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2003, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class XM_WHITESPACE_NORMALIZER

inherit

	XM_CALLBACKS_FILTER
		redefine
			on_start,
			on_content,
			on_comment,
			on_processing_instruction,
			on_start_tag,
			on_attribute,
			on_end_tag,
			on_finish
		end

	XM_MARKUP_CONSTANTS
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create

	make_null,
	set_next

feature -- Content

	on_content (a_content: STRING) is
			-- Process content event with whitespace removal
			-- if heading/trailing the content events.
		local
			l_last_content: like last_content
			l_is_space_preserved: like is_space_preserved
		do
			l_is_space_preserved := is_space_preserved
			check l_is_space_preserved /= Void end -- implied by being in `on_content', then after `on_start'
			if l_is_space_preserved.item then
				next.on_content (a_content)
			else
				if in_content then
					l_last_content := last_content
					check l_last_content /= Void end -- implied by `in_content'
					if is_space (l_last_content.item.item_code (l_last_content.item.count)) then
							-- We don't know if we are at the end, so this could
							-- be tail whitespace.
						l_last_content.append_string (a_content)
					else
							-- No tail whitespace, so can be processed now.
						next.on_content (l_last_content.item)
						create last_content.make (a_content)
					end
				else
						-- First (non-space) content event.
					create last_content.make (a_content)
					normalize_content_head
						-- The content event is not processed further
						-- because it is not known whether it needs
						-- tail normalisation (if it is the last
						-- content event of a sequence)
				end
			end
		end

feature {NONE} -- Content

	is_space_preserved: ?DS_ARRAYED_STACK [BOOLEAN]
			-- Is xml:space="preserve" mode set?

	last_content: ?ST_COPY_ON_WRITE_STRING
			-- Last unprocessed content event.

	default_space_preserved: BOOLEAN is
			-- Initial xml:space mode, can be redefined.
			-- Default: False.
		do
		end

feature {NONE} -- Content

	in_content: BOOLEAN is
			-- Is there a pending unprocessed content event?
		do
			Result := last_content /= Void
		end

	end_content is
			-- New non-content event; process pending
			-- content first.
		local
			l_last_content: like last_content
		do
			if in_content then
				normalize_content_tail
				l_last_content := last_content
				if l_last_content /= Void then
					next.on_content (l_last_content.item)
					last_content := Void
				end
			end
		ensure
			last_content_void: last_content = Void
		end

	is_space (a_code: INTEGER): BOOLEAN is
			-- Is `a_code' the character code of a white space character?
		do
			Result := a_code = Lf_char.code
				or a_code = Cr_char.code
				or a_code = Tab_char.code
				or a_code = Space_char.code
		end

	normalize_content_head is
			-- Remove whitespace from beginning of content.
		require
			in_content: in_content
		local
			i: INTEGER
			l_last_content: like last_content
		do
			l_last_content := last_content
			check l_last_content /= Void end -- implied by `in_content'
			from
				i := 1
			variant
				l_last_content.item.count - i + 1
			until
				i > l_last_content.item.count or else not is_space (l_last_content.item.item_code (i))
			loop
				i := i + 1
			end

			if i > l_last_content.item.count then
					-- All content is whitespace
				last_content := Void
			elseif i > 1 then
					-- Remove whitespace.
				create last_content.make (l_last_content.item.substring (i, l_last_content.item.count))
			else
					-- Unchanged, no whitespace.
			end
		ensure
			no_whitespace_at_head: in_content implies {ot_last_content: like last_content} last_content and then not is_space (ot_last_content.item.item_code (1))
		end

	normalize_content_tail is
			-- Remove whitespace at end of content.
		require
			in_content: in_content
		local
			i: INTEGER
			l_last_content: like last_content
		do
			l_last_content := last_content
			check l_last_content /= Void end -- implied by `in_content'
			from
				i := l_last_content.item.count
			variant
				i
			until
				i = 0 or else not is_space (l_last_content.item.item_code (i))
			loop
				i := i - 1
			end

			if i = 0 then
				last_content := Void
			elseif i < l_last_content.item.count then
				create last_content.make (l_last_content.item.substring (1, i))
			end
		end

feature -- Events

	on_start is
			-- Reset.
		local
			l_is_space_preserved: like is_space_preserved
		do
			last_content := Void
			create l_is_space_preserved.make_default
			is_space_preserved := l_is_space_preserved
			l_is_space_preserved.force (default_space_preserved)
			Precursor
		end

	on_processing_instruction (a_name: STRING; a_content: STRING) is
			-- Clear content and forward.
		do
			end_content
			Precursor (a_name, a_content)
		end

	on_comment (a_comment: STRING) is
			-- Clear content and forward.
		do
			end_content
			Precursor (a_comment)
		end

	on_start_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- Clear content and forward.
		local
			l_is_space_preserved: like is_space_preserved
		do
			end_content
			l_is_space_preserved := is_space_preserved
			check l_is_space_preserved /= Void end
			l_is_space_preserved.force (l_is_space_preserved.item) -- Unchanged.
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_attribute (a_namespace, a_prefix: ?STRING; a_local_part: STRING; a_value: STRING) is
			-- Process xml:space attribute
		local
			l_is_space_preserved: like is_space_preserved
		do
			if has_prefix (a_prefix) then
				check a_prefix /= Void end -- implied by `has_prefix (a_prefix)'
				if STRING_.same_string (Xml_prefix, a_prefix)
					and STRING_.same_string (Xml_space, a_local_part)
				then
					l_is_space_preserved := is_space_preserved
					check l_is_space_preserved /= Void end
						--Replace value for current element.
					l_is_space_preserved.remove
					l_is_space_preserved.force (STRING_.same_string (Xml_space_preserve, a_value))
				end
			end
			Precursor (a_namespace, a_prefix, a_local_part, a_value)
		end

	on_end_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- Clear content and forward.
		local
			l_is_space_preserved: like is_space_preserved
		do
			end_content
			l_is_space_preserved := is_space_preserved
			check l_is_space_preserved /= Void end
			l_is_space_preserved.remove
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_finish is
			-- Clear content and forward.
		do
			end_content
			Precursor
		end

invariant

	last_content_not_empty: not {ot_last_content: like last_content} last_content or else ot_last_content.item.count > 0

end
