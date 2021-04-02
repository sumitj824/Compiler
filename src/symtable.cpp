#include "symtable.h"

using namespace std;



map<symTable*,symTable*> parent;
symTable Global;
symTable *cur = new symTable();


void make_symTable_entry(string name,string type,int init){
    cout << name << " with " << type << " init : " << init << endl;  
    s_entry * p = new s_entry();
    p -> type = type;
    p -> init = init;
    (*cur).insert({name,p});
}



s_entry* lookup(string a)
{
    symTable *t=cur;
    while(t!=NULL)
    {
        if((*t).count(a))return (*t)[a];
        t=parent[t];
    }
    return NULL;
}