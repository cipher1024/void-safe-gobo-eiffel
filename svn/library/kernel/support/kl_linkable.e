indexing

	description:

		"Linkable cells with a reference to their right neighbor"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2009-03-02 18:28:36 +0100 (Mon, 02 Mar 2009) $"
	revision: "$Revision: 6595 $"

class KL_LINKABLE [G]

inherit

	KL_CELL [G]

create

	make

feature -- Access

	right: ?like Current
			-- Right neighbor

feature -- Element change

	put_right (other: like Current) is
			-- Put `other' to right of cell.
		require
			other_not_void: other /= Void
		do
			right := other
		ensure
			linked: right = other
		end

	forget_right is
			-- Remove right neighbor.
		do
			right := Void
		ensure
			forgotten: right = Void
		end

end
