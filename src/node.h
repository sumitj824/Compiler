#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

using namespace std;

typedef struct 
{
    int id;
    char * name;
}node;


int getNodeId();
void BeginGraph();
void EndGraph();
node* terminal(char *str);
node* nonterminal1(char *str,node *x);
node* nonterminal2(char *str,node *x1,node *x2);
node* nonterminal3(char *str,node *x1,node *x2,node* x3);
node* nonterminal4(char *str,node *x1,node *x2,node* x3,node *x4);

