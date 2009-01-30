indexing

	description:

		"Shared standard files"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999-2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_SHARED_STANDARD_FILES

feature -- Access

	std: KL_STANDARD_FILES is
			-- Standard files
		once
			create Result
		ensure
			std_not_void: Result /= Void
		end

end
