indexing

	description:

		"Strings as source of XML documents"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_STRING_SOURCE

inherit

	XM_SOURCE

feature -- Output

	out: STRING is
			-- Textual representation
		once
			Result := "STRING"
		end
	
end
