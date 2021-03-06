indexing

	description:

		"Factory interface for XML parsers"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

deferred class XM_PARSER_FACTORY

feature -- Status report

	is_parser_available: BOOLEAN is
			-- Is XML parser available?
		deferred
		end

feature -- Access

	new_parser: XM_PARSER is
			-- New XML parser
		require
			parser_available: is_parser_available
		deferred
		ensure
			parser_not_void: Result /= Void
		end

end
