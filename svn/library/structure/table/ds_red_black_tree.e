indexing

	description:
	"[
		Tables using red-black tree algorithm.

		Red-black trees are a height balanced variant of binary search trees.
		It is guaranteed that `height' is always about `log_2 (count)'.
	]"
	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 2008, Daniel Tuser and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:40:54 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6526 $"

class DS_RED_BLACK_TREE [G, K]

inherit

	DS_BINARY_SEARCH_TREE [G, K]
		undefine
			on_node_added,
			on_root_node_removed,
			on_node_removed
		redefine
			root_node
		end

	DS_RED_BLACK_TREE_CONTAINER [G, K]
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
