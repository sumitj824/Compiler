#include "3ac.h"
#include "symtable.h"

#include <vector>
#include <list>

int var_counter = 0;
vector <quad> emitted_code;
map<string,int> label_map;
map<string,list<int>> label_list_map;

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
    for(auto x:l) emitted_code[x].result = {to_string(to_addr),NULL};
}

comp get_temp_label(string type){
    // comp p;
    // var_counter++;
    // p.name = "_t" + to_string(var_counter);
    // p.offset=0;
    // p.size=-1;

    var_counter++;
    string name = "_t" + to_string(var_counter);
    make_symTable_entry(name, type, 1, get_size(type));
    return make_pair(name,lookup(name));
}

void print_code(){
    for(auto x:emitted_code){
        cout<<x.op_code.first <<' '<<x.op_1.first<< ' ' << x.op_2.first<< ' '<<x.result.first<<endl;
    }
}








