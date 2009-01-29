indexing

	description:
	"[
		Tables using left-leaning red-black tree algorithm.

		Left-leaning red-black trees are a height balanced variant of binary search trees.
		It is guaranteed that `height' is always about `log_2 (count)'.
	]"
	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 2008, Daniel Tuser and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:40:54 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6526 $"

class DS_LEFT_LEANING_RED_BLACK_TREE [G, K]

inherit

	DS_RED_BLACK_TREE [G, K]
		undefine
			search_node_for_removal,
			successor_for_removal,
			on_node_added,
			on_node_removed,
			on_node_for_removal_not_found
		redefine
			root_node
		end

	DS_LEFT_LEANING_RED_BLACK_TREE_CONTAINER [G, K]
		rename
			has as has_item,
			has_void as has_void_item,
			has_key as has
		redefine
			root_node
		end

create

	make

feature {NONE} -- Implementation

	root_node: ?DS_RED_BLACK_TREE_NODE [G, K]
			-- Root node of the tree

end
