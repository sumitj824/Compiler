%{
#include <iostream>
#include <string>
#include <set>
#include <cstring>
#include "node.h"
#include "symtable.h"
#include "type.h"
#include <fstream>
#include<vector>
// to do :
// offset
// 3AC

using namespace std;

set <string> temp_arg; // to store identifier list in function declaration 1
int funcMatched = 0; // to store whether rule corresponding to function is matched.
string var_type = ""; // to store variable type in declaration list
string funcArg = "";
string tmpstr = ""; // to store identifier list in function definition 1
map <string,string> tmp_map;
int struct_count = 0;
int accept = 0;
int array_case2 = 0;
int in_param = 0;
int simple_block = 0;
extern int yylineno;
vector<int> st_line_no;
string arg_list = "";
string funcName = "";
string return_type = "";
int initializer_list_size = 0;
map <string,int> complete;
symTable * temp_table;
void yyerror(char *s);
int yylex();

%}
%union{
	int num;
	node *ptr;
	char *str;
}

// offset
// abstract declaration
// typechecking

%token<str> IDENTIFIER I_CONSTANT F_CONSTANT  STRING_LITERAL SIZEOF
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


%type <num> M
%type <ptr>  M2 M3 M4 M5	M6 M7 M8 M9 M10 M11 M12 M13 M14 M15
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
// file -> quadraple -> op_code, op1, op2, result

primary_expression
	: IDENTIFIER											{$$=make_node($1);
					string s($1);
					s_entry* t=lookup(s);
					if(t)
					{
						$$->init=t->init;
						$$->nodeType=t->type;
						$$ -> nodeLex = string($1);
						///
						$$->place={string($1),t};
						///
					}
					else 
					{
						yyerror("Error: Use of undeclared identifier.");
						$$->nodeType="";
					}
	}				
	| I_CONSTANT												{
		$$=make_node($1);
		
		char * ptr = $1;
		int num = strlen(ptr);
		//for L'ab' type
		if(ptr[0]=='L'){
			$$->ival = ptr[num-2];
		}
		long long int val=0;
		//for 'ab' type
		if(ptr[0] == '\''){

			for(int i = 1;i<num-1;i++){
				if(ptr[i] == '\\') i++;
				val = val<<8;
				val+= ptr[i];
			}
			$$->ival = val;
		}
		string s($1);
		if(ptr[num-1]!='\''){
			//it is a number
			$$->ival = stoll(s,nullptr,0);
		}

		int ty=1;
		int un=0;
		//for type:
		if(ptr[num-1] == '\''){
			$$->nodeType = "int";
		}else{
			for(int i = num-1;i>=0;i--){
				if(ptr[i] == 'L' || ptr[i] == 'l') ty++;
				else{
					if(ptr[i] == 'u' || ptr[i] == 'U') un=1;
					else break;
				}
			}
		}
		if(ty>=3) $$->nodeType = "long long int";
		if(ty==2) $$->nodeType = "long int";
		if(ty==1) $$->nodeType = "int";
		if(un) $$->nodeType = "unsigned "+$$->nodeType;
		$$->init = 1;
		///
		 $$->place={$1->str,NULL};
		///

	}
	|F_CONSTANT 											{$$=make_node($1);
		string s($1);
		$$->dval=stold(s);
		$$->nodeType = "float";
		for(auto x:s) if(x=='e') $$->nodeType = "double";
		if(s[s.length()-1] == 'L') $$->nodeType = "long double";
		if(s[s.length()-1] == 'F') $$->nodeType = "float"; 
		$$->init=1;
		///
		 $$->place={$1->str,NULL};
		///
	}
	| STRING_LITERAL										{$$=make_node($1);
		///
		 $$->place={$1->str,NULL};
		///
	}
	| '(' expression ')'									{$$=$2;}
	;


postfix_expression
	: primary_expression       								{$$=$1;}
	| postfix_expression '[' expression ']'					{$$=make_node("postfix_expression", $1, $3);
				$$->init = ($1->init && $3->init);
				string s=postfix($1->nodeType,1);
				if(!s.empty()){ $$->nodeType=s;
					if(isInt($3->nodeType)){
						//TODO :check for array bound
					}
					else{
						yyerror("Error: array subscript is not an integer");
					}

				}
				else{
					yyerror("Error:  Identifier is not pointer type");
				}

				///

				///
	}
	| postfix_expression '(' ')'							{$$=$1;
				$$->init=1;
				if(funcMap.find($1 -> nodeLex) == funcMap.end()){
					yyerror("Error : Function definition not defined.");
				}
				else{
					s_entry * s = lookup_in_table(GST,$1 -> nodeLex);
					$$ -> nodeType = s -> type;
					$$ -> nodeLex = $1 -> nodeLex;
					char* x=func_check("",funcMap[$1 -> nodeLex]);
					if(x){
						yyerror(x);
					}
				}
				///
				comp temp = get_temp_label($$ -> nodeType);
				// todo : reference to parameters
				emit({"CALL_FUNC",NULL},$1 -> place,{"",NULL},temp);	
				///
	}
	| postfix_expression '(' argument_expression_list')'   {$$=make_node("postfix_expression", $1, $3);
		 $$->init=$3->init;
		 if(funcMap.find($1 -> nodeLex) == funcMap.end()){
			yyerror("Error : Function definition not defined.");
		}
		else{
			s_entry * s = lookup_in_table(GST,$1 -> nodeLex);
			$$ -> nodeType = s -> type;
			$$ -> nodeLex = $1 -> nodeLex;
			char* x=func_check(arg_list,funcMap[$1 -> nodeLex]);
			if(x){
				yyerror(x);
			}
		}	 
		arg_list = "";
	}
	| postfix_expression '.' IDENTIFIER						{$$=make_node("postfix_expression.IDENTIFIER", $1, make_node($3));
		if(id_to_struct.count($1 -> nodeType)){
			s_entry * find = lookup_in_table(id_to_struct[$1 -> nodeType],$3);
			if(find){
				$$ -> nodeType = find -> type;
				$$ -> init = find -> init;
				$$ -> nodeLex = $1 -> nodeLex + "." + $3;
			}
			else{
				yyerror("Error : Undefined attribute access in structure.");
			}
		}
		else{
			yyerror("Error : Use of undeclared structure.");
		}
	}
	| postfix_expression PTR_OP IDENTIFIER					{$$=make_node($2,$1,make_node($3));
		string type = $1 -> nodeType;
		type.pop_back();
		if(id_to_struct.count(type)){
			s_entry * find = lookup_in_table(id_to_struct[type],$3);
			if(find){
				$$ -> nodeType = find -> type;
				$$ -> init = find -> init;
				$$ -> nodeLex = $1 -> nodeLex + $2 + $3;
				
			}
			else{
				yyerror("Error : Undefined attribute access in structure.");
			}
		}
		else{
			yyerror("Error : Use of undeclared structure.");
		}
	}
	| postfix_expression INC_OP							    {$$=make_node($2, $1);
			$$->init=$1->init;
		    string s=postfix($1->nodeType,3);
			if(!s.empty())
			{
				$$->nodeType=s;
				///
				comp temp = get_temp_label($$ -> nodeType);
				emit({"++S",lookup("++")},$1 -> place,{"",NULL},temp);	
				$$->place=temp;
				///
			}
			else{
				yyerror("Error: Increment operator not defined for this type");
			}
	}
	| postfix_expression DEC_OP								{$$=make_node($2, $1);
			$$->init=$1->init;
		    string s=postfix($1->nodeType,3);
			if(!s.empty())
			{
				$$->nodeType=s;
				///
				comp temp = get_temp_label($$ -> nodeType);
				emit({"--S",lookup("--")},$1 -> place,{"",NULL},temp);	
				$$->place=temp;
				///
			}
			else{
				yyerror("Error: Decrement operator not defined for this type");
			}
	}
	;

argument_expression_list									
	: assignment_expression									{$$=$1;
		if(arg_list == ""){
			arg_list += ($1 -> nodeType);
		}
		else{
			arg_list += ",";
			arg_list += ($1 -> nodeType);
		}
	}
	| argument_expression_list ',' assignment_expression    {$$=make_node("argument_expression_list", $1, $3);
		if(arg_list == ""){
			arg_list += ($3 -> nodeType);
		}
		else{
			arg_list += ",";
			arg_list += ($3 -> nodeType);
		}
	}
	;

unary_expression
	: postfix_expression									{$$=$1;}
	| INC_OP unary_expression								{$$=make_node($1,$2);
			$$->init=$2->init;
		    string s=postfix($2->nodeType,3);
			if(!s.empty())
			{
				$$->nodeType=s;
				$$-> nodeLex = $2 -> nodeLex;
				///
				comp temp = get_temp_label($$ -> nodeType);
				emit({"++P",lookup("++")},$2 -> place,{"",NULL},temp);	
				$$->place=temp;
				///
				

			}
			else{
				yyerror("Error: Increment operator not defined for this type");
			}
	
	}
	| DEC_OP unary_expression								{$$=make_node($1,$2);
			$$->init=$2->init;
		    string s=postfix($2->nodeType,3);
			if(!s.empty())
			{
				$$->nodeType=s;
				$$-> nodeLex = $2 -> nodeLex;
				///
				comp temp = get_temp_label($$ -> nodeType);
				emit({"--P",lookup("--")},$2 -> place,{"",NULL},temp);	
				$$->place=temp;
				///
			}
			else{
				yyerror("Error: Decrement operator not defined for this type");
			}
	
	
	}
	| unary_operator cast_expression						{$$=make_node("unary_expression",$1,$2);
			$$->init=$2->init;
			
		    string s=unary($2->nodeType,$1->name);
			if(!s.empty())
			{
				$$->nodeType=s;
				$$-> nodeLex = $2 -> nodeLex;
				///
				comp temp = get_temp_label($$ -> nodeType);
				emit($1->place,$2 -> place,{"",NULL},temp);	
				$$->place=temp;
				///
			}
			else{
				yyerror("Error: Type inconsistent with unary operator");
			}
	
	
	}
	| SIZEOF unary_expression								{$$=make_node($1,$2);
			$$->nodeType="int";
			$$->init=1;
			$$->nodeLex = $2 -> nodeLex;
			///
			comp temp = get_temp_label($$ -> nodeType);
			emit({"SIZEOF",lookup("sizeof")},$2 -> place,{"",NULL},temp);	
			$$->place=temp;
			///
	
	}
	| SIZEOF '(' type_name ')'								{$$=make_node($1,$3);
			$$->nodeType="int";
			$$->init=1;
			$$->nodeLex = $3 -> nodeLex;
			///
			comp temp = get_temp_label($$ -> nodeType);
			emit({"SIZEOF",lookup("sizeof")},$3 -> place,{"",NULL},temp);	
			$$->place=temp;
			///
	}
	;

unary_operator
	: '&'		{$$=make_node("&");
		$$->place={"&",lookup("&")};
	}
	| '*'		{$$=make_node("*");
		$$->place={"*",lookup("*")};
	}
	| '+'		{$$=make_node("+");
		$$->place={"unary+",lookup("+")};
	}
	| '-'		{$$=make_node("-");
		$$->place={"unary-",lookup("-")};
	}
	| '~'		{$$=make_node("~");
		$$->place={"~",lookup("~")};
	}
	| '!'		{$$=make_node("!");
		$$->place={"!",lookup("!")};
	}
	;

cast_expression
	: unary_expression									   {$$=$1;}
	| '(' type_name ')' cast_expression                    {$$=make_node("cast_expression", $2, $4);
			$$->nodeType=$2->nodeType;
			$$->init=$4->init;
			$$ -> nodeLex = $4 -> nodeLex;
			///
			comp temp = get_temp_label($$ -> nodeType);
			emit({$4->nodeType+"to"+$$->nodeType,NULL},$4 -> place,{"",NULL},temp);	
			$$->place=temp;
			///
	}
	;

multiplicative_expression
	: cast_expression									   {$$=$1;}
	| multiplicative_expression '*' cast_expression        {$$=make_node("*", $1, $3);
			string s=multiply($1->nodeType, $3->nodeType,'*');
			if(s=="int"){
				$$->nodeType="long long";
				///
				comp temp = get_temp_label($$ -> nodeType);
				emit({"*int",lookup("*")},$1 -> place,$3 -> place,temp);	
				$$->place=temp;
				///
			}
			else if(s=="float"){
				$$->nodeType="long double";
				///
				comp temp1 = get_temp_label($$ -> nodeType);
				if(isInt($1->nodeType)){
					comp temp2=get_temp_label($$ -> nodeType);
					emit({"inttoreal",NULL},$1->place,{"",NULL},temp2);
					emit({"*real",lookup("*")},temp2,$3 -> place,temp1);	
				}
				else if(isInt($3->nodeType)){
					comp temp2=get_temp_label($$ -> nodeType);
					emit({"inttoreal",NULL},$3->place,{"",NULL},temp2);
					emit({"*real",lookup("*")},$1 -> place,temp2,temp1);
				}
				else {
					emit({"*real",lookup("*")},$1 -> place,$3->place,temp1);
				}
				$$->place=temp1;
				///
			}
			else{
				yyerror("Error:  Incompatible type for * operator");
			} 

			$$->init= ($1->init&& $3->init);
	}
	| multiplicative_expression '/' cast_expression        {$$=make_node("/", $1, $3);
			string s=multiply($1->nodeType, $3->nodeType,'/');
			if(s=="int"){
				$$->nodeType="long long";
				///
				comp temp = get_temp_label($$ -> nodeType);
				emit({"/int",lookup("/")},$1 -> place,$3 -> place,temp);	
				$$->place=temp;
				///
			}
			else if(s=="float"){
				$$->nodeType="long double";
				///
				comp temp1 = get_temp_label($$ -> nodeType);
				if(isInt($1->nodeType)){
					comp temp2=get_temp_label($$ -> nodeType);
					emit({"inttoreal",NULL},$1->place,{"",NULL},temp2);
					emit({"/real",lookup("/")},temp2,$3 -> place,temp1);	
				}
				else if(isInt($3->nodeType)){
					comp temp2=get_temp_label($$ -> nodeType);
					emit({"inttoreal",NULL},$3->place,{"",NULL},temp2);
					emit({"/real",lookup("/")},$1 -> place,temp2,temp1);
				}
				else {
					emit({"/real",lookup("/")},$1 -> place,$3->place,temp1);
	
				}
				$$->place=temp1;
				///
			}
			else{
				yyerror("Error:  Incompatible type for / operator");
			} 

			$$->init= ($1->init&& $3->init);
	}
	| multiplicative_expression '%' cast_expression        {$$=make_node("%", $1, $3);
			string s=multiply($1->nodeType, $3->nodeType,'%');
			if(s=="int"){
				$$->nodeType="long long";
				///
				comp temp = get_temp_label($$ -> nodeType);
				emit({"%",lookup("%")},$1 -> place,$3 -> place,temp);	
				$$->place=temp;
				///
			
			}
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
		if(!s.empty()){
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
		if(!s.empty()){
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
			///
			comp temp = get_temp_label($$ -> nodeType);
			emit({"LEFT_OP",lookup("<<")},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			///
		else{
			yyerror("Error: Invalid operands to binary <<");
		}
		$$->init= ($1->init&& $3->init);

	}



	| shift_expression RIGHT_OP additive_expression     {$$=make_node(">>",$1,$3);
		if(isInt($1->nodeType) && isInt($3->nodeType)) 
			$$->nodeType= $1->nodeType;
			///
			comp temp = get_temp_label($$ -> nodeType);
			emit({"RIGHT_OP",lookup(">>")},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			///
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
		if(!s.empty())
		{
			$$->nodeType="bool";
			if(s=="Bool")
			{
				 yyerror("Warning: comparison between pointer and integer");
			}
			///
			comp temp = get_temp_label($$ -> nodeType);
			emit({"<",lookup("<")},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			///
			
		}
		else{
              yyerror("Error: invalid operands to binary <");
		}
		$$->init= ($1->init&& $3->init);

	
	}
	| relational_expression '>' shift_expression   {$$=make_node(">",$1,$3);
		string s= relational($1->nodeType, $3->nodeType);
		if(!s.empty())
		{
			$$->nodeType="bool";
			if(s=="Bool")
			{
				 yyerror("Warning: comparison between pointer and integer");
			}
			///
			comp temp = get_temp_label($$ -> nodeType);
			emit({">",lookup(">")},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			///
		}
		else{
              yyerror("Error: invalid operands to binary >");
		}
		$$->init= ($1->init&& $3->init);
	}

	| relational_expression LE_OP shift_expression {$$=make_node("<=",$1,$3);
		string s= relational($1->nodeType, $3->nodeType);
		if(!s.empty())
		{
			$$->nodeType="bool";
			if(s=="Bool")
			{
				 yyerror("Warning: comparison between pointer and integer");
			}
			///
			comp temp = get_temp_label($$ -> nodeType);
			emit({"LE_OP",lookup("<=")},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			///
		}
		else{
              yyerror("Error: invalid operands to binary <=");
		}
		$$->init= ($1->init&& $3->init);
	}

	| relational_expression GE_OP shift_expression {$$=make_node(">=",$1,$3);
		string s= relational($1->nodeType, $3->nodeType);
		if(!s.empty())
		{
			$$->nodeType="bool";
			if(s=="Bool")
			{
				 yyerror("Warning: comparison between pointer and integer");
			}
			///
			comp temp = get_temp_label($$ -> nodeType);
			emit({"GE_OP",lookup(">=")},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			///
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
		if(!s.empty())
		{
			$$->nodeType="bool";
			if(s=="Bool")
			{
				 yyerror("Warning: comparison between pointer and integer");
			}
			///
			comp temp = get_temp_label($$ -> nodeType);
			emit({"EQ_OP",lookup("==")},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			///
		}
		else{
              yyerror("Error: invalid operands to binary ==");
		}
		$$->init= ($1->init&& $3->init);
	
	
	}
	| equality_expression NE_OP relational_expression       {$$=make_node("!=",$1,$3);
		string s= equality($1->nodeType, $3->nodeType);
		if(!s.empty())
		{
			$$->nodeType="bool";
			if(s=="Bool")
			{
				 yyerror("Warning: comparison between pointer and integer");
			}
			///
			comp temp = get_temp_label($$ -> nodeType);
			emit({"NE_OP",lookup("!=")},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			///
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
		if(!s.empty())
		{
			if(s=="bool")$$->nodeType=s;
			else $$->nodeType="long long";
			///
			comp temp = get_temp_label($$ -> nodeType);
			emit({"&",lookup("&")},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			///
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
		if(!s.empty())
		{
			if(s=="bool")$$->nodeType=s;
			else $$->nodeType="long long";
			///
			comp temp = get_temp_label($$ -> nodeType);
			emit({"^",lookup("^")},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			///
			
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
		if(!s.empty())
		{
			if(s=="bool")$$->nodeType=s;
			else $$->nodeType="long long";
			///
			comp temp = get_temp_label($$ -> nodeType);
			emit({"|",lookup("|")},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			///
			
		}
		else{
              yyerror("Error: invalid operands to binary |");
		}
		$$->init= ($1->init&& $3->init);
	
	
	}
	;

M
	: %empty {
		$$ = (int)code.size();
	}

logical_and_expression
	: inclusive_or_expression										{$$=$1;}
	| logical_and_expression AND_OP M inclusive_or_expression			{$$=make_node("&&",$1,$3);
		$$->nodeType="bool";
		$$->init= ($1->init&& $3->init);
		///
		
		///
	}
	;



logical_or_expression
	: logical_and_expression										{$$=$1;}
	| logical_or_expression OR_OP logical_and_expression			{$$=make_node("||",$1,$3);
		$$->nodeType="bool";
		$$->init= ($1->init&& $3->init);
	}
	;


conditional_expression
	: logical_or_expression												{$$=$1;}
	| logical_or_expression '?' expression ':' conditional_expression    {$$=make_node("conditional_expression",$1,$3,$5);
		string s=condition($3->nodeType,$5->nodeType);
		if(!s.empty())$$->nodeType=s;
		else{
            yyerror("Error: Type mismatch in conditional expression");
		}

		$$->init= ($1->init&& $3->init && $5->init);
	}


	;
assignment_expression
	: conditional_expression													{$$=$1;}
	| unary_expression assignment_operator assignment_expression		    {$$=make_node("assignment_expression",$1,make_node($2),$3);
		string s=assign($1->nodeType,$3->nodeType,$2);
		if(!s.empty())
		{
			$$->nodeType=$1->nodeType;
			if(s=="warning"){
                yyerror("Warning: Assignment with incompatible pointer type"); 
			}
			update_init($1 -> nodeLex,$3 -> init);
		}
		else{
			s="Error: Incompatible types when assigning type " +$3->nodeType +" to "+$1->nodeType;
			char *x;
			strcpy(x,s.c_str());
			yyerror(x);
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

expression
	: assignment_expression										{$$=$1;}
	| expression ',' assignment_expression						{$$=make_node("expression",$1,$3);}
	;

constant_expression
	: conditional_expression								   {$$=$1;}
	;

declaration
	: declaration_specifiers ';'								{$$=$1;
		var_type = "";
	}					
	| declaration_specifiers init_declarator_list ';'			{$$=make_node("declaration",$1,$2);
		var_type = "";
	}
	;

declaration_specifiers
	: storage_class_specifier									{$$=$1;}
	| storage_class_specifier declaration_specifiers			{$$=make_node("declaration_specifiers",$1,$2);}
	| M2 type_specifier											{$$=$2;}
	| M2 type_specifier declaration_specifiers						{$$=make_node("declaration_specifiers",$2,$3);}
	| type_qualifier											{$$=$1;}
	| type_qualifier declaration_specifiers						{$$=make_node("declaration_specifiers",$1,$2);}
	;

M2
	:%empty		{
		var_type = "";
	}
	;

init_declarator_list
	: init_declarator											{$$=$1;
		
	}
	| init_declarator_list ',' init_declarator					{$$=make_node("init_declarator_list",$1,$3);

	}	
	;

init_declarator
	: declarator											{$$=$1;
		s_entry * find = lookup_in_curr($1->nodeLex);
		if(array_case2){
			yyerror("Error : array size not defined.");
			array_case2 = 0;
		}
		else{
			// if(funcMatched){
			// 	if(temp_arg.find($1 -> nodeLex) == temp_arg.end()){
			// 		yyerror("Error: variable not introduced in function definition.");
			// 	}	
			// 	else{
			// 		tmp_map[$1 -> nodeLex] = $1 -> nodeType;
			// 		temp_arg.erase($1 -> nodeLex);
			// 	}
			// }
			if(find){
				yyerror("Error: redeclaration of the variable."); 
			}
			else{
				make_symTable_entry($1->nodeLex,$1 -> nodeType,0);
				$$ -> init = 0;
			}
		}
	}
	| declarator '=' initializer							{$$=make_node("init_declarator",$1,$3);
		s_entry * find = lookup_in_curr($1->nodeLex);
		if(array_case2 && initializer_list_size == 0){
			yyerror("Error : unexpected initialisation of array.");
		}
		if(check_type($1 -> nodeType,$3 -> nodeType)){
			if(find){
				yyerror("Error: redeclaration of the variable."); 
			}
			else{
				make_symTable_entry($1->nodeLex,$1 -> nodeType,1);
				$$ -> init = 1;
			}
			initializer_list_size = 0;
			array_case2 = 0;
		}
		else{
			yyerror("Error : unexpected initialisation of variable.");
		}
	}
	;

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
	| struct_or_union_specifier							{$$=$1;
		if(var_type == "")
			var_type += $1 -> nodeType;
		else
			var_type += " " + $1 -> nodeType;
	}
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
	: M5 M11 M10 '{' struct_declaration_list '}'  {$$=make_node("struct_or_union_specifier",$1,$5);
		curr_struct_table = struct_parent[curr_struct_table];
		printSymTable(curr_table,$1 -> nodeLex,"struct",st_line_no.back(),yylineno);
		st_line_no.pop_back();
		id_to_struct[$1 -> nodeType] = curr_table;
		id_to_struct_name[$1 -> nodeType] = "struct_name " + $1 -> nodeLex;
		curr_table = parent[curr_table];
		complete[$1 -> nodeType] = 1;
		$$ -> nodeType = $1 -> nodeType;
		$$ -> nodeLex = $1 -> nodeLex;
	}
	| struct_or_union M11 M10 '{' struct_declaration_list '}'             {$$=make_node("struct_or_union_specifier",$1,$5);
		curr_struct_table = struct_parent[curr_struct_table];
		struct_count++;
		string name = to_string(struct_count);
		id_to_struct[name] = curr_table;
		printSymTable(curr_table,name,"struct",st_line_no.back(),yylineno);
		st_line_no.pop_back();
		curr_table = parent[curr_table];
		id_to_struct_name[name] = "struct_type_definition_2";
		(*curr_struct_table)[name] = {struct_count,$1 -> is_union};
		$$ -> nodeType = name;
		$$ -> nodeLex = name;
		complete[$1 -> nodeType] = 1;
	}
	| struct_or_union IDENTIFIER								  {$$=make_node("struct_or_union_specifier",$1,make_node($2));
		int id = lookup_struct($2,$1 -> is_union);
		if(id){
			$$ -> nodeType = to_string(id);
			$$ -> nodeLex = to_string(id); 
		}
		else{
			yyerror("Error : structure not declared.");
		}
	}
	;

M5
	:struct_or_union IDENTIFIER		{ $$ = make_node("Marker",$1,make_node($2));
		if(lookup_in_struct_curr_scope($2)){
			yyerror("Error : Redeclaration of structure.");
		}
		else{
			struct_count++;
			(*curr_struct_table)[$2] = {struct_count,$1 -> is_union};
			$$ -> nodeType = to_string(struct_count);
			$$ -> nodeLex = $2;
			complete[$$ -> nodeType] = 0;
		}
	}
struct_or_union
	: STRUCT										    {$$=make_node($1);
		$$ -> nodeType = $1;
		$$ -> nodeLex = $1;
		$$ -> is_union = 0;
	}
	| UNION										        {$$=make_node($1);
		$$ -> nodeType = $1;
		$$ -> nodeLex = $1;
		$$ -> is_union = 1;
	}
	;

struct_declaration_list
	: struct_declaration											{$$=$1;}
	| struct_declaration_list struct_declaration					{$$=make_node("struct_declaration_list",$1,$2);}
	;

struct_declaration
	: M6 struct_declarator_list ';'          {$$=make_node("struct_declaration",$1,$2);
		var_type = "";
	}
	;

M6
	:specifier_qualifier_list		{$$ = $1;}
	;
specifier_qualifier_list
	: type_specifier specifier_qualifier_list					{$$=make_node("specifier_qualifier_list",$1,$2);
		$$ -> nodeType = $1 -> nodeType + $2 -> nodeType;;
	}
	| type_specifier											{$$=$1;
		$$ -> nodeType = $1 -> nodeType;
	}
	| type_qualifier specifier_qualifier_list					{$$=make_node("specifier_qualifier_list",$1,$2);
		$$ -> nodeType = $1 -> nodeType + $2 -> nodeType;
	}
	| type_qualifier											{$$=$1;
		$$ -> nodeType = $1 -> nodeType;
	}
	;

struct_declarator_list
	: M7											{$$=$1;}
	| struct_declarator_list ',' M7				{$$=make_node("struct_declarator_list",$1,$3);}              
	;

M7
	:struct_declarator		{ $$ = $1;
		accept = 0;
	}

struct_declarator
	: declarator											{$$=$1;
		if(lookup_in_curr($1 -> nodeLex)){
			yyerror("Error: redeclaration of variable.");
		}
		else{// var_type == ""; int var_type == 
			if((complete.find(var_type) != complete.end()) && (complete[var_type] == 0) && !accept){
				yyerror("Error : Creating object before completing structure definition.");
			}
			else make_symTable_entry($1 -> nodeLex,$1 -> nodeType,0);
		}
	}
	| ':' constant_expression								{$$=$2;}
	| declarator ':' constant_expression					{$$=make_node("struct_declarator",$1,$3);
		if(lookup_in_curr($1 -> nodeLex)){
			yyerror("Error: redeclaration of variable.");
		}
		else{// var_type == "";
			if((complete.find(var_type) != complete.end()) && (complete[var_type] == 0) && !accept){
				yyerror("Error : Creating object before completing structure definition.");
			}
			else make_symTable_entry($1 -> nodeLex,$1 -> nodeType,0);
		}
	}
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
	: pointer direct_declarator	               					{$$=make_node("direct_declarator",$1,$2);
		$$ -> nodeType = $2 -> nodeType + $1 -> nodeType;
		$$ -> nodeLex = $2 -> nodeLex;
		accept = 1;
	}
	| direct_declarator											{$$=$1;}
	;

direct_declarator
	: IDENTIFIER										    	{$$=make_node($1);
		$$ -> nodeType = var_type;
		$$ -> nodeLex = $1;
	}
	| '(' declarator ')'										{$$=$2;}
	| direct_declarator '[' constant_expression ']'        		{$$=make_node("direct_declarator",$1,$3);
		$$ -> nodeType = $1 -> nodeType + "*";
		$$ -> nodeLex = $1 -> nodeLex;
		//$$ -> size = ($1 -> size)*$3 -> iVal; // check whether constant_expression is evaluated or not
	}
	| direct_declarator '[' ']'							  		{$$=make_node("direct_declarator",$1,make_node("[]"));
		$$ -> nodeType = $1 -> nodeType + "*";
		$$ -> nodeLex = $1 -> nodeLex;
		//$$ -> size = ($1 -> size)*initializer_list_size;
		if(!in_param){
			array_case2 = 1;
		}
	}
	| direct_declarator '(' M8 M13 parameter_type_list M8 ')'        		{$$=make_node("direct_declarator",$1,$5);
		$$ -> nodeLex = $1 -> nodeLex;
		$$ -> nodeType = $1 -> nodeType;
		funcName = $1 -> nodeLex;
	}
	| direct_declarator '(' identifier_list ')'       		    {$$=make_node("direct_declarator",$1,$3);
		$$ -> nodeLex = $1 -> nodeLex;
		$$ -> nodeType = $1 -> nodeType;
	}
	| direct_declarator '(' M13 M3 ')'									{$$=make_node("direct_declarator",$1,make_node("()"));
		$$ -> nodeLex = $1 -> nodeLex;
		$$ -> nodeType = $1 -> nodeType;
		funcName = $1 -> nodeLex;
	}
	;

pointer
	: '*'														{$$=make_node("*");
		$$ -> nodeType = "*";
	}
	| '*' type_qualifier_list									{$$=make_node("*",$2);
		$$ -> nodeType = $2 -> nodeType + "*";
	}
	| '*' pointer												{$$=make_node("*",$2);
		$$ -> nodeType = $2 -> nodeType + "*";
	}
	| '*' type_qualifier_list pointer		    				{$$=make_node("*",$2,$3);
		$$ -> nodeType = $2 -> nodeType + $3 -> nodeType + "*";
	}
	;

type_qualifier_list
	: type_qualifier											{$$=$1;}
	| type_qualifier_list type_qualifier						{$$=make_node("type_qualifier_list",$1,$2);}
	;


parameter_type_list
	: parameter_list											{$$=$1;}
	| parameter_list ',' ELLIPSIS								{$$=make_node("parameter_type_list",$1,make_node($3));
		if(funcArg == ""){
			funcArg += "...";
		}
		else{
			funcArg += ",...";
		}
	}
	;

parameter_list
	: parameter_declaration										{$$=$1;}
	| parameter_list ',' parameter_declaration                 	{$$=make_node("parameter_list",$1,$3);}
	;

parameter_declaration
	: declaration_specifiers  declarator                  		{$$=make_node("parameter_declaration",$1,$2);
		s_entry* find = lookup_in_curr($2 -> nodeLex);
		if(find){
			yyerror("Error: redeclaration of variable.");
		}
		else{
			make_symTable_entry2(temp_table,$2 -> nodeLex,$2 -> nodeType,1);
		}
		if(funcArg == ""){
			funcArg += $2 -> nodeType;
		}
		else{
			funcArg += "," + $2 -> nodeType;
		}
		var_type = "";
	}
	| declaration_specifiers abstract_declarator                {$$=make_node("parameter_declaration",$1,$2);
		var_type = "";
	}
	| declaration_specifiers									{$$=$1;
		var_type = "";
	}
	;

M8
	:%empty{
		in_param = 1 - in_param;
	}

identifier_list
	: IDENTIFIER												{$$=make_node($1);
		if(tmpstr == "")
			tmpstr += $1;
		else{
			tmpstr += ',';
			tmpstr += $1;
		}
		if(temp_arg.find($1) == temp_arg.end()){
			temp_arg.insert($1);
		}
		else{
			yyerror("Error: reuse of same argument");
		}
	}
	| identifier_list ',' IDENTIFIER							{$$=make_node("identifier_list",$1,make_node($3));
		if(tmpstr == "")
			tmpstr += $3;
		else{
			tmpstr += ',';
			tmpstr += $3;
		}
		if(temp_arg.find($3) == temp_arg.end()){
			temp_arg.insert($3);
		}
		else{
			yyerror("Error: reuse of same argument");
		}
	}
	;


type_name
	: specifier_qualifier_list									{$$=$1;
		$$ -> nodeType = var_type;
	}
	| specifier_qualifier_list abstract_declarator		 		{$$=make_node("type_name",$1,$2);
		$$ -> nodeType = $2 -> nodeType;
	}
	;
abstract_declarator
	: pointer													{$$=$1;
		$$ -> nodeType = var_type + $1 -> nodeType;
	}
	| direct_abstract_declarator								{$$=$1;}
	| pointer direct_abstract_declarator 						{$$=make_node("abstract_declarator",$1,$2);
		$$ -> nodeType = $2 -> nodeType + $1 -> nodeType;
	}
	;

direct_abstract_declarator
	: '(' abstract_declarator ')'								{$$=$2;
		$$ -> nodeType = $2 -> nodeType;		
	}
	| '[' ']'													{$$=make_node("[ ]");
		$$ -> nodeType = var_type + "*";
	}
	| '[' constant_expression ']'								{$$=$2;
		$$ -> nodeType = var_type + "*";
	}
	| direct_abstract_declarator '[' ']'						{$$=make_node("direct_abstract_declarator",$1,make_node("[]"));
		$$ -> nodeType = $1 -> nodeType + "*";
	}
	| direct_abstract_declarator '[' constant_expression ']'  	{$$ = make_node("direct_abstract_declarator", $1, $3);;
		$$ -> nodeType = $1 -> nodeType + "*";
	}
	| '(' ')'													{$$ = make_node("( )");
		$$ -> nodeType = var_type;
	}
	| '(' parameter_type_list ')'								{$$=$2;}
	| direct_abstract_declarator '(' ')'						{$$=make_node("direct_abstract_declarator",$1,make_node("()"));
		$$ -> nodeType = $1 -> nodeType;
	}
	| direct_abstract_declarator '(' parameter_type_list ')'    {$$=make_node("direct_abstract_declarator",$1,$3);
		$$ -> nodeType = $1 -> nodeType;
	}
	;

initializer
	: assignment_expression											{$$=$1;
		
	}
	| '{' initializer_list '}'										{$$=$2;}
	| '{' initializer_list ',' '}'									{$$=make_node("initializer",$2,make_node($3));}
	;

initializer_list
	: initializer											{$$=$1;
		initializer_list_size++;
	}
	| initializer_list ',' initializer						{$$=make_node("initializer_list",$1,$3);
		initializer_list_size++;
	}
	;

statement
	: labeled_statement												{$$=$1;}
	| M12 M9 compound_statement M9											{$$=$3;}
	| expression_statement											{$$=$1;}
	| selection_statement											{$$=$1;}
	| iteration_statement											{$$=$1;}
	| jump_statement												{$$=$1;}
	;

M9
	:%empty		{
		simple_block = 1 - simple_block;
	}
labeled_statement
	: IDENTIFIER ':' statement			 		 {$$=make_node("labeled_statement",make_node($1),$3);}
	| CASE constant_expression ':' statement   	 {$$=make_node("labeled_statement",make_node("case"),$2,$4);}
	| DEFAULT ':' statement   			  		 {$$=make_node("labeled_statement",make_node("default"),$3);}
	;

compound_statement
	: M10 '{' '}'    								{$$=make_node("{ }");
		if(symTable_type[curr_table] == "function"){
			printSymTable(curr_table,funcName,"function",st_line_no.back(),yylineno);
			st_line_no.pop_back();
		}
		else{
			printSymTable(curr_table,"BLOCK","BLOCK",st_line_no.back(),yylineno);
			st_line_no.pop_back();
		}
		curr_table = parent[curr_table];
		curr_struct_table = struct_parent[curr_struct_table];
	}
	| M10 '{' statement_list '}'					{$$=make_node("compound_statement",$3);
		if(symTable_type[curr_table] == "function"){
			printSymTable(curr_table,funcName,"function",st_line_no.back(),yylineno);
			st_line_no.pop_back();
		}
		else{
			printSymTable(curr_table,"BLOCK","BLOCK",st_line_no.back(),yylineno);
			st_line_no.pop_back();
		}
		curr_table = parent[curr_table];
		curr_struct_table = struct_parent[curr_struct_table];
	}
	| M10 '{' declaration_list '}'					{$$=make_node("compound_statement",$3);
		if(symTable_type[curr_table] == "function"){
			printSymTable(curr_table,funcName,"function",st_line_no.back(),yylineno);
			st_line_no.pop_back();
		}
		else{
			printSymTable(curr_table,"BLOCK","BLOCK",st_line_no.back(),yylineno);
			st_line_no.pop_back();
		}
		curr_table = parent[curr_table];
		curr_struct_table = struct_parent[curr_struct_table];
	}
	| M10 '{' declaration_list statement_list '}'   {$$=make_node("compound_statement",$3,$4);
		if(symTable_type[curr_table] == "function"){
			printSymTable(curr_table,funcName,"function",st_line_no.back(),yylineno);
			st_line_no.pop_back();
		}
		else{
			printSymTable(curr_table,"BLOCK","BLOCK",st_line_no.back(),yylineno);
			st_line_no.pop_back();
		}
		curr_table = parent[curr_table];
		curr_struct_table = struct_parent[curr_struct_table];
	}
	;

M10
	:%empty		{
		st_line_no.push_back(yylineno);
	}
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
	| expression ';'											{$$=$1;// complete typechecking
	}
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
	| RETURN ';'						        {$$=make_node("return");
		return_type = "void";
	}
	| RETURN expression ';'						{$$=make_node("jump_statement",make_node("return"),$2);
		return_type = $2 -> nodeType;
	}
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
	: declaration_specifiers declarator M3 M4 declaration_list compound_statement M4       {$$=make_node("function_definition",$1,$2,$5,$6);
		int x= 0;
		string tmp;
		while(x < tmpstr.size()){
			if(tmpstr[x] == ','){
				if(funcArg == ""){
					funcArg += tmp_map[tmp];
				}
				else{
					funcArg += "," + tmp_map[tmp];
				}
				tmp = "";
			}
			else{
				tmp += tmpstr[x];
			}
			x++;
		}
		if(funcArg == ""){
			funcArg += tmp_map[tmp];
		}
		else{
			funcArg += "," + tmp_map[tmp];
		}
		if(is_struct($2 -> nodeType) || is_struct(return_type)){
			if($2 -> nodeType != return_type){
				yyerror("Error : Return type not consistent with output type of function.");
			}
		}
		else{
			if($2 -> nodeType != return_type){
				yyerror("Warning : Implicit typecasting at return type.");
			}
		}
		if(funcMap.find($2 -> nodeLex) == funcMap.end()){
			if(!lookup($2 -> nodeLex)){
				 funcMap.insert({$2 -> nodeLex,funcArg});
				 make_symTable_entry($2 -> nodeLex,$2 -> nodeType,0);
			}
			else{
				yyerror("Error: redeclaration of the function.");
			}
		}
		else{
			yyerror("Error: redeclaration of the function.");
		}
		funcArg = "";
		tmpstr = "";
		tmp_map.clear();
		var_type = "";
		return_type = "";
	}
	| M14 M4 compound_statement M4                        {$$=make_node("function_definition",$1,$3);
		if(is_struct($2 -> nodeType) || is_struct(return_type)){
			if($2 -> nodeType != return_type){
				yyerror("Error : Return type not consistent with output type of function.");
			}
		}
		else{
			if($2 -> nodeType != return_type){
				yyerror("Warning : Implicit typecasting at return type.");
			}
		}
		return_type = "";
	}
	| declarator M3 M4 declaration_list compound_statement M4                        {$$=make_node("function_definition",$1,$4,$5);
		int x= 0;
		string tmp;
		if(is_struct("int") || is_struct(return_type)){
			if("int" != return_type){
				yyerror("Error : Return type not consistent with output type of function.");
			}
		}
		else{
			if("int" != return_type){
				yyerror("Warning : Implicit typecasting at return type.");
			}
		}
		return_type = "";
		while(x < tmpstr.size()){
			if(tmpstr[x] == ','){
				if(funcArg == ""){
					funcArg += tmp_map[tmp];
				}
				else{
					funcArg += "," + tmp_map[tmp];
				}
				tmp = "";
			}
			else{
				tmp += tmpstr[x];
			}
			x++;
		}
		if(funcArg == ""){
			funcArg += tmp_map[tmp];
		}
		else{
			funcArg += "," + tmp_map[tmp];
		}
		if(funcMap.find($1 -> nodeLex) == funcMap.end()){
			if(!lookup($1 -> nodeLex)){
				 funcMap.insert({$1 -> nodeLex,funcArg});
				 make_symTable_entry($1 -> nodeLex,"int",0);
			}
			else{
				yyerror("Error: redeclaration of the function.");
			}
		}
		else{
			yyerror("Error: redeclaration of the function.");
		}
		funcArg = "";
		tmpstr = "";
		tmp_map.clear();
	}
	| M15 M4 compound_statement M4                                              {$$=make_node("function_definition",$1,$3);
		if(is_struct("int") || is_struct(return_type)){
			if("int" != return_type){
				yyerror("Error : Return type not consistent with output type of function.");
			}
		}
		else{
			if("int" != return_type){
				yyerror("Warning : Implicit typecasting at return type.");
			}
		}
		return_type = "";
	}
	;

M3
	:%empty		{
		symTable * temp = new symTable();
		struct_table * temp2 = new struct_table();
		struct_parent.insert({temp2,curr_struct_table});
		curr_struct_table = temp2;
		parent.insert({temp,curr_table});
		curr_table = temp;
		symTable_type[curr_table] = "function";
	}
	;
M11
	:%empty		{
		symTable * temp = new symTable();
		struct_table * temp2 = new struct_table();
		struct_parent.insert({temp2,curr_struct_table});
		curr_struct_table = temp2;
		parent.insert({temp,curr_table});
		curr_table = temp;
		symTable_type[curr_table] = "struct";
	}
	;
M12
	:%empty		{
	symTable * temp = new symTable();
	struct_table * temp2 = new struct_table();
	struct_parent.insert({temp2,curr_struct_table});
	curr_struct_table = temp2;
	parent.insert({temp,curr_table});
	curr_table = temp;
	symTable_type[curr_table] = "block";
	}
	;
M4
	:%empty		{
		funcMatched = 1 - funcMatched;
		if(funcMatched == 0){
			if(temp_arg.empty()){

			}
			else{
				yyerror("Error: definition of all parameters is not specified.");
			}
			while(!temp_arg.empty()){
				temp_arg.erase(temp_arg.begin());
			}
			funcName = "";
		}
	}
	;
M13 
	:%empty		{
		temp_table = new symTable();
		struct_table * temp = new struct_table;
		struct_parent[temp] = curr_struct_table;
		curr_struct_table = temp;
		symTable_type[temp_table]="function";
	}
	;
M14
	:declaration_specifiers declarator		{ $$ = make_node("Marker14",$1,$2);
		$$ -> nodeType = $1 -> nodeType;
		if(funcMap.find($2 -> nodeLex) == funcMap.end()){
			if(!lookup($2 -> nodeLex)){
				 funcMap.insert({$2 -> nodeLex,funcArg});
				 make_symTable_entry($2 -> nodeLex,$2 -> nodeType,0);
			}
			else{
				yyerror("Error: redeclaration of the function.");
			}
		}
		else{
			yyerror("Error: redeclaration of the function.");
		}
		funcArg = "";
		var_type = "";
		parent[temp_table] = curr_table;
		curr_table = temp_table;
	}
	;
M15
	:declarator		{
		$$ = $1;
		if(funcMap.find($1 -> nodeLex) == funcMap.end()){
			if(!lookup($1 -> nodeLex)){
				 funcMap.insert({$1 -> nodeLex,funcArg});
				 make_symTable_entry($1 -> nodeLex,"int",0);
			}
			else{
				yyerror("Error: redeclaration of the function.");
			}
		}
		else{
			yyerror("Error: redeclaration of the function.");
		}
		funcArg = "";
		parent[temp_table] = curr_table;
		curr_table = temp_table;
	}
	;
%%
#include <stdio.h>
#include <vector>
#define red   "\033[31;1m"
#define reset   "\033[0m"
extern char yytext[];
extern int column;
extern int line;
char *filename;
FILE *in=NULL;
FILE *out=NULL;
vector<string> code;
void yyerror(char *s)
{	
	fflush(stdout);
	fprintf(stderr,"%s:%d:%d:%s %s%s\n",filename,line,column,red,s,reset);
	cerr<<code[line-1];
	fprintf(stderr,"\n%s%*s%s\n", red,column,"^~~~~",reset);
}

void help(int f)
{	
	if(f) printf("%sError: %s\n",red,reset);
	printf("Give Input file with -i flag\n");
	printf("Give Output file with -o flag\n");
}


int main(int argc, char *argv[])
{	
	complete[""] = 1;
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
	if(!in){
		help(1);
		return 0;
	}
	if(!out)freopen("ast.dot","w",stdout);

	string s;
	while(getline(cin,s))
	{
		code.push_back(s);
	}
	fclose(in);
	in=freopen(filename,"r",stdin);



	BeginGraph();
	yyparse();
	EndGraph();
	
} 