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
            //TODO:
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



string addition(string t1,string t2)
{
    if(isNum(t1) && isNum(t2))
    {
        if(isInt(t1) && isInt(t2))return "int";
        return "float";
    }

    else if(t1=="char" && isInt(t2)) return "char";
    else if(t2=="char" && isInt(t1)) return "char";
    else if(t1.back()=='*' && isInt(t2)) return t1;
    else if(t2.back()=='*' && isInt(t1)) return t2;
    else return NULL;

}


string relational(string t1,string t2)
{
    if(isNum(t1) || t1=="char")
    {
        if(isNum(t2) || t2=="char") return "bool";
        else if(t2.back()=='*'){
            if(isFloat(t1))return NULL;
            return "Bool";
        }
    }
    if(t1.back()=='*'){
        if(isInt(t2) || t2="char")return "Bool";
    }
    return NULL;
}


string equality(string t1,string t2)
{
    if(isNum(t1) && isNum(t2))return "bool";
    if(t1==t2) return "bool";
    if(t1.back()=='*' && isInt(t2))return "Bool";
    if(t2.back()=='*' && isInt(t1))return "Bool";
    return NULL;
}



string bitwise(string t1,string t2)
{
    if(t1=="bool" && t2=="bool")return "bool";
    if((isInt(t1) || t1=="bool") && (isInt(t2) || t2=="bool"))return "Bool";
    return NULL;
}


string conditional(string t1,string t2)
{

}


string assign(string t1,string t2,string op)
{

}