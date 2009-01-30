indexing

	description:

		"Objects that fail to match against any node"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_NO_NODE_TEST

inherit

	XM_XPATH_NODE_TEST
		redefine
			is_no_node_test
		end

create {XM_XPATH_SHARED_NO_NODE_TEST}

	make

feature {NONE} -- Initialization

	make is
		do
			original_text := "empty-sequence()"
		end

feature -- Access

	is_no_node_test: BOOLEAN is
			-- Is `Current' a no-node test?
		do
			Result := True
		end

	node_kind_mask: INTEGER is
			-- Mask of types of nodes matched
		do
			Result := 0
		end
	
feature -- Status report

	-- Not sure if this next feature is needed

	allows_text_nodes: BOOLEAN is
			-- Does this node test allow text nodes?
		do
			Result := False
		end

feature -- Matching

	matches_node (a_node_kind: INTEGER; a_fingerprint: INTEGER; a_node_type: INTEGER): BOOLEAN is
			-- Is this node test satisfied by a given node?
		do
			Result := False
		end

end
