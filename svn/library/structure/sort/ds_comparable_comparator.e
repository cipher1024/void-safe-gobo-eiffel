indexing

	description:

		"Comparators based on COMPARABLE"

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 2000-2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:40:54 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6526 $"

class DS_COMPARABLE_COMPARATOR [G -> COMPARABLE]

obsolete

	"[020707] Use KL_COMPARABLE_COMPARATOR instead."

inherit

	KL_COMPARABLE_COMPARATOR [G]

	DS_COMPARATOR [G]

create

	make

end
