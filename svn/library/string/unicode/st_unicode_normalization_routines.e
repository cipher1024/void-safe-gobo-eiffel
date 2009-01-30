indexing

	description:

		"Routines for normalizing Unicode strings"

	remark: "[
		These routines will not work on UTF-16 strings - they will
		need a few modifications to account of surrogates.
	]"
	library: "Gobo Eiffel String Library"
	copyright: "Copyright (c) 2006, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2008-10-06 09:53:14 +0200 (Mon, 06 Oct 2008) $"
	revision: "$Revision: 6531 $"

class ST_UNICODE_NORMALIZATION_ROUTINES

inherit

	ST_UNICODE_V510_NORMALIZATION_ROUTINES

end
