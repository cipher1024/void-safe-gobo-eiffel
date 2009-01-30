indexing
	
	description:
	
		"Event filter that removes comment events"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2003, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"
		
class XM_NO_COMMENT_FILTER

inherit

	XM_CALLBACKS_FILTER
		redefine
			on_comment
		end
		
create

	make_null,
	set_next
	
feature -- Event(s)

	on_comment (a: STRING) is
			-- Do not forward comment event.
		do
		end
		
end
