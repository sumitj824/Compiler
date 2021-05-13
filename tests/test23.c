struct x{
    int a;
    int b;
};

int main(){
    struct x a;
    struct x *b = &a;
    b -> a = 3;
    b -> b = 5;
    printf(a.a);
    prints("\n");
    printf(a.b);
    prints("\n");
    a.a = 7;
    a.b = 9;
    printf(b -> a);
    prints("\n");
    printf(b -> b);
    return 0;
}