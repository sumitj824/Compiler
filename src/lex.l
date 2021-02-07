
D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			[Ee][+-]?{D}+
FS			(f|F|l|L)
IS			(u|U|l|L)*

%{
#include <stdio.h>
#include "y.tab.h"

void count();

%}

%%
"/*"			{ comment(); }
"//"			{single_line_comment(); }

"auto"			{ count(); printf("AUTO          ");  return(AUTO); }
"break"			{ count(); printf("BREAK         ");  return(BREAK); }
"case"			{ count(); printf("CASE          ");  return(CASE); }
"char"			{ count(); printf("CHAR          ");  return(CHAR); }
"const"			{ count(); printf("CONST         ");  return(CONST); }
"continue"		{ count(); printf("CONTINUE      ");  return(CONTINUE); }
"default"		{ count(); printf("DEFAULT       ");  return(DEFAULT); }
"do"			{ count(); printf("DO            ");  return(DO); }
"double"		{ count(); printf("DOUBLE        ");  return(DOUBLE); }
"else"			{ count(); printf("ELSE          ");  return(ELSE); }
"enum"			{ count(); printf("ENUM          ");  return(ENUM); }
"extern"		{ count(); printf("EXTERN        ");  return(EXTERN); }
"float"			{ count(); printf("FLOAT         ");  return(FLOAT); }
"for"			{ count(); printf("FOR           ");  return(FOR); }
"goto"			{ count(); printf("GOTO          ");  return(GOTO); }
"if"			{ count(); printf("IF            ");  return(IF); }
"int"			{ count(); printf("INT           ");  return(INT); }
"long"			{ count(); printf("LONG          ");  return(LONG); }
"register"		{ count(); printf("REGISTER      ");  return(REGISTER); }
"return"		{ count(); printf("RETURN        ");return(RETURN); }
"short"			{ count(); printf("SHORT         "); return(SHORT);}
"signed"		{ count(); printf("SIGNED        "); return(SIGNED);}
"sizeof"		{ count(); printf("SIZEOF        "); return(SIZEOF);}
"static"		{ count(); printf("STATIC        "); return(STATIC);}
"struct"		{ count(); printf("STRUCT        "); return(STRUCT);}
"switch"		{ count(); printf("SWITCH        "); return(SWITCH);}
"typedef"		{ count(); printf("TYPEDEF       "); return(TYPEDEF);}
"union"			{ count(); printf("UNION         "); return(UNION);}
"unsigned"		{ count(); printf("UNSIGNED      "); return(UNSIGNED);}
"void"			{ count(); printf("VOID          "); return(VOID);}
"volatile"		{ count(); printf("VOLATILE      "); return(VOLATILE);}
"while"			{ count(); printf("WHILE         "); return(WHILE);}

{L}({L}|{D})*	{ count(); printf("ID            "); return(check_type()); }

0[xX]{H}+{IS}?	{ count(); printf("CONSTANT      "); return(CONSTANT); }
0{D}+{IS}?		{ count(); printf("CONSTANT      "); return(CONSTANT); }
{D}+{IS}?		{ count(); printf("CONSTANT      "); return(CONSTANT); }
L?'(\\.|[^\\'])+'	{ count();printf("CONSTANT      "); return(CONSTANT); }

{D}+{E}{FS}?		{ count();printf("CONSTANT      "); return(CONSTANT); }
{D}*"."{D}+({E})?{FS}?	{ count();printf("CONSTANT      "); return(CONSTANT); }
{D}+"."{D}*({E})?{FS}?	{ count();printf("CONSTANT      "); return(CONSTANT); }

L?\"(\\.|[^\\"])*\"	{ count();printf("STRING_LITERAL"); return(STRING_LITERAL); }

"..."			{ count(); printf("ELLIPSIS      "); return(ELLIPSIS);}
">>="			{ count(); printf("RIGHT_ASSIGN	 "); return(RIGHT_ASSIGN);}
"<<="			{ count(); printf("LEFT_ASSIGN   "); return(LEFT_ASSIGN);}
"+="			{ count(); printf("ADD_ASSIGN    "); return(ADD_ASSIGN);}
"-="			{ count(); printf("SUB_ASSIGN    "); return(SUB_ASSIGN);}
"*="			{ count(); printf("MUL_ASSIGN    "); return(MUL_ASSIGN);}
"/="			{ count(); printf("DIV_ASSIGN    "); return(DIV_ASSIGN);}
"%="			{ count(); printf("MOD_ASSIGN    "); return(MOD_ASSIGN);}
"&="			{ count(); printf("AND_ASSIGN    "); return(AND_ASSIGN);}
"^="			{ count(); printf("XOR_ASSIGN    "); return(XOR_ASSIGN);}
"|="			{ count(); printf("OR_ASSIGN     "); return(OR_ASSIGN);}
">>"			{ count(); printf("RIGHT_OP      "); return(RIGHT_OP);}
"<<"			{ count(); printf("LEFT_OP       "); return(LEFT_OP);}
"++"			{ count(); printf("INC_OP        "); return(INC_OP);}
"--"			{ count(); printf("DEC_OP        "); return(DEC_OP);}
"->"			{ count(); printf("PTR_OP        "); return(PTR_OP);}
"&&"			{ count(); printf("AND_OP        "); return(AND_OP);}
"||"			{ count(); printf("OR_OP         "); return(OR_OP);}
"<="			{ count(); printf("LE_OP         ");return(LE_OP); }
">="			{ count(); printf("GE_OP         "); return(GE_OP);}
"=="			{ count(); printf("EQ_OP         "); return(EQ_OP);}
"!="			{ count(); printf("NE_OP         ");return(NE_OP); }
";"			{ count();     printf("%s             ",yytext); return(';'); }
("{"|"<%")	{ count();printf("%s             ",yytext); return('{'); }
("}"|"%>")	{ count();printf("%s             ",yytext); return('}'); }
","			{ count();printf("%s             ",yytext); return(','); }
":"			{ count();printf("%s             ",yytext); return(':'); }
"="			{ count();printf("%s             ",yytext); return('='); }
"("			{ count();printf("%s             ",yytext); return('('); }
")"			{ count();printf("%s             ",yytext); return(')'); }
("["|"<:")	{ count();printf("%s             ",yytext); return('['); }
("]"|":>")	{ count();printf("%s             ",yytext); return(']'); }
"."			{ count();printf("%s             ",yytext); return('.'); }
"&"			{ count();printf("%s             ",yytext); return('&'); }
"!"			{ count();printf("%s             ",yytext); return('!'); }
"~"			{ count();printf("%s             ",yytext); return('~'); }
"-"			{ count();printf("%s             ",yytext); return('-'); }
"+"			{ count();printf("%s             ",yytext); return('+'); }
"*"			{ count();printf("%s             ",yytext); return('*'); }
"/"			{ count();printf("%s             ",yytext); return('/'); }
"%"			{ count();printf("%s             ",yytext); return('%'); }
"<"			{ count();printf("%s             ",yytext); return('<'); }
">"			{ count();printf("%s             ",yytext); return('>'); }
"^"			{ count();printf("%s             ",yytext); return('^'); }
"|"			{ count();printf("%s             ",yytext); return('|'); }
"?"			{ count();printf("%s             ",yytext); return('?'); }

[ \t\v\n\f]		{ count(); }
.			{ count(); printf("UNKNOWN       "); return yytext[0]; }

%%

yywrap()
{
	return(1);
}

int column = 0;
int line=1;




comment()
{
	char c, c1;
	column+=2;
loop:
	while ((c = input()) != '*' && c != 0)
	{
		if (c == '\n')
			column = 0,line++;
		else if (c == '\t')
			column += 8 - (column % 8);
		else
			column++;
	}
	 if ((c1 = input()) != '/' && c != 0)
	{
		unput(c1);
		goto loop;
	}
	column +=2;


	/* if (c != 0)
		putchar(c1);  */
}

single_line_comment()
{
	char c;
	while ((c = input()) != '\n' && c != 0) ;
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

int main(int argc, char *argv[])
{	
	freopen(argv[1], "r",stdin);
	printf("Token			Lexeme 			Line#			Column#\n");
	
	int val;
	while((val = yylex())>0)
	{
		printf("	    	%s			%d                		%d \n",yytext,line,col_start);							
	}
}