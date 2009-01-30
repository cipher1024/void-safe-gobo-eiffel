indexing

	description:

		"Clonable objects"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2005, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-07-26 10:10:48 +0200 (Sat, 26 Jul 2008) $"
	revision: "$Revision: 6456 $"

class KL_CLONABLE

inherit

	ANY

	KL_IMPORTED_ANY_ROUTINES
		export {NONE} all end

feature -- Duplication

	cloned_object: like Current is
			-- Clone of current object
		do
			Result := twin
		ensure
			cloned_not_void: Result /= Void
			same_type: ANY_.same_types (Result, Current)
			is_equal: Result.is_equal (Current)
		end

end
