#include "symtable.h"

using namespace std;



map<symTable*,symTable*> parent;
map<string,string> funcMap;
symTable *curr_table = new symTable();
symTable *GST = curr_table;
struct_table * curr_struct_table = new struct_table();
map <struct_table*,struct_table*> struct_parent;
map <string,symTable*> id_to_struct;
FILE * csv_output = fopen("csv_output.csv","w");

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

int lookup_in_struct_curr_scope(string a){
    if((*curr_struct_table).find(a) == (*curr_struct_table).end()){
        return false;
    }
    else{
        return true;
    }
}

int lookup_struct(string name,int is_union){
    struct_table * temp = curr_struct_table;
    while(temp){
        if((*temp).find(name) != (*temp).end()){
            if((*temp)[name].second == is_union){
                return (*temp)[name].first;
            }
            else{
                temp = struct_parent[temp];
            }
        }
        else{
            temp = struct_parent[temp];
        }
    }
    return 0;
}

void start_new_block(string block_name,string block_type,int line){
    fprintf(csv_output,"----------------------------------------------------------------\n");
    fprintf(csv_output,"              starting %s with type %s  at line  %d      \n",block_name.c_str(),block_type.c_str(),line);
    fprintf(csv_output,"----------------------------------------------------------------\n");
}

void printSymTable(symTable* table,string block_name,string block_type,int line){
    start_new_block(block_name,block_type,line);
    fprintf(csv_output,"Key,Type,Is_initialized\n");
    for(auto it : (*table)){
        fprintf(csv_output,"%s,%s,%d\n",(it.first).c_str(),((it.second) -> type).c_str(),(it.second) -> init);
    }
}

s_entry * lookup_in_table(symTable * table,string name){
    if((*table).count(name)){
        return (*table)[name];
    }
    else return NULL;
}

void update_init(string name,int init){
    s_entry * find = lookup(name);
    if(find){
        find -> init = init;
    }
    return;
}

int is_struct(string type1){
    if(type1 == ""){
        return false;
    }
    for(char a : type1){
        if(a >= '0' && a <= '9'){

        }
        else{
            return false;
        }
    }
    return true;
}

int check_type(string type1,string type2){
    if(is_struct(type1) || is_struct(type2)){
        return type1 == type2;
    }
    else{
        return true;
    }
}