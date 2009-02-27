indexing

	description:

		"Shared platform-dependent properties"

	pattern: "Singleton"
	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2009-02-26 23:52:17 +0100 (Thu, 26 Feb 2009) $"
	revision: "$Revision: 6590 $"

class KL_SHARED_PLATFORM

inherit

	KL_ANY

feature -- Access

	Platform: KL_PLATFORM is
			-- Platform-dependent properties
		once
			create Result
		ensure
			platform_not_void: Result /= Void
		end

end
