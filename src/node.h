#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include<sstream>
#include<string.h>
#include "codegeneration.h"
#include<list>

using namespace std;

typedef struct 
{
    int id;
    char * name;
    long long int ival;
    long double dval;
    char cval;
    string nodeType;
    string nodeLex;
    int init;
    int is_union;
    int size;
    unsigned long long int offset;
    int union_size;
    vector <int> dimensions;
    comp place;
    list<int> nextlist;
    list<int> breaklist;
    list<int> continuelist;
    list<int> caselist;
    list<int> truelist;
    list<int> falselist;
    int is_logical;
    int is_case;
}node;


int getNodeId();
void BeginGraph();
void EndGraph();
node* make_node(char *str,node* x1=NULL, node* x2=NULL,node* x3=NULL,node* x4=NULL);
