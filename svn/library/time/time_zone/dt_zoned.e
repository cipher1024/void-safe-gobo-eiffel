indexing

	description:

		"Objects that pair an absolute time with a time zone"

	library: "Gobo Eiffel Time Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2009-04-23 16:03:08 +0200 (Thu, 23 Apr 2009) $"
	revision: "$Revision: 6627 $"

deferred class DT_ZONED

feature -- Access

	time_zone: DT_TIME_ZONE
			-- Time zone

invariant

	time_zone_not_void: time_zone /= Void

end
