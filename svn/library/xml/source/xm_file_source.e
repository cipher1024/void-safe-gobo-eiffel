indexing

	description:

		"Files as source of XML documents"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_FILE_SOURCE

obsolete "Use XM_POSITION instead"

inherit

	XM_URI_SOURCE
		redefine
			out
		end

	KL_IMPORTED_STRING_ROUTINES
		export
			{NONE} all
		undefine
			out
		end

create

	make

feature {NONE} -- Initialization

	make (a_filename: STRING) is
			-- Create a new file source.
		require
			a_filename_not_void: a_filename /= Void
		do
			filename := a_filename
		ensure
			filename_set: filename = a_filename
		end

feature -- Access

	filename: STRING
			-- File name

	uri: STRING is
			-- File URI
		do
			Result := STRING_.concat ("file:", filename)
		end

feature -- Output

	out: STRING is
			-- Textual representation
		do
			Result := filename
		end

invariant

	filename_not_void: filename /= Void

end
