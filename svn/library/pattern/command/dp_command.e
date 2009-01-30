indexing

	description:

		"Executable commands"

	library: "Gobo Eiffel Pattern Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:35:10 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6524 $"

deferred class DP_COMMAND

inherit

	ANY
			-- Needed for SE 2.1b1.

feature -- Status report

	is_executable: BOOLEAN is
			-- Can current command be executed?
			-- (Default: True.)
		do
			Result := True
		end

feature -- Execution

	execute is
			-- Execute current command.
		require
			is_executable: is_executable
		deferred
		end

end
