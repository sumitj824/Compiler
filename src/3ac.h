#include "symtable.h"
#include <vector>

typedef pair<string,s_entry*> comp;

typedef struct{
    comp op_code;
    comp op_1;
    comp op_2;
    comp result;
    int num;
}quad;

extern vector <quad> code;