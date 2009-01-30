indexing

	description:

		"Imported routines that ought to be in class CHARACTER"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_IMPORTED_CHARACTER_ROUTINES

feature -- Access

	CHARACTER_: KL_CHARACTER_ROUTINES is
			-- Routines that ought to be in class CHARACTER
		once
			create Result
		ensure
			character_routines_not_void: Result /= Void
		end

end
