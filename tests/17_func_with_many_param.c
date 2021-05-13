int f8(int a, int b, int c, int d,int e, int f, int g, int h) {
  return a+b+c+d+e+f+g+h;
}
int f9(int a, int b, int c, int d,int e, int f, int g, int h, int i) {
  return a+b+c+d+e+f+g+h+i;
}

int f10(int a, int b, int c, int d, int e,int f, int g, int h, int i, int j) {
  return a+b+c+d+e+f+g+h+i+j;
}
int main(){
    printf(f8(1,1,1,1,1,1,1,1)); //8
    prints("\n");
    printf(f9(1,1,1,1,1,1,1,1,1)); //9
    prints("\n");
    printf(f10(1,1,1,1,1,1,1,1,1,1));//10
    prints("\n");

    return 0;
}