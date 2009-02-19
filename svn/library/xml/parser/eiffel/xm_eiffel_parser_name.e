indexing

	description:

		"Parser name: optimised for namespaces but still allowing XML 1.0 names"

	todo: "Review how to handle strict XML 1.0 with namespaces"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class XM_EIFFEL_PARSER_NAME

inherit

	HASHABLE
		redefine
			is_equal, out
		end

	XM_MARKUP_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, out
		end

	XM_UNICODE_STRUCTURE_FACTORY
		export
			{NONE} all
		undefine
			is_equal, out
		end

	KL_IMPORTED_STRING_ROUTINES
		export
			{NONE} all
		undefine
			is_equal, out
		end

create

	make_namespaces, make_no_namespaces

feature {NONE} -- Initialization

	make_namespaces is
			-- Create a new empty name, that behaves with namespaces.
		do
			make_no_namespaces
			use_namespaces := True
		ensure
			use_namespaces: use_namespaces
		end

	make_no_namespaces is
			--
		do
			count := 0
			first := Void
			second := Void
			tail := Void
		ensure
			not_use_namespaces: not use_namespaces

		end

feature -- Status report

	use_namespaces: BOOLEAN
			-- Is namespace parsing enabled?

feature -- Status report

	is_name: BOOLEAN is
			-- Is `Current' a name?
		do
			Result := is_simple_name or is_namespace_name
		end

	is_simple_name: BOOLEAN is
			-- Is current name a simple name?
		local
			f: like first
		do
			if count = 1 then
				f := first
				check f /= Void end -- implied by `count = 1'
				Result := f.count > 0
			end
		end

	is_namespace_name: BOOLEAN is
			-- Is current name with a namespace?
		local
			f,s: ?STRING
		do
			if count = 2 then
				f := first
				s := second
				check f /= Void and s /= Void end -- implied by `count = 2'
				Result := f.count > 0 and s.count > 0
			end
		end

	is_namespace_declaration: BOOLEAN is
			-- Is current name an XML namespace declaration?
		do
			Result := (count = 1 or count = 2) and then {l_first: like first} first and then same_string (Xmlns, l_first)
		end

	is_named_namespace_declaration: BOOLEAN is
			-- Is current name an XML declaration for a named namespace?
		do
			Result := is_namespace_declaration and is_namespace_name
		end

	is_empty: BOOLEAN is
			-- Is name empty?
		do
			Result := count = 0
		ensure
			definition: Result = (count = 0)
		end

feature -- Access

	ns_prefix: ?STRING is
			-- Namespace prefix
		do
			if use_namespaces and is_namespace_name then
				Result := first
			end
		ensure
			no_namespaces_void: not use_namespaces implies Result = Void
		end

	local_part: ?STRING is
			-- Local part
			-- (including tail)
		local
			it: DS_LIST_CURSOR [STRING]
			s: ?STRING
			l_tail: like tail
		do
			if use_namespaces then
				check count_for_namespaces: count <= 2 end
				Result := last
			else
				if count > 0 then
					s := first
					check s /= Void end -- implied by `count > 0'
					Result := STRING_.cloned_string (s)
					if (count > 1) then
						Result.append_character (':')
						s := second
						check s /= Void end -- implied by count > 1
						Result := STRING_.appended_string (Result, s)
						if (count > 2) then
							l_tail := tail
							check l_tail /= Void end -- implied by `count > 2'
							it := l_tail.new_cursor
							from it.start until it.after loop
								Result.append_character (':')
								Result := STRING_.appended_string (Result, it.item)
								it.forth
							end
						end
					end
				end
			end
		end

	item (i: INTEGER): STRING is
			-- Item at position i.
		require
			i_large_enough: i >= 1
			i_small_enough: i <= count
		local
			l_tail: like tail
			s: ?STRING
		do
			if i = 1 then
				s := first
				check s /= Void end -- implied by `i = 1 and i in range'
				Result := s
			elseif i = 2 then
				s := second
				check s /= Void end -- implied by `i = 2 and i in range'				
				Result := s
			else
				l_tail := tail
				check l_tail /= Void end -- implied by `i > 2 and i in range'
				Result := l_tail.item (i - 2)
			end
		end

	first: ?STRING
			-- First item (name or namespace)

	last: STRING is
			-- Last item
		require
			not_empty: not is_empty
		local
			l_tail: like tail
			s: ?STRING
		do
			if count = 1 then
				s := first
				check s /= Void end -- implied by `count = 1'
				Result := s
			elseif count = 2 then
				s := second
				check s /= Void end -- implied by `count = 2'			
				Result := s
			else
				l_tail := tail
				check l_tail /= Void end -- implied by `not_empty and count > 2'
				Result := l_tail.last
			end
		ensure
			Result_attached: Result /= Void
			definition: Result = item (count)
		end

	hash_code: INTEGER is
			-- Hash code value
		local
			i, nb: INTEGER
		do
			nb := count
			from i := 1 until i > nb loop
					-- Never overflow.
				Result := (Result // 3) + (item (i).hash_code // 3)
				i := i + 1
			end
		end

feature -- Measurement

	count: INTEGER
			-- Number of items

feature -- Element change

	can_force_last (a_string: STRING): BOOLEAN is
			-- Is it possible to add an element?
		require
			a_string_not_void: a_string /= Void
		do
			if use_namespaces then
				Result := count < 2 and a_string.count > 0
			else
				Result := True
			end
		ensure
			use_namespaces: not use_namespaces implies Result
		end

	force_last (a_string: STRING) is
			-- Add `a_string' at end.
		require
			a_string_not_void: a_string /= Void
			allowed: can_force_last (a_string)
		local
			l_tail: like tail
		do
			count := count + 1
			if count = 1 then
				first := a_string
			elseif count = 2 then
				second := a_string
			else
				if count = 3 then
					l_tail := new_string_bilinked_list
					tail := l_tail
				else
					l_tail := tail
					check l_tail /= Void end -- implied by count > 3
				end
				l_tail.force_last (a_string)
			end
		ensure
			one_more: count = old count + 1
			at_last: last = a_string
		end

feature -- Removal

	wipe_out is
			-- Remove all.
		do
			count := 0
			first := Void
			second := Void
			tail := Void
		ensure
			wiped_out: is_empty
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Are `Current' and `other' considered equal?
		local
			a_cursor, an_other_cursor: DS_LINEAR_CURSOR [STRING]
			s, other_s: ?STRING
			l_tail, l_other_tail: like tail
		do
			if count = other.count then
				if count = 0 then
					Result := True
				else
					check count >= 1 end --| /= 0 and >= 0
					s := first
					other_s := other.first
					check s /= Void end -- implied by `count >= 1'
					check other_s /= Void end -- implied by `count >= 1 and count = other.count'
					Result := same_string (s, other_s)
					if count >= 2 then
						s := second
						other_s := other.second
						check s /= Void end -- implied by `count >= 2'
						check other_s /= Void end -- implied by `count >= 2 and count = other.count'
						Result := Result and same_string (s, other_s)
						if count > 2 then
							l_tail := tail
							l_other_tail := other.tail
							check l_tail /= Void end -- implied by `count > 2'
							check l_other_tail /= Void end -- implied by `count > 2 and and count = other.count'
							from
								a_cursor := l_tail.new_cursor
								a_cursor.start
								an_other_cursor := l_other_tail.new_cursor
								an_other_cursor.start
							until
								a_cursor.after or not Result
							loop
								Result := same_string (a_cursor.item, an_other_cursor.item)
								a_cursor.forth
								an_other_cursor.forth
							end
							check synch_from_count: a_cursor.after = an_other_cursor.after end
						end
					end
				end
			end
		end

feature -- Output

	out: STRING is
			-- Colon-separated name
		local
			i, nb: INTEGER
		do
			nb := count
			if nb > 0 then
				Result := STRING_.cloned_string (item (1))
				from
					i := 2
				until
					i > nb
				loop
					Result := STRING_.appended_string (Result, item (i))
					i := i + 1
				end
			else
					-- If nb = count = 0, ensure Result is not Void, to respect postcondition
				create Result.make_empty
			end
		end

feature {XM_EIFFEL_PARSER_NAME} -- Implementation

	second: ?STRING
			-- Second (name).

	tail: ?DS_LIST [STRING]
			-- Inefficient(?) tail, because "a:b:c:d" is valid XML 1.0 but
			-- it is supposed to be rare in practice.

invariant

	count_positive: count >= 0

end
