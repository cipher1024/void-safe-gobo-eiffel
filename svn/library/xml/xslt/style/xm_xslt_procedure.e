indexing

	description:

	"Element nodes in an XSLT stylesheet that can contain local variable declaration.%
%Specifically, xsl:template, xsl:variable, xsl:param, xsl:function or xsl:attribute-sets"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XSLT_PROCEDURE

feature -- Access

	slot_manager: XM_XPATH_SLOT_MANAGER
			-- Slot manager

invariant

	slot_manager_not_void: slot_manager /= Void

end
