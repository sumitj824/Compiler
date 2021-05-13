struct x{
    int a;
    int b;
};

struct x f(struct x a[][6],int N){
    int i = 0,j = 0;
    for(i = 0;i < N;i++){
        for(j = 0;j < 6;j++){
            a[i][j].a = (i + 1);
            a[i][j].b = (j + 1);
        }
    }
    return a[2][3];
}

int main(){
    struct x a[5][6];
    a[2][3] = f(a,5);
    printf(a[2][3].a); //3
    prints("\n");
    printf(a[2][3].b); //4
    prints("\n");
    return 0;
}