indexing
	description: "[
		Ancestor of all exception classes.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2008, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2008-05-12 09:58:30 +0200 (Mon, 12 May 2008) $"
	revision: "$Revision: 6408 $"

class
	EXCEPTION

feature -- Access

	message: ?STRING
			-- Message(Tag) of current exception

	exception_trace: STRING is
			-- String representation of current exception trace
		do
-- TODO
			Result := ""
		end

end
