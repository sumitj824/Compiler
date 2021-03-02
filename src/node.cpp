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


node *nonterminal1(char *str,node *x)
{
    node *n=new node;
    n->name=str;
    n->id=getNodeId();
    printf("\t%d [label=\"%s\"];\n",n->id,n->name);
    printf("\t%d -> %d;\n", n->id, x->id);
    return n;
}
node *nonterminal2(char *str,node *x1,node *x2)
{
    node *n=new node;
    n->name=str;
    n->id=getNodeId();
    printf("\t%d [label=\"%s\"];\n",n->id,n->name);
    printf("\t%d -> %d;\n", n->id, x1->id);
    printf("\t%d -> %d;\n", n->id, x2->id);
    return n;
}

node *nonterminal3(char *str,node *x1,node *x2,node* x3)
{
    node *n=new node;
    n->name=str;
    n->id=getNodeId();
    printf("\t%d [label=\"%s\"];\n",n->id,n->name);
    printf("\t%d -> %d;\n", n->id, x1->id);
    printf("\t%d -> %d;\n", n->id, x2->id);
    printf("\t%d -> %d;\n", n->id, x3->id);
    return n;
}


node *nonterminal4(char *str,node *x1,node *x2,node* x3,node *x4)
{
    node *n=new node;
    n->name=str;
    n->id=getNodeId();
    printf("\t%d [label=\"%s\"];\n",n->id,n->name);
    printf("\t%d -> %d;\n", n->id, x1->id);
    printf("\t%d -> %d;\n", n->id, x2->id);
    printf("\t%d -> %d;\n", n->id, x3->id);
    printf("\t%d -> %d;\n", n->id, x4->id);
    return n;
}