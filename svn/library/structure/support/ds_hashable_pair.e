indexing

	description:

		"Cells containing two hashable items"

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class DS_HASHABLE_PAIR [G -> HASHABLE, H -> HASHABLE]

inherit

	DS_PAIR [G, H]

	HASHABLE

create

	make

feature -- Access

	hash_code: INTEGER is
			-- Hash code value
		local
			l_first: ?G
			l_second: ?H
		do
			l_first := first
			if l_first /= Void then
				if l_second /= Void then
					Result := l_first.hash_code // 2 + l_second.hash_code // 2
				else
					Result := l_first.hash_code
				end
			else
				l_second := second
				if l_second /= Void then
					Result := l_second.hash_code
				else
					Result := 0
				end
			end
		end

end
