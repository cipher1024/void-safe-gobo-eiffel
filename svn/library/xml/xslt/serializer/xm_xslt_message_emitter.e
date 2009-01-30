indexing
	description:

	"Emitters that write xsl:messages."

library: "Gobo Eiffel XSLT Library"
copyright: "Copyright (c) 2004, Colin Adams and others"
license: "MIT License"
date: "$Date: 2007-10-08 08:22:35 +0200 (Mon, 08 Oct 2007) $"
revision: "$Revision: 6112 $"

class XM_XSLT_MESSAGE_EMITTER

inherit

	XM_XSLT_XML_EMITTER
		redefine
			end_document
		end

create

	make

feature -- Events

	end_document is
			-- Notify the end of the document
		do
			if is_output_open then
				output ("%N")
			end
			Precursor
		end

end


