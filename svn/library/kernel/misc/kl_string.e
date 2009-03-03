indexing

	description:

		"Adapters for class STRING during the transition period from infix/prefix to alias"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2009, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2009-03-03 11:33:29 +0100 (Tue, 03 Mar 2009) $"
	revision: "$Revision: 6599 $"

class KL_STRING

inherit

	STRING
		rename
			infix "<" as is_less alias "<",
			infix "<=" as is_less_equal alias "<=",
			infix ">" as is_greater alias ">",
			infix ">=" as is_greater_equal alias ">=",
			infix "@" as at alias "@",
			infix "+" as plus alias "+"
		end

create

	make

end
