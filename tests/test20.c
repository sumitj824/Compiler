int func1(){
    printf(1);
    return 1;
}



int main(){
   int a=0;

   //a=0;
   if(a && func1() )
   {
       //this should not call  funct1

   }
   printf(a);
   return 0;
}