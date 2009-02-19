%{
indexing

	description:

		"Parsers for parser generators such as 'geyacc'"

	library: "Gobo Eiffel Parse Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class PR_YACC_PARSER

inherit

	PR_YACC_PARSER_SKELETON

	PR_YACC_SCANNER
		rename
			make as make_yacc_scanner,
			reset as reset_yacc_scanner
		end

create

	make

%}

%token T_TOKEN T_LEFT T_RIGHT T_NONASSOC T_EXPECT T_PREC T_START T_TYPE
%token T_2PERCENTS T_UNKNOWN

%token <STRING> T_EIFFEL T_IDENTIFIER T_ACTION T_USER_CODE T_CHAR T_STR
%token <STRING> T_INTEGER T_BOOLEAN T_CHARACTER T_REAL T_DOUBLE T_POINTER
%token <STRING> T_LIKE
%token <INTEGER> T_NUMBER T_ERROR '|' ':'

%type <STRING> Identifier
%type <PR_TOKEN> Terminal Token_declaration Left_declaration Right_declaration Nonassoc_declaration
%type <PR_TYPE> Eiffel_type
%type <DS_ARRAYED_LIST [PR_TYPE]> Eiffel_type_list Eiffel_generics

%expect 8

%start Grammar

%%

Grammar:
		{
			initialize_grammar
		}
	Declarations T_2PERCENTS Rules User_code
		{
			if successful then
				set_start_symbol
				process_symbols
			end
		}
	;

Declarations: -- Empty
		{
			precedence := 1
		}
	| Declarations Declaration
	;

Declaration: T_EIFFEL
		{
			if attached $1 as l_decl_1 then
				last_grammar.eiffel_header.force_last (l_decl_1)
			else
				check False end
			end
		}
	| T_TOKEN Symbol_type Token_declaration_list
		{
			type := Void
		}
	| T_TYPE Symbol_type Type_declaration_list
		{
			type := Void
		}
	| T_LEFT Left_declaration_list
		{
			precedence := precedence + 1
		}
	| T_RIGHT Right_declaration_list
		{
			precedence := precedence + 1
		}
	| T_NONASSOC Nonassoc_declaration_list
		{
			precedence := precedence + 1
		}
	| T_START Identifier
		{
			if start_symbol /= Void then
				report_multiple_start_declarations_error
			else
				if attached $2 as l_start_symbol_name then
					create start_symbol.make (l_start_symbol_name, line_nb)
				else
					check False end
				end
			end
		}
	| T_EXPECT T_NUMBER
		{
			last_grammar.set_expected_conflicts ($2)
		}
	;

Symbol_type: -- Empty
		{
			type := No_type
		}
	| '<' Eiffel_type '>'
		{
			type := $2
		}
	;

Eiffel_type: T_IDENTIFIER
		{
			$$ := new_type ($1)
		}
	| T_INTEGER
		{
			$$ := new_basic_type ($1)
		}
	| T_BOOLEAN
		{
			$$ := new_basic_type ($1)
		}
	| T_CHARACTER
		{
			$$ := new_basic_type ($1)
		}
	| T_REAL
		{
			$$ := new_basic_type ($1)
		}
	| T_DOUBLE
		{
			$$ := new_basic_type ($1)
		}
	| T_POINTER
		{
			$$ := new_basic_type ($1)
		}
	| T_IDENTIFIER Eiffel_generics
		{
			$$ := new_generic_type ($1, $2)
		}
	| T_LIKE T_IDENTIFIER
		{
			$$ := new_anchored_type ($2)
		}
	;

Eiffel_generics: '[' Eiffel_type_list ']'
		{
			$$ := $2
		}
	;

Eiffel_type_list: -- Empty
		{
			$$ := Void
		}
	| Eiffel_type
		{
			create $$.make (5)
			if attached $1 as l_type_1 then
				$$.force_last (l_type_1)
			else
				check False end
			end
		}
	| Eiffel_type_list ',' Eiffel_type
		{
			$$ := $1
			check $$ /= Void end
			if attached $3 as l_type_3 then
				$$.force_last (l_type_3)
			else
				check False end
			end
		}
	;

Token_declaration_list: -- Empty
	| Token_declaration_list Token_declaration
	| Token_declaration_list ',' Token_declaration
	;

Token_declaration: Identifier
		{
			$$ := new_terminal ($1, type)
		}
	| Identifier T_NUMBER
		{
			$$ := new_terminal ($1, type)
			set_token_id ($$, $2)
		}
	| Identifier T_STR
		{
			$$ := new_terminal ($1, type)
			set_literal_string ($$, $2)
		}
	| Identifier T_NUMBER T_STR
		{
			$$ := new_terminal ($1, type)
			set_token_id ($$, $2)
			set_literal_string ($$, $3)
		}
	| T_CHAR
		{
			$$ := new_char_terminal ($1, type)
		}
	;

Left_declaration_list: -- Empty
	| Left_declaration_list Left_declaration
	| Left_declaration_list ',' Left_declaration
	;

Left_declaration: Identifier
		{
			$$ := new_left_terminal ($1, precedence)
		}
	| Identifier T_NUMBER
		{
			$$ := new_left_terminal ($1, precedence)
			set_token_id ($$, $2)
		}
	| Identifier T_STR
		{
			$$ := new_left_terminal ($1, precedence)
			set_literal_string ($$, $2)
		}
	| Identifier T_NUMBER T_STR
		{
			$$ := new_left_terminal ($1, precedence)
			set_token_id ($$, $2)
			set_literal_string ($$, $3)
		}
	| T_CHAR
		{
			$$ := new_left_char_terminal ($1, precedence)
		}
	;

Right_declaration_list: -- Empty
	| Right_declaration_list Right_declaration
	| Right_declaration_list ',' Right_declaration
	;

Right_declaration: Identifier
		{
			$$ := new_right_terminal ($1, precedence)
		}
	| Identifier T_NUMBER
		{
			$$ := new_right_terminal ($1, precedence)
			set_token_id ($$, $2)
		}
	| Identifier T_STR
		{
			$$ := new_right_terminal ($1, precedence)
			set_literal_string ($$, $2)
		}
	| Identifier T_NUMBER T_STR
		{
			$$ := new_right_terminal ($1, precedence)
			set_token_id ($$, $2)
			set_literal_string ($$, $3)
		}
	| T_CHAR
		{
			$$ := new_right_char_terminal ($1, precedence)
		}
	;

Nonassoc_declaration_list: -- Empty
	| Nonassoc_declaration_list Nonassoc_declaration
	| Nonassoc_declaration_list ',' Nonassoc_declaration
	;

Nonassoc_declaration: Identifier
		{
			$$ := new_nonassoc_terminal ($1, precedence)
		}
	| Identifier T_NUMBER
		{
			$$ := new_nonassoc_terminal ($1, precedence)
			set_token_id ($$, $2)
		}
	| Identifier T_STR
		{
			$$ := new_nonassoc_terminal ($1, precedence)
			set_literal_string ($$, $2)
		}
	| Identifier T_NUMBER T_STR
		{
			$$ := new_nonassoc_terminal ($1, precedence)
			set_token_id ($$, $2)
			set_literal_string ($$, $3)
		}
	| T_CHAR
		{
			$$ := new_nonassoc_char_terminal ($1, precedence)
		}
	;

Type_declaration_list: -- Empty
	| Type_declaration_list Nonterminal_declaration
	| Type_declaration_list ',' Nonterminal_declaration
	;

Nonterminal_declaration: Identifier
		{
			$$ := new_nonterminal ($1, type)
		}
	;

Rules: -- Empty
		{
			report_no_rules_error
		}
	| Rule
	| Rules Rule
	;

Rule: Lhs Colon Rhs_list ';'
		{
			if attached rule as l_rule_0 then
				process_rule (l_rule_0)
			else
				check False end
			end
			rule := Void
			precedence_token := Void
		}
	;

Lhs: Identifier
		{
			if is_terminal ($1) then
				report_lhs_symbol_token_error ($1)
				rule := new_rule (new_dummy_variable)
			else
				rule := new_rule (new_variable ($1))
				if attached rule as l_rule_4 then
					if l_rule_4.lhs.rules.count > 1 then
						report_rule_declared_twice_warning ($1)
					end
				else
					check False end
				end
			end
			precedence_token := Void
			if attached rule as l_rule_3 then
				put_rule (l_rule_3)
			else
				check False end
			end
		}
	;

Colon: ':'
		{
			if attached rule as l_rule_5 then
				l_rule_5.set_line_nb ($1)
			else
				check False end
			end
		}
	;

Rhs_list: Rhs_errors
	| Rhs_list Bar Rhs_errors
	;

Rhs_errors: Rhs
	| Rhs_errors T_ERROR '(' T_NUMBER ')' T_ACTION
		{
			if attached rule as l_rule_6 then
				if $4 < 1 or $4 > l_rule_6.error_actions.count then
					report_invalid_error_n_error ($4)
				else
					put_error_action (new_error_action ($6, $2), $4, l_rule_6)
				end
			else
				check False end
			end
		}
	;

Rhs: -- Empty
	| Rhs Identifier
		{
			put_symbol (new_symbol ($2), rule)
		}
	| Rhs T_CHAR
		{
			put_symbol (new_char_token ($2), rule)
		}
	| Rhs T_STR
		{
			put_symbol (new_string_token ($2), rule)
		}
	| Rhs T_ACTION
		{
			put_action (new_action ($2), rule)
		}
	| Rhs T_PREC Terminal
		{
			if precedence_token /= Void then
				report_prec_specified_twice_error
			else
				precedence_token := $3
			end
		}
	;

Terminal: Identifier
		{
			if is_terminal ($1) then
				$$ := new_token ($1)
			else
				report_prec_not_token_error ($1)
				$$ := new_char_token ("'a'")
			end
		}
	| T_CHAR
		{
			$$ := new_char_token ($1)
		}
	;

Bar: '|'
		{
			if attached rule as l_rule_1 then
				process_rule (l_rule_1)
				rule := new_rule (l_rule_1.lhs)
			else
				check False end
			end
				precedence_token := Void
			if attached rule as l_rule_2 then
				l_rule_2.set_line_nb ($1)
				put_rule (l_rule_2)
			else
				check False end
			end
		}
	;

User_code: -- Empty
	| T_2PERCENTS
	| T_2PERCENTS T_USER_CODE
		{
			last_grammar.set_eiffel_code ($2)
		}
	;

Identifier: T_IDENTIFIER
		{ $$ := $1 }
	| T_INTEGER
		{ $$ := $1 }
	| T_BOOLEAN
		{ $$ := $1 }
	| T_CHARACTER
		{ $$ := $1 }
	| T_REAL
		{ $$ := $1 }
	| T_DOUBLE
		{ $$ := $1 }
	| T_POINTER
		{ $$ := $1 }
	| T_LIKE
		{ $$ := $1 }
	;

%%

end
