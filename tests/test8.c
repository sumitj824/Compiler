struct x{
    int c;
    int d;
}; 

struct y{
    struct x a[];
    float c;
    struct x * b[];
    char ** d;
};

int main(){
    //  x ka type 1 y int error type assignment
    int e;
    struct y x;
    int a[5] = {1,2,3,4,5};
    return 0;
}