indexing

	description: 

		"Shared instance of UT_URL_ENCODING"

	library: "Gobo Eiffel Utility Library"
	author: "Copyright (c) 2004, Eric Bezault and others"
	date: "$Date: 2005-03-15 20:17:41 +0100 (Tue, 15 Mar 2005) $"
	revision: "$Revision: 4832 $"

class UT_SHARED_URL_ENCODING

feature -- Access

	Url_encoding: UT_URL_ENCODING is
			-- Shared instance of URL encoding routines
		once
			create Result
		ensure
			url_encoding_not_void: Result /= Void
		end

end
