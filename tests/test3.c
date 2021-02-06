//testing data types and operations

typedef unsigned char BYTE;

struct point{
    int x;
    int y;
};

static int num = 6;
extern int var;
int k = 9;

int main(){
    int a = 5;
    float b = 5.0000;
    char c = 'c';
    double d = 7.0000000;
    unsigned int e = 11;
    short f = 12;
    long g = 133333;
    int arr[5] = {1,2,3,4,5};

    auto x = 7;


    int k = a++;
    b-=a;
    a+=b;
    a*=b;
    a/=b;
    a--;
    --a;
    ++b;

    //binary operators


    int c = a|b;
    int d = a&b;
    int e = a^b;
    int e = ~a;
}