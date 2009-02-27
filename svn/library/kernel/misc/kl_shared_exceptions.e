indexing

	description:

		"Shared exception handling"

	pattern: "Singleton"
	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2009-02-26 23:52:17 +0100 (Thu, 26 Feb 2009) $"
	revision: "$Revision: 6590 $"

class KL_SHARED_EXCEPTIONS

feature -- Access

	Exceptions: KL_EXCEPTIONS is
			-- Exception handling
		once
			create Result
		ensure
			exceptions_not_void: Result /= Void
		end

end
