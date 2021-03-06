indexing

	description:

		"Error: Unknown command-line flag"

	library: "Gobo Eiffel Utility Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class UT_UNKNOWN_FLAG_ERROR

inherit

	UT_ERROR

create

	make

feature {NONE} -- Initialization

	make (a_flag: STRING) is
			-- Create a new error reporting that
			-- `a_flag' is an unknown flag.
		require
			a_flag_not_void: a_flag /= Void
		do
			create parameters.make (1, 1)
			parameters.put (a_flag, 1)
		end

feature -- Access

	default_template: STRING is "$0: unknown flag '$1'"
			-- Default template used to built the error message

	code: STRING is "UT0002"
			-- Error code

invariant

	-- dollar0: $0 = program name
	-- dollar1: $1 = flag

end
