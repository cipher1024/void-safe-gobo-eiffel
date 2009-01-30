indexing

	description:

		"Validation routines for UT_HOST_PORT"

	library: "Gobo Eiffel Utility Library"
	author: "Copyright (c) 2004, Franck Arnaud and others"
	revision: "$Revision: 4832 $"
	date: "$Date: 2005-03-15 20:17:41 +0100 (Tue, 15 Mar 2005) $"

class UT_HOST_PORT_ROUTINES

feature -- Status report

	is_valid_host_port (a_string: STRING): BOOLEAN is
			-- Is the string a valid host name and port?
			-- Matches [^:]+(:[0-9]+)?
		local
			i: INTEGER
			a_port: STRING
		do
			if a_string /= Void then
				i := a_string.index_of (Port_separator, 1)
				if i > 1 then
					a_port := a_string.substring (i + 1, a_string.count)
					Result := a_port.is_integer and then is_valid_port (a_port.to_integer)
				elseif i = 0 then
					Result := a_string.count > 0
				end
			end
		end

	is_valid_port (a_port: INTEGER): BOOLEAN is
			-- Is this port number allowed?
		do
			Result := a_port >= 0 and a_port < Maximum_port
		ensure
			definition: Result = (a_port >= 0 and a_port < Maximum_port)
		end

feature {NONE} -- Constants

	Maximum_port: INTEGER is 65535
			-- Maximum port number

	Port_separator: CHARACTER is ':'
			-- Port separator

end
