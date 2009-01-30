indexing

	description:

		"Shared formatters"

	library: "Gobo Eiffel String Library"
	copyright: "Copyright (c) 2004, Berend de Boer and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class ST_SHARED_FORMATTERS

feature -- Access

	formatter: ST_SCIENTIFIC_FORMATTER is
			-- Shared scientific formatter
		once
			Result := scientific_formatter
		ensure
			formatter_not_void: Result /= Void
		end

	scientific_formatter: ST_SCIENTIFIC_FORMATTER is
			-- Shared scientific formatter
		once
			create Result.make
		ensure
			scientific_formatter_not_void: Result /= Void
		end

end
