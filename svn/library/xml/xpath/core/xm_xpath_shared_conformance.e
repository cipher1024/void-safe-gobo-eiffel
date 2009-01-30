indexing

	description:

		"Shared access to conformance to XPath, XQuery and XSLT standards"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_SHARED_CONFORMANCE

feature -- Access

	conformance: XM_XPATH_CONFORMANCE is
			-- The shared conformance object
		once
			create Result
		end

end
