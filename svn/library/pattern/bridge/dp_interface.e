indexing

	description:

		"Interface in the Bridge Pattern"

	library: "Gobo Eiffel Pattern Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date: 2009-04-23 16:03:08 +0200 (Thu, 23 Apr 2009) $"
	revision: "$Revision: 6627 $"

deferred class DP_INTERFACE

obsolete

	"[090423] This class does not work well in void-safe mode. Please stop using it."

feature {NONE} -- Initialization

	make_from_implementation (an_implementation: like implementation) is
			-- Create a new interface using
			-- `an_implementation' as implementation.
		require
			an_implementation_not_void: an_implementation /= Void
			valid_implementation: an_implementation.can_implement (Current)
		do
			implementation := an_implementation
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
