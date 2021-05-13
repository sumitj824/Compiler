// C for implementation of Newton Raphson Method for solving equation


float EPSILON=0.001;
float absolute(float x){
    if(x<0){
        return -x;
    }
    return x;
}

float func(float x)
{
	return x*x*x - x*x + 2;
}


float derivFunc(float x)
{
	return 3*x*x - 2*x;
}


void newtonRaphson(float x)
{   
    int y;
	float h = func(x) / derivFunc(x);
	while (absolute(h) >= EPSILON)
	{
		h = func(x)/derivFunc(x);
		x = x - h;
	}
	prints("The value of the root is : " );
    print_float(x);

    return ;
}

int main()
{
	float x=-20.0;
	newtonRaphson(x);
	return 0;
}
