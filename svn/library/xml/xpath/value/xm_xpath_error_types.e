indexing

	description:

		"XPath error value types and codes"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_ERROR_TYPES

inherit

	ANY -- For SE 2.x, so that `is_equal' is exported

	UC_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

feature -- Access

	Static_error: INTEGER is 1
	Type_error: INTEGER is 2
	Dynamic_error: INTEGER is 3

end
	
