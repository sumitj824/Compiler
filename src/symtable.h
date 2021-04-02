#include <iostream>
#include <string>
#include <map>
using namespace std;


typedef struct symEntry{
    string type;
    int init;

}s_entry;

typedef map<string,s_entry*> symTable;
extern map<symTable*,symTable*> parent;
extern map<string,string> funcMap;
extern symTable *curr_table;

s_entry* lookup(string a);

void make_symTable_entry(string name,string type,int init);

s_entry* lookup_in_curr(string a);


