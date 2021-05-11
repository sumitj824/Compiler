void f(int a[5]){
    a[2] = 1;
    return;
}

int main(){
    int a[5];
    int c;
    f(a);
    c = a[2];
    return 0;
}