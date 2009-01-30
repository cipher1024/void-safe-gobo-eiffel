indexing

	description:

		"Reverse total order comparators"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001-2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_REVERSE_COMPARATOR [G]

inherit

	KL_REVERSE_PART_COMPARATOR [G]
		redefine
			comparator
		end

	KL_COMPARATOR [G]

create

	make

feature -- Access

	comparator: KL_COMPARATOR [G]
			-- Base comparator

end
