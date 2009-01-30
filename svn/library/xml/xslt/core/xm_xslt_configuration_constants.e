indexing

	description:

		"Configuration constants"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XSLT_CONFIGURATION_CONSTANTS

feature -- Access

	Recover_silently: INTEGER is 1
	Recover_with_warnings: INTEGER is 2
	Do_not_recover: INTEGER is 3
			-- Recovery policies

	Run_to_completion: INTEGER is 0
	Stop_after_principal_source: INTEGER is -1
	Stop_after_compilation: INTEGER is -2
			-- Execution phases

end
	
