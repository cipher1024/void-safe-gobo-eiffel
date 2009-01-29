indexing

	description:

		"xml:id validator"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2005, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class XM_XMLID_VALIDATOR

inherit

	XM_CALLBACKS_FILTER
		redefine
			on_start,
			on_finish,
			on_attribute
		end

	XM_MARKUP_CONSTANTS
		export {NONE} all end

	XM_SHARED_UNICODE_CHARACTERS
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	KL_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

create

	make_null,
	set_next

feature -- Events

	on_start is
			-- Initialize ID set.
		local
			l_ids: like ids
		do
			create l_ids.make_default
			ids := l_ids
			l_ids.set_equality_tester (string_equality_tester)
			Precursor
		end

	on_finish is
			-- Clear ID set.
		do
			ids := Void
			Precursor
		end

	on_attribute (a_namespace, a_prefix: ?STRING; a_local_part: STRING; a_value: STRING) is
			-- Normalize xml:id attribute and check it is unique.
		local
			an_id: STRING
			l_ids: like ids
		do
			l_ids := ids
			check l_ids /= Void end -- implied by ... ?
			if has_prefix (a_prefix) then
				check a_prefix /= Void end -- implied by `has_prefix (a_prefix)'
				if
					a_prefix.same_string (Xml_prefix) and
					a_local_part.same_string (Xml_id)
				then
					an_id := normalize (a_value)
					if not characters_1_0.is_ncname (an_id) then
						on_error (Id_not_ncname_error)
					elseif l_ids.has (an_id) then
						on_error (Duplicate_id_error)
					else
						l_ids.force (an_id)
					end
					Precursor (a_namespace, a_prefix, a_local_part, an_id)
				end
			end
		end

feature {NONE} -- Implementation

	ids: ?DS_HASH_SET [STRING]
			-- IDs table for duplicate check

feature {NONE} -- Implementation

	normalize (an_id: STRING): STRING is
			-- Identifier attribute normalized
			-- (duplicates spaces removed, head and trailing spaces removed)
		require
			an_id_not_void: an_id /= Void
			--xml_normalized: is_normalized_attribute (an_id)
		local
			last_start: INTEGER
			i: INTEGER
			r: ?STRING
		do
				-- Remove duplicate spaces
			from
				last_start := 1
				i := 2
			variant
				an_id.count - i + 1
			until
				i > an_id.count
			loop
				if is_space (an_id.item_code (i)) and is_space (an_id.item_code (i - 1)) then
					if last_start > 0 then
							-- There has been valid chars since last duplicate space
						if r = Void then
							create r.make_empty
						end
						r := STRING_.appended_string (r, an_id.substring (last_start, i - 1))
						last_start := 0
					end
				else
					if last_start = 0 then
							-- first of non duplicate space char
						last_start := i
					end
				end
				i := i + 1
			end

			if last_start = 1 then
					-- no duplicate spaces
				r := an_id
			elseif last_start > 1 then
					-- tail
				check r /= Void end -- implied by implementation of previous loop
				r := STRING_.appended_string (r, an_id.substring (last_start, an_id.count))
			else
				check
					no_leftovers: last_start = 0
					ends_with_space: is_space (an_id.item_code (an_id.count))
				end
				check r /= Void end -- implied by implementation of previous loop
			end

				-- Remove heading and trailing space
			if not r.is_empty and then is_space (r.item_code (1)) then
				r := r.substring (2, r.count)
			end
			if not r.is_empty and then is_space (r.item_code (r.count)) then
				r := r.substring (1, r.count - 1)
			end
			Result := r
		ensure
			result_not_void: Result /= Void
			fewer_or_equal_count: Result.count <= an_id.count
			not_heading_space: Result.is_empty or else not is_space (Result.item_code (1))
			not_trailing_space: Result.is_empty or else not is_space (Result.item_code (Result.count))
		end

	is_space (a_char: INTEGER): BOOLEAN is
			-- Is this character a space for the purpose of ID normalisation?
		do
			Result := characters_1_0.is_space (a_char)
		end

feature {NONE} -- Constants

	Duplicate_id_error: STRING is "duplicate xml:id declaration"
			-- Duplicate ID

	Id_not_ncname_error: STRING is "xml:id value is not an NCName"
			-- NCName error

end
