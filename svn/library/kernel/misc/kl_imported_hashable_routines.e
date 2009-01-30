indexing

	description:

		"Imported routines that ought to be in class HASHABLE"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_IMPORTED_HASHABLE_ROUTINES

feature -- Access

	HASHABLE_: KL_HASHABLE_ROUTINES is
			-- Routines that ought to be in class HASHABLE
		once
			create Result
		ensure
			hashable_routines_not_void: Result /= Void
		end

end
