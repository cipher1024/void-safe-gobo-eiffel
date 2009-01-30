indexing

	description:

		"Sets that allow bilinear traversing"

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 2008, Daniel Tuser and others"
	license: "MIT License"
	date: "$Date: 2008-07-20 21:27:20 +0200 (Sun, 20 Jul 2008) $"
	revision: "$Revision: 6454 $"

deferred class DS_BILINEAR_SET [G]

inherit

	DS_SET [G]

	DS_BILINEAR [G]
		undefine
			occurrences,
			cursor_off,
			equality_tester_settable
		redefine
			new_cursor
		end

feature -- Access

	new_cursor: DS_BILINEAR_SET_CURSOR [G] is
			-- New external cursor for traversal
		deferred
		end

end
