#include"node.h"


int nodeId=0;

int getNodeId()
{
    nodeId++;
    return nodeId;
}

void BeginGraph()
{
    printf("digraph G{\n");
}

void EndGraph()
{
    printf("}\n");
}


struct node* terminal(char *str)
{
    struct node *n=(struct node *)malloc(sizeof(struct node));
    n->name=str;
    n->id=getNodeId();
    printf("\t%d [label=\"%s\"];\n",n->id,n->name);
    return n;
}


struct node* nonterminal1(char *str,struct node *x)
{
    struct node *n=(struct node *)malloc(sizeof(struct node));

    n->name=str;
    n->id=getNodeId();
    printf("\t%d [label=\"%s\"];\n",n->id,n->name);
    printf("\t%d -> %d;\n", n->id, x->id);
    return n;
}
struct node* nonterminal2(char *str,struct node *x1,struct node *x2)
{
    struct node *n=(struct node *)malloc(sizeof(struct node));
    n->name=str;
    n->id=getNodeId();
    printf("\t%d [label=\"%s\"];\n",n->id,n->name);
    printf("\t%d -> %d;\n", n->id, x1->id);
    printf("\t%d -> %d;\n", n->id, x2->id);
    return n;
   

}

struct node* nonterminal3(char *str,struct node *x1,struct node *x2,struct node* x3)
{
    struct node *n=(struct node *)malloc(sizeof(struct node));
    n->name=str;
    n->id=getNodeId();
    printf("\t%d [label=\"%s\"];\n",n->id,n->name);
    printf("\t%d -> %d;\n", n->id, x1->id);
    printf("\t%d -> %d;\n", n->id, x2->id);
    printf("\t%d -> %d;\n", n->id, x3->id);
    return n;


}

struct node* nonterminal4(char *str,struct node *x1,struct node *x2,struct node* x3,struct node *x4)
{
    struct node *n=(struct node *)malloc(sizeof(struct node));
    n->name=str;
    n->id=getNodeId();
    printf("\t%d [label=\"%s\"];\n",n->id,n->name);
    printf("\t%d -> %d;\n", n->id, x1->id);
    printf("\t%d -> %d;\n", n->id, x2->id);
    printf("\t%d -> %d;\n", n->id, x3->id);
    printf("\t%d -> %d;\n", n->id, x4->id);
    return n;
}
