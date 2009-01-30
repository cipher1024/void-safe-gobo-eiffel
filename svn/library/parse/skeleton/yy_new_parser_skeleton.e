indexing

	description:

		"Skeletons for parsers implemented with tables"

	remark: "[
		To be used with 'geyacc --new_typing'. Use YY_OLD_PARSER_SKELETON and
		'geyacc --old_typing' instead, or switch to YY_PARSER_SKELETON.
	]"
	library: "Gobo Eiffel Parse Library"
	copyright: "Copyright (c) 2001-2005, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-05 12:21:37 +0200 (Sun, 05 Oct 2008) $"
	revision: "$Revision: 6530 $"

deferred class YY_NEW_PARSER_SKELETON

obsolete

	"[050311] Use YY_PARSER_SKELETON and 'geyacc --new_typing' instead."

inherit

	YY_PARSER_SKELETON

end
