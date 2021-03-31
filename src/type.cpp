#include "type.h"
#include "symtable.h"



string postfix(string t, int num)
{
    if(num==1)  // postfix_expression '[' expression ']' 
    {
        if(t.back()=='*')
        {
            t.back()='\0';
            return t;
        }
         return NULL;
    }
    if(num==2)
    {
        if(t.substr(0,5)=="FUNC_")
        {
            t+=5;
            return t;
        }
         return NULL;
    }
    if (num==3)
    { // postfix_expression INC_OP/DEC_OP
	    if(isInt(t))
        {
	        return t;
	    } 
	    return NULL;
    }
    return t;

}


bool isNum(string t)
{
    return isInt(t) || isFloat(t);
}

string multiply(string t1,string t2,char op)
{
    if(isNum(t1) && isNum(t2))
    {
        if(isInt(t1) && isInt(t2))return "int";
        if(op=='*' || op=='/')return "float";
    }
    return NULL;
}