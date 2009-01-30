indexing

	description:

		"Shared access to XM_XPATH_DEFAULT_NAME_POOL"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2003, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2008-04-06 12:00:43 +0200 (Sun, 06 Apr 2008) $"
	revision: "$Revision: 6341 $"

class XM_XPATH_SHARED_NAME_POOL
	
feature -- Access

	shared_name_pool: XM_XPATH_NAME_POOL is
			-- Shared name pool
		once
			create Result.make
		ensure
			shared_name_pool_not_void: Result /= Void
		end

end
	
