struct x{
    int a;
    int b;
};

int main(){
    struct x a;
    struct x *b = &a;
    b -> a = 3;
    b -> b = 5;
    printf(a.a);//3
    prints("\n");
    printf(a.b);//5
    prints("\n");
    a.a = 7;
    a.b = 9;
    printf(b -> a);//7
    prints("\n");
    printf(b -> b);//9
    return 0;
}