indexing
	description: "[
		Ancestor of all exception classes.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2008, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2009-05-16 10:45:38 +0200 (Sat, 16 May 2009) $"
	revision: "$Revision: 6634 $"

class
	EXCEPTION

feature -- Raise

	raise
			-- Raise current exception
		do
-- TODO
		end

feature -- Access

	code: INTEGER
			-- Code of the exception.
		do
		end

	message: ?STRING
			-- Message(Tag) of current exception

	exception_trace: STRING is
			-- String representation of current exception trace
		do
-- TODO
			Result := ""
		end

feature -- Status settings

	set_message (a_message: like message)
			-- Set `message' with `a_message'.
		do
-- TODO
		end

feature {NONE} -- Implementation

	internal_meaning: STRING
			-- Internal `meaning'
		once
			Result := "General exception."
		end

end
