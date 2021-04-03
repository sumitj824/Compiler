#include "type.h"
#include "symtable.h"

bool isInt(string t)
{
    if(t=="int" || t=="long" || t=="long long" || t=="long long int" || t=="long int")return 1;
    if(t=="signed int" || t=="signed long" || t=="signed long long" || t=="signed long long int" || t=="signed long int")return 1;
    if(t=="unsigned int" || t=="unsigned long" || t=="unsigned long long" || t=="unsigned long long int" || t=="unsigned long int")return 1;
    if(t=="short" || t=="short int" || t=="signed short" || t=="unsigned short" || t=="unsigned short int" || t=="signed short int")return 1;
    return 0;
}


bool isFloat(string t)
{
   if(t=="float" || t=="double" || t=="long double" || t=="unsigned float" || t=="unsigned double" ) return 1;
   if(t=="unsigned long double" || t=="signed float" ||t=="signed double" || t=="signed long double")return 1;
   return 0;
}


bool isNum(string t)
{
    return isInt(t) || isFloat(t);
}




string postfix(string t, int num)
{
    if(num==1)  // postfix_expression '[' expression ']' 
    {
        if(t.back()=='*')
        {
            t.back()='\0';
            return t;
        }
         return "";
    }
    if(num==2)
    {
        if(t.substr(0,5)=="FUNC_")
        {
            //TODO:
            t+=5;
            return t;
        }
         return "";
    }
    if (num==3)
    { // postfix_expression INC_OP/DEC_OP
	    if(isInt(t))
        {
	        return t;
	    } 
	    return "";
    }
    return t;

}



string multiply(string t1,string t2,char op)
{
    if(isNum(t1) && isNum(t2))
    {
        if(isInt(t1) && isInt(t2))return "int";
        if(op=='*' || op=='/')return "float";
    }
    return "";
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
    else return "";

}


string relational(string t1,string t2)
{
    if(isNum(t1) || t1=="char")
    {
        if(isNum(t2) || t2=="char") return "bool";
        else if(t2.back()=='*'){
            if(isFloat(t1))return "";
            return "Bool";
        }
    }
    if(t1.back()=='*'){
        if(isInt(t2) || t2=="char")return "Bool";
    }
    return "";
}


string equality(string t1,string t2)
{
    if(isNum(t1) && isNum(t2))return "bool";
    if(t1==t2) return "bool";
    if(t1.back()=='*' && isInt(t2))return "Bool";
    if(t2.back()=='*' && isInt(t1))return "Bool";
    return "";
}



string bitwise(string t1,string t2)
{
    if(t1=="bool" && t2=="bool")return "bool";
    if((isInt(t1) || t1=="bool") && (isInt(t2) || t2=="bool"))return "Bool";
    return "";
}


string condition(string t1,string t2)
{

    //TODO:
    return "";
}


string assign(string t1,string t2,string op)
{   
    //TODO:
    return "";
}