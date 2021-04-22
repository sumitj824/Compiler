#include <vector>
#include <string>
#include <list>
using namespace std;

typedef struct{
    string name;
    unsigned long long int offset;
    int size;
} comp;


typedef struct{
    comp op_code;
    comp op_1;
    comp op_2;
    comp result;
    int num;
}quad;

extern vector <quad> emitted_code;
int emit(comp op_code,comp op_1,comp op_2,comp result);
void backpatch(list<int> l,int to_addr);
comp get_temp_label();
void print_code();