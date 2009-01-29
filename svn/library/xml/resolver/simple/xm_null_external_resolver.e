indexing

	description:

		"Null resolver that always fails"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class XM_NULL_EXTERNAL_RESOLVER

inherit

	XM_EXTERNAL_RESOLVER

feature -- Action(s)

	resolve (a_system: STRING) is
			-- Fails.
		do
		ensure then
			fails: has_error
		end

feature -- Result

	has_error: BOOLEAN is
			-- Always true
		do
			Result := True
		ensure then
			fails: Result
		end

	last_error: ?STRING is
			-- Error message.
		do
			Result := "external entities not supported"
		end

	last_stream: ?KI_CHARACTER_INPUT_STREAM is
			-- Not used.
		do
		ensure then
			never_called: False
		end

end
