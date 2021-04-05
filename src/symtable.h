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
extern map<string,symTable*> struct_table;
extern symTable *curr_table;
extern symTable *GST;

s_entry* lookup(string a);

void make_symTable_entry(string name,string type,int init);
void make_symTable_entry2(symTable * table,string name,string type,int init);
string convert_to_string(int n);
s_entry* lookup_in_curr(string a);


