indexing

	description:

		"Objects that wrap another instruction for tracing purposes"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XSLT_TRACE_INSTRUCTION

inherit

	XM_XSLT_TRACE_WRAPPER

create

	make

feature {NONE} -- Initialization

	make (a_child: like child; an_executable: like executable; some_details: like trace_details) is
			-- Establish invariant.
		require
			child_not_void: a_child /= Void
			
		do
			executable := an_executable
			trace_details := some_details
			child := a_child; adopt_child_expression (child)
			compute_static_properties
			initialized := True
		ensure
			executable_set: executable = an_executable
			details_set: trace_details = some_details
			child_set: child = a_child
		end

feature {NONE} -- Implementation

	trace_details: XM_XSLT_TRACE_DETAILS
			-- Trace details

end
	
