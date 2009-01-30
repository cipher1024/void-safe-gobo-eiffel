indexing

	description:

		"States of finite automata"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-05 12:21:37 +0200 (Sun, 05 Oct 2008) $"
	revision: "$Revision: 6530 $"

deferred class LX_STATE

inherit

	KL_CLONABLE

feature -- Status report

	is_accepting: BOOLEAN is
			-- Is current state an accepting state?
		deferred
		end

end
