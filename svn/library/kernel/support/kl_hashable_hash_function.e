indexing

	description:

		"Hash-code functions for HASHABLE objects, using their `hash_code' feature"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-12-16 11:18:43 +0100 (dim., 16 déc. 2007) $"
	revision: "$Revision: 6213 $"

class KL_HASHABLE_HASH_FUNCTION [G -> HASHABLE]

inherit

	KL_HASH_FUNCTION [G]

feature -- Access

	hash_code (v: G): INTEGER is
			-- Hash code for `v'
		do
			Result := v.hash_code
		end

end
