indexing

	description:

		"Singleton XSLT pattern that matches any node"

	library: "Gobo Eiffel XXLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XSLT_SHARED_ANY_NODE_TEST

feature -- Access

	any_xslt_node_test: XM_XSLT_ANY_NODE_TEST is
			-- Singleton
		once
			create Result.make
		end

end
	
