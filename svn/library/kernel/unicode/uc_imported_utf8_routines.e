indexing

	description:

		"Imported UTF-8 encoding routines"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class UC_IMPORTED_UTF8_ROUTINES

feature -- Access

	utf8: UC_UTF8_ROUTINES is
			-- UTF-8 encoding routines
		once
			create Result
		ensure
			utf8_not_void: Result /= Void
		end

end
