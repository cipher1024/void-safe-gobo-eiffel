indexing

	description:

		"Imported normalization routines for Unicode version 5.0.0"

	library: "Gobo Eiffel String Library"
	copyright: "Copyright (c) 2006, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2008-10-06 09:53:14 +0200 (Mon, 06 Oct 2008) $"
	revision: "$Revision: 6531 $"

class ST_IMPORTED_UNICODE_V500_NORMALIZATION_ROUTINES

feature -- Access

	normalization_v500: ST_UNICODE_V500_NORMALIZATION_ROUTINES is
			-- Unicode V500 normalization routines
		once
			create Result
		ensure
			normalization_v500_not_void: Result /= Void
		end

end
