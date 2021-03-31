#include <iostream>
#include <string>
#include <map>
using namespace std;


typedef struct symEntry{
    string type;
    int init;

}s_entry;

typedef map<string,s_entry*> symTable;
extern map<symTable*,symTable*> parent;



extern symTable Global;
extern symTable *cur;


s_entry* lookup(string a);


