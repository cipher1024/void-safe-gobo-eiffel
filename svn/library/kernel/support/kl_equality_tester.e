indexing

	description:

		"Equality testers"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999-2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2009-03-02 23:02:37 +0100 (Mon, 02 Mar 2009) $"
	revision: "$Revision: 6597 $"

class KL_EQUALITY_TESTER [G]

inherit

	ANY

feature -- Status report

	test (v, u: ?G): BOOLEAN is
			-- Are `v' and `u' considered equal?
			-- (Use '~' by default.)
		do
			if v = u then
				Result := True
			else
				Result := v ~ u
			end
		end

end
