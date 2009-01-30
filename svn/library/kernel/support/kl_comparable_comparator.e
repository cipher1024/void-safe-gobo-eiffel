indexing

	description:

		"Comparators based on COMPARABLE"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2000-2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_COMPARABLE_COMPARATOR [G -> COMPARABLE]

inherit

	KL_COMPARATOR [G]

create

	make

feature {NONE} -- Initialization

	make is
			-- Create a new comparator.
		do
		end

feature -- Status report

	less_than (u, v: G): BOOLEAN is
			-- Is `u' considered less than `v'?
		do
			Result := (u < v)
		end

end
