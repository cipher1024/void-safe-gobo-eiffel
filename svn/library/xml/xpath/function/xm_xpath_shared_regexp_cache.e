indexing

	description:

		"Objects that provide shared access to a singleton compiled regular expression cache"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_SHARED_REGEXP_CACHE

feature -- Access

	shared_regexp_cache: XM_XPATH_REGEXP_CACHE is
			-- Shared instance
		once
			create Result.make
		end
	
end
	
