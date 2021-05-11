

int func1(){
    printf("func1 is called\n");
    return 1;
}



int main(){
   int a=1;
   if(a || func1() )
   {
       //this should not call func1
   }
   a=0;
   if(a && func1() )
   {
       //this should not call  funct1

   }

}