note
	description: "[
		Objects representing delayed calls to a boolean function,
		with some arguments possibly still open.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2004, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2009-01-12 17:05:16 +0100 (Mon, 12 Jan 2009) $"
	revision: "$Revision: 6572 $"

class
	PREDICATE [BASE_TYPE, OPEN_ARGS -> TUPLE create default_create end]

inherit
	FUNCTION [BASE_TYPE, OPEN_ARGS, BOOLEAN]

end
