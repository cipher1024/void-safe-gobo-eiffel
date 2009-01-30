indexing

	description:

		"Shared XPath atomic-value equality testers"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_SHARED_ATOMIC_VALUE_TESTER
	
feature -- Access

	atomic_value_tester: XM_XPATH_ATOMIC_VALUE_TESTER is
			-- Atomic_value equality tester
		once
			create Result
		ensure
			atomic_value_tester_not_void: Result /= Void
		end

end
