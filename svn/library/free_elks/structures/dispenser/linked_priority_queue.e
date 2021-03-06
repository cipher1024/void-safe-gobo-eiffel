note

	description:
		"Priority queues implemented as sorted lists"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	names: priority_queue, queue;
	contents: generic;
	date: "$Date: 2009-01-23 21:06:53 +0100 (Fri, 23 Jan 2009) $"
	revision: "$Revision: 6576 $"

class LINKED_PRIORITY_QUEUE [G -> COMPARABLE] inherit

	SORTED_TWO_WAY_LIST [G]
		rename
			item as sl_item
		export
			{NONE} all
			{LINKED_PRIORITY_QUEUE}
				cursor, start, forth, go_to, index, after,
				first_element, last_element, valid_cursor, sl_item
			{ANY}
				off
		redefine
			put, remove
		end

	PRIORITY_QUEUE [G]
		rename
			item as sl_item
		export
			{LINKED_PRIORITY_QUEUE} sl_item
		undefine
			copy, is_equal,
			prune_all, append, readable, writable, fill
		redefine
			put, remove
		end

create
	make

create {LINKED_PRIORITY_QUEUE}
	make_sublist

feature -- Access

	item: G
			-- Entry at top of heap.
		do
			Result := i_th (count)
		end

feature -- Removal

	remove
			-- Remove item of highest value.
		do
			go_i_th (count)
			Precursor {SORTED_TWO_WAY_LIST}
			go_i_th (count)
		end

feature -- Element change

	put (v: like item)
			-- Insert item `v' at its proper position.
		do
			extend (v)
		end


note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"







end -- class LINKED_PRIORITY_QUEUE


