indexing

	description:

		"Cells containing an item"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-05 12:21:37 +0200 (Sun, 05 Oct 2008) $"
	revision: "$Revision: 6530 $"

class KL_CELL [G]

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
