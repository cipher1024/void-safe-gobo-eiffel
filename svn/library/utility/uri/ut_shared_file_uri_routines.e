indexing

	description:

		"Shared access to file: URI routines"

	library: "Gobo Eiffel Utility Library"
	copyright: "Copyright (c) 2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class UT_SHARED_FILE_URI_ROUTINES

feature -- Access

	File_uri: UT_FILE_URI_ROUTINES is
			-- Shared file: URI routines
		once
			create Result
		ensure
			file_uri_not_void: Result /= Void
		end

end
