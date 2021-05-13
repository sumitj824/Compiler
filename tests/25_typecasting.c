
int main(){
    int a = 8;
    float x = 5.678;
    float y;
    int c = (int) x;                //5
    printf(c);
    prints("\n");
    y = (int)x * 5.0;            //25.0
    print_float(y);
    prints("\n");
    a++;                             //9
    printf(a);
    prints("\n");
    y++;                        //26.0
    print_float(y);
    prints("\n");
    c = (float)((int)x * 4);    //20
    printf(c);
    prints("\n");
    c = x;                      //5
    printf(c);
    prints("\n");
    x = c;                       //5.0
    print_float(x);
    prints("\n");
    return 0;
}