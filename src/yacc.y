%{
#include <iostream>
#include <string>
#include <set>
#include <cstring>
#include "node.h"
#include "type.h"
#include <fstream>
#include<vector>
// to do :
// offset
// 3AC
//check if the $number are correct after introducing markers
//make sure is_logical is flowing correctly
// case should not be there without switch...
//handle if(a==b,c==d).....
//a=b || c...............
//character addition,multi,.......
//implement constant expression: for switch.....

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
int is_union2 = 0;
extern int yylineno;
extern vector <quad> emitted_code;
vector<int> st_line_no;
string arg_list = "";
string funcName = "";
string return_type = "";
int initializer_list_size = 0;
int accept2 = 0;
int is_logical = 0;
map <string,int> complete;
symTable * temp_table;
void yyerror(char *s);
int yylex();

%}
%union{
	int num;
	node *ptr;
	char *str;
};

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


%type <num> and_operator or_operator question_mark M N N1 N2
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
						$$ -> offset = t -> offset;
						$$ -> size = t -> size;
						if(array_symTable_entry.count(t)){
							$$ -> dimensions = array_symTable_entry[t];
						}
						///
						$$->place={string($1),t};
						$$->nextlist={};
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
		 $$->place={string($1),NULL};
		 $$->nextlist={};
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
		 $$->place={string($1),NULL};
		 $$->nextlist={};
		///
	}
	| STRING_LITERAL										{$$=make_node($1);
		///
		 $$->place={string($1),NULL};
		 $$->nextlist={};
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
				$$ -> offset = $1 -> offset + product_of_dimensions($1 -> dimensions)*($3 -> ival);
				$$ -> dimensions = remove_first($1 -> dimensions);
				///



				//3AC




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
				comp temp = get_temp_label(find -> type);	//type of id
				emit({".",NULL},$1->place,$3->place,temp);
				$$->place = temp;
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
				comp temp = get_temp_label(find -> type);	//type of id
				emit({"ptr_op",NULL},$1->place,$3->place,temp);
				$$->place = temp;
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
				 
				//emit({"",0,-1},$1->place,{"",0,0},temp);
				 if(isInt(s)){
					 comp temp = get_temp_label("int");
					 emit({"+int",NULL},$1->place,{"1",NULL},temp);
					 emit({"=",NULL},temp,{"",NULL},$1->place);
					 $$->place=$1->place;
				 }else{
					 if(isFloat(s)){
						 comp temp = get_temp_label("float");
						 emit({"+float",NULL},$1->place,{"1",NULL},$1->place);
						 emit({"=",NULL},temp,{"",NULL},$1->place);
						 $$->place=$1->place;
					 }else{
						 //if()
						 yyerror("increment operator with not int or float");
					 }
				 }	
				 
				///
			}
			else{
				yyerror("Error: Increment operator not defined for this type");
			}
			// cout << "inside postfix for variable " << $1 -> nodeLex << endl; 
	}
	| postfix_expression DEC_OP								{$$=make_node($2, $1);
			$$->init=$1->init;
		    string s=postfix($1->nodeType,3);
			if(!s.empty())
			{
				$$->nodeType=s;
				///
				 
				//emit({"",0,-1},$1->place,{"",0,0},temp);
				 if(isInt(s)){
					 comp temp = get_temp_label("int");
					 emit({"-int",NULL},$1->place,{"1",NULL},temp);
					 emit({"=",NULL},temp,{"",NULL},$1->place);
					 $$->place=$1->place;
				 }else{
					 if(isFloat(s)){
						 comp temp = get_temp_label("float");
						 emit({"-float",NULL},$1->place,{"1",NULL},$1->place);
						 emit({"=",NULL},temp,{"",NULL},$1->place);
						 $$->place=$1->place;
					 }else{
						 yyerror("increment operator with not int or float");
					 }
				 }	
				 
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
		//TODO:3ac
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
				 
				
				 if(isInt(s)){
					 comp temp = get_temp_label("int");
					 emit({"+int",NULL},$2->place,{"1",NULL},temp);
					 emit({"=",NULL},temp,{"",NULL},$2->place);
					 $$->place = $2->place;
				 }else{
					 if(isFloat(s)){
						 comp temp = get_temp_label("float");
						 emit({"+float",NULL},$2->place,{"1",NULL},$2->place);
						 emit({"=",NULL},temp,{"",NULL},$2->place);
						 $$->place = $2->place;
					 }else{
						 yyerror("increment operator with not int or float");
					 }
				 }	
				//  emit({"",0,-1},$2->place,{"",0,0},temp);
				//  $$->place=temp;
				
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
				 
				
				 if(isInt(s)){
					 comp temp = get_temp_label("int");
					 emit({"-int",NULL},$2->place,{"1",NULL},$2->place);
					 emit({"=",NULL},temp,{"",NULL},$2->place);
					 $$->place=$2->place;
				 }else{
					 if(isFloat(s)){
						 comp temp = get_temp_label("float");
						 emit({"-float",NULL},$2->place,{"1",NULL},$2->place);
						 emit({"=",NULL},temp,{"",NULL},$2->place);
						 $$->place=$2->place;
					 }else{
						 yyerror("increment operator with not int or float");
					 }
				 }	
				//  emit({"",0,-1},$2->place,{"",0,0},temp);
				 
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
				 comp temp = get_temp_label(s);
				 emit($1->place,$2 -> place,{"",NULL},temp);	
				 $$->place=temp;
				$$->nextlist = {};
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
			 comp temp = get_temp_label("int");
			 emit({"sizeof",NULL},$2 -> place,{"",NULL},temp);	
			 $$->place=temp;
			$$->nextlist = {};
			///
	
	}
	| SIZEOF '(' type_name ')'								{$$=make_node($1,$3);
			$$->nodeType="int";
			$$->init=1;
			$$->nodeLex = $3 -> nodeLex;
			///
			 comp temp = get_temp_label("int");
			 emit({"SIZEOF",NULL},$3 -> place,{"",NULL},temp);	
			$$->place=temp;
			$$->nextlist = {};
			///
	}
	;

unary_operator
	: '&'		{$$=make_node("&");
		$$->place={"&",NULL};
	}
	| '*'		{$$=make_node("*");
		//s_entry *op=lookup("*");
		$$->place={"unary*",NULL};
	}
	| '+'		{$$=make_node("+");
		//s_entry *op=lookup("+");
		$$->place={"unary+",NULL};
	}
	| '-'		{$$=make_node("-");
		//s_entry *op=lookup("-");
		$$->place={"unary-",NULL};
	}
	| '~'		{$$=make_node("~");
		//s_entry *op=lookup("~");
		$$->place={"~",NULL};
	}
	| '!'		{$$=make_node("!");
		$$->place={"!",NULL};
	}
	;

cast_expression
	: unary_expression									   {$$=$1;}
	| '(' type_name ')' cast_expression                    {$$=make_node("cast_expression", $2, $4);
			$$->nodeType=$2->nodeType;
			$$->init=$4->init;
			$$ -> nodeLex = $4 -> nodeLex;
			///
			 comp temp = get_temp_label($2->nodeType);
			 emit({$4->nodeType+"to"+$2->nodeType,NULL},$4 -> place,{"",NULL},temp);	
			 $$->place=temp;
			// $$->nextlist = {};
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
				comp temp = get_temp_label("long long");

				emit({"*int",NULL},$1 -> place,$3 -> place,temp);	
				$$->place=temp;
				$$->nextlist = {};
				///
			}
			else if(s=="float"){
				$$->nodeType="long double";
				///
				comp temp1 = get_temp_label("long double");
			    s_entry *op=lookup("*");
				if(isInt($1->nodeType)){
					comp temp2=get_temp_label("long double");
					emit({"inttoreal",NULL},$1->place,{"",NULL},temp2);
					emit({"*real",NULL},temp2,$3 -> place,temp1);	
				}
				else if(isInt($3->nodeType)){
					comp temp2=get_temp_label("long double");
					emit({"inttoreal",NULL},$3->place,{"",NULL},temp2);
					emit({"*real",NULL},$1 -> place,temp2,temp1);
				}
				else {
					emit({"*real",NULL},$1 -> place,$3->place,temp1);
				}
				$$->place=temp1;
				$$->nextlist = {};
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
				comp temp = get_temp_label("long long");

				emit({"/int",NULL},$1 -> place,$3 -> place,temp);	
				$$->place=temp;
				$$->nextlist = {};
				///
			}
			else if(s=="float"){
				$$->nodeType="long double";
				///
				comp temp1 = get_temp_label("long double");
				if(isInt($1->nodeType)){
					comp temp2=get_temp_label("long double");
					emit({"inttoreal",NULL},$1->place,{"",NULL},temp2);
					emit({"/real",NULL},temp2,$3 -> place,temp1);	
				}
				else if(isInt($3->nodeType)){
					comp temp2=get_temp_label("long double");
					emit({"inttoreal",NULL},$3->place,{"",NULL},temp2);
					emit({"/real",NULL},$1 -> place,temp2,temp1);
				}
				else {
					emit({"/real",NULL},$1 -> place,$3->place,temp1);
	
				}
				$$->place=temp1;
				$$->nextlist = {};
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
				comp temp = get_temp_label("long long");
				emit({"%",NULL},$1 -> place,$3 -> place,temp);	
				$$->place=temp;
				$$->nextlist = {};
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

			///
			comp temp1 = get_temp_label(s);

			if(isInt($1->nodeType)&&isFloat($3->nodeType)){
				comp temp2=get_temp_label("long double");
				emit({"inttoreal",NULL},$1 -> place,{"",NULL},temp2);	
				emit({"+"+s,NULL},temp2,$3 -> place,temp1);	
			}
			else if(isInt($3->nodeType)&&isFloat($1->nodeType)){
				comp temp2=get_temp_label("long double");
				emit({"inttoreal",NULL},$3 -> place,{"",NULL},temp2);	
				emit({"+"+s,NULL},$1 -> place,temp2,temp1);	
			}
			else{
				emit({"+"+s,NULL},$1 -> place,$3 -> place,temp1);	
			}
			$$->place=temp1;
			$$->nextlist = {};
			///
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

			///
			comp temp1 = get_temp_label(s);

			if(isInt($1->nodeType)&&isFloat($3->nodeType)){
				comp temp2=get_temp_label("long double");
				emit({"inttoreal",NULL},$1 -> place,{"",NULL},temp2);	
				emit({"-"+s,NULL},temp2,$3 -> place,temp1);	
			}
			else if(isInt($3->nodeType)&&isFloat($1->nodeType)){
				comp temp2=get_temp_label("long double");
				emit({"inttoreal",NULL},$3 -> place,{"",NULL},temp2);	
				emit({"-"+s,NULL},$1 -> place,temp2,temp1);	
			}
			else{
				emit({"-"+s,NULL},$1 -> place,$3 -> place,temp1);	
			}
			$$->place=temp1;
			$$->nextlist = {};
			///



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
		if(isInt($1->nodeType) && isInt($3->nodeType)) {
			$$->nodeType= $1->nodeType;
			///
			comp temp = get_temp_label("int");
			emit({"LEFT_OP",NULL},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			$$->nextlist = {};
			///
		}
		else{
			yyerror("Error: Invalid operands to binary <<");
		}
		$$->init= ($1->init&& $3->init);

	}



	| shift_expression RIGHT_OP additive_expression     {$$=make_node(">>",$1,$3);
		if(isInt($1->nodeType) && isInt($3->nodeType)) {
			$$->nodeType= $1->nodeType;
			///
			comp temp = get_temp_label("int");
			emit({"RIGHT_OP",NULL},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			$$->nextlist = {};
			///
		}
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
			comp temp = get_temp_label("int");
			emit({"<",NULL},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			$$->nextlist = {};
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
			comp temp = get_temp_label("int");
			emit({">",NULL},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			$$->nextlist = {};
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
			comp temp = get_temp_label("int");
			emit({"LE_OP",NULL},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			$$->nextlist = {};
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
			comp temp = get_temp_label("int");
			emit({"GE_OP",NULL},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			$$->nextlist = {};
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
			comp temp = get_temp_label("int");
			//s_entry *op=lookup("==");
			emit({"EQ_OP",NULL},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			$$->nextlist = {};
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
			comp temp = get_temp_label("int");
			emit({"NE_OP",NULL},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			$$->nextlist = {};
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
			comp temp = get_temp_label("int");
			emit({"&",NULL},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			$$->nextlist = {};
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
			comp temp = get_temp_label("int");
			emit({"^",NULL},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			$$->nextlist = {};
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
			comp temp = get_temp_label("int");
			emit({"|",NULL},$1 -> place,$3 -> place,temp);	
			$$->place=temp;
			$$->nextlist = {};
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
		$$ = (int)emitted_code.size();
	}

and_operator
	: AND_OP	{
		if(is_logical == 0){
			emit({"if_goto",NULL},{"",NULL},{"",NULL},{"",NULL});
			emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
		}
		$$ = (int)emitted_code.size();
	}

logical_and_expression
	: inclusive_or_expression										{$$=$1;
	 ///
	 is_logical = 0;
	 $$->is_logical = 0;
	 ///
	 }
	| logical_and_expression and_operator  inclusive_or_expression			{$$=make_node("&&",$1,$3);
		$$->nodeType="bool";
		$$->init= ($1->init&& $3->init);
		///
		if(is_logical == 0){
			emitted_code[$2-2].op_1 = $1->place;
			$1->truelist.push_back($2-2);
			$1->falselist.push_back($2-1);
		}
		if($3->is_logical == 0){
			emit({"if_goto",NULL},$3->place,{"",NULL},{"",NULL});
			emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
			$3->truelist.push_back((int)emitted_code.size()-2);
			$3->falselist.push_back((int)emitted_code.size()-1);
		}
		$$->falselist = $1->falselist;
		$$->falselist.merge($3->falselist);
		backpatch($1->truelist,$2);
		$$->truelist = $3->truelist;
		is_logical = 1;
		$$->is_logical = 1;
		///
	}
	;

or_operator
	: OR_OP  			{
		if(is_logical == 0){
			emit({"if_goto",NULL},{"",NULL},{"",NULL},{"",NULL});
			emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
		}
		$$ = (int)emitted_code.size();
	}

logical_or_expression
	: logical_and_expression										{$$=$1; is_logical = $1->is_logical;}
	| logical_or_expression or_operator logical_and_expression			{$$=make_node("||",$1,$3);
		$$->nodeType="bool";
		$$->init= ($1->init&& $3->init);
		///
		is_logical = 1;
		if($1->is_logical == 0){
			emitted_code[$2-2].op_1 = $1->place;
			$1->truelist.push_back($2-2);
			$1->falselist.push_back($2-1);
		}
		if($3->is_logical == 0){
			emit({"if_goto",NULL},$3->place,{"",NULL},{"",NULL});
			emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
			$3->truelist.push_back((int)emitted_code.size()-2);
			$3->falselist.push_back((int)emitted_code.size()-1);
		}
		$$->is_logical = 1;
		$$->truelist = $1->truelist;
		$$->truelist.merge($3->truelist);
		$$->falselist = $3->falselist;
		backpatch($1->falselist,$2);
		
		///
	}
	;
question_mark
	:'?'			{
		if(is_logical == 0){
			emit({"if_goto",NULL},{"",NULL},{"",NULL},{"",NULL});
			emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
		}
		$$ = (int)emitted_code.size();
	}

N
	: %empty 		{
		emit({"",NULL},{"",NULL},{"",NULL},{"",NULL});
		emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
		$$ = (int)emitted_code.size();
	}

conditional_expression
	: logical_or_expression												{$$=$1; is_logical = $$->is_logical;
	comp temp = get_temp_label("int");
	int n = emitted_code.size();
	if($1->is_logical == 1){
		emit({"",NULL},{"1",NULL},{"",NULL},temp);
		emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
		emit({"",NULL},{"0",NULL},{"",NULL},temp);
		emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
		backpatch($1->truelist,n);
		backpatch($1->falselist,n+2);
		$$->nextlist.push_back(n+1);
		$$->nextlist.push_back(n+3);
		$$->truelist={n+1};
		$$->falselist={n+3};
		$$->place = temp;
		$$->nextlist = $1->truelist;
		$$->nextlist.merge($1->falselist);
		}
	}
	| logical_or_expression question_mark expression ':' N conditional_expression    {$$=make_node("conditional_expression",$1,$3,$6);
		string s=condition($3->nodeType,$6->nodeType);
		if(!s.empty()){
			$$->nodeType=s;
			///
			comp temp = get_temp_label(s);

			emitted_code[$5-2].op_1 = $3->place;		//(if true) setting the values
			emitted_code[$5-2].result = temp;

			emit({"",NULL},$6->place,{"",NULL},temp);		//for (if false) equate to $6, and goto statement
			emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});

			backpatch($1->truelist,$2);
			backpatch($1->falselist,$5);

			if($1->is_logical == 0){
				$1->truelist.push_back($2-2);		//if $1 is not a logical exp,truelist,falselist included
				$1->falselist.push_back($2-1);
				emitted_code[$2-2].op_1 = $1->place;
			}

			$$->nextlist = $3->nextlist;
			$$->nextlist.merge($6->nextlist);
			$$->nextlist.push_back($2-1);
			$$->nextlist.push_back($5-1);


			is_logical = 0;
			$$->is_logical = 0;
			
			///
		}
		else{
            yyerror("Error: Type mismatch in conditional expression");
		}

		$$->init= ($1->init&& $3->init && $6->init);
	}


	;
assignment_expression
	: conditional_expression													{$$=$1; }
	| unary_expression assignment_operator assignment_expression		    {$$=make_node("assignment_expression",$1,make_node($2),$3);

		string p=assign($1->nodeType,$3->nodeType,$2);
		//cout<<p<<"         .......................\n";
		//string s = "int";
		if(!p.empty())
		{
			$$->nodeType=$1->nodeType;
			if(p=="warning"){
                yyerror("Warning: Assignment with incompatible pointer type"); 
			}
			update_init($1 -> nodeLex,$3 -> init);
			///
			//comp temp = get_temp_label();
			int temp_addr = (int)emitted_code.size();
			string s($2);
			if(s == "="){
				emit({"=",NULL},$3->place,{"",NULL},$1->place);
			}else{
				if(s[0] == '+' || s[0] == '-' || s[0] == '*' || s[0] == '/'){
					if(isInt($1->nodeType) && isInt($3->nodeType)){
						string op = s.substr(0,1);
						op=op+"int";
						//cout<<s<<' '<<op<<".........................."<<endl;
						emit({op,NULL},$1->place,$3->place,$1->place);
					}else{
						if(isInt($1->nodeType)){
							emit({"inttoreal",NULL},$1->place,{"",NULL},$1->place);
						}
						if(isInt($3->nodeType)){
							emit({"inttoreal",NULL},$3->place,{"",NULL},$3->place);
						}


						string op = s.substr(0,1)+"float";
						emit({op,NULL},$1->place,$3->place,$1->place);
					}
				}else{
					string op="";
					if(s.length() == 2) op+=s[0];
					else{
						if(s[0] == '>') op+="LEFT_OP";
						else op+="RIGHT_OP";
					}
					emit({op,NULL},$1->place,$3->place,$1->place);
				}

			}
			$$->place = $1->place;
			backpatch($3->nextlist,temp_addr);
			is_logical = 0;
			$$->is_logical = 0;

			///
		}
		else{
			string s="Error: Incompatible types when assigning type " +$3->nodeType +" to "+$1->nodeType;
			char x[300];
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

//need to handle truelist,......
expression
	: assignment_expression										{$$=$1;}
	| expression ',' M assignment_expression						{$$=make_node("expression",$1,$4);
		///
		backpatch($1->nextlist,$3);
		$$->nextlist=$4 -> nextlist;
		$$->is_logical = 0;
		is_logical = 0;
		///
	}
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
		///
		$$ -> nextlist = $2 -> nextlist;
		///
	}
	;

declaration_specifiers
	: storage_class_specifier									{$$=$1;}
	| storage_class_specifier declaration_specifiers			{$$=make_node("declaration_specifiers",$1,$2);}
	| type_specifier											{$$=$1;}
	| type_specifier declaration_specifiers						{$$=make_node("declaration_specifiers",$1,$2);}
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
	| init_declarator_list ',' M init_declarator					{$$=make_node("init_declarator_list",$1,$4);
			///
			backpatch($1->nextlist, $3);
            $$->nextlist = $4->nextlist;
			///
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
				make_symTable_entry($1->nodeLex,$1 -> nodeType,0,$1 -> size);
				$$ -> init = 0;
			}
			//TODO:3ac
		}
		accept2 = 0;
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
				if(initializer_list_size != 0 && $1 -> size == 0){
					if(accept2){
						$1 -> size = get_size("*")*initializer_list_size;
						(*curr_array_arg_table).insert({$1 -> nodeLex,{initializer_list_size}});
					}
					else{
						string tmp = $1 -> nodeType;
						while(tmp[tmp.size() - 1] == '*'){
							tmp.pop_back();
						}
						$1 -> size = get_size(tmp)*initializer_list_size; 
						(*curr_array_arg_table).insert({$1 -> nodeLex,{initializer_list_size}});
					}
				}
				make_symTable_entry($1->nodeLex,$1 -> nodeType,1,$1 -> size);
				$$ -> init = 1;
			}
			initializer_list_size = 0;
			array_case2 = 0;
			accept2 = 0;


			emit({"=",NULL},$3->place,{"",NULL},$1->place);
		}
		else{
			yyerror("Error : unexpected initialisation of variable.");
		}
			//TODO:3ac

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
		id_to_struct_name[$1 -> nodeType] = $1 -> nodeType;
		curr_table = parent[curr_table];
		curr_array_arg_table = parent_array_arg_table[curr_array_arg_table];
		complete[$1 -> nodeType] = 1;
		$$ -> nodeType = $1 -> nodeType;
		$$ -> nodeLex = $1 -> nodeLex;
		if($1 -> is_union == 0){
			structSize[$$ -> nodeType] = $5 -> size;
			$$ -> size = $5 -> size;
		}
		else{
			structSize[$$ -> nodeType] = $5 -> union_size;
			$$ -> size = $5 -> union_size;
		}
	}
	| struct_or_union M11 M10 '{' struct_declaration_list '}'             {$$=make_node("struct_or_union_specifier",$1,$5);
		curr_struct_table = struct_parent[curr_struct_table];
		struct_count++;
		string name = to_string(struct_count);
		id_to_struct[name] = curr_table;
		printSymTable(curr_table,name,"struct",st_line_no.back(),yylineno);
		st_line_no.pop_back();
		curr_table = parent[curr_table];
		curr_array_arg_table = parent_array_arg_table[curr_array_arg_table];
		id_to_struct_name[name] = name;
		(*curr_struct_table)[name] = {struct_count,$1 -> is_union};
		$$ -> nodeType = name;
		$$ -> nodeLex = name;
		if($1 -> is_union == 0){
			structSize[$$ -> nodeType] = $5 -> size;
			$$ -> size = $5 -> size;
		}
		else{
			structSize[$$ -> nodeType] = $5 -> union_size;
			$$ -> size = $5 -> union_size;
		}
		complete[$1 -> nodeType] = 1;
	}
	| struct_or_union IDENTIFIER								  {$$=make_node("struct_or_union_specifier",$1,make_node($2));
		int id = lookup_struct($2,$1 -> is_union);
		if(id){
			$$ -> nodeType = to_string(id);
			$$ -> nodeLex = to_string(id); 
			$$ -> size = structSize[to_string(id)];
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
		$$ -> is_union = $1 -> is_union;
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
		is_union2 = 1;
	}
	;

struct_declaration_list
	: struct_declaration											{$$=$1;}
	| struct_declaration_list struct_declaration					{$$=make_node("struct_declaration_list",$1,$2);
			$$ -> size = $1 -> size + $2 -> size;
			$$ -> union_size = max($1 -> union_size,$2 -> union_size);
	}
	;
struct_declaration
	: M6 struct_declarator_list ';'          {$$=make_node("struct_declaration",$1,$2);
		var_type = "";
		$$ -> size = $2 -> size;
		$$ -> union_size = $2 -> union_size;
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
	: M7											{$$=$1;
		$$ -> union_size = $1 -> size;
	}
	| struct_declarator_list ',' M7				{$$=make_node("struct_declarator_list",$1,$3);
		$$ -> size = $1 -> size + $3 -> size;
		$$ -> union_size = max($1 -> union_size,$3 -> size);
	}              
	;

M7
	:struct_declarator		{ $$ = $1;
		accept = 0;
	}
	;
struct_declarator
	: declarator											{$$=$1;
		if(lookup_in_curr($1 -> nodeLex)){
			yyerror("Error: redeclaration of variable.");
		}
		else{// var_type == ""; int var_type == 
			$$ -> size = $1 -> size;
			if((complete.find(var_type) != complete.end()) && (complete[var_type] == 0) && !accept){
				yyerror("Error : Creating object before completing structure definition.");
			}
			else make_symTable_entry($1 -> nodeLex,$1 -> nodeType,0,$$ -> size);
		}
		accept2 = 0;
	}
	| ':' constant_expression								{$$=$2;}
	| declarator ':' constant_expression					{$$=make_node("struct_declarator",$1,$3);
		if(lookup_in_curr($1 -> nodeLex)){
			yyerror("Error: redeclaration of variable.");
		}
		else{// var_type == "";
			$$ -> size = $1 -> size;
			if((complete.find(var_type) != complete.end()) && (complete[var_type] == 0) && !accept){
				yyerror("Error : Creating object before completing structure definition.");
			}
			else make_symTable_entry($1 -> nodeLex,$1 -> nodeType,0,$$ -> size);
		}
		accept2 = 0;
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
		$$ -> size = get_size("*")*($2 -> size);
		accept = 1;
		accept2 = 1;
		///
		$$ ->place={$$->nodeLex,NULL};
		///
	}
	| direct_declarator											{$$=$1;
		string tmp = $1 -> nodeType;
		while(tmp[tmp.size() - 1] == '*'){
			tmp.pop_back();
		}
		$$ -> size = get_size(tmp)*($1 -> size);
		///
		$$ ->place={$$->nodeLex,NULL};
		///
	}
	;

direct_declarator
	: IDENTIFIER										    	{$$=make_node($1);
		$$ -> nodeType = var_type;
		$$ -> nodeLex = $1;
		$$ -> size = 1;
		///
		$$ ->place={$$->nodeLex,NULL};
		///
	}
	| '(' declarator ')'										{$$=$2;}
	| direct_declarator '[' constant_expression ']'        		{$$=make_node("direct_declarator",$1,$3);
		$$ -> nodeType = $1 -> nodeType + "*";
		$$ -> nodeLex = $1 -> nodeLex;
		if((*curr_array_arg_table).count($1 -> nodeLex)){
			(*curr_array_arg_table)[$1 -> nodeLex].push_back($3 -> ival);
		}
		else{
			(*curr_array_arg_table).insert({$1 -> nodeLex,{}});
			(*curr_array_arg_table)[$1 -> nodeLex].push_back($3 -> ival);
		}
		$$ -> size = ($1 -> size)*($3 -> ival);
		///
		$$ ->place={$1->nodeLex,NULL};
		///
	}
	| direct_declarator '[' ']'							  		{$$=make_node("direct_declarator",$1,make_node("[]"));
		$$ -> nodeType = $1 -> nodeType + "*";
		$$ -> nodeLex = $1 -> nodeLex;
		$$ -> size = ($1 -> size)*initializer_list_size;
		if(!in_param){
			array_case2 = 1;
		}
		///
		$$ ->place={$1->nodeLex,NULL};
		///
	}
	| direct_declarator '(' M8 M13 parameter_type_list M8 ')'        		{$$=make_node("direct_declarator",$1,$5);
		$$ -> nodeLex = $1 -> nodeLex;
		$$ -> nodeType = $1 -> nodeType;
		funcName = $1 -> nodeLex;
		//TODO:3ac
	}
	| direct_declarator '(' identifier_list ')'       		    {$$=make_node("direct_declarator",$1,$3);
		$$ -> nodeLex = $1 -> nodeLex;
		$$ -> nodeType = $1 -> nodeType;
		//TODO:3ac

	}
	| direct_declarator '(' M13 M3 ')'									{$$=make_node("direct_declarator",$1,make_node("()"));
		$$ -> nodeLex = $1 -> nodeLex;
		$$ -> nodeType = $1 -> nodeType;
		funcName = $1 -> nodeLex;
		//TODO:3ac

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
		$$->nextlist=$1 -> nextlist;
	}
	;

parameter_list
	: parameter_declaration										{$$=$1;}
	| parameter_list ',' M parameter_declaration                 	{$$=make_node("parameter_list",$1,$4);
		///
		backpatch($1->nextlist,$3);
		$$->nextlist=$4->nextlist;
		///
	}
	;

parameter_declaration
	: declaration_specifiers  declarator                  		{$$=make_node("parameter_declaration",$1,$2);
		$$ -> size = $2 -> size;
		s_entry* find = lookup_in_curr($2 -> nodeLex);
		if(find){
			yyerror("Error: redeclaration of variable.");
		}
		else{
			make_symTable_entry2(temp_table,$2 -> nodeLex,$2 -> nodeType,1,$$ -> size);
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
	| '{' initializer_list ',' '}'									{$$=make_node("initializer",$2,make_node($3));
		
		// $$->nodeType = $2 -> nodeType+"*"; //same in above //!doubt
		///
		 $$->place=$2 -> place;
		 $$->nextlist=$2 -> nextlist;
		///
	}
	;

initializer_list
	: initializer											{$$=$1;
		initializer_list_size++;
	}
	| initializer_list ',' M initializer						{$$=make_node("initializer_list",$1,$4);
		initializer_list_size++;
		///
		 backpatch($1->nextlist,$3);
		 $$->nextlist=$4 -> nextlist;
		///
	}
	;

statement
	: labeled_statement												{$$=$1; }
	| M12 M9 compound_statement M9									{$$=$3; $$->is_case=0;}
	| expression_statement											{$$=$1; $$->is_case=0;}
	| selection_statement											{$$=$1; $$->is_case=0;}
	| iteration_statement											{$$=$1; $$->is_case=0;}
	| jump_statement												{$$=$1; $$->is_case=0;}
	;

M9
	:%empty		{
		simple_block = 1 - simple_block;
	}
labeled_statement
	: IDENTIFIER ':' M statement			 		 {$$=make_node("labeled_statement",make_node($1),$4);
		///
		if(label_map.find(string($1)) != label_map.end()){
			yyerror("use of duplicate label");
		}else{
			label_map[string($1)] = $3;
			backpatch(label_list_map[string($1)],$3);
		}
		 $$->nextlist=$4 -> nextlist;
		$$->caselist = $4->caselist;
		 $$->continuelist = $4->continuelist;
		 $$->breaklist = $4->breaklist;
		///
	
	}
	| CASE constant_expression ':' statement   	 {$$=make_node("labeled_statement",make_node("case"),$2,$4);
		//Todo:3ac
	
	}
	| DEFAULT ':' statement   			  		 {$$=make_node("labeled_statement",make_node("default"),$3);
		///
		$$->nextlist=$3 -> nextlist;
		$$->continuelist = $3->continuelist;
		$$->breaklist = $3->breaklist;
		///
	}
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
		curr_array_arg_table = parent_array_arg_table[curr_array_arg_table];
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
		curr_array_arg_table = parent_array_arg_table[curr_array_arg_table];
		curr_struct_table = struct_parent[curr_struct_table];
		$$->nextlist = $3->nextlist;
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
		curr_array_arg_table = parent_array_arg_table[curr_array_arg_table];
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
		curr_array_arg_table = parent_array_arg_table[curr_array_arg_table];
		curr_struct_table = struct_parent[curr_struct_table];
		$$->nextlist = $4->nextlist;
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
	| statement_list M statement								{$$=make_node("statement_list",$1,$3);
	$$->nextlist = $3->nextlist;
	$$->continuelist = $1->continuelist; $$->continuelist.merge($3->continuelist);
	$$->breaklist = $1->breaklist ; $$->breaklist.merge($3->breaklist );
	backpatch($1->nextlist,$2);
	
	}
	;



expression_statement
	: ';'														{$$=make_node(";"); is_logical = 2;}
	| expression ';'											{$$=$1;// complete typechecking
	}
	;

N1
	: %empty{
		//if(is_logical == 0){
		if(is_logical == 0){
			emit({"if_goto",NULL},{"",NULL},{"",NULL},{"",NULL});
			emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
		}
		if(is_logical == 2){
			emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
		}
		$$ = (int)emitted_code.size();
	}
	;

N2
	: %empty{
		emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
		$$ = (int)(emitted_code.size() - 1);
		// return (int)(emitted_code.size()-1);
	}
	;

selection_statement
	: IF '(' expression ')' N1 statement               		{$$=make_node("IF (expr) stmt",$3,$6);
	///
	//cout<<"hello........................................\n";
	//if($6->stmtType )
		if(is_logical == 0){
			emitted_code[$5-2].op_1 = $3->place;
			//emitted_code[$5-2].result = $5;
			$3->truelist.push_back($5-2);
			$3->falselist.push_back($5-1);
		}
		$$->nextlist = $6->nextlist;
		$$->nextlist.merge($3->falselist);
		//for(auto x:$$->nextlist){
		//	cout<<x<<' ';
		//}
		//cout<<"............................................\n";
		backpatch($3->truelist,$5);
		$$->breaklist = $6->breaklist;
		$$->continuelist = $6->continuelist;
	///
	}
	| IF '(' expression ')' N1 statement N2  ELSE statement     	{$$=make_node("IF (expr) stmt ELSE stmt",$3,$6,$9);
		if(is_logical == 0){
			emitted_code[$5-2].op_1 = $3->place;
			//emitted_code[$5-2].result = $5;
			$3->truelist.push_back($5-2);
			$3->falselist.push_back($5-1);
		}
		$6->nextlist.push_back($7);
		backpatch($3->truelist,$5);
		backpatch($3->falselist,$7);
		$$->nextlist = $6->nextlist;
		$$->nextlist.merge($9->nextlist);
		$$->breaklist = $6->breaklist; $$->breaklist.merge($9->breaklist);
		$$->continuelist = $6->continuelist; $$->continuelist.merge($9->continuelist);

	}
	| SWITCH '(' expression ')' statement              	 	{$$=make_node("SWITCH (expr) stmt",$3,$5);}
	;

iteration_statement
	: WHILE '(' M expression ')' N1 statement                                     	{$$=make_node("WHILE (expr) stmt",$4,$7);
	//: WHILE '(' M expression ')' N1 statement N2                                      	{$$=make_node("WHILE (expr) stmt",$4,$7);
	///
		emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
		//cout<<is_logical<<"is I am coming here....................................\n";
		if(is_logical == 0){
			emitted_code[$6-2].op_1 = $4->place;
			//emitted_code[$6-2].result = $6;
			$4->truelist.push_back($6-2);
			$4->falselist.push_back($6-1);
		}
		$7->continuelist.push_back((int)emitted_code.size()-1);
		$7->continuelist.merge($7->nextlist);
		//for(auto x:$7->nextlist){
		//	cout<<x<<' ';
		//}
		//cout<<"............................................\n";

		backpatch($4->truelist,$6);
		backpatch($7->continuelist,$3);
		$$->nextlist = $4->falselist;
		$$->nextlist = $7->breaklist;
	///
	}

	| DO M statement N2 WHILE '(' M expression N1 ')' ';'			                            {$$=make_node("DO stmt WHILE (expr)",$3,$8);
		if(is_logical == 0){
			emitted_code[$9-2].op_1 = $8->place;
			//emitted_code[$8-2].result = $6;
			$8->truelist.push_back($9-2);
			$8->falselist.push_back($9-1);
		}
		$3->continuelist.push_back($4);
		$3->continuelist.merge($3->nextlist);
		backpatch($8->truelist,$2);
		backpatch($3->continuelist,$7);
		$$->nextlist = $8->falselist;
		$$->nextlist.merge($3->breaklist);

	}
	| FOR '(' expression_statement M expression_statement N1 ')' statement N2              {$$=make_node("FOR (expr_stmt expr_stmt) stmt",$3,$5,$8);
		//need to deal with 2 cases,; and exp;
		if(is_logical == 0){
			emitted_code[$6-2].op_1 = $5->place;
			//emitted_code[$8-2].result = $6;
			$5->truelist.push_back($6-2);
			$5->falselist.push_back($6-1);
		}
		if(is_logical == 2){
			$5->truelist.push_back($6-1);
		}
		$8->continuelist.merge($8->nextlist);
		$8->continuelist.push_back($9);
		backpatch($8->continuelist,$4);
		backpatch($5->truelist,$6);
		$$->nextlist = $5->falselist;
		$$->nextlist.merge($8->breaklist);

	}
	| FOR '(' expression_statement M expression_statement N1 expression N2 ')' statement N2   {$$=make_node("FOR (expr_stmt expr_stmt expr) stmt",$3,$5,$7,$10);
		if(is_logical == 0){
			emitted_code[$6-2].op_1 = $5->place;
			//emitted_code[$8-2].result = $6;
			$5->truelist.push_back($6-2);
			$5->falselist.push_back($6-1);
		}
		if(is_logical == 2){
			$5->truelist.push_back($6-1);
		}
		$10->continuelist.merge($10->nextlist);
		$10->continuelist.push_back($11);
		backpatch($10->continuelist,$6);
		$7->nextlist.push_back($8);
		backpatch($7->nextlist,$4);
		backpatch($5->truelist,$8+1);
		$$->nextlist = $5->falselist;
		$$->nextlist.merge($10->breaklist);
	}
	;

jump_statement
	: GOTO IDENTIFIER ';'						{$$=make_node("jump_statement",make_node($1),make_node($2));
	string s($2);
	emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
	if(label_map.find(s) != label_map.end()){
		label_map[s];
		
		emitted_code[(int)emitted_code.size()-1].result = {to_string(label_map[s]),NULL};
	}else{
		label_list_map[s].push_back((int)emitted_code.size()-1);
	}
	}
	| CONTINUE ';'						        {$$=make_node("continue");
		emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
		$$->continuelist.push_back((int)emitted_code.size()-1);
	}
	| BREAK ';'						            {$$=make_node("break");
		emit({"goto",NULL},{"",NULL},{"",NULL},{"",NULL});
		$$->breaklist.push_back((int)emitted_code.size()-1);
	}
	| RETURN ';'						        {$$=make_node("return");
		return_type = "void";
		///todo:
	}
	| RETURN expression ';'						{$$=make_node("jump_statement",make_node("return"),$2);
		return_type = $2 -> nodeType;
		///todo:
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
				 make_symTable_entry($2 -> nodeLex,$2 -> nodeType,0,$2 -> size);
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
		accept2 = 0;
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
				 make_symTable_entry($1 -> nodeLex,"int",0,get_size("int"));
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
		accept2 = 0;
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
		offset_table[curr_table] = 0;
		array_arg_table * temp3 = new array_arg_table;
		parent_array_arg_table[temp3] = curr_array_arg_table;
		curr_array_arg_table = temp3;
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
		offset_table[curr_table] = 0;
		array_arg_table * temp3 = new array_arg_table;
		parent_array_arg_table[temp3] = curr_array_arg_table;
		curr_array_arg_table = temp3;
		if(is_union2){
			symTable_type[curr_table] = "union";
		}
		else{
			symTable_type[curr_table] = "struct";
		}
		is_union2 = 0;
	}
	;
M12
	:%empty		{
		symTable * temp = new symTable();
		struct_table * temp2 = new struct_table();
		struct_parent.insert({temp2,curr_struct_table});
		curr_struct_table = temp2;
		parent.insert({temp,curr_table});
		offset_table[temp] = offset_table[curr_table];
		curr_table = temp;
		symTable_type[curr_table] = "block";
		array_arg_table * temp3 = new array_arg_table;
		parent_array_arg_table[temp3] = curr_array_arg_table;
		curr_array_arg_table = temp3;
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
		offset_table[curr_table] = 0;
		array_arg_table * temp3 = new array_arg_table;
		parent_array_arg_table[temp3] = curr_array_arg_table;
		curr_array_arg_table = temp3;
	}
	;
M14
	:declaration_specifiers declarator		{ $$ = make_node("Marker14",$1,$2);
		$$ -> nodeType = $1 -> nodeType;
		if(funcMap.find($2 -> nodeLex) == funcMap.end()){
			if(!lookup($2 -> nodeLex)){
				 funcMap.insert({$2 -> nodeLex,funcArg});
				 make_symTable_entry($2 -> nodeLex,$2 -> nodeType,0,$2 -> size);
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
		accept2 = 0;
	}
	;
M15
	:declarator		{
		$$ = $1;
		if(funcMap.find($1 -> nodeLex) == funcMap.end()){
			if(!lookup($1 -> nodeLex)){
				 funcMap.insert({$1 -> nodeLex,funcArg});
				 make_symTable_entry($1 -> nodeLex,"int",0,get_size("int"));
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
		accept2 = 0;
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
	
	symTable_type[GST] = "global_table";

	printSymTable(GST,"Global","",st_line_no.back(),yylineno);

	freopen("3ac_code.txt","w",stdout);
	print_code();
} 