indexing

	description:

		"Interface in the Bridge Pattern"

	library: "Gobo Eiffel Pattern Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:35:10 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6524 $"

class DP_INTERFACE
create
	make_from_implementation

feature {NONE} -- Initialization

	make_from_implementation (an_implementation: like implementation) is
			-- Create a new interface using
			-- `an_implementation' as implementation.
		require
			an_implementation_not_void: an_implementation /= Void
		do
			implementation := an_implementation
			check valid_implementation: an_implementation.can_implement (Current) end
			implementation.implement (Current)
		ensure
			implementation_set: implementation = an_implementation
		end

feature {DP_IMPLEMENTATION, DP_INTERFACE} -- Implementation

	implementation: DP_IMPLEMENTATION
			-- Implementation

invariant

	implementation_not_void: implementation /= Void
	valid_implementation: implementation.can_implement (Current)

end
