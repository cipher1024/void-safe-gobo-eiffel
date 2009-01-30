indexing

	description:

		"Shared XPath comparsion key testers"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_SHARED_COMPARISON_KEY_TESTER

feature -- Access

	comparison_key_tester: XM_XPATH_COMPARISON_KEY_TESTER is
			-- Comparison key equality tester
		once
			create Result
		ensure
			comparison_key_tester_not_void: Result /= Void
		end
	
end
	
