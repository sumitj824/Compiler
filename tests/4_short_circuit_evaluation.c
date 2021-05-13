

int func1(){
    printf(1);
    return 1;
}
int func2(){
    printf(2);
    return 1;
}



int main(){
   int a=1;
   if(a || func1() ) //this should not call func1
   {
       printf(3);
   }
   a=0;
   if(a && func1() ) //this should not call  func2
   {
       
      printf(4);
   }
   else
   {
       printf(5);
   }
   
   return 0;
}