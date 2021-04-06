#include "symtable.h"

using namespace std;



map<symTable*,symTable*> parent;
map<string,string> funcMap;
symTable *curr_table = new symTable();
symTable *GST = curr_table;
map<string,symTable*> struct_table;

void make_symTable_entry(string name,string type,int init){
   // cout << name << " with " << type << " init : " << init << endl;  
    s_entry * p = new s_entry();
    p -> type = type;
    p -> init = init;
    (*curr_table).insert({name,p});
}

void make_symTable_entry2(symTable* table,string name,string type,int init){
   // cout << name << " with " << type << " init : " << init << endl;  
    s_entry * p = new s_entry();
    p -> type = type;
    p -> init = init;
    (*table).insert({name,p});
}

s_entry* lookup(string a)
{
    symTable *t=curr_table;
    while(t!=NULL)
    {
        if((*t).count(a))return (*t)[a];
        t=parent[t];
    }
    return NULL;
}

s_entry* lookup_in_curr(string a){
    return (((*curr_table).find(a) == (*curr_table).end()) ? NULL : (*curr_table)[a]);
}

