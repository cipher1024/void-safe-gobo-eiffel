indexing

	description:

		"Decimal number parsers"

	library: "Gobo Eiffel Decimal Arithmetic Library"
	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

deferred class MA_DECIMAL_PARSER

feature {NONE} -- Initialization

	make is
			-- Create a new decimal parser.
		do
		end

feature -- Access

	last_decimal: ?MA_DECIMAL
			-- Last decimal parsed

feature -- Status report

	error: BOOLEAN is
			-- Has an error occurred during the last call to `parse'?
		deferred
		end

feature -- Basic operations

	parse (a_string: STRING) is
			-- Parse `a_string'.
		require
			a_string_not_void: a_string /= Void
			a_string_not_empty: not a_string.is_empty
		deferred
		ensure
			last_decimal_not_void_when_no_error: not error implies last_decimal /= Void
		end

end
