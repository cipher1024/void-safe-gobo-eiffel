indexing

	description:

		"XPath expression equality testers"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2008-05-05 19:06:00 +0200 (Mon, 05 May 2008) $"
	revision: "$Revision: 6390 $"

class XM_XPATH_EXPRESSION_TESTER

inherit

	KL_EQUALITY_TESTER [XM_XPATH_EXPRESSION]
		redefine
			test
		end

feature -- Status report

	test (v, u: XM_XPATH_EXPRESSION): BOOLEAN is
			-- Are `v' and `u' considered equal?
		do
			if v = u then
				Result := True
			elseif v = Void then
				Result := False
			elseif u = Void then
				Result := False
			else
				Result := v.same_expression (u)
			end
		end

end
