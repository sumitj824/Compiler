void g(int a[]){
    a[2] = 3;
    return;
}

void f(int a[]){
    g(a);
    return;
}

int main(){
    int a[5];
    a[2] = 1;
    printf(a[2]);
    f(a);
    printf(a[2]);
    return 0;
}