#include "3ac.h"

extern string curr_Func;

extern map <string,vector <string>> assembly_code;

extern vector <quad> parameters;

void push_line(string s);

bool is_array_element(comp q);

void load_array_element0(comp q);

void load_array_element1(comp q);

void load_array_element2(comp q);

bool is_parameter(string name);

string get_array_name(string s);