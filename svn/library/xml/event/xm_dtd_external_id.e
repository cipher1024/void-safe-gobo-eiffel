indexing

	description:

		"External identifiers in DTD"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-05 12:21:37 +0200 (Sun, 05 Oct 2008) $"
	revision: "$Revision: 6530 $"

class XM_DTD_EXTERNAL_ID

inherit

	ANY
		undefine
			out
		end

	HASHABLE
		redefine
			out
		end

	KL_IMPORTED_STRING_ROUTINES
		export
			{NONE} all
		undefine
			out
		end

create

	make

feature {NONE} -- Initialization

	make is
			-- Create a new external ID.
		do
		end

feature -- Status report

	is_public: BOOLEAN is
			-- Is public_id defined?
		do
			Result := public_id /= Void
		end

feature -- Access

	base: ?STRING
			-- Base URI

	system_id: ?STRING
			-- SYSTEM
			-- FIXME:jfiat: check callers, since most of them do not check if system_id is attached

	public_id: ?STRING
			-- PUBLIC

	hash_code: INTEGER is
			-- Hash code
		local
			l_id: ?STRING
		do
			l_id := public_id
			if l_id /= Void then
				Result := l_id.hash_code // 3
			end
			l_id := system_id
			if l_id /= Void then
				Result := Result + (l_id.hash_code // 3)
			end
		end

feature -- Setting

	set_base (a_base: like base) is
			-- Set base URI.
		do
			base := a_base
		ensure
			base_set: base = a_base
		end

	set_system (a_system_id: like system_id) is
			-- Set SYSTEM.
		do
			system_id := a_system_id
		ensure
			system_id_set: system_id = a_system_id
		end

	set_public (a_public_id: like public_id) is
			-- Set PUBLIC.
		do
			public_id := a_public_id
		ensure
			public_id_set: public_id = a_public_id
		end

feature -- Output

	out: STRING is
			-- Print as in input.
		local
			l_id: ?STRING
			s: ?STRING
		do
			l_id := public_id
			if l_id /= Void then
				s := STRING_.cloned_string ("PUBLIC ")
				s := STRING_.appended_string (s, l_id)
			end

			l_id := system_id
			if l_id /= Void then
				if s = Void then
					s := STRING_.cloned_string ("SYSTEM")
				end
				s.append_character (' ')
				s := STRING_.appended_string (s, l_id)
				s.append_character (' ')
			end
			if s = Void then
				create s.make_empty --| to satisfy postcondition Result /= Void FIXME:jfiat
			end
			Result := s
		end

end
