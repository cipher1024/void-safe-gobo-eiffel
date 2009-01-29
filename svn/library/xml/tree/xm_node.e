indexing

	description:

		"XML nodes"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

deferred class XM_NODE

inherit

	ANY

	KL_CLONABLE

	XM_UNICODE_STRUCTURE_FACTORY
		export {NONE} all end

feature -- Access

	parent: ?XM_COMPOSITE
			-- Parent of current node;
			-- Void if current node is root

feature -- Status report

	parent_element: XM_ELEMENT is
			-- Parent element.
		require
			not_root_node: not is_root_node
			not_root_element: {p: like parent} parent and then not p.is_root_node
		local
			typer: XM_NODE_TYPER
			l_parent: like parent
			l_element: ?XM_ELEMENT
		do
			create typer
			l_parent := parent
			check l_parent /= Void end -- implied by not is_root_node
			l_parent.process (typer)
			check precondition: typer.is_element end
			l_element := typer.element
			check l_element /= Void end -- implied by `precondition: typer.is_element'
			Result := l_element
		ensure
			result_not_void: Result /= Void
		end

	root_node: XM_DOCUMENT is
			-- Root node of current node
		local
			l_parent: like parent
		do
			check not_root_node: not is_root_node end
			-- is_root_node case dealt by descendant because
			-- we cannot do Result := Current here.
			l_parent := parent
			check l_parent /= Void end -- implied by `not_root_node'
			Result := l_parent.root_node
		ensure
			result_not_void: Result /= Void
		end

	level: INTEGER is
			-- Depth at which current node appears relative to its root
			-- (The root node has the level 1.)
		local
			l_parent: like parent
		do
			if is_root_node then
				Result := 1
			else
				l_parent := parent
				check l_parent /= Void end -- implied by `is_root_node'
				Result := l_parent.level + 1
			end
		ensure
			root_level: is_root_node implies (Result = 1)
		end

	is_root_node: BOOLEAN is
			-- Is current node the root node?
		do
			Result := (parent = Void)
		ensure
			definition: Result = (parent = Void)
		end

	is_first: BOOLEAN is
			-- Is this node the first in its parent's child list,
			-- or the root node?
		local
			l_parent: like parent
		do
			if is_root_node then
				Result := True
			else
				l_parent := parent
				check l_parent /= Void end -- implied by `is_root_node'
				Result := l_parent.first = Current
			end
		ensure
			definition: Result = (is_root_node or else {p: like parent} parent and then (p.first = Current))
		end

	is_last: BOOLEAN is
			-- Is this node the last in its parent's child list,
			-- or the root node?
		local
			l_parent: like parent
		do
			if is_root_node then
				Result := True
			else
				l_parent := parent
				check l_parent /= Void end -- implied by `is_root_node'
				Result := l_parent.last = Current
			end
		ensure
			definition: Result = (is_root_node or else {p: like parent} parent and then (p.last = Current))
		end

feature -- Element change

	set_parent (a_parent: like parent) is
			-- Set `parent' to `a_parent'.
		require
			a_parent_not_void: a_parent /= Void
			not_root_node: not is_root_node
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

feature {XM_COMPOSITE} -- Element change

	node_set_parent (a_parent: like parent) is
			-- Set `parent' to `a_parent'.
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

feature {NONE} -- Implementation

	Default_ns: XM_NAMESPACE is
			-- Shared default namespace constant object.
		once
			create Result.make_default
		ensure
			definition: Result.uri.count = 0
		end

feature -- Processing

	process (a_processor: XM_NODE_PROCESSOR) is
			-- Process current node with `a_processor'.
		require
			a_processor_not_void: a_processor /= Void
		deferred
		end

end
