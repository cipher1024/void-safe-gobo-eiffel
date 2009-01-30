indexing

	description:

		"Shared command-line arguments"

	pattern: "Singleton"
	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_SHARED_ARGUMENTS

feature -- Access

	Arguments: KL_ARGUMENTS is
			-- Command-line arguments
		once
			create Result.make
		ensure
			arguments_not_void: Result /= Void
		end

end
