indexing

	description:

		"Objects that provide shared access to an atomizing function"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_SHARED_ATOMIZING_FUNCTION

feature -- Access

	shared_atomizing_function: XM_XPATH_ATOMIZING_FUNCTION is
			-- Shared object
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

end

	
