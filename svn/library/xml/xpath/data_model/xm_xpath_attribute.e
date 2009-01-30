indexing

	description:

		"XPath Attribute nodes"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2003, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2008-04-05 21:24:10 +0200 (Sat, 05 Apr 2008) $"
	revision: "$Revision: 6339 $"

deferred class XM_XPATH_ATTRIBUTE

inherit

	XM_XPATH_NODE
	
feature -- Access

	node_kind: STRING is
			-- Kind of node
		do
			Result := "attribute"
		ensure then
			node_kind_is_attribute: STRING_.same_string (Result, "attribute")
		end
	
	item_type: XM_XPATH_ITEM_TYPE is
			-- Type
		do
			 Result := attribute_node_kind_test
		end

	path: STRING is
			-- XPath expression for location within document;
			-- Used for reporting purposes.
		do
			Result := STRING_.concat ("/@", node_name)
			if parent /= Void then
				Result := STRING_.appended_string (parent.path, Result)
			end
		end

end
