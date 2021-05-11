#include "symtable.h"

using namespace std;



map<symTable*,symTable*> parent;
map<string,string> funcMap;
symTable *curr_table = new symTable();
symTable *GST = curr_table;
struct_table * curr_struct_table = new struct_table();
map <struct_table*,struct_table*> struct_parent;
map <string,symTable*> id_to_struct;
FILE * csv_output = fopen("All_symbolTable.txt","w");
map <symTable*,string> symTable_type;
map <string,string> id_to_struct_name;
map <string,int> structSize;
map <symTable*,unsigned long long int> offset_table;
array_arg_table * curr_array_arg_table = new array_arg_table();
map <array_arg_table*,array_arg_table*> parent_array_arg_table;
map <string,int> funcSize;
map <s_entry*,vector <int>> array_symTable_entry;
map <string,string> funcParams;
string funcName = "";

void make_symTable_entry(string name,string type,int init,int size){
   // cout << name << " with " << type << " init : " << init << endl;  
    s_entry * p = new s_entry();
    p -> type = type;
    p -> init = init;
    p -> size = size;
    if(symTable_type[curr_table] == "union"){
        p -> offset = 0;
    }
    else{
        p -> offset = offset_table[curr_table];
        offset_table[curr_table] += size;
    }
    if((*curr_array_arg_table).count(name)){
        string temp_type = type;
        vector <int> temp = (*curr_array_arg_table)[name];
        int i = 0;
        while(i < temp.size()){
            temp_type.pop_back();
            i++;
        }
        (*curr_array_arg_table)[name].push_back(get_size(temp_type));
        array_symTable_entry[p] = (*curr_array_arg_table)[name];
    }
    (*curr_table).insert({name,p});
    funcSize[funcName] += size;
}

void make_symTable_entry2(symTable* table,string name,string type,int init,int size){
   // cout << name << " with " << type << " init : " << init << endl;  
    s_entry * p = new s_entry();
    p -> type = type;
    p -> init = init;
    p -> size = size;
    if(symTable_type[table] == "union"){
        p -> offset = 0;
    }
    else{
        p -> offset = offset_table[table];
        offset_table[table] += size;
    }
    if((*curr_array_arg_table).count(name)){
        string temp_type = type;
        vector <int> temp = (*curr_array_arg_table)[name];
        int i = 0;
        while(i < temp.size()){
            temp_type.pop_back();
            i++;
        }
        (*curr_array_arg_table)[name].push_back(get_size(temp_type));
        array_symTable_entry[p] = (*curr_array_arg_table)[name];
    }
    (*table).insert({name,p});
    funcSize[funcName] += size;
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

void start_new_block(string block_name,string block_type,int sline,int eline){
    fprintf(csv_output,"\n_________________________________________________________________\n");
    fprintf(csv_output,"      %s with type %s  from line %d  to line %d        \n",block_name.c_str(),block_type.c_str(),sline,eline);
    fprintf(csv_output,"-----------------------------------------------------------------\n");
}

void printSymTable(symTable* table,string block_name,string block_type,int sline,int eline){
    start_new_block(block_name,symTable_type[table],sline,eline);
    fprintf(csv_output,"%-25s%-25s%-25s%-25s%-25s\n\n","Key","Type","Is_initialized","Size","Offset");
    for(auto it : (*table)){
        string type = (it.second) -> type;
        if(id_to_struct_name.count(type)){
            type = id_to_struct_name[type];
        }
        fprintf(csv_output,"%-25s%-25s%-25d%-25d%-25lld\n",(it.first).c_str(),type.c_str(),(it.second) -> init,(it.second -> size),(it.second) -> offset);
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

int get_size(string type){
    if(structSize.count(type)) return structSize[type];
    // if(type ==  "int") return sizeof(int);
    // if(type ==  "long int") return sizeof(long int);
    // if(type ==  "long long") return sizeof(long long);
    // if(type ==  "long long int") return sizeof(long long int);
    // if(type ==  "unsigned int") return sizeof(unsigned int);
    // if(type ==  "unsigned long int") return sizeof(unsigned long int);
    // if(type ==  "unsigned long long") return sizeof(unsigned long long);
    // if(type ==  "unsigned long long int") return sizeof(unsigned long long int);
    // if(type ==  "signed int") return sizeof(signed int);
    // if(type ==  "signed long int") return sizeof(signed long int);
    // if(type ==  "signed long long") return sizeof(signed long long);
    // if(type ==  "signed long long int") return sizeof(signed long long int);
    // if(type ==  "short") return sizeof(short);
    // if(type ==  "short int") return sizeof(short int);
    // if(type ==  "unsigned short int") return sizeof(unsigned short int);
    // if(type ==  "signed short int") return sizeof(signed short int);


    // //float
    // if(type ==  "float") return sizeof(float);
    // if(type ==  "double") return sizeof(double);
    // if(type ==  "long double") return sizeof(long double);
    // // char 
    // if(type ==  "char") return sizeof(char);

    return 4;
}