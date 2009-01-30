indexing

	description:

		"Objects that provide shared access to a singleton catalog manager"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_SHARED_CATALOG_MANAGER

feature -- Access

	shared_catalog_manager: XM_CATALOG_MANAGER is
			-- Shared catalog manager
		once
			create Result.make
		ensure
			shared_catalog_manager_not_void: Result /= Void
		end

end
	
