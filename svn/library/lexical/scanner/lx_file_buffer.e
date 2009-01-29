indexing

	description:

		"Lexical analyzer input file buffers"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class LX_FILE_BUFFER

inherit

	LX_BUFFER
		rename
			make as make_string_buffer
		redefine
			refill
		end

create

	make

feature -- Initialization

	make (a_file: like file) is
			-- Create a new buffer for `a_file'.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		do
			file := a_file
			refill
		ensure
			file_set: file = a_file
		end

feature -- Access

	file: KI_CHARACTER_INPUT_STREAM
			-- Input file

feature -- Status report

	end_of_file: BOOLEAN
			-- Has end-of-file been reached?

feature -- Element change

	refill is
			-- Refill buffer with characters from `file'.
		local
			l_content: ?like content
			l_last_string: ?STRING
		do
			if not file.end_of_input then
				file.read_string (16384)
				l_last_string := file.last_string
				check l_last_string /= Void end
				l_content := l_last_string
			else
				end_of_file := True
				l_content := ""
			end
			content := l_content
			index := 1
		end

invariant

	file_not_void: file /= Void
	file_open_read: not end_of_file implies file.is_open_read

end
