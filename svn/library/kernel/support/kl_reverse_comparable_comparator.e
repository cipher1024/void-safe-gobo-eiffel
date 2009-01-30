indexing

	description:

		"Reverse comparators based on COMPARABLE"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2000-2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_REVERSE_COMPARABLE_COMPARATOR [G -> COMPARABLE]

inherit

	KL_COMPARABLE_COMPARATOR [G]
		redefine
			less_than
		end

create

	make

feature -- Status report

	less_than (u, v: G): BOOLEAN is
			-- Is `u' considered less than `v'?
		do
			Result := (v < u)
		end

end
