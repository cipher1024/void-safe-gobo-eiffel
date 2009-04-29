indexing

	description:

		"Cursors for in-order traversal of sets using binary search tree algorithms"

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 2008, Daniel Tuser and others"
	license: "MIT License"
	date: "$Date: 2009-04-29 11:04:25 +0200 (Wed, 29 Apr 2009) $"
	revision: "$Revision: 6628 $"

class DS_BINARY_SEARCH_TREE_SET_CURSOR [G]

inherit

	DS_BILINEAR_SET_CURSOR [G]
		undefine
			item
		redefine
			container,
			next_cursor
		end

	DS_BINARY_SEARCH_TREE_CONTAINER_CURSOR [G, G]
		rename
			go_at_or_before_key as go_at_or_before,
			go_at_or_after_key as go_at_or_after
		redefine
			container,
			next_cursor
		end

create

	make

feature -- Access

	container: DS_BINARY_SEARCH_TREE_SET [G]
			-- Binary search tree set traversed

feature {DS_BILINEAR} -- Implementation

	next_cursor: ?DS_BINARY_SEARCH_TREE_SET_CURSOR [G]
			-- Next cursor
			-- (Used by `container' to keep track of traversing
			-- cursors (i.e. cursors associated with `container'
			-- and which are not currently `off').)

end
