

struct st
{
    int a;
    struct st *b;
};

int main(){
    struct st x,*y;
    x.a=5;
    x.b=y;
    return 0;
}