indexing

	description:

		"Shared days of the week which start on Monday"

	library: "Gobo Eiffel Time Library"
	copyright: "Copyright (c) 2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class DT_SHARED_WEEK_DAYS_FROM_MONDAY

feature -- Access

	week_days_from_monday: DT_WEEK_DAYS_FROM_MONDAY is
			-- Week days from monday
		once
			create Result
		ensure
			week_days_from_monday_not_void: Result /= Void
		end

end
