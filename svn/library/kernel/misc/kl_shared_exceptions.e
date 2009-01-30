indexing

	description:

		"Shared exception handling"

	pattern: "Singleton"
	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_SHARED_EXCEPTIONS

feature -- Access

	Exceptions: KL_EXCEPTIONS is
			-- Exception handling
		once
			create Result
		ensure
			exceptions_not_void: Result /= Void
		end

feature -- Obsolete

	exceptions_: KL_EXCEPTIONS is
			-- Exception handling
		obsolete
			"[040101] Use `Exceptions' instead."
		once
			Result := Exceptions
		ensure
			exceptions_not_void: Result /= Void
		end

end
