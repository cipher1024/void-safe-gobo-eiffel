indexing

	description:
	"[
		Binary search tree nodes which associate keys and items.
		Nodes may be linked to other binary search tree nodes.
	]"
	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 2008, Daniel Tuser and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:40:54 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6526 $"

deferred class DS_BINARY_SEARCH_TREE_CONTAINER_NODE [G, K]

feature {DS_BINARY_SEARCH_TREE_CONTAINER, DS_BINARY_SEARCH_TREE_CONTAINER_NODE, DS_BINARY_SEARCH_TREE_CONTAINER_CURSOR} -- Access

	item: G is
			-- Item
		deferred
		end

	key: K
			-- Key

feature {DS_BINARY_SEARCH_TREE_CONTAINER, DS_BINARY_SEARCH_TREE_CONTAINER_NODE} -- Access

	parent: ?like Current
			-- Parent

	left_child: like parent
			-- First child

	right_child: like parent
			-- Second child

feature {DS_BINARY_SEARCH_TREE_CONTAINER, DS_BINARY_SEARCH_TREE_CONTAINER_NODE} -- Measurement

	count: INTEGER is
			-- Number of nodes, including the current node and
			-- recursively the number of nodes in its children
		local
			l_child: like parent
		do
			Result := 1
			l_child := left_child
			if l_child /= Void then
				Result := Result + l_child.count
			end
			l_child := right_child
			if l_child /= Void then
				Result := Result + l_child.count
			end
		ensure
			count_positive: Result > 0
		end

	height: INTEGER is
			-- Height of the branch in which `Current' is seen as root node
		do
			Result := height_of_left_child.max (height_of_right_child) + 1
		ensure
			height_positive: Result > 0
		end

	height_of_left_child: INTEGER is
			-- Height of the branch where `left_child' is seen as root node
		local
			l_left_child: like left_child
		do
			l_left_child := left_child
			if l_left_child /= Void then
				Result := l_left_child.height
			end
		ensure
			height_not_negative: Result >= 0
			zero_iff_child_is_void: (left_child = Void) = (Result = 0)
		end

	height_of_right_child: INTEGER is
			-- Height of branch where `right_child' is seen as root node
		local
			l_right_child: like right_child
		do
			l_right_child := right_child
			if l_right_child /= Void then
				Result := l_right_child.height
			end
		ensure
			height_not_negative: Result >= 0
			zero_iff_child_is_void: (right_child = Void) = (Result = 0)
		end

feature {DS_BINARY_SEARCH_TREE_CONTAINER, DS_BINARY_SEARCH_TREE_CONTAINER_NODE} -- Status report

	sorted (a_comparator: KL_COMPARATOR [K]): BOOLEAN is
			-- Definition: A binary search tree is sorted iff the `key' of the `left_child'
			-- of every node in the tree is less than the `key' of the node itself and the `key'
			-- of the `right_child' is greater than the `key' of the node itself. `Void' is
			-- the smallest key.
		require
			a_comparator_not_void: a_comparator /= Void
		local
			l_left_child_key: like key
			l_child: like parent
		do
			if key = Void then
				if left_child = Void then
					l_child := right_child
					if l_child /= Void then
						Result := l_child.sorted (a_comparator)
					else
						Result := True
					end
				end
			else
				l_child := left_child
				if l_child /= Void then
					l_left_child_key := l_child.key
					if l_left_child_key /= Void then
						Result := a_comparator.less_than (l_left_child_key, key)
					else
						Result := True
					end
					Result := Result and then l_child.sorted (a_comparator)
				else
					Result := True
				end
				if Result then
					l_child := right_child
					if l_child /= Void then
						Result := a_comparator.greater_than (l_child.key, key) and then l_child.sorted (a_comparator)
					else
						Result := True
					end
				end
			end
		end

feature {DS_BINARY_SEARCH_TREE_CONTAINER} -- Duplication

	copy_item_and_key_to (other: like Current) is
			-- Copy `item' and `key' to `other'.
		require
			other_not_void: other /= Void
		deferred
		ensure
			item_set: other.item = item
			key_set: other.key = key
		end

feature {DS_BINARY_SEARCH_TREE_CONTAINER, DS_BINARY_SEARCH_TREE_CONTAINER_NODE} -- Setting

	set_key (a_key: like key) is
			-- Set `key' to `a_key'.
		do
			key := a_key
		ensure
			key_set: key = a_key
		end

	set_item (a_item: like item) is
			-- Set `item' to `a_item'.
		deferred
		ensure
			item_set: item = a_item
		end

	set_left_child (a_child: like parent) is
			-- Set `left_child' to `a_child'.
		require
			a_child_orphan: a_child /= Void implies a_child.parent = Void
		local
			l_left_child: like left_child
		do
				-- The current child will not any more have `Current' as `parent'.
			l_left_child := left_child
			if l_left_child /= Void then
				l_left_child.set_parent (Void)
			end
			left_child := a_child
			if a_child /= Void then
				a_child.set_parent (Current)
			end
		ensure
			left_child_set: left_child = a_child
			correct_parent: {ot_left_child: like left_child} left_child implies ot_left_child.parent = Current
			old_child_has_void_parent: ({old_left_child: like left_child} (old left_child)) implies old_left_child.parent = Void
		end

	set_right_child (a_child: like parent) is
			-- Set `right_child' to `a_child'.
		require
			a_child_orphan: a_child /= Void implies a_child.parent = Void
		local
			l_right_child: like right_child
		do
				-- The current child will not any more have `Current' as `parent'.
			l_right_child := right_child
			if l_right_child /= Void then
				l_right_child.set_parent (Void)
			end
			right_child := a_child
			if a_child /= Void then
				a_child.set_parent (Current)
			end
		ensure
			right_child_set: right_child = a_child
			correct_parent: {ot_right_child: like right_child} right_child implies ot_right_child.parent = Current
			old_child_has_void_parent: ({old_right_child: like right_child} (old right_child)) implies old_right_child.parent = Void
		end

feature {DS_BINARY_SEARCH_TREE_CONTAINER_NODE} -- Setting

	set_parent (a_parent: like parent) is
			-- Set `parent' to `a_parent'.
		require
			current_is_already_child_of_a_parent: a_parent /= Void implies (a_parent.left_child = Current or a_parent.right_child = Current)
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

end
