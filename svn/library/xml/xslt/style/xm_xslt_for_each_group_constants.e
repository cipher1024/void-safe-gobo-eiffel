indexing

	description:

		"Constants for xsl:for-each-group element nodes"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class XM_XSLT_FOR_EACH_GROUP_CONSTANTS

feature -- Access

	Group_by_algorithm: INTEGER is 1
	Group_adjacent_algorithm: INTEGER is 2
	Group_starting_with_algorithm: INTEGER is 3
	Group_ending_with_algorithm: INTEGER is 4

end
