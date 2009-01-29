indexing

	description:

		"Event filters that can forward event to 'next' filter"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class XM_CALLBACKS_FILTER

inherit

	XM_CALLBACKS

	XM_CALLBACKS_SOURCE
		rename
			set_callbacks as set_next
		end

	XM_FORWARD_CALLBACKS
		-- implementation of default behaviour:
		-- forwarding to 'next' processor in chain
		rename
			callbacks as next,
			attached_callbacks as attached_next,
			set_callbacks as set_next
		end

create

	make_null,
	set_next

feature {NONE} -- Initialization

	make_null is
			-- Next is null processor.
		do
			create {XM_CALLBACKS_NULL} next.make
		end

invariant

	next_not_void: next /= Void

end
