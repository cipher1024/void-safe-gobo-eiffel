indexing

	description:

		"Exception handling"

	usage: "[
		This class should not be used directly through
		inheritance and client/supplier relationship.
		Inherit from KL_SHARED_EXCEPTIONS instead.
	]"
	pattern: "Singleton"
	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-05 12:21:37 +0200 (Sun, 05 Oct 2008) $"
	revision: "$Revision: 6530 $"

class KL_EXCEPTIONS

inherit

	KI_EXCEPTIONS

	EXCEPTIONS
		export {NONE} all end

end
