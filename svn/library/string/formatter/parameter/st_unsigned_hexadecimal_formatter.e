indexing

	description:

		"Formatters for unsigned integer parameters, $x or $X"

	library: "Gobo Eiffel String Library"
	copyright: "Copyright (c) 2004-2005, Object-Tools and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class ST_UNSIGNED_HEXADECIMAL_FORMATTER

inherit

	ST_UNSIGNED_INTEGER_FORMATTER

create

	make

feature -- Access

	base: INTEGER is 16
			-- Base used to format integer;
			-- 8 for octal, 10 for decimal, 16 for hexadecimal, ...

end
