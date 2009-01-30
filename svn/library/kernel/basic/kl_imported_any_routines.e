indexing

	description:

		"Imported routines that ought to be in class ANY"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2005, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_IMPORTED_ANY_ROUTINES

feature -- Access

	ANY_: KL_ANY_ROUTINES is
			-- Routines that ought to be in class ANY
		once
			create Result
		ensure
			any_routines_not_void: Result /= Void
		end

end
