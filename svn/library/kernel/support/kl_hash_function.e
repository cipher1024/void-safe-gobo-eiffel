indexing

	description:

		"Hash-code functions"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-12-16 11:18:43 +0100 (Sun, 16 Dec 2007) $"
	revision: "$Revision: 6213 $"

deferred class KL_HASH_FUNCTION [G]

feature -- Access

	hash_code (v: G): INTEGER is
			-- Hash code for `v'
		require
			v_not_void: v /= Void
		deferred
		ensure
			hash_code_not_negative: Result >= 0
		end

end
