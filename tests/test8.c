int f(int a,int b){
    return a+b;
}

int main(){
    long long i;
    int arr[3]={1,2,3};
    arr[f(2,3)] = 4;
    for(i=0;i<f(3,4);i++){
        arr[f(i,i+1)]=1;
        arr[0]=0;
        arr[i+7]=f(i,i=7);      
    }
    return 0;
}