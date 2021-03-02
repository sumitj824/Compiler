%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME

%token TYPEDEF EXTERN STATIC AUTO REGISTER
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token STRUCT UNION ENUM ELLIPSIS

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%union{
	node *ptr;
}






%type <ptr> primary_expression postfix_expression argument_expression_list unary_expression unary_operator cast_expression multiplicative_expression additive_expression
%type <ptr> shift_expression relational_expression equality_expression and_expression exclusive_or_expression inclusive_or_expression logical_and_expression logical_or_expression
%type <ptr> conditional_expression assignment_expression assignment_operator expression constant_expression declaration declaration_specifiers init_declarator_list init_declarator
%type <ptr> storage_class_specifier type_specifier struct_or_union_specifier struct_or_union struct_declaration_list struct_declaration specifier_qualifier_list struct_declarator_list
%type <ptr> struct_declarator enum_specifier enumerator_list enumerator type_qualifier declarator direct_declarator pointer type_qualifier_list parameter_type_list parameter_list
%type <ptr> parameter_declaration identifier_list type_name abstract_declarator direct_abstract_declarator initializer initializer_list statement labeled_statement compound_statement
%type <ptr> declaration_list statement_list expression_statement selection_statement iteration_statement jump_statement translation_unit external_declaration function_definition

%start translation_unit
%%

primary_expression
	: IDENTIFIER											{$$=terminal($1)}				
	| CONSTANT												{$$=$1}
	| STRING_LITERAL										{$$=$1}
	| '(' expression ')'									{$$=$2}
	;

postfix_expression
	: primary_expression       								{$$=$1}
	| postfix_expression '[' expression ']'					{$$=nonterminal2("postfix_expression", $1, $3)}
	| postfix_expression '(' ')'							{$$=$1}
	| postfix_expression '(' argument_expression_list ')'   {$$=nonterminal2("postfix_expression", $1, $3)}
	| postfix_expression '.' IDENTIFIER						{$$=nonterminal2("postfix_expression.IDENTIFIER", $1, terminal($3))}
	| postfix_expression PTR_OP IDENTIFIER
	| postfix_expression INC_OP
	| postfix_expression DEC_OP
	;

argument_expression_list									
	: assignment_expression									{$$=$1}
	| argument_expression_list ',' assignment_expression    {$$=nonterminal2("argument_expression_list", $1, $3)}
	;

unary_expression
	: postfix_expression									{$$=$1}
	| INC_OP unary_expression	
	| DEC_OP unary_expression
	| unary_operator cast_expression						{$$=nonterminal2("unary_expression",$1,$2)}
	| SIZEOF unary_expression
	| SIZEOF '(' type_name ')'
	;

unary_operator
	: '&'
	| '*'
	| '+'
	| '-'
	| '~'
	| '!'
	;

cast_expression
	: unary_expression									   {$$=$1}
	| '(' type_name ')' cast_expression                    {$$=nonterminal2("cast_expression", $2, $4)}
	;

multiplicative_expression
	: cast_expression									   {$$=$1}
	| multiplicative_expression '*' cast_expression        
	| multiplicative_expression '/' cast_expression
	| multiplicative_expression '%' cast_expression
	;

additive_expression
	: multiplicative_expression								{$$=$1}
	| additive_expression '+' multiplicative_expression
	| additive_expression '-' multiplicative_expression
	;

shift_expression
	: additive_expression									{$$=$1}
	| shift_expression LEFT_OP additive_expression
	| shift_expression RIGHT_OP additive_expression
	;

relational_expression	
	: shift_expression										{$$=$1}
	| relational_expression '<' shift_expression
	| relational_expression '>' shift_expression
	| relational_expression LE_OP shift_expression
	| relational_expression GE_OP shift_expression
	;

equality_expression
	: relational_expression									{$$=$1}
	| equality_expression EQ_OP relational_expression
	| equality_expression NE_OP relational_expression
	;

and_expression
	: equality_expression									       {$$=$1}
	| and_expression '&' equality_expression
	;

exclusive_or_expression
	: and_expression											    {$$=$1}
	| exclusive_or_expression '^' and_expression
	;

inclusive_or_expression
	: exclusive_or_expression										{$$=$1}
	| inclusive_or_expression '|' exclusive_or_expression
	;

logical_and_expression
	: inclusive_or_expression										{$$=$1}
	| logical_and_expression AND_OP inclusive_or_expression
	;

logical_or_expression
	: logical_and_expression										{$$=$1}
	| logical_or_expression OR_OP logical_and_expression
	;

conditional_expression
	: logical_or_expression												{$$=$1}
	| logical_or_expression '?' expression ':' conditional_expression
	;

assignment_expression
	: conditional_expression													{$$=$1}
	| unary_expression assignment_operator assignment_expression		    {$$=nonterminal3("assignment_expression",$1,$2,$3)}
	;

assignment_operator
	: '='
	| MUL_ASSIGN
	| DIV_ASSIGN
	| MOD_ASSIGN
	| ADD_ASSIGN
	| SUB_ASSIGN
	| LEFT_ASSIGN
	| RIGHT_ASSIGN
	| AND_ASSIGN
	| XOR_ASSIGN
	| OR_ASSIGN
	;

expression
	: assignment_expression										{$$=$1}
	| expression ',' assignment_expression						{$$=nonterminal2("expression",$1,$3)}
	;

constant_expression
	: conditional_expression								   {$$=$1}
	;

declaration
	: declaration_specifiers ';'								
	| declaration_specifiers init_declarator_list ';'			{$$=nonterminal2("declaration",$1,$2)}
	;

declaration_specifiers
	: storage_class_specifier									{$$=$1}
	| storage_class_specifier declaration_specifiers			{$$=nonterminal2("declaration_specifiers",$1,$2)}
	| type_specifier											{$$=$1}
	| type_specifier declaration_specifiers						{$$=nonterminal2("declaration_specifiers",$1,$2)}
	| type_qualifier											{$$=$1}
	| type_qualifier declaration_specifiers						{$$=nonterminal2("declaration_specifiers",$1,$2)}
	;

init_declarator_list
	: init_declarator											{$$=$1}
	| init_declarator_list ',' init_declarator					{$$=nonterminal2("init_declarator_list",$1,$3)}	
	;

init_declarator
	: declarator											{$$=$1}
	| declarator '=' initializer							{$$=nonterminal2("init_declarator",$1,$3)}
	;

storage_class_specifier
	: TYPEDEF												{$$=terminal($1)}
	| EXTERN												{$$=terminal($1)}
	| STATIC												{$$=terminal($1)}
	| AUTO												    {$$=terminal($1)}
	| REGISTER												{$$=terminal($1)}
	;

type_specifier
	: VOID												{$$=terminal($1)}
	| CHAR												{$$=terminal($1)}
	| SHORT												{$$=terminal($1)}
	| INT												{$$=terminal($1)}
	| LONG												{$$=terminal($1)}
	| FLOAT												{$$=terminal($1)}
	| DOUBLE										    {$$=terminal($1)}
	| SIGNED											{$$=terminal($1)}
	| UNSIGNED										    {$$=terminal($1)}
	| struct_or_union_specifier							{$$=$1}
	| enum_specifier								    {$$=$1}
	| TYPE_NAME											{$$=terminal($1)}
	;

struct_or_union_specifier
	: struct_or_union IDENTIFIER '{' struct_declaration_list '}'  {$$=nonterminal3("struct_or_union_specifier",$1,terminal($2),$4)}
	| struct_or_union '{' struct_declaration_list '}'             {$$=nonterminal2("struct_or_union_specifier",$1,$3)}
	| struct_or_union IDENTIFIER								  {$$=nonterminal2("struct_or_union_specifier",$1,terminal($2))}
	;

struct_or_union
	: STRUCT										    {$$=terminal($1)}
	| UNION										        {$$=terminal($1)}
	;

struct_declaration_list
	: struct_declaration											{$$=$1}
	| struct_declaration_list struct_declaration					{$$=nonterminal2("struct_declaration_list",$1,$2)}
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list ';'          {$$=nonterminal2("struct_declaration",$1,$2)}
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list					{$$=nonterminal2("specifier_qualifier_list",$1,$2)}
	| type_specifier											{$$=$1}
	| type_qualifier specifier_qualifier_list					{$$=nonterminal2("specifier_qualifier_list",$1,$2)}
	| type_qualifier											{$$=$1}
	;

struct_declarator_list
	: struct_declarator											{$$=$1}
	| struct_declarator_list ',' struct_declarator				{$$=nonterminal2("struct_declarator_list",$1,$3)}              
	;

struct_declarator
	: declarator											{$$=$1}
	| ':' constant_expression								{$$=$1}
	| declarator ':' constant_expression					{$$=nonterminal2("struct_declarator"),$1,$3)}
	;

enum_specifier
	: ENUM '{' enumerator_list '}'					{$$=nonterminal2("enum_specifier",$1,$3)}
	| ENUM IDENTIFIER '{' enumerator_list '}'	   {$$=nonterminal3("enum_specifier",$1,$2,$4)}
	| ENUM IDENTIFIER								{$$=nonterminal2("enum_specifier",$1,$2)}
	;

enumerator_list
	: enumerator											{$$=$1}
	| enumerator_list ',' enumerator					{$$=nonterminal2("enumerator_list",$1,$3)}
	;

enumerator
	: IDENTIFIER										{$$=$1}
	| IDENTIFIER '=' constant_expression                {$$=nonterminal2("=",$1,$3)}
	;

type_qualifier	
	: CONST										    {$$=terminal($1)}
	| VOLATILE										{$$=terminal($1)}
	;

declarator
	: pointer direct_declarator	               					{$$=nonterminal2("declarator",$1,$2)}
	| direct_declarator											{$$=$1}
	;

direct_declarator
	: IDENTIFIER										    {$$=terminal($1)}
	| '(' declarator ')'										{$$=$2}
	| direct_declarator '[' constant_expression ']'        {$$=nonterminal2("direct_declarator",$1,$3)}
	| direct_declarator '[' ']'
	| direct_declarator '(' parameter_type_list ')'        {$$=nonterminal2("direct_declarator",$1,$3)}
	| direct_declarator '(' identifier_list ')'        {$$=nonterminal2("direct_declarator",$1,$3)}
	| direct_declarator '(' ')'
	;

pointer
	: '*'										{$$=terminal("*")}
	| '*' type_qualifier_list					{$$=nonterminal1("*",$2)}
	| '*' pointer								{$$=nonterminal1("*",$2)}
	| '*' type_qualifier_list pointer		    {$$=nonterminal2("*",$2,$3)}
	;

type_qualifier_list
	: type_qualifier											{$$=$1}
	| type_qualifier_list type_qualifier						{$$=nonterminal2("type_qualifier_list",$1,$2)}
	;


parameter_type_list
	: parameter_list											{$$=$1}
	| parameter_list ',' ELLIPSIS								{$$=nonterminal1("parameter_type_list",$1,terminal($3))}
	;

parameter_list
	: parameter_declaration											{$$=$1}
	| parameter_list ',' parameter_declaration                 {$$=nonterminal2("parameter_list",$1,$3)}
	;

parameter_declaration
	: declaration_specifiers declarator                 {$$=nonterminal2("parameter_declaration",$1,$2)}
	| declaration_specifiers abstract_declarator                 {$$=nonterminal2("parameter_declaration",$1,$2)}
	| declaration_specifiers											{$$=$1}
	;

identifier_list
	: IDENTIFIER										{$$=terminal($1)}
	| identifier_list ',' IDENTIFIER					{$$=nonterminal2("identifier_list",$1,terminal($3))}
	;

type_name
	: specifier_qualifier_list											{$$=$1}
	| specifier_qualifier_list abstract_declarator		 {$$=nonterminal2("type_name",$1,$2)}
	;

abstract_declarator
	: pointer											{$$=$1}
	| direct_abstract_declarator											{$$=$1}
	| pointer direct_abstract_declarator {$$=nonterminal2("abstract_declarator",$1,$2)}
	;

direct_abstract_declarator
	: '(' abstract_declarator ')'		{$$=$2}
	| '[' ']'							{$$=terminal("[ ]")}
	| '[' constant_expression ']'		
	| direct_abstract_declarator '[' ']'
	| direct_abstract_declarator '[' constant_expression ']'
	| '(' ')'
	| '(' parameter_type_list ')'
	| direct_abstract_declarator '(' ')'
	| direct_abstract_declarator '(' parameter_type_list ')'
	;

initializer
	: assignment_expression											{$$=$1}
	| '{' initializer_list '}'
	| '{' initializer_list ',' '}'
	;

initializer_list
	: initializer											{$$=$1}
	| initializer_list ',' initializer
	;

statement
	: labeled_statement											{$$=$1}
	| compound_statement											{$$=$1}
	| expression_statement											{$$=$1}
	| selection_statement											{$$=$1}
	| iteration_statement											{$$=$1}
	| jump_statement											{$$=$1}
	;

labeled_statement
	: IDENTIFIER ':' statement
	| CASE constant_expression ':' statement
	| DEFAULT ':' statement
	;

compound_statement
	: '{' '}'    					{$$=terminal("{ }")}
	| '{' statement_list '}'		{$$=nonterminal1("compound_statement",$2)}
	| '{' declaration_list '}'		{$$=nonterminal1("compound_statement",$2)}
	| '{' declaration_list statement_list '}'   {$$=nonterminal2("compound_statement",$2,$3)}
	;

declaration_list
	: declaration											{$$=$1}
	| declaration_list declaration                        {$$=nonterminal2("declaration_list",$1,$2)}
	;

statement_list
	: statement											{$$=$1}
	| statement_list statement							{$$=nonterminal2("statement_list",$1,$2)}
	;

expression_statement
	: ';'
	| expression ';'											{$$=$1}
	;

selection_statement
	: IF '(' expression ')' statement               	{$$=nonterminal2("IF (expr) stmt",$3,$5)}
	| IF '(' expression ')' statement ELSE statement      {$$=nonterminal3("IF (expr) stmt ELSE stmt",$3,$5,$7)}
	| SWITCH '(' expression ')' statement               {$$=nonterminal2("SWITCH (expr) stmt",$3,$5)}
	;

iteration_statement
	: WHILE '(' expression ')' statement              	{$$=nonterminal2("WHILE (expr) stmt",$3,$5)}
	| DO statement WHILE '(' expression ')' ';'			{$$=nonterminal2("DO stmt WHILE (expr)",$2,$5)}
	| FOR '(' expression_statement expression_statement ')' statement   {$$=nonterminal3("FOR (expr_stmt expr_stmt) stmt",$3,$4,$6)}
	| FOR '(' expression_statement expression_statement expression ')' statement    {$$=nonterminal4("FOR (expr_stmt expr_stmt expr) stmt",$3,$4,$5,$7)}
	;

jump_statement
	: GOTO IDENTIFIER ';'						{$$=nonterminal2("jump_statement",terminal($1),terminal($2))}
	| CONTINUE ';'						{$$=nonterminal1("jump_statement",terminal("continue"))}
	| BREAK ';'						{$$=nonterminal1("jump_statement",terminal("break"))}
	| RETURN ';'						{$$=nonterminal1("jump_statement",terminal("return"))}
	| RETURN expression ';'						{$$=nonterminal2("jump_statement",terminal("return"),$2)}
	;

translation_unit
	: external_declaration											{$$=$1}
	| translation_unit external_declaration                        {$$=nonterminal2("translation_unit",$1,$2)}
	;

external_declaration
	: function_definition									{$$=$1}
	| declaration											{$$=$1}
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement                         {$$=nonterminal4("function_definition",$1,$2,$3,$4)}
	| declaration_specifiers declarator compound_statement                        {$$=nonterminal3("function_definition",$1,$2,$3)}
	| declarator declaration_list compound_statement                        {$$=nonterminal3("function_definition",$1,$2,$3)}
	| declarator compound_statement                        {$$=nonterminal2("function_definition",$1,$2)}
	;

%%
#include <stdio.h>

extern char yytext[];
extern int column;

yyerror(s)
char *s;
{
	fflush(stdout);
	printf("\n%*s\n%*s\n", column, "^", column, s);
}

void help(int f)
{	
	if(f) printf("Error : \n");
	printf("Specify input file with -i flag\n");
	printf("Specify Output file with -o flag\n");
}


int main(int argc, char *argv[])
{	
	if(argc==1)
	{
		help(1);
		return 0;
	}

	for(int i=1;i<argc;i++)
	{

		if(strcmp("-help",argv[i])==0)
		{
			help(0);
			return 0;
		}
		else if(strcmp("-i",argv[i])==0)
		{
			if(i+1<argc)
			{
				FILE *in=freopen(argv[i+1],"r",stdin);
				i++;

				if(!in)
				{
					help(1);
					return 0;
				}
			}
			else
			{
				help(1);
				return 0;
			}
		}

		else if(strcmp("-o",argv[i])==0)
		{
			if(i+1<argc)
			{
				FILE *out =freopen(argv[i+1],"w",stdout);
				i++;
				if(!out)
				{
					help(1);
					return 0;
				}
			}
			else
			{
				help(1);
				return 0;
			}
		}
		else
		{
			help(1);
			return 0;
		}
	}

	yyparse();
	
} 