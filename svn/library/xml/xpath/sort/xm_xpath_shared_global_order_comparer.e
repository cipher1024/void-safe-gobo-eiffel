indexing

	description:

		"Shared access to singleton global order comparer"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_SHARED_GLOBAL_ORDER_COMPARER

feature -- Access

	global_order_comparer: XM_XPATH_GLOBAL_ORDER_COMPARER is
			-- Shared singleton instance
		once
			create Result
		end
	
end
	
