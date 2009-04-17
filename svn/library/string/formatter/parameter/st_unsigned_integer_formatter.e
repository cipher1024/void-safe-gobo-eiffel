indexing

	description:

		"Formatters for unsigned integer parameters"

	library: "Gobo Eiffel String Library"
	copyright: "Copyright (c) 2004-2005, Object-Tools and others"
	license: "MIT License"
	date: "$Date: 2009-04-16 17:06:13 +0200 (Thu, 16 Apr 2009) $"
	revision: "$Revision: 6624 $"

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
			Result := {l_cell: DS_CELL [INTEGER]} a_parameter and then l_cell.item >= 0
		end

feature -- Formatting

	integer_format_to (a_parameter: INTEGER; a_stream: KI_CHARACTER_OUTPUT_STREAM) is
			-- Format `a_parameter' to `a_stream'.
		do
			plus_sign_enabled := False
			space_sign_enabled := False
			precursor (a_parameter, a_stream)
		end

end
