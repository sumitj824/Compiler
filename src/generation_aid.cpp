#include "generation_aid.h"

map <string, vector <string>> assembly_code;

void push_line(string s){
    assembly_code[curr_Func].push_back(s);
    // cout << s << endl;
}