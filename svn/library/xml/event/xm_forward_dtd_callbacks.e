indexing

	description:

		"Callbacks for DTD declaration"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class XM_FORWARD_DTD_CALLBACKS

inherit

	XM_DTD_CALLBACKS_SOURCE

	XM_DTD_CALLBACKS
		export {NONE} all end

feature -- Access

	dtd_callbacks: ?XM_DTD_CALLBACKS
			-- Callbacks event interface to which events are forwarded;
			-- If void, a null callback is created on startup.

feature -- Setting

	set_dtd_callbacks (a_callbacks: like dtd_callbacks) is
			-- Set `dtd_callbacks' to `a_callbacks'.
		do
			dtd_callbacks := a_callbacks
		ensure then
			dtd_callbacks_set: dtd_callbacks = a_callbacks
		end

feature {NONE} -- Document type definition callbacks

	on_doctype (name: STRING; an_id: ?XM_DTD_EXTERNAL_ID; has_internal_subset: BOOLEAN) is
			-- Document type declaration.
		local
			c: like dtd_callbacks
		do
			c := dtd_callbacks
			if c = Void then
				create {XM_DTD_CALLBACKS_NULL} c.make
				dtd_callbacks := c
			end
			c.on_doctype (name, an_id, has_internal_subset)
		ensure then
			dtd_callbacks_not_void: dtd_callbacks /= Void
		end

	on_element_declaration (a_name: STRING; a_model: XM_DTD_ELEMENT_CONTENT) is
			-- Element declaration.
		local
			c: like dtd_callbacks
		do
			c := dtd_callbacks
			check c_attached: c /= Void end
			c.on_element_declaration (a_name, a_model)
		end

	on_attribute_declaration (an_element_name, a_name: STRING; a_model: XM_DTD_ATTRIBUTE_CONTENT) is
			-- Attribute declaration, one event per attribute.
		local
			c: like dtd_callbacks
		do
			c := dtd_callbacks
			check c_attached: c /= Void end
			c.on_attribute_declaration (an_element_name, a_name, a_model)
		end

	on_entity_declaration (entity_name: STRING; is_parameter: BOOLEAN; value: ?STRING;
		an_id: ?XM_DTD_EXTERNAL_ID; notation_name: ?STRING) is
			-- Entity declaration.
		local
			c: like dtd_callbacks
		do
			c := dtd_callbacks
			check c_attached: c /= Void end
			c.on_entity_declaration (entity_name, is_parameter, value, an_id, notation_name)
		end

	on_notation_declaration (notation_name: STRING; an_id: XM_DTD_EXTERNAL_ID) is
			-- Notation declaration.
		local
			c: like dtd_callbacks
		do
			c := dtd_callbacks
			check c_attached: c /= Void end
			c.on_notation_declaration (notation_name, an_id)
		end

	on_dtd_processing_instruction (a_name, a_content: STRING) is
			-- Forward PI.
		local
			c: like dtd_callbacks
		do
			c := dtd_callbacks
			check c_attached: c /= Void end
			c.on_dtd_processing_instruction (a_name, a_content)
		end

	on_dtd_comment (a_content: STRING) is
			-- Forward comment.
		local
			c: like dtd_callbacks
		do
			c := dtd_callbacks
			check c_attached: c /= Void end
			c.on_dtd_comment (a_content)
		end

	on_dtd_end is
			-- End of DTD.
		local
			c: like dtd_callbacks
		do
			c := dtd_callbacks
			check c_attached: c /= Void end
			c.on_dtd_end
		end

end
