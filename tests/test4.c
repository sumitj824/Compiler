//for conditionals

int main(){
    //if condition
    int c;
    int a = 5+6+7;
    int b = 3+9+6;
    if( a == b || a>=b || a<=b || a!=b){
        printf("yes!!\n");
    }else{
        printf("NO!!\n");
    }

    //? conditional operator

    c = (a>b)?a:b;

    //switch statement

    switch(a){
        case 1: printf("%d", a); break;
        case 2: printf("%d", b); break;
        default : printf("no!!\n");
    }




}