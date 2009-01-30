indexing

	description:

		"Reverse total order comparators"

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class DS_REVERSE_COMPARATOR [G]

obsolete

	"[020707] Use KL_REVERSE_COMPARATOR instead."

inherit

	KL_REVERSE_COMPARATOR [G]
		redefine
			comparator
		end

	DS_REVERSE_PART_COMPARATOR [G]
		redefine
			comparator
		end

	DS_COMPARATOR [G]

create

	make

feature -- Access

	comparator: KL_COMPARATOR [G]
			-- Base comparator

end
