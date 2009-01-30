indexing

	description:

		"Error: Multiple <<EOF>> rules for a start condition"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-06 09:53:14 +0200 (Mon, 06 Oct 2008) $"
	revision: "$Revision: 6531 $"

class LX_MULTIPLE_EOF_RULES_ERROR

inherit

	UT_ERROR

create

	make

feature {NONE} -- Initialization

	make (filename: STRING; line: INTEGER; sc: STRING) is
			-- Create a new error reporting that there are
			-- multiple <<EOF>> rules for start condition `sc'.
		require
			filename_not_void: filename /= Void
			sc_not_void: sc /= Void
		do
			create parameters.make (1, 3)
			parameters.put (filename, 1)
			parameters.put (line.out, 2)
			parameters.put (sc, 3)
		end

feature -- Access

	default_template: STRING is "%"$1%", line $2: multiple <<EOF>> rules for start condition $3"
			-- Default template used to built the error message

	code: STRING is "LX0014"
			-- Error code

invariant

--	dollar0: $0 = program name
--	dollar1: $1 = filename
--	dollar2: $2 = line number
--	dollar3: $3 = start condition

end
