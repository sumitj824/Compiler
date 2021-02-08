// #include<stdio.h>
// #include<math.h>
// #include<stdlib.h>

struct ar{
    float x;
    int y;
    char *s;
};
/* multiple
    line */

//single line comment


int main() {
 
 int x=0;

 struct ar instant;
 instant.x = 100;
 instant.s = (char *)malloc(5*sizeof(char));
 instant.s[0] = 'a';
 instant.s[1] = 'b';
 instant.s[2] = 'c';
 instant.s[3] = 'd';
 instant.s[4] = '\0';

 printf("%d  %f  %s", x, instant.x, instant.s);

 return 0;

}