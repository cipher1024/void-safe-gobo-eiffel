indexing

	description:

		"Comparators of strings that can be polymorphically unicode strings"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class UC_STRING_COMPARATOR

inherit

	KL_COMPARATOR [STRING]

	KL_IMPORTED_STRING_ROUTINES

feature -- Status report

	less_than (u, v: STRING): BOOLEAN is
			-- Is `u' considered less than `v'?
		do
			Result := STRING_.three_way_comparison (u, v) = -1
		end

end
