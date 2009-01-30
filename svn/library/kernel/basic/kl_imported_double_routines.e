indexing

	description:

		"Imported routines that ought to be in class DOUBLE"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2003, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_IMPORTED_DOUBLE_ROUTINES

feature -- Access

	DOUBLE_: KL_DOUBLE_ROUTINES is
			-- Routines that ought to be in class DOUBLE
		once
			create Result
		ensure
			double_routines_not_void: Result /= Void
		end

end
