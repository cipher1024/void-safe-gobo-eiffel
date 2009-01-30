indexing

	description:

		"Shared equality testers between strings that can be polymorphically unicode strings"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class UC_SHARED_STRING_EQUALITY_TESTER

feature -- Access

	string_equality_tester: UC_STRING_EQUALITY_TESTER is
			-- String equality tester
		once
			create Result
		ensure
			string_equality_tester_not_void: Result /= Void
		end

end
