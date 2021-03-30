#include <iostream>
#include <string>
#include <map>
using namespace std;


typedef struct symEntry{
    string type;
    int init;

}entry;

typedef map<string,entry*> symTable;
map<symTable*,symTable*> parent;



symTable Global;
symTable *cur;




