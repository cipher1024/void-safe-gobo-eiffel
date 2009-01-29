indexing

	description:

		"Cursors for set traversals"

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:40:54 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6526 $"

deferred class DS_SET_CURSOR [G]

inherit

	DS_LINEAR_CURSOR [G]
		redefine
			container,
			next_cursor
		end

feature -- Access

	container: DS_SET [G] is
			-- Set traversed
		deferred
		end

feature {DS_SET} -- Implementation

	next_cursor: ?DS_SET_CURSOR [G]
			-- Next cursor
			-- (Used by `container' to keep track of traversing
			-- cursors (i.e. cursors associated with `container'
			-- and which are not currently `off').)

end
