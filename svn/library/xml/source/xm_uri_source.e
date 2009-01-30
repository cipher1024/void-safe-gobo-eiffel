indexing

	description:

		"Abstract definition of the source of an XML document that %
		%has been retrieved via an URI"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

deferred class XM_URI_SOURCE

inherit

	XM_SOURCE

feature -- Access

	uri: STRING is
			-- URI for the source of the XML document
		deferred
		end

feature -- Output

	out: STRING is
			-- Textual representation
		do
			Result := uri
		end

invariant

	uri_not_void: uri /= Void

end
