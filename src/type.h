#include <iostream>
#include <string>
using namespace std;




bool isInt(string t);
bool isFloat(string t);
bool isNum(string t);
string postfix(string t, int num);
string unary(string t, string op);
string multiply(string t1,string t2,char op);
string addition(string t1,string t2);
string relational(string t1,string t2);
string equality(string t1,string t2);
string bitwise(string t1,string t2);
string condition(string t1,string t2);
string validAssign(string t1,string t2);
string assign(string t1,string t2,string op);
int func_check(string user_arg,string func_arg);