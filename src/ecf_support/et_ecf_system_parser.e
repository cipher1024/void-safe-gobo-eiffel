indexing
	description: ""
	date: "$Date: 2008-12-02 23:56:22 +0100 (Tue, 02 Dec 2008) $"
	revision: "$Revision: 76039 $"

class
	ET_ECF_SYSTEM_PARSER

inherit
	ET_ECF_PARSER

create
	make, make_standard, make_with_factory

feature -- Parsing

	parse_file (a_file: KI_CHARACTER_INPUT_STREAM) is
			-- Parse ECF file `a_file'.
		do
		end

	set_ise_version (s: UT_VERSION) is
			--
		do

		end


end
