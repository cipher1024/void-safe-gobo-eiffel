indexing

	description:

		"Shared XPath expression equality testers"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_SHARED_EXPRESSION_TESTER
	
feature -- Access

	expression_tester: XM_XPATH_EXPRESSION_TESTER is
			-- Expression equality tester
		once
			create Result
		ensure
			expression_tester_not_void: Result /= Void
		end

end
