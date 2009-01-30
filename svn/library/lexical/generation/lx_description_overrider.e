indexing

	description:

		"Lexical analyzer description overriders"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-05 12:21:37 +0200 (Sun, 05 Oct 2008) $"
	revision: "$Revision: 6530 $"

deferred class LX_DESCRIPTION_OVERRIDER

feature -- Basic operations

	override_description (a_description: LX_DESCRIPTION) is
			-- Override values specified in `a_description'.
		require
			a_description_not_void: a_description /= Void
		deferred
		end

end
