indexing

	description:

		"Formatters for character parameters, $c"

	library: "Gobo Eiffel String Library"
	copyright: "Copyright (c) 2004-2005, Object-Tools and others"
	license: "MIT License"
	date: "$Date: 2008-10-06 09:53:14 +0200 (Mon, 06 Oct 2008) $"
	revision: "$Revision: 6531 $"

class ST_CHARACTER_FORMATTER

inherit

	ST_PARAMETER_FORMATTER

create

	make

feature -- Status report

	valid_parameter (a_parameter: ANY): BOOLEAN is
			-- Is `a_parameter' a valid parameter for current formatter?
		do
			Result := {a_cell: DS_CELL [CHARACTER]} a_parameter
		end

feature -- Formatting

	format_to (a_parameter: ANY; a_stream: KI_CHARACTER_OUTPUT_STREAM) is
			-- Format `a_parameter' to `a_stream'.
			-- (Use DS_CELL [CHARACTER] because in SE 2.1
			-- CHARACTER does not conform to ANY.)
		local

		do
			if {a_cell: DS_CELL [CHARACTER]} a_parameter then
				character_format_to (a_cell.item, a_stream)
			else
				check
					valid_parameter: False
				end
			end
		end

	character_format_to (a_parameter: CHARACTER; a_stream: KI_CHARACTER_OUTPUT_STREAM) is
			-- Format `a_parameter' to `a_stream'.
		require
			a_stream_not_void: a_stream /= Void
			a_stream_open_write: a_stream.is_open_write
		do
			character_buffer.put (a_parameter, 1)
			justify_format_to (character_buffer, a_stream)
		end

feature {NONE} -- Constants

	character_buffer: STRING is "#"
			-- Buffer used in `character_format_to'

end
