indexing

	description:

		"Shared execution environment facilities"

	pattern: "Singleton"
	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_SHARED_EXECUTION_ENVIRONMENT

feature -- Access

	Execution_environment: KL_EXECUTION_ENVIRONMENT is
			-- Execution environment
		once
			create Result
		ensure
			execution_environment_not_void: Result /= Void
		end

end
