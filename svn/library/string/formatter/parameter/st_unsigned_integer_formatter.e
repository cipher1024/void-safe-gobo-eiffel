indexing

	description:

		"Formatters for unsigned integer parameters"

	library: "Gobo Eiffel String Library"
	copyright: "Copyright (c) 2004-2005, Object-Tools and others"
	license: "MIT License"
	date: "$Date: 2008-10-06 09:53:14 +0200 (Mon, 06 Oct 2008) $"
	revision: "$Revision: 6531 $"

deferred class ST_UNSIGNED_INTEGER_FORMATTER

inherit

	ST_INTEGER_FORMATTER
		redefine
			valid_parameter,
			integer_format_to
		end

feature -- Status report

	valid_parameter (a_parameter: ANY): BOOLEAN is
			-- Is `a_parameter' a valid parameter for current formatter?
		do
			Result := {a_cell: DS_CELL [INTEGER]} a_parameter and then a_cell.item >= 0
		end

feature -- Formatting

	integer_format_to (a_parameter: INTEGER; a_stream: KI_CHARACTER_OUTPUT_STREAM) is
			-- Format `a_parameter' to `a_stream'.
		do
			plus_sign_enabled := False
			precursor (a_parameter, a_stream)
		end

end
