indexing

	description:

		"Objects that represent xsl:import elements in the stylesheet."

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XSLT_IMPORT

inherit

	XM_XSLT_MODULE

create

	make_style_element

feature -- Status report

	is_import: BOOLEAN is
			-- Is this an xsl:import?
		do
			Result := True
		end

end
	
