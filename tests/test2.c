int num = 17;

//checking extern
extern float point;

int main(){
    for(int i = 0; i < 5; i++){
        printf("%d",i);
    }
    while(1){
        break;
        //check if comment is neglected  
        /* and even this*/
    }

    //checking auto

    int arr[5] = {1,2,3,4,5};

    printf("%d", &num);

    for(auto &x: arr){
        printf("%d",x);
    }

    //checking if condition

    int a = 4;
    int b = 5;


    if(a == b || !a){
        printf("equal");
    }else{
        printf("not equal");
    }

    //checking binary operators

    int c = a|b;
    int d = a&b;
    int e = a^b;

    //unknown character will print token name unknown.
    $#
    
    


}