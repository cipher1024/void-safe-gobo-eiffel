indexing

	description:

		"Singleton object that represent any item"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_SHARED_ANY_ITEM_TYPE

feature -- Access

	any_item: XM_XPATH_ANY_ITEM_TYPE is
			-- Singleton
		once
			create Result.make
		end

end
	
