indexing

	description:

	"Objects that can be passed to an XM_XPATH_NODE_MAPPING_ITERATOR.%
	%Such objects, when given an XM_XPATH_NODE, can generate an%
	%XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_NODE] which delivers%
	%a series of such items."

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

deferred class XM_XPATH_NODE_MAPPING_FUNCTION
	
feature -- Access

	last_node_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_NODE] is
			-- Result from `map_nodes'
		deferred
		end

feature -- Evaluation

	map_nodes (an_item: XM_XPATH_ITEM; a_context: XM_XPATH_CONTEXT) is
			-- Map `an_item' to a sequence
		require
			item_not_void: an_item /= Void
		deferred

			-- If an error is detected, then this command should create an invalid iterator

		ensure
			result_not_void: last_node_iterator /= Void
		end

end
