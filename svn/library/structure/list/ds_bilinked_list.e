indexing

	description:

		"Lists implemented with bilinked cells"

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 1999-2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:40:54 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6526 $"

class DS_BILINKED_LIST [G]

inherit

	DS_LINKED_LIST [G]
		redefine
			new_cursor,
			put_left_cursor,
			force_left_cursor,
			extend_left_cursor,
			append_left_cursor,
			remove_last,
			remove_at_cursor,
			remove_left_cursor,
			prune_last,
			prune_left_cursor,
			keep_last,
			first_cell,
			set_first_cell,
			cursor_back,
			cursor_search_back,
			cursor_go_i_th
		end

create

	make,
	make_equal,
	make_from_linear,
	make_from_array,
	make_default

feature -- Access

	new_cursor: DS_BILINKED_LIST_CURSOR [G] is
			-- New external cursor for traversal
		do
			create Result.make (Current)
		end

feature -- Element change

	put_left_cursor, force_left_cursor (v: G; a_cursor: like new_cursor) is
			-- Add `v' to left of `a_cursor' position.
			-- Do not move cursors.
			-- (Synonym of `a_cursor.put_left (v)'.)
			-- (Performance: O(1).)
		local
			l_cell, new_cell, old_cell: like first_cell
		do
			if a_cursor.after then
				put_last (v)
			elseif a_cursor.is_first then
				put_first (v)
			else
				old_cell := a_cursor.current_cell
				check
						-- inherited precondition `not_before: not a_cursor.before'
						-- and condition `not a_cursor.is_after'
					a_cursor_current_cell_not_void: old_cell /= Void
				end
				create new_cell.make (v)
				l_cell := old_cell.left
				check
				 		-- inherited precondition `not_before'
				 		-- and condition `not a_cursor.is_first'
					old_cell_left_not_void: l_cell /= Void
				end
				l_cell.put_right (new_cell)
				new_cell.put_right (old_cell)
				count := count + 1
			end
		end

	extend_left_cursor, append_left_cursor (other: DS_LINEAR [G]; a_cursor: like new_cursor) is
			-- Add items of `other' to left of `a_cursor' position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
			-- (Synonym of `a_cursor.extend_left (other)'.)
			-- (Performance: O(other.count).)
		local
			other_cursor: DS_LINEAR_CURSOR [G]
			old_cell: like first_cell
			a_cell, fcell, lcell, new_lcell: like first_cell
		do
			if not other.is_empty then
				from
					other_cursor := other.new_cursor
					other_cursor.start
					create fcell.make (other_cursor.item)
					lcell := fcell
					other_cursor.forth
				until
					other_cursor.after
				loop
					create new_lcell.make (other_cursor.item)
					lcell.put_right (new_lcell)
					lcell := new_lcell
					other_cursor.forth
				end
				if is_empty then
					first_cell := fcell
					last_cell := lcell
				elseif a_cursor.after then
					a_cell := last_cell
					check
 							-- condition `not is_empty'
						last_cell_not_void: a_cell /= Void
					end
					a_cell.put_right (fcell)
					last_cell := lcell
				elseif a_cursor.is_first then
					a_cell := first_cell
					check
 							-- condition `not is_empty'					
						first_cell_not_void: a_cell /= Void
					end
					lcell.put_right (a_cell)
					first_cell := fcell
				else
					old_cell := a_cursor.current_cell
					check
						-- The current cell exists (because the cursor is
						-- not `after' (see above) and not `before' (see
						-- precondition)) and it has a left neighbor
						-- (because the cursor is not `is_first' (see above)).
						-- Insert new cells in-between.
						a_cursor_current_cell_not_void: old_cell /= Void
					end
					a_cell := old_cell.left
					check
					 		-- conditions `not a_cursor.is_empty' and `not a_cursor.is_first'
						old_cell_left_not_void: a_cell /= Void
					end
					a_cell.put_right (fcell)
					lcell.put_right (old_cell)
				end
				count := count + other.count
			end
		end

feature -- Removal

	remove_last is
			-- Remove item at end of list.
			-- Move any cursors at this position `forth'.
			-- (Performance: O(1).)
		local
			l_last_cell: like last_cell
		do
			if count = 1 then
				wipe_out
			else
				move_last_cursors_after
				l_last_cell := last_cell
				check
 						-- inherited precondition `not_empty'
					last_cell_not_void: l_last_cell /= Void
				end
				set_last_cell (l_last_cell.left)
				count := count - 1
			end
		end

	remove_at_cursor (a_cursor: like new_cursor) is
			-- Remove item at `a_cursor' position.
			-- Move any cursors at this position `forth'.
			-- (Synonym of `a_cursor.remove'.)
			-- (Performance: O(1).)
		local
			l_cell, current_cell, new_right: like first_cell
		do
			if a_cursor.is_first then
				remove_first
			elseif a_cursor.is_last then
				remove_last
			else
					-- The current cell has a right and left neighbor because
					-- the cursor is neither `is_first' nor `is_last'.
				current_cell := a_cursor.current_cell
				check 
						-- precondition `not_off'
					a_cursor_current_cell_not_void: current_cell /= Void 
				end
				new_right := current_cell.right
				check 
						-- condition `not is_last'
					current_cell_right_not_void: new_right /= Void 
				end
				move_all_cursors (current_cell, new_right)
				l_cell := current_cell.left
				check 
						-- condition `not is_first'
					current_cell_left_not_void: l_cell /= Void 
				end
				l_cell.put_right (new_right)
				count := count - 1
			end
		end

	remove_left_cursor (a_cursor: like new_cursor) is
			-- Remove item to left of `a_cursor' position.
			-- Move any cursors at this position `forth'.
			-- (Synonym of `a_cursor.remove_left'.)
			-- (Performance: O(1).)
		local
			current_cell, left_cell: like first_cell
		do
			if a_cursor.after then
				remove_last
			else
				current_cell := a_cursor.current_cell
				check 
						-- condition `not a_cursor.after' and preconditions `valid_cursor and not_empty'
					a_cursor_current_cell_not_void: current_cell /= Void 
				end 
				left_cell := current_cell.left
				check 
						-- precondition `not_before' and `not_first'
					current_cell_left_not_void:	left_cell /= Void 
				end
				move_all_cursors (left_cell, current_cell)
				left_cell := left_cell.left
				if left_cell = Void then
						-- The cell to be removed was the first in the
						-- list. The cell at cursor position becomes
						-- the new first cell.
					set_first_cell (current_cell)
				else
					current_cell.put_left (left_cell)
				end
				count := count - 1
			end
		end

	prune_last (n: INTEGER) is
			-- Remove `n' last items from list.
			-- Move all cursors `off'.
			-- (Performance: O(n).)
		local
			i: INTEGER
			new_last: like first_cell
		do
			if count = n then
				wipe_out
			elseif n /= 0 then
				move_all_cursors_after
				new_last := last_cell
				check 
						-- `n /= 0' and `valid_n'
					last_cell_not_void: new_last /= Void 
				end
				from
					i := 1
				until
					i > n
				loop
					new_last := new_last.left
					check 
							-- `0 < i <= n' and `valid_n'
						new_last_left_not_void: new_last /= Void 
					end
					i := i + 1
				end
				set_last_cell (new_last)
				count := count - n
			else
				move_all_cursors_after
			end
		end

	prune_left_cursor (n: INTEGER; a_cursor: like new_cursor) is
			-- Remove `n' items to left of `a_cursor' position.
			-- Move all cursors `off'.
			-- (Synonym of `a_cursor.prune_left (n)'.)
			-- (Performance: O(n).)
		local
			i: INTEGER
			current_cell, new_left: like first_cell
		do
			if a_cursor.after then
				prune_last (n)
			elseif n /= 0 then
				current_cell := a_cursor.current_cell
				check 
						-- `not a_cursor.after' and `n /= 0'
					a_cursor_current_cell_not_void: current_cell /= Void 
				end
				move_all_cursors_after
					-- Go to the cell to the left of the first
					-- cell to be removed.
				new_left := current_cell.left
				check 
						-- `n /= 0' and `not after' and `valid_n'
					current_cell_left_not_void: new_left /= Void 
				end
				from
					i := 1
				until
					i > n
				loop
					new_left := new_left.left
					check 
							-- previous state `1 <= i < n' and `n /= 0'
						new_left_left_not_void: new_left /= Void 
					end
					i := i + 1
				end
				if new_left = Void then
						-- There is no such cell. The cell at cursor
						-- position becomes the new first cell of the list.
					set_first_cell (current_cell)
				else
					new_left.put_right (current_cell)
				end
				count := count - n
			else
				move_all_cursors_after
			end
		end

	keep_last (n: INTEGER) is
			-- Keep `n' last items of list.
			-- Move all cursors `off'.
			-- (Performance: O(n).)
		local
			i: INTEGER
			new_first: like first_cell
		do
			if n = 0 then
				wipe_out
			elseif n = count then
				move_all_cursors_after
			else
				move_all_cursors_after
				new_first := last_cell
				check 
						-- `0 < n < count'
					last_cell_not_void: new_first /= Void 
				end
				from
					i := 1
				until
					i = n
				loop
					new_first := new_first.left
					check 
							-- `1 <= i < n < count'
						new_first_left_not_void: new_first /= Void 
					end
					i := i + 1
				end
				set_first_cell (new_first)
				count := n
			end
		end

feature {DS_LINKED_LIST, DS_LINKED_LIST_CURSOR} -- Implementation

	first_cell: ?DS_BILINKABLE [G]
			-- First cell in list

feature {NONE} -- Implementation

	set_first_cell (a_cell: like first_cell) is
			-- Set `first_cell' to `a_cell'.
			-- This routine has to be called (instead of
			-- making a direct assignment to `first_cell')
			-- when `a_cell' may have dangling left neighbors
			-- that need to be gotten rid of. There is no need
			-- to call this routine when `a_cell' has just
			-- been created.
		do
			a_cell.forget_left
			first_cell := a_cell
		end

feature {DS_BILINKED_LIST_CURSOR} -- Cursor implementation

	cursor_back (a_cursor: like new_cursor) is
			-- Move `a_cursor' to previous position.
			-- (Performance: O(1).)
		local
			was_off, new_before: BOOLEAN
			l_current_cell, new_cell: like first_cell
		do
			if a_cursor.after then
				was_off := True
				new_cell := last_cell
			else
				l_current_cell := a_cursor.current_cell
				check 
						-- condition `not a_cursor.after' and precondition `a_cursor_not_before'
					a_cursor_current_cell_not_void: l_current_cell /= Void 
				end
				new_cell :=	l_current_cell.left
			end
			new_before := (new_cell = Void)
			a_cursor.set (new_cell, new_before, False)
			if new_before then
				if not was_off then
					remove_traversing_cursor (a_cursor)
				end
			elseif was_off then
				add_traversing_cursor (a_cursor)
			end
		end

	cursor_search_back (a_cursor: like new_cursor; v: G) is
			-- Move `a_cursor' to first position at or before its current
			-- position where `cursor_item (a_cursor)' and `v' are equal.
			-- (Use `equality_tester''s comparison criterion
			-- if not void, use `=' criterion otherwise.)
			-- Move `before' if not found.
		local
			a_cell: like first_cell
			a_tester: like equality_tester
			was_off, new_before: BOOLEAN
		do
			a_cell := a_cursor.current_cell
			was_off := (a_cell = Void)
			a_tester := equality_tester
			if a_tester /= Void then
				from
				until
					a_cell = Void or else a_tester.test (a_cell.item, v)
				loop
					a_cell := a_cell.left
				end
			else
					-- Use `=' as comparison criterion.
				from
				until
					a_cell = Void or else a_cell.item = v
				loop
					a_cell := a_cell.left
				end
			end
			new_before := (a_cell = Void)
			a_cursor.set (a_cell, new_before, False)
			if new_before then
				if not was_off then
					remove_traversing_cursor (a_cursor)
				end
			elseif was_off then
				add_traversing_cursor (a_cursor)
			end
		end

	cursor_go_i_th (a_cursor: like new_cursor; i: INTEGER) is
			-- Move `a_cursor' to `i'-th position.
			-- (Performance: O(min(i,count-i)).)
		local
			j, k, nb: INTEGER
			a_cell: like first_cell
			was_off: BOOLEAN
		do
			was_off := cursor_off (a_cursor)
			nb := count
			if i = 0 then
				a_cursor.set_before
			elseif i = count + 1 then
				a_cursor.set_after
			else
				if i = 1 then
					a_cell := first_cell
				elseif i = nb then
					a_cell := last_cell
				else
					k := count - i + 1
					if k < i then
						a_cell := last_cell
						check 
								-- `1 < i < nb' and precondition `valid_index'
							last_cell_not_void: a_cell /= Void 
						end 
						from
							j := 1
						until
							j = k
						loop
							a_cell := a_cell.left
							check 
									-- `1 <= j < k < i < nb'						
								a_cell_left_not_void: a_cell /= Void 
							end
							j := j + 1
						end
					else
						a_cell := first_cell
						check 
								-- `1 < i < nb' and precondition `valid_index'						
							first_cell_not_void: a_cell /= Void 
						end 
						from
							j := 1
						until
							j = i
						loop
							a_cell := a_cell.right
							check 
									-- `1 <= j < i <= k < nb'
								a_cell /= Void 
							end 
							j := j + 1
						end
					end
				end
				a_cursor.set (a_cell, False, False)
			end
			if a_cell = Void then
					-- `a_cursor.off'
				if not was_off then
					remove_traversing_cursor (a_cursor)
				end
			elseif was_off then
				add_traversing_cursor (a_cursor)
			end
		end

invariant

	first_constraint: {l_first_cell: like first_cell} first_cell implies l_first_cell.left = Void

end
