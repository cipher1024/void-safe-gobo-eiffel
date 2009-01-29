indexing

	description:

		"External resolver that opens files on the local filesystem"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date: 2007-07-08 16:19:43 +0200 (dim., 08 juil. 2007) $"
	revision: "$Revision: 6002 $"

class XM_FILE_EXTERNAL_RESOLVER

inherit

	XM_EXTERNAL_RESOLVER

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make is
			-- Make.
		do
			last_error := "no stream"
		end

feature -- Action(s)

	resolve (a_system_name: STRING) is
			-- Open file with corresponding name.
		local
			l_last_stream: like last_stream
		do
			last_error := Void
			create {KL_BINARY_INPUT_FILE} l_last_stream.make (a_system_name)
			last_stream := l_last_stream
			l_last_stream.open_read
			if not l_last_stream.is_open_read then
				last_error := STRING_.concat ("cannot open input file: ", a_system_name)
				last_stream := Void
			end
		end

feature -- Result

	last_stream: ?KI_BINARY_INPUT_FILE
			-- File matching stream

	last_error: ?STRING
			-- Error

	has_error: BOOLEAN is
			-- Is there an error?
		do
			Result := last_error /= Void
		end

invariant

	error_or_stream: last_stream /= Void xor last_error /= Void

end
