#include"node.h"


int nodeId=0;

int getNodeId()
{
    nodeId++;
    return nodeId;
}

void BeginGraph()
{
    cout<<"digraph G{\n";
}

void EndGraph()
{
    cout<<"}\n";
}


node* terminal(char *str)
{
    node *n= new node;
    n->name=str;
    n->id=getNodeId();
    printf("\t%d [label=\"%s\"];\n",n->id,n->name);
}

