#include <iostream>
#include <string>
#include <map>
#include <list>
#include <vector>
#include <set>
using namespace std;


typedef struct symEntry{
    string type;
    int init;
    int size;
    unsigned long long int offset;
}s_entry;
// curr_scope struct name -> {id,0/1}, map
// curr_scope -> previous_scope -> previous_scope
typedef map<string,s_entry*> symTable;
typedef map<string,pair <int,int>> struct_table;
typedef map<string,vector <int>> array_arg_table;
extern map<symTable*,symTable*> parent;
extern map<string,string> funcMap;
extern symTable *curr_table;
extern symTable *GST;
extern struct_table* curr_struct_table;// struct_id[name] -> id
extern map<struct_table*,struct_table*> struct_parent;
extern map<string,symTable*> id_to_struct;
extern FILE * csv_output;
extern map <symTable*,string> symTable_type;
extern map <string,string> id_to_struct_name;
extern map <string,int> structSize;
extern map <symTable*,unsigned long long int> offset_table;
extern array_arg_table * curr_array_arg_table;
extern map <array_arg_table*,array_arg_table*> parent_array_arg_table;
extern map <s_entry*,vector <int>> array_symTable_entry;
extern map <string,int> funcSize;
extern map <string,string> funcParams;
extern string funcName;
extern set <s_entry*> temp_global_set;

s_entry* lookup(string a);

void make_symTable_entry(string name,string type,int init,int size);
void make_symTable_entry2(symTable * table,string name,string type,int init,int size);
s_entry* lookup_in_curr(string a);
int lookup_in_struct_curr_scope(string a); // returns a flag 0/1
int lookup_struct(string a,int is_union); // returns id of struct
void printSymTable(symTable* tablem,string block_name,string block_type,int startline,int endline);
s_entry * lookup_in_table(symTable *table,string name);
void update_init(string name,int init);
int check_type(string type1,string type2);
int is_struct(string type1);
int get_size(string type);
int is_global(s_entry * temp);