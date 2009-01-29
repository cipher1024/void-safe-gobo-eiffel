indexing

	description:

		"Decimal number parsers for BCD representation"

	library: "Gobo Eiffel Decimal Arithmetic Library"
	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "MIT License"
	date: "$Date: 2008-10-06 09:53:14 +0200 (Mon, 06 Oct 2008) $"
	revision: "$Revision: 6531 $"

class MA_DECIMAL_BCD_PARSER

inherit

	MA_DECIMAL_PARSER

create

	make

feature -- Access

	last_nibble: INTEGER
			-- Last nibble

feature -- Status report

	error: BOOLEAN
			-- Has an error occurred during the last call to `parse'?

feature -- Basic operations

	parse (packed_string: STRING) is
			-- Parse `packed_string'.
		local
			zero_code: INTEGER
			index, l_count, hi, lo: INTEGER
			l_coefficient: MA_DECIMAL_COEFFICIENT
			nibble_index, c_code: INTEGER
			c: CHARACTER
			l_decimal: like last_decimal
		do
			error := False
			create l_decimal.make (packed_string.count * 2 - 1)
			last_decimal := l_decimal
			l_coefficient := l_decimal.coefficient
			zero_code := ('0').code
			from
				index := 1
				nibble_index := l_coefficient.capacity - 1
				l_count := packed_string.count
			until
				index > l_count or else error
			loop
				c := packed_string.item (index)
				c_code := c.code
				lo := c_code \\ 16
				hi := c_code // 16
				l_coefficient.put (hi, nibble_index)
				nibble_index := nibble_index - 1
				last_nibble := hi
				if index < l_count then
					l_coefficient.put (lo, nibble_index)
					nibble_index := nibble_index - 1
					last_nibble := lo
				else
					inspect lo
					when 11, 13 then
						l_decimal.set_negative
					when 10, 12, 14, 15 then
							-- Do nothing.
					else
--						create e
--						e.raise ("Invalid file format : need 8 bytes packed decimal")
						error := True
						l_decimal := Void
					end
				end
				index := index + 1
			end
		end

end
