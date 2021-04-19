#include "3ac.h"
#include "type.h"
#include <vector>
#include <list>

int var_counter = 0;

comp get_temp_label(string type){
    var_counter++;
    string var = "_t" + to_string(var_counter);
    make_symTable_entry(var,type,1);
    return {var,lookup(var)};
}

int emit(comp op_code,comp op_1,comp op_2,comp result, int num){
    quad p;
    p.op_code = op_code;
    p.op_1 = op_1;
    p.op_2 = op_2;
    p.result = result;
    p.num = num;
    code.push_back(p);
    return (int)code.size()-1;
    //to do: could be changed as num could be of no use
}

void backpatch(list<int> l,int to_addr){
    for(auto x:l) code[x].num = to_addr;
}








