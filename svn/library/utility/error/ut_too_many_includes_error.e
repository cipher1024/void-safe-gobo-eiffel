indexing

	description:

		"Error: Too many nested include files"

	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-09-07 20:03:00 +0200 (Fri, 07 Sep 2007) $"
	revision: "$Revision: 6060 $"

class UT_TOO_MANY_INCLUDES_ERROR

inherit

	UT_ERROR

create

	make

feature {NONE} -- Initialization

	make (max: INTEGER) is
			-- Create a new error.
		do
			create parameters.make (1, 1)
			parameters.put (max.out, 1)
		end

feature -- Access

	default_template: STRING is "$0: too many (i.e. $1) nested include files"
			-- Default template used to built the error message

	code: STRING is "UT0010"
			-- Error code

invariant

	-- dollar0: $0 = program name
	-- dollar1: $1 = max number of nested include files

end
