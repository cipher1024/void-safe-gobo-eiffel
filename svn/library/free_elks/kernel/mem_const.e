note
	description: "[
		Constants used by memory management.
		This class may be used as ancestor by classes needing its facilities.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2004, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2009-01-12 17:05:16 +0100 (Mon, 12 Jan 2009) $"
	revision: "$Revision: 6572 $"

class
	MEM_CONST

feature -- Access

	Total_memory: INTEGER = 0
			-- Code for all the memory managed
			-- by the garbage collector

	Eiffel_memory: INTEGER = 1
			-- Code for the Eiffel memory managed
			-- by the garbage collector

	C_memory: INTEGER = 2
			-- Code for the C memory managed
			-- by the garbage collector

	Full_collector: INTEGER = 0
			-- Statistics for full collections

	Incremental_collector: INTEGER = 1;
			-- Statistics for incremental collections

end
