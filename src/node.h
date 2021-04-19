#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include<sstream>
#include<string.h>
#include "3ac.h"
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


    comp place;
    list<int> nextlist;
    list<int> breaklist;
    list<int> continuelist;
    list<int> caselist;
}node;


int getNodeId();
void BeginGraph();
void EndGraph();
node* make_node(char *str,node* x1=NULL, node* x2=NULL,node* x3=NULL,node* x4=NULL);
