indexing

	description:

		"Shared Eiffel compiler used to compile this program"

	pattern: "Singleton"
	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_SHARED_EIFFEL_COMPILER

feature -- Acess

	eiffel_compiler: KL_EIFFEL_COMPILER is
			-- Eiffel compiler used to compile this program
		once
			create Result
		ensure
			eiffel_compiler_not_void: Result /= Void
		end

end
