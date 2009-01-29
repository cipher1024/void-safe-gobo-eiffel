indexing

	description:

		"Infer a unique set of namespace prefixes for a document tree"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2003, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class XM_UNIQUE_NAMESPACE_PREFIXES

inherit

	XM_NODE_PROCESSOR
		redefine
			process_element,
			process_attribute,
			process_document
		end

	XM_MARKUP_CONSTANTS
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	UC_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

feature -- Node processor.

	process_document (a_node: XM_DOCUMENT) is
			-- Process document.
		do
			make_namespaces
			a_node.process_children (Current)
		end

	process_element (a_node: XM_ELEMENT) is
			-- Collect namespaces.
		do
			process_namespace (a_node.namespace)
			a_node.process_children (Current)
		end

	process_attribute (a_node: XM_ATTRIBUTE) is
			-- Collect namespaces.
		do
			process_namespace (a_node.namespace)
		end

feature -- State

	namespaces: ?DS_HASH_TABLE [XM_NAMESPACE, STRING]
			-- All of the document namespaces with
			-- explicit prefixes (indexed by URI).
			-- ensure prefixes are unique.

feature {NONE} -- State

	prefixes: ?DS_HASH_TABLE [XM_NAMESPACE, STRING]
			-- Inverted index of prefixes from `namespaces'.

feature -- Result

	top_level_declaration: STRING is
			-- Top level declaration of all xml namespaces within
			-- the document.
		require
			namespaces_not_void: namespaces /= Void
		local
			a_cursor: DS_HASH_TABLE_CURSOR [XM_NAMESPACE, STRING]
			l_namespaces: like namespaces
		do
			l_namespaces := namespaces
			check l_namespaces /= Void end -- implied by `namespaces_not_void'
			from
				create Result.make_empty
				a_cursor := l_namespaces.new_cursor
				a_cursor.start
			until
				a_cursor.after
			loop

				Result := STRING_.appended_string (Result, namespace_declaration (a_cursor.item))
				a_cursor.forth
				if not a_cursor.after then
					Result := STRING_.appended_string (Result, Space_s)
				end
			end
		ensure
			not_void_result: Result /= Void
		end

	has_namespace (a_ns: XM_NAMESPACE): BOOLEAN is
			-- Is this namespace known (has an allocated prefix)?
		require
			a_ns_not_void: a_ns /= Void
		do
			Result := {l_namespaces: like namespaces} namespaces
				and then (l_namespaces.has (a_ns.uri) or implicit_namespaces.has (a_ns.uri))
		end

	ns_prefix (a_ns: XM_NAMESPACE): STRING is
			-- Prefix for a non default NS.
		require
			a_ns_not_void: a_ns /= Void
			has: has_namespace (a_ns)
			item_has_prefix: {rl_namespaces: like namespaces} namespaces and then
				rl_namespaces.has (a_ns.uri) implies rl_namespaces.item (a_ns.uri).has_prefix
		local
			s: ?STRING
			l_namespaces: like namespaces
		do
			l_namespaces := namespaces
			check l_namespaces /= Void end -- implied by precondition `has'
			if l_namespaces.has (a_ns.uri) then
				s := l_namespaces.item (a_ns.uri).ns_prefix
			else
				s := implicit_namespaces.item (a_ns.uri).ns_prefix
			end
			check s /= Void end -- implied by `item_has_prefix'
			Result := s
		ensure
			result_not_void: Result /= Void
			result_not_empty: Result.count > 0
		end

	namespace_declaration (a_ns: XM_NAMESPACE): STRING is
			-- Single xmlns declaration.
		require
			a_ns_not_void: a_ns /= Void
		local
			l_ns_prefix: ?STRING
		do
			Result := STRING_.cloned_string (Xmlns)
			if a_ns.has_prefix then
				l_ns_prefix := a_ns.ns_prefix
				check l_ns_prefix /= Void end -- implied by `a_ns.has_prefix'
				Result := STRING_.appended_string (Result, Prefix_separator)
				Result := STRING_.appended_string (Result, l_ns_prefix)
			end
			Result := STRING_.appended_string (Result, Eq_s)
			Result := STRING_.appended_string (Result, Quot_s)
			Result := STRING_.appended_string (Result, a_ns.uri)
			Result := STRING_.appended_string (Result, Quot_s)
		end

feature {NONE} -- Implementation

	process_namespace (a_namespace: XM_NAMESPACE) is
			-- Process a non default namespace.
		require
			a_namespace_not_void: a_namespace /= Void
			namespaces_not_void: namespaces /= Void
		local
			a_candidate_namespace: XM_NAMESPACE
			l_namespaces: like namespaces
			l_prefixes: like prefixes
		do
			if a_namespace.uri.is_empty then
				-- not a defined namespace
			else
				l_namespaces := namespaces
				check l_namespaces /= Void end -- implied by `namespaces_not_void'
				-- the namespace is a defined URI
				if not l_namespaces.has (a_namespace.uri) and not implicit_namespaces.has (a_namespace.uri) then
					-- The namespace is not known, we need
					-- to register it.

					l_prefixes := prefixes
					check l_prefixes /= Void end -- implied by `namespaces_not_void' and `namespaces_with_prefixes'

					if
						a_namespace.has_prefix
						and then {l_prefix: STRING} a_namespace.ns_prefix -- same as has_prefix ...
						and then not l_prefixes.has (l_prefix)
					then
						register_namespace (a_namespace)
					else
						-- The namespace may be without prefix (a default
						-- declaration) or the prefix is already used.
						-- Use an alternative prefix.
						create a_candidate_namespace.make (unique_prefix, a_namespace.uri)
						register_namespace (a_candidate_namespace)
					end
				else
					check
						has_or_implicit: l_namespaces.has (a_namespace.uri)
							or implicit_namespaces.has (a_namespace.uri)
					end
					-- The namespace is known, this may be with another
					-- prefix, in which case the first prefix will be
					-- used everywhere.
				end
			end
		end

feature {NONE} -- Implementation

	make_namespaces is
			-- Initialise namespace tables.
		local
			l_prefixes: like prefixes
			l_namespaces: like namespaces
		do
			create l_namespaces.make_map_default
			namespaces := l_namespaces
			l_namespaces.set_key_equality_tester (string_equality_tester)
			create l_prefixes.make_map_default
			prefixes := l_prefixes
			l_prefixes.set_key_equality_tester (string_equality_tester)
		ensure
			namespaces_not_void: namespaces /= Void
			prefixes_not_void: prefixes /= Void
		end

	register_namespace (a_ns: XM_NAMESPACE) is
			-- Register a namespace (and prefix).
		require
			a_ns_not_void: a_ns /= Void
			not_default_declaration: a_ns.has_prefix
			namespaces_not_void: namespaces /= Void
			not_known_namespace: {rl_namespaces: like namespaces} namespaces and then not rl_namespaces.has (a_ns.uri)
			not_known_prefix: {rl_prefixes: like prefixes} prefixes
					and then {rl_ns_prefix: STRING} a_ns.ns_prefix -- same as has_prefix ...
					and then not rl_prefixes.has (rl_ns_prefix)
		local
			l_namespaces: like namespaces
			l_prefixes: like prefixes
			l_ns_prefix: ?STRING
		do
			l_namespaces := namespaces
			check l_namespaces /= Void end -- implied by `namespaces_not_void'
			l_namespaces.force_new (a_ns, a_ns.uri)

			l_prefixes := prefixes
			check l_prefixes /= Void end -- implied by precondition `namespaces_not_void' and invariant `namespaces_with_prefixes'
			l_ns_prefix := a_ns.ns_prefix
			check l_ns_prefix /= Void end -- implied by `not_default_declaration'
			l_prefixes.force_new (a_ns, l_ns_prefix)
		end

	unique_prefix: STRING is
			-- Find out a prefix not used in current
			-- namespaces.
		require
			namespaces_not_void: namespaces /= Void
		local
			i: INTEGER
			l_prefixes: like prefixes
		do
			-- This linear search will not be very efficient
			-- if there are lots of different namespaces with
			-- duplicate prefixes, but this seems unlikely.
			-- An alternative implementation could use
			-- dichotomic search on i, or a pseudo-random i.
			l_prefixes := prefixes
			check l_prefixes /= Void end -- implied by precondition `namespaces_not_void' and invariant `namespaces_with_prefixes'
			from
				Result := "ns1"
				i := 1
			variant
				l_prefixes.count + 2 - i
			until
				not l_prefixes.has (Result)
			loop
				i := i + 1
				Result := "ns" + i.out
			end
		ensure
			result_not_void: Result /= Void
			new_prefix: {ot_prefixes: like prefixes} prefixes and then not ot_prefixes.has (Result)
		end

	implicit_namespaces: DS_HASH_TABLE [XM_NAMESPACE, STRING] is
			-- Implicit namespaces defined in standards that must
			-- not be declared.
		local
			a_namespace: XM_NAMESPACE
		once
			create Result.make_map_default
			Result.set_key_equality_tester (string_equality_tester)
			create a_namespace.make (Xml_prefix, Xml_prefix_namespace)
			Result.force_new (a_namespace, a_namespace.uri)
			create a_namespace.make (Xmlns, Xmlns_namespace)
			Result.force_new (a_namespace, a_namespace.uri)
		ensure
			result_not_void: Result /= Void
		end

invariant

	namespaces_with_prefixes: namespaces /= Void implies prefixes /= Void

end
