indexing

	description:

		"Imported routines that ought to be in class INPUT_STREAM"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-06 09:53:14 +0200 (Mon, 06 Oct 2008) $"
	revision: "$Revision: 6531 $"

class KL_IMPORTED_INPUT_STREAM_ROUTINES

obsolete

	"[020502] Use descendants of KI_INPUT_STREAM instead."

feature -- Access

	INPUT_STREAM_: KL_INPUT_STREAM_ROUTINES is
			-- Routines that ought to be in class INPUT_STREAM
		once
			create Result
		ensure
			input_stream_routines_not_void: Result /= Void
		end

feature -- Type anchors

	INPUT_STREAM_TYPE: ?IO_MEDIUM is
			-- Type anchor
		do
		end

end
