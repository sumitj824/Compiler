#include <iostream>
#include <string>
#include <map>
using namespace std;


typedef struct symEntry{
    string type;
    int init;

}s_entry;

typedef map<string,s_entry*> symTable;
map<symTable*,symTable*> parent;



symTable Global;
symTable *cur;




