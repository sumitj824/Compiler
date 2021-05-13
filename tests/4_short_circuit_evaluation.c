

int func1(){
    prints("test1 failed\n");
    return 1;
}
int func2(){
    prints("test2 failed\n");
    return 1;
}



int main(){
   int a=1;
   if(a || func1() ) //this should not call func1
   {
       prints("if1 is working\n");
   }
   a=0;
   if(a && func2() ) //this should not call  func2
   {
       
      prints("if2 is not working\n");
   }
   else
   {
       prints("if2 is working\n");
   }
   
   return 0;
}