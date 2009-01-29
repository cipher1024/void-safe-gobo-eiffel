indexing

	description:

	"Objects that can be returned from {XM_XPATH_MAPPING_FUNCTION}.map"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_MAPPED_ITEM

create

	make_item, make_sequence

feature {NONE} -- Initialization

	make_item (an_item: XM_XPATH_ITEM) is
			-- Create an item result.
		require
			item_not_void: an_item /= Void
		do
			item_result := an_item
		ensure
			item_set: item_result = an_item
		end

	make_sequence (a_sequence: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_ITEM]) is
			-- Create a sequence result.
		require
			sequence_not_void: a_sequence /= Void
		do
			sequence_result := a_sequence
			is_sequence := True
		ensure
			sequence_set: sequence_result = a_sequence
		end

feature -- Access

	item: XM_XPATH_ITEM is
			-- Encapsulated item
		require
			item_result: not is_sequence
		local
			r: like item_result
		do
			r := item_result
			check r /= Void end -- implied by `not is_sequence'
			Result := r
		ensure
			item_not_void: Result /= Void
		end

	sequence: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_ITEM] is
			-- Encapsulated sequence
		require
			sequence_result: is_sequence
		local
			r: like sequence_result
		do
			r := sequence_result
			check r /= Void end -- implied by `is_sequence'
			Result := r
		ensure
			sequence_not_void: Result /= Void
		end

feature -- Status setting

	is_sequence: BOOLEAN
			-- Does `Current' encapsulate a sequence iterator?

feature {NONE} -- Implementation

	item_result: ?XM_XPATH_ITEM

	sequence_result: ?XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_ITEM]

invariant

	sequence_result: is_sequence implies sequence_result /= Void and item_result = Void
	item_result: not is_sequence implies sequence_result = Void and item_result /= Void

end
