struct x{
    int a;
    int b;
};

int main(){
    struct x a;
    struct x* b = &a;
    a.a = 5;
    a.b = 3;
    b = &a;
    a.a = 7;
    a.b = 9;
    printf(b -> a);
    printf(b -> b);
    return 0;
}