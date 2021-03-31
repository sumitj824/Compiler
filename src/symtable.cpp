#include "symtable.h"

using namespace std;



map<symTable*,symTable*> parent;
symTable Global;
symTable *cur;






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

