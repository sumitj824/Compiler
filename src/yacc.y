%{
#include <iostream>
#include <cstring>
#include "node.h"
using namespace std;
void yyerror(char *s);
int yylex();

%}
%union{
	node *ptr;
	char *str;
}



%token<str> IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token<str> PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token<str> AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token<str> SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token<str> XOR_ASSIGN OR_ASSIGN TYPE_NAME

%token<str> TYPEDEF EXTERN STATIC AUTO REGISTER
%token<str> CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token<str> STRUCT UNION ENUM ELLIPSIS

%token<str> CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN


%left <str> ',' '^' '|' ';' '{' '}' '[' ']' '(' ')' '+' '-' '%' '/' '*' '.' '>' '<' 
%right <str> '&' '=' '!' '~' ':' '?'





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
	: IDENTIFIER											{$$=add($1);}				
	| CONSTANT												{$$=add($1);}
	| STRING_LITERAL										{$$=add($1);}
	| '(' expression ')'									{$$=$2;}
	;

postfix_expression
	: primary_expression       								{$$=$1;}
	| postfix_expression '[' expression ']'					{$$=add("postfix_expression", $1, $3);}
	| postfix_expression '(' ')'							{$$=$1;}
	| postfix_expression '(' argument_expression_list ')'   {$$=add("postfix_expression", $1, $3);}
	| postfix_expression '.' IDENTIFIER						{$$=add("postfix_expression.IDENTIFIER", $1, add($3));}
	| postfix_expression PTR_OP IDENTIFIER					{$$=add("postfix_expression",$1,add($2),add($3));}
	| postfix_expression INC_OP							   {$$=add("postfix_expression", $1, add($2));}
	| postfix_expression DEC_OP								 {$$=add("postfix_expression", $1, add($2));}
	;

argument_expression_list									
	: assignment_expression									{$$=$1;}
	| argument_expression_list ',' assignment_expression    {$$=add("argument_expression_list", $1, $3);}
	;

unary_expression
	: postfix_expression									{$$=$1;}
	| INC_OP unary_expression								{$$=add("unary_expression",add($1),$2);}
	| DEC_OP unary_expression								{$$=add("unary_expression",add($1),$2);}
	| unary_operator cast_expression						{$$=add("unary_expression",$1,$2);}
	| SIZEOF unary_expression								{$$=add("unary_expression",add($1),$2);}
	| SIZEOF '(' type_name ')'								{$$=add("unary_expression",add($1),$3);}
	;

unary_operator
	: '&'		{$$=add("&");}
	| '*'		{$$=add("*");}
	| '+'		{$$=add("+");}
	| '-'		{$$=add("-");}
	| '~'		{$$=add("~");}
	| '!'		{$$=add("!");}
	;

cast_expression
	: unary_expression									   {$$=$1;}
	| '(' type_name ')' cast_expression                    {$$=add("cast_expression", $2, $4);}
	;

multiplicative_expression
	: cast_expression									   {$$=$1;}
	| multiplicative_expression '*' cast_expression        {$$=add("*", $1, $3);}
	| multiplicative_expression '/' cast_expression        {$$=add("/", $1, $3);}
	| multiplicative_expression '%' cast_expression        {$$=add("%", $1, $3);}
	;

additive_expression
	: multiplicative_expression								{$$=$1;}
	| additive_expression '+' multiplicative_expression     {$$=add("+", $1, $3);}
	| additive_expression '-' multiplicative_expression     {$$=add("-", $1, $3);}
	;

shift_expression
	: additive_expression									{$$=$1;}
	| shift_expression LEFT_OP additive_expression		{$$=add("<<",$1,$3);}
	| shift_expression RIGHT_OP additive_expression     {$$=add(">>",$1,$3);}
	;

relational_expression	
	: shift_expression										{$$=$1;}
	| relational_expression '<' shift_expression   {$$=add(">",$1,$3);}
	| relational_expression '>' shift_expression   {$$=add("<",$1,$3);}
	| relational_expression LE_OP shift_expression {$$=add("<=",$1,$3);}
	| relational_expression GE_OP shift_expression {$$=add(">=",$1,$3);}
	;

equality_expression
	: relational_expression									{$$=$1;}
	| equality_expression EQ_OP relational_expression       {$$=add("==",$1,$3);}
	| equality_expression NE_OP relational_expression       {$$=add("!=",$1,$3);}
	;

and_expression
	: equality_expression									       {$$=$1;}
	| and_expression '&' equality_expression                       {$$=add("&",$1,$3);}
	;

exclusive_or_expression
	: and_expression											    {$$=$1;}
	| exclusive_or_expression '^' and_expression			{$$=add("^",$1,$3);}
	;

inclusive_or_expression
	: exclusive_or_expression										{$$=$1;}
	| inclusive_or_expression '|' exclusive_or_expression			{$$=add("|",$1,$3);}
	;

logical_and_expression
	: inclusive_or_expression										{$$=$1;}
	| logical_and_expression AND_OP inclusive_or_expression			{$$=add("&&",$1,$3);}
	;

logical_or_expression
	: logical_and_expression										{$$=$1;}
	| logical_or_expression OR_OP logical_and_expression			{$$=add("||",$1,$3);}
	;

/*check & vs && */
conditional_expression
	: logical_or_expression												{$$=$1;}
	| logical_or_expression '?' expression ':' conditional_expression    {$$=add("conditional_expression",$1,$3,$5);}
	;

assignment_expression
	: conditional_expression													{$$=$1;}
	| unary_expression assignment_operator assignment_expression		    {$$=add("assignment_expression",$1,$2,$3);}
	;

assignment_operator
	: '='				{$$=add("=");}
	| MUL_ASSIGN		{$$=add("*=");}
	| DIV_ASSIGN		{$$=add("/=");}
	| MOD_ASSIGN		{$$=add("%=");}
	| ADD_ASSIGN		{$$=add("+=");}
	| SUB_ASSIGN		{$$=add("-=");}
	| LEFT_ASSIGN		{$$=add("<<=");}
	| RIGHT_ASSIGN		{$$=add(">>=");}
	| AND_ASSIGN		{$$=add("&=");}
	| XOR_ASSIGN		{$$=add("^=");}
	| OR_ASSIGN		   {$$=add("|=");}
	;
/*check here for error*/
expression
	: assignment_expression										{$$=$1;}
	| expression ',' assignment_expression						{$$=add("expression",$1,$3);}
	;

constant_expression
	: conditional_expression								   {$$=$1;}
	;

declaration
	: declaration_specifiers ';'								{$$=$1;}					
	| declaration_specifiers init_declarator_list ';'			{$$=add("declaration",$1,$2);}
	;

declaration_specifiers
	: storage_class_specifier									{$$=$1;}
	| storage_class_specifier declaration_specifiers			{$$=add("declaration_specifiers",$1,$2);}
	| type_specifier											{$$=$1;}
	| type_specifier declaration_specifiers						{$$=add("declaration_specifiers",$1,$2);}
	| type_qualifier											{$$=$1;}
	| type_qualifier declaration_specifiers						{$$=add("declaration_specifiers",$1,$2);}
	;

init_declarator_list
	: init_declarator											{$$=$1;}
	| init_declarator_list ',' init_declarator					{$$=add("init_declarator_list",$1,$3);}	
	;

init_declarator
	: declarator											{$$=$1;}
	| declarator '=' initializer							{$$=add("init_declarator",$1,$3);}
	;

storage_class_specifier
	: TYPEDEF												{$$=add($1);}
	| EXTERN												{$$=add($1);}
	| STATIC												{$$=add($1);}
	| AUTO												    {$$=add($1);}
	| REGISTER												{$$=add($1);}
	;

type_specifier
	: VOID												{$$=add($1);}
	| CHAR												{$$=add($1);}
	| SHORT												{$$=add($1);}
	| INT												{$$=add($1);}
	| LONG												{$$=add($1);}
	| FLOAT												{$$=add($1);}
	| DOUBLE										    {$$=add($1);}
	| SIGNED											{$$=add($1);}
	| UNSIGNED										    {$$=add($1);}
	| struct_or_union_specifier							{$$=$1;}
	| enum_specifier								    {$$=$1;}
	| TYPE_NAME											{$$=add($1);}
	;

struct_or_union_specifier
	: struct_or_union IDENTIFIER '{' struct_declaration_list '}'  {$$=add("struct_or_union_specifier",$1,add($2),$4);}
	| struct_or_union '{' struct_declaration_list '}'             {$$=add("struct_or_union_specifier",$1,$3);}
	| struct_or_union IDENTIFIER								  {$$=add("struct_or_union_specifier",$1,add($2));}
	;

struct_or_union
	: STRUCT										    {$$=add($1);}
	| UNION										        {$$=add($1);}
	;

struct_declaration_list
	: struct_declaration											{$$=$1;}
	| struct_declaration_list struct_declaration					{$$=add("struct_declaration_list",$1,$2);}
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list ';'          {$$=add("struct_declaration",$1,$2);}
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list					{$$=add("specifier_qualifier_list",$1,$2);}
	| type_specifier											{$$=$1;}
	| type_qualifier specifier_qualifier_list					{$$=add("specifier_qualifier_list",$1,$2);}
	| type_qualifier											{$$=$1;}
	;

struct_declarator_list
	: struct_declarator											{$$=$1;}
	| struct_declarator_list ',' struct_declarator				{$$=add("struct_declarator_list",$1,$3);}              
	;

struct_declarator
	: declarator											{$$=$1;}
	| ':' constant_expression								{$$=$2;}
	| declarator ':' constant_expression					{$$=add("struct_declarator",$1,$3);}
	;

enum_specifier
	: ENUM '{' enumerator_list '}'					{$$=add("enum_specifier",add($1),$3);}
	| ENUM IDENTIFIER '{' enumerator_list '}'	   {$$=add("enum_specifier",add($1),add($2),$4);}
	| ENUM IDENTIFIER								{$$=add("enum_specifier",add($1),add($2));}
	;

enumerator_list
	: enumerator											{$$=$1;}
	| enumerator_list ',' enumerator					{$$=add("enumerator_list",$1,$3);}
	;

enumerator
	: IDENTIFIER										{$$=add($1);}
	| IDENTIFIER '=' constant_expression                {$$=add("=",add($1),$3);}
	;

type_qualifier	
	: CONST										    {$$=add($1);}
	| VOLATILE										{$$=add($1);}
	;

declarator
	: pointer direct_declarator	               					{$$=add("declarator",$1,$2);}
	| direct_declarator											{$$=$1;}
	;

direct_declarator
	: IDENTIFIER										    {$$=add($1);}
	| '(' declarator ')'										{$$=$2;}
	| direct_declarator '[' constant_expression ']'        {$$=add("direct_declarator",$1,$3);}
	| direct_declarator '[' ']'							  {$$=add("direct_declarator",$1,add("[]"));}
	| direct_declarator '(' parameter_type_list ')'        {$$=add("direct_declarator",$1,$3);}
	| direct_declarator '(' identifier_list ')'        {$$=add("direct_declarator",$1,$3);}
	| direct_declarator '(' ')'							{$$=add("direct_declarator",$1,add("()"));}
	;

pointer
	: '*'										{$$=add("*");}
	| '*' type_qualifier_list					{$$=add("*",$2);}
	| '*' pointer								{$$=add("*",$2);}
	| '*' type_qualifier_list pointer		    {$$=add("*",$2,$3);}
	;

type_qualifier_list
	: type_qualifier											{$$=$1;}
	| type_qualifier_list type_qualifier						{$$=add("type_qualifier_list",$1,$2);}
	;


parameter_type_list
	: parameter_list											{$$=$1;}
	| parameter_list ',' ELLIPSIS								{$$=add("parameter_type_list",$1,add($3));}
	;

parameter_list
	: parameter_declaration											{$$=$1;}
	| parameter_list ',' parameter_declaration                 {$$=add("parameter_list",$1,$3);}
	;

parameter_declaration
	: declaration_specifiers declarator                 {$$=add("parameter_declaration",$1,$2);}
	| declaration_specifiers abstract_declarator                 {$$=add("parameter_declaration",$1,$2);}
	| declaration_specifiers											{$$=$1;}
	;

identifier_list
	: IDENTIFIER										{$$=add($1);}
	| identifier_list ',' IDENTIFIER					{$$=add("identifier_list",$1,add($3));}
	;

type_name
	: specifier_qualifier_list											{$$=$1;}
	| specifier_qualifier_list abstract_declarator		 {$$=add("type_name",$1,$2);}
	;

abstract_declarator
	: pointer											{$$=$1;}
	| direct_abstract_declarator											{$$=$1;}
	| pointer direct_abstract_declarator {$$=add("abstract_declarator",$1,$2);}
	;

direct_abstract_declarator
	: '(' abstract_declarator ')'		{$$=$2;}
	| '[' ']'							{$$=add("[ ]");}
	| '[' constant_expression ']'		{$$=$2;}
	| direct_abstract_declarator '[' ']'			{$$=add("direct_abstract_declarator",$1,add("[]"));}
	| direct_abstract_declarator '[' constant_expression ']'  {$$ = add("direct_abstract_declarator", $1, $3);;}
	| '(' ')'							{$$ = add("( )");}
	| '(' parameter_type_list ')'		{$$=$2;}
	| direct_abstract_declarator '(' ')'				{$$=add("direct_abstract_declarator",$1,add("()"));}
	| direct_abstract_declarator '(' parameter_type_list ')'    {$$=add("direct_abstract_declarator",$1,$3);}
	;

initializer
	: assignment_expression											{$$=$1;}
	| '{' initializer_list '}'										{$$=$2;}
	| '{' initializer_list ',' '}'								{$$=add("initializer",$2,add($3));}
	;

initializer_list
	: initializer											{$$=$1;}
	| initializer_list ',' initializer						{$$=add("initializer_list",$1,$3);}
	;

statement
	: labeled_statement											{$$=$1;}
	| compound_statement											{$$=$1;}
	| expression_statement											{$$=$1;}
	| selection_statement											{$$=$1;}
	| iteration_statement											{$$=$1;}
	| jump_statement											{$$=$1;}
	;

labeled_statement
	: IDENTIFIER ':' statement			   {$$=add("labeled_statement",add($1),$3);}
	| CASE constant_expression ':' statement    {$$=add("labeled_statement",add("case"),$2,$4);}
	| DEFAULT ':' statement   			   {$$=add("labeled_statement",add("default"),$3);}
	;

compound_statement
	: '{' '}'    					{$$=add("{ }");}
	| '{' statement_list '}'		{$$=add("compound_statement",$2);}
	| '{' declaration_list '}'		{$$=add("compound_statement",$2);}
	| '{' declaration_list statement_list '}'   {$$=add("compound_statement",$2,$3);}
	;

declaration_list
	: declaration											{$$=$1;}
	| declaration_list declaration                        {$$=add("declaration_list",$1,$2);}
	;

statement_list
	: statement											{$$=$1;}
	| statement_list statement							{$$=add("statement_list",$1,$2);}
	;

expression_statement
	: ';'													{$$=add(";");}
	| expression ';'											{$$=$1;}
	;

selection_statement
	: IF '(' expression ')' statement               	{$$=add("IF (expr) stmt",$3,$5);}
	| IF '(' expression ')' statement ELSE statement      {$$=add("IF (expr) stmt ELSE stmt",$3,$5,$7);}
	| SWITCH '(' expression ')' statement               {$$=add("SWITCH (expr) stmt",$3,$5);}
	;

iteration_statement
	: WHILE '(' expression ')' statement              	{$$=add("WHILE (expr) stmt",$3,$5);}
	| DO statement WHILE '(' expression ')' ';'			{$$=add("DO stmt WHILE (expr)",$2,$5);}
	| FOR '(' expression_statement expression_statement ')' statement   {$$=add("FOR (expr_stmt expr_stmt) stmt",$3,$4,$6);}
	| FOR '(' expression_statement expression_statement expression ')' statement    {$$=add("FOR (expr_stmt expr_stmt expr) stmt",$3,$4,$5,$7);}
	;

jump_statement
	: GOTO IDENTIFIER ';'						{$$=add("jump_statement",add($1),add($2));}
	| CONTINUE ';'						{$$=add("jump_statement",add("continue"));}
	| BREAK ';'						{$$=add("jump_statement",add("break"));}
	| RETURN ';'						{$$=add("jump_statement",add("return"));}
	| RETURN expression ';'						{$$=add("jump_statement",add("return"),$2);}
	;

translation_unit
	: external_declaration											{$$=$1;}
	| translation_unit external_declaration                        {$$=add("translation_unit",$1,$2);}
	;

external_declaration
	: function_definition									{$$=$1;}
	| declaration											{$$=$1;}
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement       {$$=add("function_definition",$1,$2,$3,$4);}
	| declaration_specifiers declarator compound_statement                        {$$=add("function_definition",$1,$2,$3);}
	| declarator declaration_list compound_statement                              {$$=add("function_definition",$1,$2,$3);}
	| declarator compound_statement                                              {$$=add("function_definition",$1,$2);}
	;

%%
#include <stdio.h>
extern char yytext[];
extern int column;
extern int line;
void yyerror(char *s)
{
	fflush(stdout);
	printf("Error: On Line %d  and Column %d\n",line,column);
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
	BeginGraph();
	yyparse();
	EndGraph();
	
} 