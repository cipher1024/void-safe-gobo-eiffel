indexing

	description:

		"Objects that provide access to a shared function library during stylesheet module compilation"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XSLT_SHARED_FUNCTION_LIBRARY

feature -- Access

	shared_function_library: XM_XPATH_FUNCTION_LIBRARY_MANAGER is
			-- Establish invariant
		local
			a_function_library: XM_XPATH_FUNCTION_LIBRARY
		once
			create Result.make
			create {XM_XSLT_SYSTEM_FUNCTION_LIBRARY} a_function_library.make
			Result.add_function_library (a_function_library)
			create {XM_XPATH_CONSTRUCTOR_FUNCTION_LIBRARY} a_function_library.make
			Result.add_function_library (a_function_library)
		end
end
	
