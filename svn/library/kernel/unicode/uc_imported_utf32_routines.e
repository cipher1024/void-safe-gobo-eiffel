indexing

	description:

		"Imported UTF-32 encoding routines"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class UC_IMPORTED_UTF32_ROUTINES

feature -- Access

	utf32: UC_UTF32_ROUTINES is
			-- UTF-32 encoding routines
		once
			create Result
		ensure
			utf32_not_void: Result /= Void
		end

end
