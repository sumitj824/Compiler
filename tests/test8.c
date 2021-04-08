//int b=5;
//error cases
struct point{
    int a;
    int b;
};

int f(int a){
    return 0;
}

int main(){
    // f(2);               // unknown syntax error.... check
    // f();                //less number of arguments
    // f()();              //f() is not a function
    // int x[10.2];        //index not integer
    // struct point p;
    // p.a=1;              //unknown syntax error .......check      
    // p.b=2;
    // void y=11;          //variable of void type cannot be there 
    // int* a=4;           //invalid conversion from int to int*
    int b[10];
    b[11] = 2;         //accessing array with index not an integer

}