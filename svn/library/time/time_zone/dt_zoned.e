indexing

	description:

		"Objects that pair an absolute time with a time zone"

	library: "Gobo Eiffel Time Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2008-09-28 20:36:52 +0200 (Sun, 28 Sep 2008) $"
	revision: "$Revision: 6525 $"

deferred class DT_ZONED

feature -- Access

	time_zone: DT_TIME_ZONE
			-- Time zone

invariant

	time_zone_not_void: time_zone /= Void

end
