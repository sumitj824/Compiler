#include<stdio.h>
#include<stdlib.h>
#include<string.h>

struct node
{
    int id;
    char * name;
};


int getNodeId();
void BeginGraph();
void EndGraph();
struct node* terminal(char *str);
struct node* nonterminal1(char *str,struct node *x);
struct node* nonterminal2(char *str,struct node *x1,struct node *x2);
struct node* nonterminal3(char *str,struct node *x1,struct node *x2,struct node* x3);
struct node* nonterminal4(char *str,struct node *x1,struct node *x2,struct node* x3,struct node *x4);

