// #include<stdio.h>

union xy_z{
    int  *ptr;
    float x;
};

int main(){
    union xy_z curr;
    curr.x = 15/5;
    printf("%ld \n",sizeof(curr));
    for(int i = 0; i < 5; i++){
        if(i%2!=0)
        {
            printf("%ld \n", sizeof(curr.ptr));
        }
        else printf ("%f \n",curr.x);
    }
    return 0;
}