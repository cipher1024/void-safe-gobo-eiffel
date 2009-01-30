indexing

	description:

		"Execution environment facilities"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class GE_EXECUTION_ENVIRONMENT

inherit

	EXECUTION_ENVIRONMENT
		redefine
			environ
		end

feature {NONE} -- Implementation

	environ: GE_HASH_TABLE [C_STRING, STRING] is
			-- Environment variable memory set by current execution,
			-- indexed by environment variable name. Needed otherwise
			-- we would corrupt memory after freeing memory used by
			-- C_STRING instance since not referenced anywhere else.
		local
			l_string_tester: GE_STRING_EQUALITY_TESTER
		once
			create Result.make_map (10)
			create l_string_tester
			Result.set_key_equality_tester (l_string_tester)
		ensure then
			environ_not_void: Result /= Void
		end

end
