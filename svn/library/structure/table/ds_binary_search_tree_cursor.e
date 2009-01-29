indexing

	description:

		"Cursors for in-order traversal of binary search trees"

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 2008, Daniel Tuser and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:40:54 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6526 $"

class DS_BINARY_SEARCH_TREE_CURSOR [G, K]

inherit

	DS_BILINEAR_TABLE_CURSOR [G, K]
		undefine
			item
		redefine
			next_cursor
		end

	DS_BINARY_SEARCH_TREE_CONTAINER_CURSOR [G, K]
		export
			{ANY}
				key
		redefine
			container,
			next_cursor
		end

create

	make

feature -- Access

	container: DS_BINARY_SEARCH_TREE [G, K]
			-- Binary search tree traversed

feature {DS_BILINEAR} -- Implementation

	next_cursor: ?DS_BINARY_SEARCH_TREE_CURSOR [G, K]
			-- Next cursor
			-- (Used by `container' to keep track of traversing
			-- cursors (i.e. cursors associated with `container'
			-- and which are not currently `off').)

end
