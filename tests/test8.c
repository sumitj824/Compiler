union d{
    int a;
};

struct c{
    int a;
    struct c *e;
};

int b[2];

int f(int a,int b[]){
    int c[5];
    return 0;
}

struct abc{
    struct abc{
        struct abc* f;
        union d* g[1][2];
    } a;
    struct abc h;
};

int main(){
    int a;
    int b = 5;
    int c = 1;
    int d[] = {1,2,};
    int e[4];
    return 0;
}