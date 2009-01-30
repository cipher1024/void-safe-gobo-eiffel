indexing

	description:

		"Objects that provide access to shared decimal contexts"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2008-01-02 14:57:21 +0100 (Wed, 02 Jan 2008) $"
	revision: "$Revision: 6243 $"

class XM_XPATH_SHARED_DECIMAL_CONTEXTS

inherit

	MA_SHARED_DECIMAL_CONTEXT
	
	MA_DECIMAL_CONTEXT_CONSTANTS

feature -- Access

	shared_integer_context: MA_DECIMAL_CONTEXT is
			-- Decimal context for use by all integers
		once
			create Result.make (shared_decimal_context.digits, Round_down)
		end

	shared_round_context: MA_DECIMAL_CONTEXT is
			-- Decimal context for use by round on positive_number
		once
			create Result.make (shared_decimal_context.digits, Round_half_up)
		end

	shared_negative_round_context: MA_DECIMAL_CONTEXT is
			-- Decimal context for use by round on negative numbers
		once
			create Result.make (shared_decimal_context.digits, Round_half_down)
		end

	shared_half_even_context: MA_DECIMAL_CONTEXT is
			-- Decimal context for use by rounded-half-even
		once
			create Result.make (shared_decimal_context.digits, Round_half_even)
		end

	shared_floor_context: MA_DECIMAL_CONTEXT is
			-- Decimal context for use by floor
		once
			create Result.make (shared_decimal_context.digits, Round_floor)
		end

	shared_ceiling_context: MA_DECIMAL_CONTEXT is
			-- Decimal context for use by ceiling
		once
			create Result.make (shared_decimal_context.digits, Round_ceiling)
		end

end
