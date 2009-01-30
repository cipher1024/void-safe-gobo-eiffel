indexing

	description:

		"Standard files"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999-2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class KL_STANDARD_FILES

feature -- Access

	input: KL_STDIN_FILE is
			-- Standard input file
		once
			create Result.make
		ensure
			file_not_void: Result /= Void
			file_open_read: Result.is_open_read
		end

	output: KL_STDOUT_FILE is
			-- Standard output file
		once
			create Result.make
		ensure
			file_not_void: Result /= Void
			file_open_write: Result.is_open_write
		end

	error: KL_STDERR_FILE is
			-- Standard error file
		once
			create Result.make
		ensure
			file_not_void: Result /= Void
			file_open_write: Result.is_open_write
		end

end
