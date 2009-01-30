indexing

	description:

		"Cells containing an item"

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:40:54 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6526 $"

class DS_CELL [G]

create

	make

feature -- Access

	item: G
			-- Content of cell

feature -- Element change

	put, make (v: G) is
			-- Insert `v' in cell.
		do
			item := v
		ensure
			inserted: item = v
		end

end
