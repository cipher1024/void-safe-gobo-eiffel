indexing

	description:

		"Shared decimal math constants"

	library: "Gobo Eiffel Decimal Arithmetic Library"
	copyright: "Copyright (c) 2005, Paul G. Crismer and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class MA_SHARED_DECIMAL_CONSTANTS

feature -- Access

	decimal: MA_DECIMAL_CONSTANTS is
			-- Decimal constants
		once
			create Result
		ensure
			decimal_not_void: Result /= Void
		end

end
