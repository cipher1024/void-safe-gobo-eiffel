indexing

	description:

		"Cursors for multi-arrayed hash set traversals"

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 1999-2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:40:54 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6526 $"

class DS_MULTIARRAYED_HASH_SET_CURSOR [G -> HASHABLE]

inherit

	DS_MULTIARRAYED_SPARSE_SET_CURSOR [G]
		redefine
			container,
			next_cursor
		end

create

	make

feature -- Access

	container: DS_MULTIARRAYED_HASH_SET [G]
			-- Hash set traversed

feature {DS_MULTIARRAYED_HASH_SET} -- Implementation

	next_cursor: ?DS_MULTIARRAYED_HASH_SET_CURSOR [G]
			-- Next cursor
			-- (Used by `container' to keep track of traversing
			-- cursors (i.e. cursors associated with `container'
			-- and which are not currently `off').)

end
