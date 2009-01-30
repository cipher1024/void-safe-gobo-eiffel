indexing

	description:

		"Locators that provide no useful information"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_DEFAULT_LOCATOR

inherit

	XM_XPATH_LOCATOR

feature -- Access

	system_id: STRING is ""
			-- Current SYSTEM ID

	line_number: INTEGER is 0
			-- Approximate line number of current event, or 0 if unknown

end
