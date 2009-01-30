note
	description: "Objects that provide an output in debugger"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 2005, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2009-01-12 17:05:16 +0100 (Mon, 12 Jan 2009) $"
	revision: "$Revision: 6572 $"

deferred class
	DEBUG_OUTPUT

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		deferred
		ensure
			result_not_void: Result /= Void
		end

end
