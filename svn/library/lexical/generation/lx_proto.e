indexing

	description:

		"Protos are DFA states with transition tables that have a high %
		%probability of either being redundant (a state processed later %
		%will have an identical transition table) or nearly redundant (a %
		%state processed later will have many of the same out-transitions)"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-10-05 12:21:37 +0200 (Sun, 05 Oct 2008) $"
	revision: "$Revision: 6530 $"

class LX_PROTO

create

	make

feature {NONE} -- Initialization

	make (i: INTEGER; trans: like transitions; com_st: like common_state) is
			-- Create a new proto of state id `i'.
		require
			trans_not_void: trans /= Void
			com_st_not_void: com_st /= Void
		do
			state_id := i
			transitions := trans
			common_state := com_st
		ensure
			state_id_set: state_id = i
			transitions_set: transitions = trans
			common_state_set: common_state = com_st
		end

feature -- Access

	transitions: LX_TRANSITION_TABLE [LX_DFA_STATE]
			-- Transition table

	state_id: INTEGER
			-- Proto state id

	common_state: LX_DFA_STATE
			-- Most common `transitions'' target

invariant

	common_state_not_void: common_state /= Void
	transitions_not_void: transitions /= Void

end
