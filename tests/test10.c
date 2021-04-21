int a;

struct x{
    int a;
    int b;
};

int main(){
    struct x y;
    int a[7];
    {
        struct x y;
        int a[] = {1,2,3,4,5,6,8,7};
        a[4] = 1;
    }
    a[5] = 1;
    return 0;
}

// offset
// initializer_list_size
// 