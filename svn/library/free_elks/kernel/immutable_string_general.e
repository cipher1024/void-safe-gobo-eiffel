note
	description: "Common ancestors to all immutable STRING classes."
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2008, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2009-01-12 17:05:16 +0100 (Mon, 12 Jan 2009) $"
	revision: "$Revision: 6572 $"

deferred class
	IMMUTABLE_STRING_GENERAL

inherit
	READABLE_STRING_GENERAL
		redefine
			is_immutable
		end

feature -- Status report

	is_immutable: BOOLEAN = True
			-- Can the character sequence of `Current' be changed?

invariant
	immutable: is_immutable

end
