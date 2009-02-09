indexing

	description:

		"Imported routines that ought to be in class OUTPUT_STREAM"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-06 09:53:14 +0200 (Mon, 06 Oct 2008) $"
	revision: "$Revision: 6531 $"

class KL_IMPORTED_OUTPUT_STREAM_ROUTINES

obsolete

	"[020502] Use descendants of KI_OUTPUT_STREAM instead."

feature -- Access

	OUTPUT_STREAM_: KL_OUTPUT_STREAM_ROUTINES is
			-- Routines that ought to be in class OUTPUT_STREAM
		once
			create Result
		ensure
			output_stream_routines_not_void: Result /= Void
		end

feature -- Type anchors

	OUTPUT_STREAM_TYPE: IO_MEDIUM is
			-- Type anchor
		require
			do_not_call: False
		do
			Result := OUTPUT_STREAM_TYPE --| void-safety: this code should never be called.
		end

end
