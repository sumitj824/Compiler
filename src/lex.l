
D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			[Ee][+-]?{D}+
FS			(f|F|l|L)
IS			(u|U|l|L)*

%{
#include<iostream>
#include <stdio.h>
#include "node.h"
#include "y.tab.h"
void yyerror(char *s);
void count();
void comment();
void single_line_comment();
int check_type();
%}

%%
"/*"			{ comment(); }
"//"			{single_line_comment(); }

"auto"			{ count(); yylval.str=strdup(yytext);  return(AUTO); }
"break"			{ count(); yylval.str=strdup(yytext);  return(BREAK); }
"case"			{ count(); yylval.str=strdup(yytext);  return(CASE); }
"char"			{ count(); yylval.str=strdup(yytext);  return(CHAR); }
"const"			{ count(); yylval.str=strdup(yytext);  return(CONST); }
"continue"		{ count(); yylval.str=strdup(yytext);  return(CONTINUE); }
"default"		{ count(); yylval.str=strdup(yytext);  return(DEFAULT); }
"do"			{ count(); yylval.str=strdup(yytext);  return(DO); }
"double"		{ count(); yylval.str=strdup(yytext);  return(DOUBLE); }
"else"			{ count(); yylval.str=strdup(yytext);  return(ELSE); }
"enum"			{ count(); yylval.str=strdup(yytext);  return(ENUM); }
"extern"		{ count(); yylval.str=strdup(yytext);  return(EXTERN); }
"float"			{ count(); yylval.str=strdup(yytext);  return(FLOAT); }
"for"			{ count(); yylval.str=strdup(yytext);  return(FOR); }
"goto"			{ count(); yylval.str=strdup(yytext);  return(GOTO); }
"if"			{ count(); yylval.str=strdup(yytext);  return(IF); }
"int"			{ count(); yylval.str=strdup(yytext);  return(INT); }
"long"			{ count(); yylval.str=strdup(yytext);  return(LONG); }
"register"		{ count(); yylval.str=strdup(yytext);  return(REGISTER); }
"return"		{ count(); yylval.str=strdup(yytext); return(RETURN); }
"short"			{ count(); yylval.str=strdup(yytext);  return(SHORT);}
"signed"		{ count(); yylval.str=strdup(yytext);  return(SIGNED);}
"sizeof"		{ count(); yylval.str=strdup(yytext); return(SIZEOF);}
"static"		{ count(); yylval.str=strdup(yytext);  return(STATIC);}
"struct"		{ count(); yylval.str=strdup(yytext); return(STRUCT);}
"switch"		{ count(); yylval.str=strdup(yytext); return(SWITCH);}
"typedef"		{ count(); yylval.str=strdup(yytext); return(TYPEDEF);}
"union"			{ count(); yylval.str=strdup(yytext); return(UNION);}
"unsigned"		{ count(); yylval.str=strdup(yytext); return(UNSIGNED);}
"void"			{ count(); yylval.str=strdup(yytext); return(VOID);}
"volatile"		{ count(); yylval.str=strdup(yytext); return(VOLATILE);}
"while"			{ count(); yylval.str=strdup(yytext); return(WHILE);}

{L}({L}|{D})*	{ count();yylval.str=strdup(yytext);  return(check_type()); }

0[xX]{H}+{IS}?	{ count();yylval.str=strdup(yytext);  return(CONSTANT); }
0{D}+{IS}?		{ count();yylval.str=strdup(yytext);  return(CONSTANT); }
{D}+{IS}?		{ count();yylval.str=strdup(yytext);  return(CONSTANT); }
L?'(\\.|[^\\'])+'	{ count();yylval.str=strdup(yytext); return(CONSTANT); }

{D}+{E}{FS}?		{ count();yylval.str=strdup(yytext); return(CONSTANT); }
{D}*"."{D}+({E})?{FS}?	{ count();yylval.str=strdup(yytext); return(CONSTANT); }
{D}+"."{D}*({E})?{FS}?	{ count();yylval.str=strdup(yytext); return(CONSTANT); }

L?\"(\\.|[^\\"])*\"	{ count();yylval.str=strdup(yytext); return(STRING_LITERAL); }

"..."			{ count();yylval.str=strdup(yytext);  return(ELLIPSIS);}
">>="			{ count();yylval.str=strdup(yytext);  return(RIGHT_ASSIGN);}
"<<="			{ count();yylval.str=strdup(yytext);  return(LEFT_ASSIGN);}
"+="			{ count();yylval.str=strdup(yytext);  return(ADD_ASSIGN);}
"-="			{ count();yylval.str=strdup(yytext);  return(SUB_ASSIGN);}
"*="			{ count();yylval.str=strdup(yytext);  return(MUL_ASSIGN);}
"/="			{ count();yylval.str=strdup(yytext);  return(DIV_ASSIGN);}
"%="			{ count();yylval.str=strdup(yytext);  return(MOD_ASSIGN);}
"&="			{ count();yylval.str=strdup(yytext);  return(AND_ASSIGN);}
"^="			{ count();yylval.str=strdup(yytext);  return(XOR_ASSIGN);}
"|="			{ count();yylval.str=strdup(yytext);  return(OR_ASSIGN);}
">>"			{ count();yylval.str=strdup(yytext);  return(RIGHT_OP);}
"<<"			{ count();yylval.str=strdup(yytext);  return(LEFT_OP);}
"++"			{ count();yylval.str=strdup(yytext);  return(INC_OP);}
"--"			{ count();yylval.str=strdup(yytext);  return(DEC_OP);}
"->"			{ count();yylval.str=strdup(yytext);  return(PTR_OP);}
"&&"			{ count();yylval.str=strdup(yytext);  return(AND_OP);}
"||"			{ count();yylval.str=strdup(yytext);  return(OR_OP);}
"<="			{ count();yylval.str=strdup(yytext); return(LE_OP); }
">="			{ count();yylval.str=strdup(yytext);  return(GE_OP);}
"=="			{ count();yylval.str=strdup(yytext);  return(EQ_OP);}
"!="			{ count();yylval.str=strdup(yytext); return(NE_OP); }
";"			{ count();yylval.str=strdup(yytext); return(';'); }
("{"|"<%")	{ count();yylval.str=strdup(yytext); return('{'); }
("}"|"%>")	{ count();yylval.str=strdup(yytext); return('}'); }
","			{ count();yylval.str=strdup(yytext); return(','); }
":"			{ count();yylval.str=strdup(yytext); return(':'); }
"="			{ count();yylval.str=strdup(yytext); return('='); }
"("			{ count();yylval.str=strdup(yytext); return('('); }
")"			{ count();yylval.str=strdup(yytext); return(')'); }
("["|"<:")	{ count();yylval.str=strdup(yytext); return('['); }
("]"|":>")	{ count();yylval.str=strdup(yytext); return(']'); }
"."			{ count();yylval.str=strdup(yytext); return('.'); }
"&"			{ count();yylval.str=strdup(yytext); return('&'); }
"!"			{ count();yylval.str=strdup(yytext); return('!'); }
"~"			{ count();yylval.str=strdup(yytext); return('~'); }
"-"			{ count();yylval.str=strdup(yytext); return('-'); }
"+"			{ count();yylval.str=strdup(yytext); return('+'); }
"*"			{ count();yylval.str=strdup(yytext); return('*'); }
"/"			{ count();yylval.str=strdup(yytext); return('/'); }
"%"			{ count();yylval.str=strdup(yytext); return('%'); }
"<"			{ count();yylval.str=strdup(yytext); return('<'); }
">"			{ count();yylval.str=strdup(yytext); return('>'); }
"^"			{ count();yylval.str=strdup(yytext); return('^'); }
"|"			{ count();yylval.str=strdup(yytext); return('|'); }
"?"			{ count();yylval.str=strdup(yytext); return('?'); }

[ \t\v\n\f]		{ count(); }
.			{ count();return yytext[0]; }

%%

int yywrap()
{
	return(1);
}

int column = 0;
int line=1;




void comment()
{
	char c, c1;
	column+=2;
loop:
	while ((c = yyinput()) != '*' && c != 0)
	{
		if (c == '\n')
			column = 0,line++;
		else if (c == '\t')
			column += 8 - (column % 8);
		else
			column++;
	}
	 if ((c1 = yyinput()) != '/' && c != 0)
	{
		unput(c1);
		goto loop;
	}
	column +=2;


	/* if (c != 0)
		putchar(c1);  */
}

void single_line_comment()
{
	char c;
	while ((c = yyinput()) != '\n' && c != 0) ;
	column=0;
	line++;
}	





int col_start = 0;
void count()
{
	int i;

	col_start =column+1;
	for (i = 0; yytext[i] != '\0'; i++)
	{	
		if (yytext[i] == '\n')
			column = 0,line++;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;
	}
	/* ECHO; */
}


int check_type()
{
	/*
	* pseudo code --- this is what it should check
	*
	*	if (yytext == type_name)
	*		return(TYPE_NAME);
	*
	*	return(IDENTIFIER);
	*/

	/*
	*	it actually will only return IDENTIFIER
	*/

	return(IDENTIFIER);
}

