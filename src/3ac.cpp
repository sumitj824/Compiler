#include "3ac.h"
#include "symtable.h"

#include <vector>
#include <list>

int var_counter = 0;
vector <quad> emitted_code;

int emit(comp op_code,comp op_1,comp op_2,comp result){
    quad p;
    p.op_code = op_code;
    p.op_1 = op_1;
    p.op_2 = op_2;
    p.result = result;
    emitted_code.push_back(p);
    return (int)emitted_code.size()-1;
    //to do: could be changed as num could be of no use
    //todo : not storing statement number
}


void backpatch(list<int> l,int to_addr){
    for(auto x:l) emitted_code[x].num = to_addr;
}

comp get_temp_label(string type){
    comp p;
    var_counter++;
    p.name = "__t" + to_string(var_counter)+"__";
    // make_symTable_entry2(GST,p.name,type,0,get_size(type));
    s_entry * find = lookup(p.name);
    p.offset=find->offset;
    p.size=find->size;
    return p;
}








