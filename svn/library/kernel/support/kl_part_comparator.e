indexing

	description:

		"Partial order comparators"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001-2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-05 12:21:37 +0200 (Sun, 05 Oct 2008) $"
	revision: "$Revision: 6530 $"

deferred class KL_PART_COMPARATOR [G]

feature -- Status report

	less_than (u, v: G): BOOLEAN is
			-- Is `u' considered less than `v'?
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		deferred
		ensure
			asymmetric: Result implies not less_than (v, u)
		end

	greater_than (u, v: G): BOOLEAN is
			-- Is `u' considered greater than `v'?
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			Result := less_than (v, u)
		ensure
			definition: Result = less_than (v, u)
		end

end
