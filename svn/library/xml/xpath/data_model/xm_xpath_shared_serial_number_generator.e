indexing

	description:

		"Objects that provide access to a shared unique serial number generator"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XPATH_SHARED_SERIAL_NUMBER_GENERATOR

feature -- Access

	shared_serial_number_generator: XM_XPATH_SERIAL_NUMBER_GENERATOR is
			-- Shared serial number generator
		once
			create Result.make
		end
	
end
	
