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
    for(auto x:l) emitted_code[x].result = {to_string(to_addr),0,0};
}

comp get_temp_label(){
    comp p;
    var_counter++;
    p.name = "_t" + to_string(var_counter);
    p.offset=0;
    p.size=-1;
    return p;
}

void print_code(){
    for(auto x:emitted_code){
        cout<<x.op_code.name <<' '<<x.op_1.name<< ' ' << x.op_2.name<< ' '<<x.result.name<<endl;
    }
}








