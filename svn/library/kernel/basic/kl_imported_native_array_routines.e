indexing

	description:

		"Imported routines that ought to be in class NATIVE_ARRAY. %
		%A native array is a zero-based indexed sequence of values, %
		%equipped with features `put' and `item', but the clients %
		%have to keep track of `count'."

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2002-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-06 09:53:14 +0200 (Mon, 06 Oct 2008) $"
	revision: "$Revision: 6531 $"

class KL_IMPORTED_NATIVE_ARRAY_ROUTINES

obsolete

	"[041219] Use SPECIAL and KL_SPECIAL_ROUTINES instead."

feature -- Access

	NATIVE_ANY_ARRAY_: KL_NATIVE_ARRAY_ROUTINES [ANY] is
			-- Routines that ought to be in class NATIVE_ARRAY
		once
			create Result
		ensure
			native_any_array_routines_not_void: Result /= Void
		end

	NATIVE_BOOLEAN_ARRAY_: KL_NATIVE_ARRAY_ROUTINES [BOOLEAN] is
			-- Routines that ought to be in class NATIVE_ARRAY
		once
			create Result
		ensure
			native_boolean_array_routines_not_void: Result /= Void
		end

	NATIVE_CHARACTER_ARRAY_: KL_NATIVE_ARRAY_ROUTINES [CHARACTER] is
			-- Routines that ought to be in class NATIVE_ARRAY
		once
			create Result
		ensure
			native_character_array_routines_not_void: Result /= Void
		end

	NATIVE_INTEGER_ARRAY_: KL_NATIVE_ARRAY_ROUTINES [INTEGER] is
			-- Routines that ought to be in class NATIVE_ARRAY
		once
			create Result
		ensure
			native_integer_array_routines_not_void: Result /= Void
		end

	NATIVE_STRING_ARRAY_: KL_NATIVE_ARRAY_ROUTINES [STRING] is
			-- Routines that ought to be in class NATIVE_ARRAY
		once
			create Result
		ensure
			native_string_array_routines_not_void: Result /= Void
		end

feature -- Type anchors

	NATIVE_ANY_ARRAY_TYPE: SPECIAL [ANY] is
			-- Type anchor
		require
			do_not_call: False
		do
			Result := NATIVE_ANY_ARRAY_TYPE --| void-safety: this code should never be called.
		end

	NATIVE_BOOLEAN_ARRAY_TYPE: SPECIAL [BOOLEAN] is
			-- Type anchor
		require
			do_not_call: False
		do
			Result := NATIVE_BOOLEAN_ARRAY_TYPE --| void-safety: this code should never be called.
		end

	NATIVE_CHARACTER_ARRAY_TYPE: SPECIAL [CHARACTER] is
			-- Type anchor
		require
			do_not_call: False
		do
			Result := NATIVE_CHARACTER_ARRAY_TYPE --| void-safety: this code should never be called.
		end

	NATIVE_INTEGER_ARRAY_TYPE: SPECIAL [INTEGER] is
			-- Type anchor
		require
			do_not_call: False
		do
			Result := NATIVE_INTEGER_ARRAY_TYPE --| void-safety: this code should never be called.
		end

	NATIVE_STRING_ARRAY_TYPE: SPECIAL [STRING] is
			-- Type anchor
		require
			do_not_call: False
		do
			Result := NATIVE_STRING_ARRAY_TYPE --| void-safety: this code should never be called.
		end

end
