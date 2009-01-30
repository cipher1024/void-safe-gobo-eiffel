indexing

	description:

		"Shared garbage collection facilities"

	pattern: "Singleton"
	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-02-14 11:45:23 +0100 (Thu, 14 Feb 2008) $"
	revision: "$Revision: 6302 $"

class KL_SHARED_MEMORY

feature -- Access

	memory: KL_MEMORY is
			-- Garbage collection facilities
		once
			create Result
		ensure
			memory_not_void: Result /= Void
		end

end
