indexing

	description:

		"Classification class for nodes that can be children of the document node"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2003, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"
	
deferred class XM_DOCUMENT_NODE

inherit

	XM_NODE

invariant

	--document_parent_not_void: parent /= Void
	
end
