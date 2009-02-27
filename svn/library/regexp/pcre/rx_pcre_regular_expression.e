indexing

	description:

		"PCRE regular expressions"

	library: "Gobo Eiffel Regexp Library"
	copyright: "Copyright (c) 2001-2002, Harald Erdbruegger and others"
	license: "MIT License"
	date: "$Date: 2009-02-26 23:52:17 +0100 (Thu, 26 Feb 2009) $"
	revision: "$Revision: 6590 $"

class RX_PCRE_REGULAR_EXPRESSION

inherit

	RX_REGULAR_EXPRESSION
		undefine
			wipe_out
		end

	RX_PCRE_MATCHER

create

	make

end
