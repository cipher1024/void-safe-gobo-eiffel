indexing

	description:

		"Objects that provide location information to XM_XPATH_RECEIVERs"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

deferred class XM_XPATH_LOCATOR

inherit
	
	ANY

feature -- Access

	system_id: STRING is
			-- Current SYSTEM ID;
			-- STRING interpretation of `base_uri' when available.
		deferred
		ensure
			system_id_not_void: Result /= Void
		end

	line_number: INTEGER is
			-- Approximate line number of current event, or 0 if unknown
		deferred
		ensure
			positive_result: Result >= 0
		end

end
