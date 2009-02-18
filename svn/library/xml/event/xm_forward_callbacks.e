indexing

	description:

		"Descendant of callbacks interface forwarding to a client interface"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (ven., 26 janv. 2007) $"
	revision: "$Revision: 5877 $"

class XM_FORWARD_CALLBACKS

inherit

	XM_CALLBACKS_SOURCE

	XM_CALLBACKS
		export {NONE} all end

feature -- Access

	internal_callbacks: ?like callbacks
			-- Callbacks event interface to which events are forwarded;
			-- If void, a null callback is created on startup.
			-- FIXME:jfiat ... could make this class deferred .. or using make_null creating the `callbacks'
			--		so that `callbacks' could be attached.

	callbacks: XM_CALLBACKS
			-- Attached version of `callbacks'
			--| for ease of conversion (FIXME:jfiat)
		require
			callbacks_set: internal_callbacks /= Void
		local
			c: like internal_callbacks
		do
			c := internal_callbacks
			check c /= Void end -- implied by `callbacks_set'
			Result := c
		end

feature -- Setting

	set_callbacks (a_callbacks: !like internal_callbacks) is
			-- Set `callbacks' to `a_callbacks'.
		do
			internal_callbacks := a_callbacks
		ensure then
			callbackes_set: internal_callbacks = a_callbacks
		end

feature {NONE} -- Document

	on_start is
			-- Forward start.
		local
			c: like internal_callbacks
		do
			c := internal_callbacks
			if c = Void then
				create {XM_CALLBACKS_NULL} c.make
				internal_callbacks := c
			end
			c.on_start
		end

	on_finish is
			-- Forward finish.
		do
			callbacks.on_finish
		end

	on_xml_declaration (a_version: STRING; an_encoding: STRING; a_standalone: BOOLEAN) is
			-- XML declaration.
		do
			callbacks.on_xml_declaration (a_version, an_encoding, a_standalone)
		end

feature {NONE} -- Errors

	on_error (a_message: STRING) is
			-- Event producer detected an error.
		do
			callbacks.on_error (a_message)
		end

feature {NONE} -- Meta

	on_processing_instruction (a_name, a_content: STRING) is
			-- Forward PI.
		do
			callbacks.on_processing_instruction (a_name, a_content)
		end

	on_comment (a_content: STRING) is
			-- Forward comment.
		do
			callbacks.on_comment (a_content)
		end

feature {NONE} -- Tag

	on_start_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- Start of start tag.
		do
			callbacks.on_start_tag (a_namespace, a_prefix, a_local_part)
		end

	on_attribute (a_namespace, a_prefix: ?STRING; a_local_part: STRING; a_value: STRING) is
			-- Process attribute.
		do
			callbacks.on_attribute (a_namespace, a_prefix, a_local_part, a_value)
		end

	on_start_tag_finish is
			-- End of start tag.
		do
			callbacks.on_start_tag_finish
		end

	on_end_tag (a_namespace, a_prefix: ?STRING; a_local_part: STRING) is
			-- End tag.
		do
			callbacks.on_end_tag (a_namespace, a_prefix, a_local_part)
		end

feature {NONE} -- Content

	on_content (a_content: STRING) is
			-- Forward content.
		do
			callbacks.on_content (a_content)
		end

end
