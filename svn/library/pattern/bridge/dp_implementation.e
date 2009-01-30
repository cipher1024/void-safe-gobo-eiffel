indexing

	description:

		"Implementation in the Bridge Pattern"

	library: "Gobo Eiffel Pattern Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:35:10 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6524 $"

class DP_IMPLEMENTATION

feature {DP_INTERFACE} -- Status report

	can_implement (an_interface: DP_INTERFACE): BOOLEAN is
			-- Can current implementation implement `an_interface'?
		require
			an_interface_not_void: an_interface /= Void
		do
			Result := True
		end

feature {DP_INTERFACE} -- Setting

	implement (an_interface: DP_INTERFACE) is
			-- Tell current implementation to implement `an_interface'?
		require
			an_interface_not_void: an_interface /= Void
			can_implement: can_implement (an_interface)
			valid_interface: an_interface.implementation = Current
		do
		end

end
