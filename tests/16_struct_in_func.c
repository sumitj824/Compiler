
struct product{
    int a;
    char c;
    int b;
};

union value{
    int x;
    int y;
    char z;
};

struct product func1(struct product p,union value v)
{
    p.a=v.x;
    p.c=v.z;
    return p;
}

union value func2(struct product p,union value v)
{
    v.x=p.a;
    v.y=p.b;
    v.z=p.c;
    return v;
}



int main(){
    struct product p;
    union value v;
    p.a=1;
    p.b=2;
    p.c='c';
    v.x=10;
    v.y=20;
    v.z='C';
    func1(p,v);
    func2(p,v);
}