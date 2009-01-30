indexing

	description:

		"Objects that represent a tail call"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-05-06 11:55:32 +0200 (Sun, 06 May 2007) $"
	revision: "$Revision: 5959 $"

deferred class XM_XPATH_TAIL_CALL

inherit

	ANY

feature -- Evaluation

	generate_tail_call (a_tail: DS_CELL [XM_XPATH_TAIL_CALL]; a_context: XM_XPATH_CONTEXT) is
			-- Execute `Current', writing results to the current `XM_XPATH_RECEIVER'.
		require
			a_tail_not_void: a_tail /= Void
			no_tail_call: a_tail.item = Void
			context_not_void: a_context /= Void
			no_error: not a_context.is_process_error
		deferred
		ensure
			possible_tail_call: a_tail.item /= Void xor a_tail.item = Void
		end
	
end
	
