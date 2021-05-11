#include <vector>
#include <string>
#include <map>
#include <list>
#include <set>
#include "symtable.h"
using namespace std;

// typedef struct{
//     string name;
//     unsigned long long int offset;
//     int size;
// } comp;

typedef pair<string, s_entry *> comp;


typedef struct{
    comp op_code;
    comp op_1;
    comp op_2;
    comp result;
    int num;
}quad;

extern vector <quad> emitted_code;
extern map<string,int> label_map;
extern map<string,list<int>> label_list_map;
int emit(comp op_code,comp op_1,comp op_2,comp result);
void backpatch(list<int> l,int to_addr);
comp get_temp_label(string type);
void print_code();