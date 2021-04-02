%{
#include <iostream>
#include <string>
#include <cstring>
#include "node.h"
#include "symtable.h"
#include "type.h"
#include <fstream>


using namespace std;

string var_type = ""; // to store variable type in declaration list
int var_init = 0;
void yyerror(char *s);
int yylex();

%}
%union{
	node *ptr;
	char *str;
}



%token<str> IDENTIFIER CONSTANT  STRING_LITERAL SIZEOF
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




%type <str>assignment_operator
%type <ptr> primary_expression postfix_expression argument_expression_list unary_expression unary_operator cast_expression multiplicative_expression additive_expression 
%type <ptr> shift_expression relational_expression equality_expression and_expression exclusive_or_expression inclusive_or_expression logical_and_expression logical_or_expression
%type <ptr> conditional_expression assignment_expression  expression constant_expression declaration declaration_specifiers init_declarator_list init_declarator
%type <ptr> storage_class_specifier type_specifier struct_or_union_specifier struct_or_union struct_declaration_list struct_declaration specifier_qualifier_list struct_declarator_list
%type <ptr> struct_declarator enum_specifier enumerator_list enumerator type_qualifier declarator direct_declarator pointer type_qualifier_list parameter_type_list parameter_list
%type <ptr> parameter_declaration identifier_list type_name abstract_declarator direct_abstract_declarator initializer initializer_list statement labeled_statement compound_statement
%type <ptr> declaration_list statement_list expression_statement selection_statement iteration_statement jump_statement translation_unit external_declaration function_definition

%start translation_unit
%%

primary_expression
	: IDENTIFIER											{$$=make_node($1);
					string s($1);
					s_entry* t=lookup(s);
					if(t)
					{
						$$->init=t->init;
						$$->nodeType=t->type;

					}
					else 
					{
						// yyerror("Error: %s is not declared in this scope",$1);
						$$->nodeType="";
	
					}
	
	}				
	| CONSTANT												{$$=make_node($1);}
	| STRING_LITERAL										{$$=make_node($1);}
	| '(' expression ')'									{$$=$2;}
	;


postfix_expression
	: primary_expression       								{$$=$1;}
	| postfix_expression '[' expression ']'					{$$=make_node("postfix_expression", $1, $3);
				$$->init = ($1->init && $3->init);
				string s=postfix($1->nodeType,1);
				if(s.empty()) $$->nodeType=s;
				else{
					yyerror("Error: array index out of bound");
				}
	
	
	}
	| postfix_expression '(' ')'							{$$=$1;
				$$->init=1;
				string s=postfix($1->nodeType,2);
				if(s.empty())
				{
					$$->nodeType =s;
					//TODO : something
				}
				else{
					yyerror("Error: Invalid Function call");
				}
				//TODO : something
	}
	| postfix_expression '(' argument_expression_list ')'   {$$=make_node("postfix_expression", $1, $3);
		 $$->init=$3->init;
		 string s=postfix($1->nodeType,2);
		 if(s.empty())
		 {
			 $$->nodeType=s;
			 //TODO: something
		 }
		 else{
			yyerror("Error: Invalid Function call");
		 }
		//TODO : something

		 
	
	}
	| postfix_expression '.' IDENTIFIER						{$$=make_node("postfix_expression.IDENTIFIER", $1, make_node($3));}
	| postfix_expression PTR_OP IDENTIFIER					{$$=make_node($2,$1,make_node($3));}
	| postfix_expression INC_OP							    {$$=make_node($2, $1);
			$$->init=$1->init;
		    string s=postfix($1->nodeType,3);
			if(s.empty())
			{
				$$->nodeType=s;
			}
			else{
				yyerror("Error: Increment operator not defined for this type");
			}
	}
	| postfix_expression DEC_OP								{$$=make_node($2, $1);
			$$->init=$1->init;
		    string s=postfix($1->nodeType,3);
			if(s.empty())
			{
				$$->nodeType=s;
			}
			else{
				yyerror("Error: Decrement operator not defined for this type");
			}
	}
	;

argument_expression_list									
	: assignment_expression									{$$=$1;}
	| argument_expression_list ',' assignment_expression    {$$=make_node("argument_expression_list", $1, $3);}
	;

unary_expression
	: postfix_expression									{$$=$1;}
	| INC_OP unary_expression								{$$=make_node($1,$2);
			$$->init=$2->init;
		    string s=postfix($2->nodeType,3);
			if(s.empty())
			{
				$$->nodeType=s;
			}
			else{
				yyerror("Error: Increment operator not defined for this type");
			}
	
	}
	| DEC_OP unary_expression								{$$=make_node($1,$2);
			$$->init=$2->init;
		    string s=postfix($2->nodeType,3);
			if(s.empty())
			{
				$$->nodeType=s;
			}
			else{
				yyerror("Error: Decrement operator not defined for this type");
			}
	
	
	}
	| unary_operator cast_expression						{$$=make_node("unary_expression",$1,$2);
			$$->init=$2->init;
			//TODO :
		    // string s=unary($1->nodeType,3);
			// if(s.empty())
			// {
			// 	$$->nodeType=s;
			// }
			// else{
			// 	yyerror("Error: Decrement operator not defined for this type");
			// }
	
	
	}
	| SIZEOF unary_expression								{$$=make_node($1,$2);
			$$->nodeType="int";
			$$->init=1;
	
	}
	| SIZEOF '(' type_name ')'								{$$=make_node($1,$3);
			$$->nodeType="int";
			$$->init=1;
	}
	;

unary_operator
	: '&'		{$$=make_node("&");}
	| '*'		{$$=make_node("*");}
	| '+'		{$$=make_node("+");}
	| '-'		{$$=make_node("-");}
	| '~'		{$$=make_node("~");}
	| '!'		{$$=make_node("!");}
	;

cast_expression
	: unary_expression									   {$$=$1;}
	| '(' type_name ')' cast_expression                    {$$=make_node("cast_expression", $2, $4);
			  $$->nodeType=$2->nodeType;
			  $$->init=$4->init;
	
	}
	;

multiplicative_expression
	: cast_expression									   {$$=$1;}
	| multiplicative_expression '*' cast_expression        {$$=make_node("*", $1, $3);
			string s=multiply($1->nodeType, $3->nodeType,'*');
			if(s=="int")$$->nodeType="long long";
			else if(s=="float")$$->nodeType="long double";
			else{
				yyerror("Error:  Incompatible type for * operator");
			} 

			$$->init= ($1->init&& $3->init);
	}
	| multiplicative_expression '/' cast_expression        {$$=make_node("/", $1, $3);
			string s=multiply($1->nodeType, $3->nodeType,'/');
			if(s=="int")$$->nodeType="long long";
			else if(s=="float")$$->nodeType="long double";
			else{
				yyerror("Error:  Incompatible type for / operator");
			} 

			$$->init= ($1->init&& $3->init);
	}
	| multiplicative_expression '%' cast_expression        {$$=make_node("%", $1, $3);
			string s=multiply($1->nodeType, $3->nodeType,'%');
			if(s=="int")$$->nodeType="long long";
			else{
				yyerror("Error:  Incompatible type for % operator");
			} 

			$$->init= ($1->init&& $3->init);
	}
	;

additive_expression
	: multiplicative_expression								{$$=$1;}
	| additive_expression '+' multiplicative_expression     {$$=make_node("+", $1, $3);
		string s= addition($1->nodeType, $3->nodeType);
		if(s.empty()){
			if(s=="int")$$->nodeType="long long";
			else if(s=="float")$$->nodeType="long double";
			else $$->nodeType=s;
		}
		else{
			yyerror("Error: Incompatible type for + operator");
		}
		$$->init= ($1->init&& $3->init);
	}


	| additive_expression '-' multiplicative_expression     {$$=make_node("-", $1, $3);
		string s= addition($1->nodeType, $3->nodeType);
		if(s.empty()){
			if(s=="int")$$->nodeType="long long";
			else if(s=="float")$$->nodeType="long double";
			else  $$->nodeType=s;
		}
		else{
			yyerror("Error: Incompatible type for - operator");
		}
		$$->init= ($1->init&& $3->init);
	
	}
	;

shift_expression
	: additive_expression									{$$=$1;}
	| shift_expression LEFT_OP additive_expression		{$$=make_node("<<",$1,$3);
		if(isInt($1->nodeType) && isInt($3->nodeType)) 
			$$->nodeType= $1->nodeType;
		else{
			yyerror("Error: Invalid operands to binary <<");
		}
		$$->init= ($1->init&& $3->init);

	}



	| shift_expression RIGHT_OP additive_expression     {$$=make_node(">>",$1,$3);
		if(isInt($1->nodeType) && isInt($3->nodeType)) 
			$$->nodeType= $1->nodeType;
		else{
			yyerror("Error: Invalid operands to binary >>");
		}
		$$->init= ($1->init&& $3->init);

	}

	;

relational_expression	
	: shift_expression										{$$=$1;}
	| relational_expression '<' shift_expression   {$$=make_node("<",$1,$3);
		string s= relational($1->nodeType, $3->nodeType);
		if(s.empty())
		{
			$$->nodeType="bool";
			if(s=="Bool")
			{
				 yyerror("Warning: comparison between pointer and integer");
			}
		}
		else{
              yyerror("Error: invalid operands to binary <");
		}
		$$->init= ($1->init&& $3->init);

	
	}
	| relational_expression '>' shift_expression   {$$=make_node(">",$1,$3);
		string s= relational($1->nodeType, $3->nodeType);
		if(s.empty())
		{
			$$->nodeType="bool";
			if(s=="Bool")
			{
				 yyerror("Warning: comparison between pointer and integer");
			}
		}
		else{
              yyerror("Error: invalid operands to binary >");
		}
		$$->init= ($1->init&& $3->init);
	}

	| relational_expression LE_OP shift_expression {$$=make_node("<=",$1,$3);
		string s= relational($1->nodeType, $3->nodeType);
		if(s.empty())
		{
			$$->nodeType="bool";
			if(s=="Bool")
			{
				 yyerror("Warning: comparison between pointer and integer");
			}
		}
		else{
              yyerror("Error: invalid operands to binary <=");
		}
		$$->init= ($1->init&& $3->init);
	}

	| relational_expression GE_OP shift_expression {$$=make_node(">=",$1,$3);
		string s= relational($1->nodeType, $3->nodeType);
		if(s.empty())
		{
			$$->nodeType="bool";
			if(s=="Bool")
			{
				 yyerror("Warning: comparison between pointer and integer");
			}
		}
		else{
              yyerror("Error: invalid operands to binary >=");
		}
		$$->init= ($1->init&& $3->init);
	}
	;

equality_expression
	: relational_expression									{$$=$1;}
	| equality_expression EQ_OP relational_expression       {$$=make_node("==",$1,$3);
		string s= equality($1->nodeType, $3->nodeType);
		if(s.empty())
		{
			$$->nodeType="bool";
			if(s=="Bool")
			{
				 yyerror("Warning: comparison between pointer and integer");
			}
		}
		else{
              yyerror("Error: invalid operands to binary ==");
		}
		$$->init= ($1->init&& $3->init);
	
	
	}
	| equality_expression NE_OP relational_expression       {$$=make_node("!=",$1,$3);
		string s= equality($1->nodeType, $3->nodeType);
		if(s.empty())
		{
			$$->nodeType="bool";
			if(s=="Bool")
			{
				 yyerror("Warning: comparison between pointer and integer");
			}
		}
		else{
              yyerror("Error: invalid operands to binary !=");
		}
		$$->init= ($1->init&& $3->init);
	
	
	}
	;

and_expression
	: equality_expression									       {$$=$1;}
	| and_expression '&' equality_expression                       {$$=make_node("&",$1,$3);
		string s= bitwise($1->nodeType, $3->nodeType);
		if(s.empty())
		{
			if(s=="bool")$$->nodeType=s;
			else $$->nodeType="long long";
			
		}
		else{
              yyerror("Error: invalid operands to binary &");
		}
		$$->init= ($1->init&& $3->init);
	
	
	}
	;

exclusive_or_expression
	: and_expression											    {$$=$1;}
	| exclusive_or_expression '^' and_expression			{$$=make_node("^",$1,$3);
		string s= bitwise($1->nodeType, $3->nodeType);
		if(s.empty())
		{
			if(s=="bool")$$->nodeType=s;
			else $$->nodeType="long long";
			
		}
		else{
              yyerror("Error: invalid operands to binary ^");
		}
		$$->init= ($1->init&& $3->init);
	
	}
	;

inclusive_or_expression
	: exclusive_or_expression										{$$=$1;}
	| inclusive_or_expression '|' exclusive_or_expression			{$$=make_node("|",$1,$3);
		string s= bitwise($1->nodeType, $3->nodeType);
		if(s.empty())
		{
			if(s=="bool")$$->nodeType=s;
			else $$->nodeType="long long";
			
		}
		else{
              yyerror("Error: invalid operands to binary |");
		}
		$$->init= ($1->init&& $3->init);
	
	
	}
	;

logical_and_expression
	: inclusive_or_expression										{$$=$1;}
	| logical_and_expression AND_OP inclusive_or_expression			{$$=make_node("&&",$1,$3);
		$$->nodeType="bool";
		$$->init= ($1->init&& $3->init);
	
		//!doubt
	}
	;

logical_or_expression
	: logical_and_expression										{$$=$1;}
	| logical_or_expression OR_OP logical_and_expression			{$$=make_node("||",$1,$3);
		$$->nodeType="bool";
		$$->init= ($1->init&& $3->init);
		//!doubt
	}
	;

/*check & vs && */
conditional_expression
	: logical_or_expression												{$$=$1;}
	| logical_or_expression '?' expression ':' conditional_expression    {$$=make_node("conditional_expression",$1,$3,$5);
		string s=condition($3->nodeType,$5->nodeType);
		if(s.empty())$$->nodeType=s;
		else{
            yyerror("Error:Type mismatch in conditional expression");
		}

		$$->init= ($1->init&& $3->init && $5->init);
	}


	;

assignment_expression
	: conditional_expression													{$$=$1;}
	| unary_expression assignment_operator assignment_expression		    {$$=make_node("assignment_expression",$1,make_node($2),$3);
		string s=assign($1->nodeType,$3->nodeType,$2);
		if(s.empty())
		{
			$$->nodeType=$1->nodeType;
			if(s=="warning"){
                yyerror("Warning: Assignment with incompatible pointer type"); 
			}
			//!TODO:
		}
	
	}
	;

assignment_operator
	: '='				{$$="=";}
	| MUL_ASSIGN		{$$="*=";}
	| DIV_ASSIGN		{$$="/=";}
	| MOD_ASSIGN		{$$="%=";}
	| ADD_ASSIGN		{$$="+=";}
	| SUB_ASSIGN		{$$="-=";}
	| LEFT_ASSIGN		{$$="<<=";}
	| RIGHT_ASSIGN		{$$=">>=";}
	| AND_ASSIGN		{$$="&=";}
	| XOR_ASSIGN		{$$="^=";}
	| OR_ASSIGN		   {$$="|=";}
	;
/*check here for error*/
expression
	: assignment_expression										{$$=$1;}
	| expression ',' assignment_expression						{$$=make_node("expression",$1,$3);}
	;

constant_expression
	: conditional_expression								   {$$=$1;}
	;

declaration
	: declaration_specifiers ';'								{$$=$1;}					
	| declaration_specifiers init_declarator_list ';'			{$$=make_node("declaration",$1,$2);}
	;

declaration_specifiers
	: storage_class_specifier									{$$=$1;}
	| storage_class_specifier declaration_specifiers			{$$=make_node("declaration_specifiers",$1,$2);}
	| type_specifier											{$$=$1;}
	| type_specifier declaration_specifiers						{$$=make_node("declaration_specifiers",$1,$2);}
	| type_qualifier											{$$=$1;}
	| type_qualifier declaration_specifiers						{$$=make_node("declaration_specifiers",$1,$2);}
	;

init_declarator_list
	: init_declarator											{$$=$1;
		var_type = "";
	}
	| init_declarator_list ',' init_declarator					{$$=make_node("init_declarator_list",$1,$3);
		var_type = "";
	}	
	;

init_declarator
	: declarator											{$$=$1;}
	| E declarator '=' initializer							{$$=make_node("init_declarator",$2,$4);
		var_init = 0;
	}
	;
// is_init ?? var_init = 1;

// int a = 5,b;

E : %empty	{
	var_init = 1;
}

storage_class_specifier
	: TYPEDEF												{$$=make_node($1);}
	| EXTERN												{$$=make_node($1);}
	| STATIC												{$$=make_node($1);}
	| AUTO												    {$$=make_node($1);}
	| REGISTER												{$$=make_node($1);}
	;

type_specifier
	: VOID												{$$=make_node($1);
		if(var_type == ""){
			var_type += "void";
		}
		else{
			var_type += " void";
		}
	}
	| CHAR												{$$=make_node($1);
		if(var_type == ""){
			var_type += "char";
		}
		else{
			var_type += " char";
		}
	}
	| SHORT												{$$=make_node($1);
		if(var_type == ""){
			var_type += "short";
		}
		else{
			var_type += " short";
		}
	}
	| INT												{$$=make_node($1);
		if(var_type == ""){
			var_type += "int";
		}
		else{
			var_type += " int";
		}
	}
	| LONG												{$$=make_node($1);
		if(var_type == ""){
			var_type += "long";
		}
		else{
			var_type += " long";
		}
	}
	| FLOAT												{$$=make_node($1);
		if(var_type == ""){
			var_type += "float";
		}
		else{
			var_type += " float";
		}
	}
	| DOUBLE										    {$$=make_node($1);
		if(var_type == ""){
			var_type += "double";
		}
		else{
			var_type += " double";
		}
	}
	| SIGNED											{$$=make_node($1);
		if(var_type == ""){
			var_type += "signed";
		}
		else{
			var_type += " signed";
		}
	}
	| UNSIGNED										    {$$=make_node($1);
		if(var_type == ""){
			var_type += "unsigned";
		}
		else{
			var_type += " unsigned";
		}
	}
	| struct_or_union_specifier							{$$=$1;}
	| enum_specifier								    {$$=$1;}
	| TYPE_NAME											{$$=make_node($1);
		if(var_type == ""){
			var_type += "void";
		}
		else{
			var_type += " void";
		}
	}
	;

struct_or_union_specifier
	: struct_or_union IDENTIFIER '{' struct_declaration_list '}'  {$$=make_node("struct_or_union_specifier",$1,make_node($2),$4);}
	| struct_or_union '{' struct_declaration_list '}'             {$$=make_node("struct_or_union_specifier",$1,$3);}
	| struct_or_union IDENTIFIER								  {$$=make_node("struct_or_union_specifier",$1,make_node($2));}
	;

struct_or_union
	: STRUCT										    {$$=make_node($1);}
	| UNION										        {$$=make_node($1);}
	;

struct_declaration_list
	: struct_declaration											{$$=$1;}
	| struct_declaration_list struct_declaration					{$$=make_node("struct_declaration_list",$1,$2);}
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list ';'          {$$=make_node("struct_declaration",$1,$2);}
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list					{$$=make_node("specifier_qualifier_list",$1,$2);}
	| type_specifier											{$$=$1;}
	| type_qualifier specifier_qualifier_list					{$$=make_node("specifier_qualifier_list",$1,$2);}
	| type_qualifier											{$$=$1;}
	;

struct_declarator_list
	: struct_declarator											{$$=$1;}
	| struct_declarator_list ',' struct_declarator				{$$=make_node("struct_declarator_list",$1,$3);}              
	;

struct_declarator
	: declarator											{$$=$1;}
	| ':' constant_expression								{$$=$2;}
	| declarator ':' constant_expression					{$$=make_node("struct_declarator",$1,$3);}
	;

enum_specifier
	: ENUM '{' enumerator_list '}'					{$$=make_node("enum_specifier",make_node($1),$3);}
	| ENUM IDENTIFIER '{' enumerator_list '}'	   	{$$=make_node("enum_specifier",make_node($1),make_node($2),$4);}
	| ENUM IDENTIFIER								{$$=make_node("enum_specifier",make_node($1),make_node($2));}
	;

enumerator_list
	: enumerator											{$$=$1;}
	| enumerator_list ',' enumerator						{$$=make_node("enumerator_list",$1,$3);}
	;

enumerator
	: IDENTIFIER										{$$=make_node($1);}
	| IDENTIFIER '=' constant_expression                {$$=make_node("=",make_node($1),$3);}
	;

type_qualifier	
	: CONST										    {$$=make_node($1);}
	| VOLATILE										{$$=make_node($1);}
	;

declarator
	: pointer direct_declarator	               					{$$=make_node("declarator_pointer",$1,$2);

	}
	| direct_declarator											{$$=$1;}
	;

direct_declarator
	: IDENTIFIER										    	{$$=make_node($1);
		make_symTable_entry($1,var_type,var_init);
		// also check if it already exists or not ?
	}
	| '(' declarator ')'										{$$=$2;}
	| direct_declarator '[' constant_expression ']'        		{$$=make_node("direct_declarator",$1,$3);}
	| direct_declarator '[' ']'							  		{$$=make_node("direct_declarator",$1,make_node("[]"));}
	| direct_declarator '(' parameter_type_list ')'        		{$$=make_node("direct_declarator",$1,$3);}
	| direct_declarator '(' identifier_list ')'       		    {$$=make_node("direct_declarator",$1,$3);}
	| direct_declarator '(' ')'									{$$=make_node("direct_declarator",$1,make_node("()"));}
	;

pointer
	: '*'														{$$=make_node("*");
		var_type += "*";
	}
	| '*' type_qualifier_list									{$$=make_node("*",$2);
		var_type += "*";
	}
	| '*' pointer												{$$=make_node("*",$2);
		var_type += "*";
	}
	| '*' type_qualifier_list pointer		    				{$$=make_node("*",$2,$3);
		var_type += "*";
	}
	;

type_qualifier_list
	: type_qualifier											{$$=$1;}
	| type_qualifier_list type_qualifier						{$$=make_node("type_qualifier_list",$1,$2);}
	;


parameter_type_list
	: parameter_list											{$$=$1;}
	| parameter_list ',' ELLIPSIS								{$$=make_node("parameter_type_list",$1,make_node($3));}
	;

parameter_list
	: parameter_declaration										{$$=$1;}
	| parameter_list ',' parameter_declaration                 	{$$=make_node("parameter_list",$1,$3);}
	;

parameter_declaration
	: declaration_specifiers declarator                 		{$$=make_node("parameter_declaration",$1,$2);}
	| declaration_specifiers abstract_declarator                {$$=make_node("parameter_declaration",$1,$2);}
	| declaration_specifiers									{$$=$1;}
	;

identifier_list
	: IDENTIFIER												{$$=make_node($1);}
	| identifier_list ',' IDENTIFIER							{$$=make_node("identifier_list",$1,make_node($3));}
	;

type_name
	: specifier_qualifier_list									{$$=$1;}
	| specifier_qualifier_list abstract_declarator		 		{$$=make_node("type_name",$1,$2);}
	;

abstract_declarator
	: pointer													{$$=$1;}
	| direct_abstract_declarator								{$$=$1;}
	| pointer direct_abstract_declarator 						{$$=make_node("abstract_declarator",$1,$2);}
	;

direct_abstract_declarator
	: '(' abstract_declarator ')'								{$$=$2;}
	| '[' ']'													{$$=make_node("[ ]");}
	| '[' constant_expression ']'								{$$=$2;}
	| direct_abstract_declarator '[' ']'						{$$=make_node("direct_abstract_declarator",$1,make_node("[]"));}
	| direct_abstract_declarator '[' constant_expression ']'  	{$$ = make_node("direct_abstract_declarator", $1, $3);;}
	| '(' ')'													{$$ = make_node("( )");}
	| '(' parameter_type_list ')'								{$$=$2;}
	| direct_abstract_declarator '(' ')'						{$$=make_node("direct_abstract_declarator",$1,make_node("()"));}
	| direct_abstract_declarator '(' parameter_type_list ')'    {$$=make_node("direct_abstract_declarator",$1,$3);}
	;

initializer
	: assignment_expression											{$$=$1;}
	| '{' initializer_list '}'										{$$=$2;}
	| '{' initializer_list ',' '}'									{$$=make_node("initializer",$2,make_node($3));}
	;

initializer_list
	: initializer											{$$=$1;}
	| initializer_list ',' initializer						{$$=make_node("initializer_list",$1,$3);}
	;

statement
	: labeled_statement												{$$=$1;}
	| compound_statement											{$$=$1;}
	| expression_statement											{$$=$1;}
	| selection_statement											{$$=$1;}
	| iteration_statement											{$$=$1;}
	| jump_statement												{$$=$1;}
	;

labeled_statement
	: IDENTIFIER ':' statement			 		 {$$=make_node("labeled_statement",make_node($1),$3);}
	| CASE constant_expression ':' statement   	 {$$=make_node("labeled_statement",make_node("case"),$2,$4);}
	| DEFAULT ':' statement   			  		 {$$=make_node("labeled_statement",make_node("default"),$3);}
	;

compound_statement
	: '{' '}'    								{$$=make_node("{ }");}
	| '{' statement_list '}'					{$$=make_node("compound_statement",$2);}
	| '{' declaration_list '}'					{$$=make_node("compound_statement",$2);}
	| '{' declaration_list statement_list '}'   {$$=make_node("compound_statement",$2,$3);}
	;

declaration_list
	: declaration											{$$=$1;}
	| declaration_list declaration                        	{$$=make_node("declaration_list",$1,$2);}
	;

statement_list
	: statement												{$$=$1;}
	| statement_list statement								{$$=make_node("statement_list",$1,$2);}
	;

expression_statement
	: ';'														{$$=make_node(";");}
	| expression ';'											{$$=$1;}
	;

selection_statement
	: IF '(' expression ')' statement               		{$$=make_node("IF (expr) stmt",$3,$5);}
	| IF '(' expression ')' statement ELSE statement     	{$$=make_node("IF (expr) stmt ELSE stmt",$3,$5,$7);}
	| SWITCH '(' expression ')' statement              	 	{$$=make_node("SWITCH (expr) stmt",$3,$5);}
	;

iteration_statement
	: WHILE '(' expression ')' statement                                        	{$$=make_node("WHILE (expr) stmt",$3,$5);}
	| DO statement WHILE '(' expression ')' ';'			                            {$$=make_node("DO stmt WHILE (expr)",$2,$5);}
	| FOR '(' expression_statement expression_statement ')' statement               {$$=make_node("FOR (expr_stmt expr_stmt) stmt",$3,$4,$6);}
	| FOR '(' expression_statement expression_statement expression ')' statement    {$$=make_node("FOR (expr_stmt expr_stmt expr) stmt",$3,$4,$5,$7);}
	;

jump_statement
	: GOTO IDENTIFIER ';'						{$$=make_node("jump_statement",make_node($1),make_node($2));}
	| CONTINUE ';'						        {$$=make_node("continue");}
	| BREAK ';'						            {$$=make_node("break");}
	| RETURN ';'						        {$$=make_node("return");}
	| RETURN expression ';'						{$$=make_node("jump_statement",make_node("return"),$2);}
	;

translation_unit
	: external_declaration										   {$$=$1;}
	| translation_unit external_declaration                        {$$=make_node("translation_unit",$1,$2);}
	;

external_declaration
	: function_definition									{$$=$1;}
	| declaration											{$$=$1;}
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement       {$$=make_node("function_definition",$1,$2,$3,$4);}
	| declaration_specifiers declarator compound_statement                        {$$=make_node("function_definition",$1,$2,$3);}
	| declarator declaration_list compound_statement                              {$$=make_node("function_definition",$1,$2,$3);}
	| declarator compound_statement                                               {$$=make_node("function_definition",$1,$2);}
	;

%%
#include <stdio.h>
#define red   "\033[31;1m"
#define reset   "\033[0m"
extern char yytext[];
extern int column;
extern int line;
char *filename;
FILE *in=NULL;
FILE *out=NULL;

void yyerror(char *s)
{	
	fflush(stdout);
	fprintf(stderr,"%s:%d:%d:%s Error: %s\n",filename,line,column,red,reset);
	fclose(in);
	in=freopen(filename,"r",stdin);
	string str;
	for(int i=0;i<line;i++)
	{
		getline(cin,str);
	}
	
	cerr<<str;

	fprintf(stderr,"\n%*s\n%s%*s%s\n", column, "^", red,column,s,reset);
}

void help(int f)
{	
	if(f) printf("%sError: %s\n",red,reset);
	printf("Give Input file with -i flag\n");
	printf("Give Output file with -o flag\n");
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
				in=freopen(argv[i+1],"r",stdin);
				filename=argv[i+1];
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
				out =freopen(argv[i+1],"w",stdout);
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
	if(!in)help(1);
	if(!out)freopen("ast.dot","w",stdout);
	BeginGraph();
	yyparse();
	EndGraph();
	
} 