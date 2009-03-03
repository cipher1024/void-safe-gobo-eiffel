indexing

	description:

		"Adapters for class STRING during the transition period from infix/prefix to alias"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2009, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2009-03-02 18:28:36 +0100 (Mon, 02 Mar 2009) $"
	revision: "$Revision: 6595 $"

class KL_STRING

inherit

	STRING

create
	make,
	make_empty,
	make_filled,
	make_from_string,
	make_from_c,
	make_from_c_pointer,
	make_from_cil

end
