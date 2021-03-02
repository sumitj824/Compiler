#include<iostream>
#include<stdio.h>
#include<string>

using namespace std;

struct node
{
    int id;
    string name;
    char *str;
};


int getNodeId();
void BeginGraph();
void EndGraph();
node* terminal(char *str);