note

	description: "[
		Basic mathematical constants.
		This class may be used as ancestor by classes needing its facilities.
		]"

	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 2005, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2009-01-12 17:05:16 +0100 (Mon, 12 Jan 2009) $"
	revision: "$Revision: 6572 $"

class
	MATH_CONST

feature -- Access

	Pi: DOUBLE = 3.14159265358979323846

	Sqrt2: DOUBLE = 1.41421356237309504880
			-- Square root of 2

	Euler: DOUBLE = 2.7182818284590452354;
			-- Logarithm base

end
