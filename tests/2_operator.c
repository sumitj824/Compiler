
int main(){
    float x = 3.2;
    float y = 1.9;
    int a = 2;
    int c = 1;
    x = x + a;  //5.2
    print_float(x);
    prints("\n");
    a = x + a;  //7
    printf(a);
    prints("\n");
    a *= 2;     //14
    printf(a);
    prints("\n");
    a = 11;
    a %= 3;     //2
    printf(a);
    prints("\n");
    a = (int)x + 5;     //10
    printf(a);
    prints("\n");
    x = (float)a + y;   //11.9
    print_float(x);
    prints("\n");
    a = y * 5;       //9
    printf(a);
    prints("\n");
    return 0;
}