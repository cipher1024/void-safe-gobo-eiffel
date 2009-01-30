note
	description: "[
		Values that may be hashed into an integer index, 
		for use as keys in hash tables
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2004, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2009-01-12 17:05:16 +0100 (Mon, 12 Jan 2009) $"
	revision: "$Revision: 6572 $"

deferred class
	HASHABLE

feature -- Access

	hash_code: INTEGER
			-- Hash code value
		deferred
		ensure
			good_hash_value: Result >= 0
		end

feature -- Status report

	is_hashable: BOOLEAN
			-- May current object be hashed?
			-- (True by default.)
		do
			Result := True
		end

end
