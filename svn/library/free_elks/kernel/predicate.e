note
	description: "[
		Objects representing delayed calls to a boolean function,
		with some arguments possibly still open.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2009-03-16 19:28:54 +0100 (Mon, 16 Mar 2009) $"
	revision: "$Revision: 6620 $"

class
	PREDICATE [BASE_TYPE, OPEN_ARGS -> detachable TUPLE create default_create end]

inherit
	FUNCTION [BASE_TYPE, OPEN_ARGS, BOOLEAN]

end
