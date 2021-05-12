int fib(int n)
{
  int a = 0, b = 1, c, i;
  if(!n) return a;
  else{
    for (i = 2; i <= n; i++)
    {
      c = a + b;
      a = b;
      b = c;
    }
    return b;
  }
}

int main ()
{
  int n = 9;
  int b;
  b=fib(n);
  printf(b);
  return 0;
}