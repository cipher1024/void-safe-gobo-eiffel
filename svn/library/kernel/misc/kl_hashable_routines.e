indexing

	description:

		"Routines that ought to be in class HASHABLE"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-07-26 10:10:48 +0200 (Sat, 26 Jul 2008) $"
	revision: "$Revision: 6456 $"

class KL_HASHABLE_ROUTINES

feature -- Access

	hash_value (an_any: ANY): INTEGER is
			-- Hash code value
		require
			an_any_not_void: an_any /= Void
		do
			if {hashable: HASHABLE} an_any then
				Result := hashable.hash_code
			else
				Result := an_any.generating_type.hash_code
			end
		ensure
			hash_value_not_negative: Result >= 0
		end

end
