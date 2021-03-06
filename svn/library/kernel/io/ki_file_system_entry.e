indexing

	description:

		"Interface for file system entries (files, directories, ...)"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-05 12:21:37 +0200 (Sun, 05 Oct 2008) $"
	revision: "$Revision: 6530 $"

deferred class KI_FILE_SYSTEM_ENTRY

feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Create a new file system entry object.
			-- (`a_name' should follow the pathname convention
			-- of the underlying platform. For pathname conversion
			-- use KI_FILE_SYSTEM.pathname_from_file_system.)
		require
			a_name_not_void: a_name /= Void
		deferred
		ensure
			name_set: name = a_name
			is_closed: is_closed
		end

feature -- Initialization

	reset (a_name: STRING) is
			-- Reuse current Eiffel object memory to
			-- represent a new file system entry.
			-- (`a_name' should follow the pathname convention
			-- of the underlying platform. For pathname conversion
			-- use KI_FILE_SYSTEM.pathname_from_file_system.)
		require
			a_name_not_void: a_name /= Void
			is_closed: is_closed
		do
			make (a_name)
		ensure
			name_set: name = a_name
			is_closed: is_closed
		end

feature -- Access

	name: STRING is
			-- File system entry name
		deferred
		ensure
			name_not_void: Result /= Void
		end

feature -- Status report

	is_open: BOOLEAN is
			-- Has file system entry been opened?
		deferred
		end

	is_closed: BOOLEAN is
			-- Is file system entry closed?
		deferred
		ensure
			definition: Result = not is_open
		end

	exists: BOOLEAN is
			-- Does file system entry physically exist on disk?
			-- (Note that with SmartEiffel this routine actually
			-- returns `is_readable'.)
		deferred
		end

	is_readable: BOOLEAN is
			-- Can file system entry be opened in read mode?
		deferred
		ensure
			exists: Result implies exists
		end

	is_closable: BOOLEAN is
			-- Can current file system entry be closed?
		do
			Result := is_open
		ensure
			definition: Result = is_open
		end

feature -- Basic operations

	open is
			-- Try to open file system entry. Set `is_open'
			-- to true if operation was successful.
		require
			is_closed: is_closed
		deferred
		end

	close is
			-- Try to close file system entry. Set `is_closed'
			-- to true if operation was successful.
		require
			is_closable: is_closable
		deferred
		end

	delete is
			-- Delete current file system entry.
			-- Do nothing if the entry could not be deleted
			-- (for example if the entry does not exist or
			-- if a directory is not empty).
		require
			is_closed: is_closed
		deferred
		end

end
