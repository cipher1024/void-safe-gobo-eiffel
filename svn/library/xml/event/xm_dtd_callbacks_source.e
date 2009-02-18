indexing

	description:

		"Source of XML document type definiton event callbacks"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

deferred class XM_DTD_CALLBACKS_SOURCE

feature

	set_dtd_callbacks (a_callback: XM_DTD_CALLBACKS) is
			-- Client will receive callbacks to.
		require
			a_callback_not_void: a_callback /= Void
		deferred
		end

end
