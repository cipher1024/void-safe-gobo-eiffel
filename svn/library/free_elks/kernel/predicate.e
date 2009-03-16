note
	description: "[
		Objects representing delayed calls to a boolean function,
		with some arguments possibly still open.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2009-03-14 15:13:03 +0100 (Sat, 14 Mar 2009) $"
	revision: "$Revision: 6612 $"

class
	PREDICATE [BASE_TYPE, OPEN_ARGS -> ?TUPLE create default_create end]

inherit
	FUNCTION [BASE_TYPE, OPEN_ARGS, BOOLEAN]

end
