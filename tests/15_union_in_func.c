union u{
    int a;
    int b;
};


union u func(union u z){
    z.b=4;
    return z;
}


int main(){
    union u x,y;
    x.a=1;
    y=func(x);
    printf(x.a);//1
    prints("\n");
    printf(y.b);//4

    return 0;

}