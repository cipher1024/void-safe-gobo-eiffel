indexing
	description: "[
		Exception manager factory.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-12 09:58:30 +0200 (Mon, 12 May 2008) $"
	revision: "$Revision: 6408 $"

class
	EXCEPTION_MANAGER_FACTORY

feature -- Access

	exception_manager: EXCEPTION_MANAGER is
			-- Exception manager
		once
			create Result
		ensure
			exception_manager_not_void: Result /= Void
		end

end
