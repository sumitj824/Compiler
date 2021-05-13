
int main()
{
    int n=-1; //-1;
    n*=-1;    //1
    n+=2;       //3
    n=n-1;      //2
    n=-n;       //-2
    n=n/-2;     //1
    n=-n-1;    //-2
    if(n==-2){
        prints("testcase passed");
    }else
    {
        prints("testcase failed");
    }
    
    return 0;
}
