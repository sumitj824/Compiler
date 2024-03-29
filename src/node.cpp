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


node* make_node(char *str,node* x1, node* x2,node* x3,node* x4)
{   
    node *n=new node;
    n -> is_union = 2;
    string s(str);
    stringstream ss;
    if(!x1)
    {
        for(int i=0; i <s.size(); i++)
        {
            if(s[i]=='\\')
            { 
                char t = '\\';
                ss << t;
            }
            ss <<s[i];
        }
        s = ss.str();
    }

    if(str[0] == '"'){
        s="\\\""+s.substr(1,s.size()-2)+"\\\"";
        strcpy(str,s.c_str());
    }
    n->name=str;
    n->id=getNodeId();
    printf("\t%d [label=\"%s\"; style=filled; color=\"#cfe2f3\"];\n",n->id,n->name);
    if(x1)printf("\t%d -> %d;\n", n->id, x1->id);
    if(x2)printf("\t%d -> %d;\n", n->id, x2->id);
    if(x3)printf("\t%d -> %d;\n", n->id, x3->id);
    if(x4)printf("\t%d -> %d;\n", n->id, x4->id);
    return n;
}
