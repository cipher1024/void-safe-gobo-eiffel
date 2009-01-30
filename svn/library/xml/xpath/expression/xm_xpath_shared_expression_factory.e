indexing

	description:

		"Shared XPath expression factory"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_SHARED_EXPRESSION_FACTORY
	
feature -- Access

	expression_factory: XM_XPATH_EXPRESSION_FACTORY is
			-- Expression equality tester
		once
			create Result
		ensure
			expression_factory_not_void: Result /= Void
		end

end
