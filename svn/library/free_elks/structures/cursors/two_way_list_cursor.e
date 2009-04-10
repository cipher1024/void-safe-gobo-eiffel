note
	description: "Cursors for two way lists."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-03-16 19:28:54 +0100 (lun., 16 mars 2009) $"
	revision: "$Revision: 6620 $"

class
	TWO_WAY_LIST_CURSOR [G]

inherit
	LINKED_LIST_CURSOR [G]
		redefine
			active
		end

create
	make

feature {TWO_WAY_LIST} -- Implementation

	active: detachable BI_LINKABLE [G];
			-- Current element in linked list

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
