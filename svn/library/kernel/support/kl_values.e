indexing

	description:

		"Values that are accessible through keys"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-05 12:21:37 +0200 (Sun, 05 Oct 2008) $"
	revision: "$Revision: 6530 $"

deferred class KL_VALUES [G, K]

feature -- Access

	value (k: K): ?G is
			-- Item associated with `k';
			-- Return default value if no such item
		require
			k_not_void: k /= Void
		deferred
		end

end
