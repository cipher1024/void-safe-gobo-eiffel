note
	description: "Objects that may be compared according to a partial order relation"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2004, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2009-01-12 17:05:16 +0100 (Mon, 12 Jan 2009) $"
	revision: "$Revision: 6572 $"

deferred class
	PART_COMPARABLE

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		require
			other_exists: other /= Void
		deferred
		end

	is_less_equal alias "<=" (other: like Current): BOOLEAN
			-- Is current object less than or equal to `other'?
		require
			other_exists: other /= Void
		do
			Result := (Current < other) or (Current ~ other)
		end

	is_greater alias ">" (other: like Current): BOOLEAN
			-- Is current object greater than `other'?
		require
			other_exists: other /= Void
		do
			Result := other < Current
		end

	is_greater_equal alias ">=" (other: like Current): BOOLEAN
			-- Is current object greater than or equal to `other'?
		require
			other_exists: other /= Void
		do
			Result := (other < Current) or (Current ~ other)
		end

end
