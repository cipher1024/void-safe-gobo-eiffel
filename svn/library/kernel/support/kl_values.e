indexing

	description:

		"Values that are accessible through keys"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2009-03-02 18:28:36 +0100 (Mon, 02 Mar 2009) $"
	revision: "$Revision: 6595 $"

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
