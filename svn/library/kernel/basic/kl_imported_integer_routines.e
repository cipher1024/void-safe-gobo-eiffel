indexing

	description:

		"Imported routines that ought to be in class INTEGER"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_IMPORTED_INTEGER_ROUTINES

feature -- Access

	INTEGER_: KL_INTEGER_ROUTINES is
			-- Routines that ought to be in class INTEGER
		once
			create Result
		ensure
			integer_routines_not_void: Result /= Void
		end

end
