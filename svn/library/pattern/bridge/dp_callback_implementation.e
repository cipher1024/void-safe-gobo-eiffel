indexing

	description:

		"Implementation in the Bridge Pattern, %
		%with a reference back to its interface."

	library: "Gobo Eiffel Pattern Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:35:10 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6524 $"

class DP_CALLBACK_IMPLEMENTATION

inherit

	DP_IMPLEMENTATION
		redefine
			can_implement,
			implement
		end

feature {DP_INTERFACE} -- Status report

	can_implement (an_interface: !like interface): BOOLEAN is
			-- Can current implementation implement `an_interface'?
		do
			Result := (interface = Void or else interface = an_interface)
		end

feature {DP_INTERFACE} -- Setting

	implement (an_interface: !like interface) is
			-- Tell current implementation to implement `an_interface'?
		do
			interface := an_interface
		ensure then
			implemented: interface = an_interface
		end

feature {DP_INTERFACE} -- Implementation

	interface: ?DP_INTERFACE
			-- Interface

invariant

	bidirectional: {ot_interface: like interface} interface implies ot_interface.implementation = Current

end
