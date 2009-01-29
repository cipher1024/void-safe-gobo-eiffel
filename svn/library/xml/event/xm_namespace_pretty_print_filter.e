indexing

	description:

		"Pretty printers with resolved namespaces"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class XM_NAMESPACE_PRETTY_PRINT_FILTER

inherit

	XM_PRETTY_PRINT_FILTER
		redefine
			on_start_tag,
			on_end_tag,
			on_attribute,
			output_name
		end

create

	make_null,
	set_next

feature -- Tag

	on_start_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- Print start of start tag.
		do
			namespace := a_namespace
			Precursor (a_namespace, a_prefix, a_local_part)
			namespace := Void
		end

	on_attribute (a_namespace, a_prefix: ?STRING; a_local_part: STRING; a_value: STRING) is
			-- Print attribute.
		do
			namespace := a_namespace
			Precursor (a_namespace, a_prefix, a_local_part, a_value)
			namespace := Void
		end

	on_end_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- Print start of start tag.
		do
			namespace := a_namespace
			Precursor (a_namespace, a_prefix, a_local_part)
			namespace := Void
		end


feature {NONE} -- Name output

	namespace: ?STRING
			-- Namespace stored for output

	output_name (a_prefix: STRING; a_local_part: STRING) is
			-- Output prefix:name, with namespace annotation.
		local
			l_namespace: like namespace
		do
			l_namespace := namespace
			if l_namespace /= Void and then l_namespace.count > 0 then
				output_constant ("{")
				output (l_namespace)
				output_constant ("}")
			end
			output (a_local_part)
		end

end
