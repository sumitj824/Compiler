#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include<sstream>
#include<string.h>

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
}node;


int getNodeId();
void BeginGraph();
void EndGraph();
node* make_node(char *str,node* x1=NULL, node* x2=NULL,node* x3=NULL,node* x4=NULL);
