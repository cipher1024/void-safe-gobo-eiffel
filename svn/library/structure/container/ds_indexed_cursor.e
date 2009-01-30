indexing

	description:

		"Indexed cursors for data structure traversals"

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

deferred class DS_INDEXED_CURSOR [G]

inherit

	DS_CURSOR [G]

feature -- Access

	index: INTEGER is
			-- Index of current position
		deferred
		ensure
			valid_index: valid_index (Result)
		end

feature -- Status report

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid index value?
		deferred
		end

feature -- Cursor movement

	go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th position.
		require
			valid_index: valid_index (i)
		deferred
		ensure
			moved: index = i
		end

end
