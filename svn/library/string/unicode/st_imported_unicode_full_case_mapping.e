indexing

	description:

		"Imported case mapping routines"

	library: "Gobo Eiffel String Library"
	copyright: "Copyright (c) 2008, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2008-01-03 12:23:14 +0100 (Thu, 03 Jan 2008) $"
	revision: "$Revision: 6244 $"

class ST_IMPORTED_UNICODE_FULL_CASE_MAPPING

feature -- Access

	case_mapping: ST_UNICODE_FULL_CASE_MAPPING is
			-- Unicode full case mapping routines
		once
			create Result
		ensure
			case_mapping_not_void: Result /= Void
		end

end
