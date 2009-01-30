indexing

	description:

		"Objects that detail trace events"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XSLT_SHARED_EMPTY_PROPERTIES

inherit

	UC_SHARED_STRING_EQUALITY_TESTER

feature -- Access

	empty_property_set: DS_HASH_TABLE [STRING, STRING] is
			-- Empty trace properties
		once
			create Result.make_with_equality_testers (0, string_equality_tester, string_equality_tester)
		end

end
	
