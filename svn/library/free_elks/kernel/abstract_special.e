note
	description: "Ancestor of SPECIAL to perform queries on SPECIAL without knowing its actual generic type."
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 2005, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2009-01-12 17:05:16 +0100 (Mon, 12 Jan 2009) $"
	revision: "$Revision: 6572 $"

deferred class
	ABSTRACT_SPECIAL

feature -- Measurement

	count: INTEGER
			-- Count of special area		
		deferred
		ensure
			count_non_negative: Result >= 0
		end

end
