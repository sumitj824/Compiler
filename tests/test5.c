//for loops and functions

int func(int a){
    return 2*a;
}

int main(){
    //for loop
    int i,b;
    for (i=0;i<5;i++){
        printf("%d\n",i);
    }

    //while loop

    i = 0;
    while(i<5 || b<22){
        i++;
        b--;
    }

    //do while loop and usage of function.

    do{
        
        i = func(i);
    }while(i<= 200);


}