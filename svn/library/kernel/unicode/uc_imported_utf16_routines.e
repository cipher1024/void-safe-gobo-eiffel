indexing

	description:

		"Imported UTF-16 encoding routines"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class UC_IMPORTED_UTF16_ROUTINES

feature -- Access

	utf16: UC_UTF16_ROUTINES is
			-- UTF-16 encoding routines
		once
			create Result
		ensure
			utf16_not_void: Result /= Void
		end

end
