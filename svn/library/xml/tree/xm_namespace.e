indexing

	description:

		"XML namespace declaration, equality and hashable based on uri only"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date: 2009-01-23 22:42:51 +0100 (Fri, 23 Jan 2009) $"
	revision: "$Revision: 6579 $"

class XM_NAMESPACE

inherit

	HASHABLE
		redefine
			out,
			is_equal
		end

	KL_IMPORTED_STRING_ROUTINES
		export
			{NONE} all
		undefine
			out,
			is_equal
		end

create

	make,
	make_default

feature {NONE} -- Initialization

	make (a_prefix: like ns_prefix; a_uri: like uri) is
			-- Create a new namespace declaration.
		require
			uri_not_void: a_uri /= Void
		do
			ns_prefix := a_prefix
			uri := a_uri
		ensure
			ns_prefix_set: ns_prefix = a_prefix
			uri_set: uri = a_uri
		end

	make_default is
			-- Make default namespace (empty URI)
		do
			make ("", "")
		ensure
			no_prefix: not has_prefix
			default_namespace: uri.count = 0
		end

feature -- Access

	ns_prefix: ?STRING
			-- Prefix of current namespace

	uri: STRING
			-- Namespace URI

feature -- Status report

	is_equal (other: like Current): BOOLEAN is
			-- Are the two namespaces equal?
		do
			Result := (uri = other.uri) or else
				(STRING_.same_string (uri, other.uri))
		ensure then
			definition: Result = STRING_.same_string (uri, other.uri)
		end

	hash_code: INTEGER is
			-- Hash code of URI
		do
			Result := uri.hash_code
		end

	out: STRING is
			-- Out
		do
			Result := uri
		end

feature -- Status report

	same_prefix (other: XM_NAMESPACE): BOOLEAN is
			-- Same
		local
			l_ns_prefix, l_other_ns_prefix: like ns_prefix
		do
			l_ns_prefix := ns_prefix
			l_other_ns_prefix := other.ns_prefix
			Result := is_equal (other) and then
				((l_ns_prefix = l_other_ns_prefix) or else
					((l_ns_prefix /= Void and l_other_ns_prefix /= Void) and then STRING_.same_string (l_ns_prefix, l_other_ns_prefix)))
		ensure
			equal: Result implies is_equal (other)
			same_prefix: Result implies
				(ns_prefix = other.ns_prefix or else (
					{el_ns_prefix: like ns_prefix} ns_prefix
					and then {el_other_ns_prefix: like ns_prefix} other.ns_prefix
					and then STRING_.same_string (el_ns_prefix, el_other_ns_prefix))
					)
		end

	has_prefix: BOOLEAN is
			-- Is there an explicit prefix?
			-- (not a default namespace declaration)
		local
			l_ns_prefix: like ns_prefix
		do
			l_ns_prefix := ns_prefix
			Result := (l_ns_prefix /= Void and then l_ns_prefix.count > 0)
		ensure
			definition: Result = ({el_ns_prefix: like ns_prefix} ns_prefix and then el_ns_prefix.count > 0)
		end

invariant

	uri_not_void: uri /= Void

end
