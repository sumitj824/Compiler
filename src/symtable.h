#include <iostream>
#include <string>
#include <map>
using namespace std;


typedef struct symEntry{
    string type;
    int init;

}s_entry;
// curr_scope struct name -> {id,0/1}, map
// curr_scope -> previous_scope -> previous_scope
typedef map<string,s_entry*> symTable;
typedef map<string,pair <int,int>> struct_table;
extern map<symTable*,symTable*> parent;
extern map<string,string> funcMap;
extern symTable *curr_table;
extern symTable *GST;
extern struct_table* curr_struct_table;// struct_id[name] -> id
extern map<struct_table*,struct_table*> struct_parent;

s_entry* lookup(string a);

void make_symTable_entry(string name,string type,int init);
void make_symTable_entry2(symTable * table,string name,string type,int init);
s_entry* lookup_in_curr(string a);
int lookup_in_struct_curr_scope(string a); // returns a flag 0/1
int lookup_struct(string a,int is_union); // returns id of struct


