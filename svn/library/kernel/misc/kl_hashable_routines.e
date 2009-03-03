indexing

	description:

		"Routines that ought to be in class HASHABLE"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2009-03-02 18:28:36 +0100 (Mon, 02 Mar 2009) $"
	revision: "$Revision: 6595 $"

class KL_HASHABLE_ROUTINES

feature -- Access

	hash_value (an_any: ANY): INTEGER is
			-- Hash code value
		require
			an_any_not_void: an_any /= Void
		local
			hashable: ?HASHABLE
		do
			hashable ?= an_any
			if hashable /= Void then
				Result := hashable.hash_code
			else
				Result := an_any.generating_type.hash_code
			end
		ensure
			hash_value_not_negative: Result >= 0
		end

end
