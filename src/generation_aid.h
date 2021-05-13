#include "3ac.h"

extern string curr_Func;

extern map <string,vector <string>> assembly_code;
extern map<int, string> basicBlock;

extern vector <quad> parameters;
extern set<s_entry*> global_entry_set;
extern string argument_label;

void push_line(string s);

bool is_array_element(string q);

void load_array_element0(comp q);

void load_array_element1(comp q);

void load_array_element2(comp q);

void load_normal_element0(comp q);

void load_normal_element1(comp q);

void load_normal_element2(comp q);

bool is_parameter(string name);

string get_array_name(string s);

void save_all_registers();

void load_prev_registers();

void print_assembly_code();

void formBasicBlocks();
int findNext(int addr);
void library_function_implementation();

void prints_implementation();
