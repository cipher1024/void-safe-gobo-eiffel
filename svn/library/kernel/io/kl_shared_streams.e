indexing

	description:

		"Shared input and output streams"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_SHARED_STREAMS

feature -- Access

	null_output_stream: KL_NULL_TEXT_OUTPUT_STREAM is
			-- Null output stream
		once
			create Result.make ("null")
		ensure
			null_output_stream_not_void: Result /= Void
		end

end
