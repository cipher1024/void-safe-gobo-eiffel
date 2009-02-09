indexing

	description:

		"Imported type anchor for FIXED_ARRAY [G]. %
		%A fixed array is a zero-based indexed sequence of values, %
		%equipped with features `put', `item' and `count'."

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-06 09:53:14 +0200 (Mon, 06 Oct 2008) $"
	revision: "$Revision: 6531 $"

class KL_IMPORTED_FIXED_ARRAY_TYPE [G]

obsolete

	"[041219] Use SPECIAL and KL_SPECIAL_ROUTINES instead."

feature -- Type anchors

	FIXED_ARRAY_TYPE: SPECIAL [G] is
			-- Type anchor
		require
			do_not_call: False
		do
			Result := FIXED_ARRAY_TYPE --| void-safety: this code should never be called.
		end

end
