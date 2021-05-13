// C for implementation of Newton Raphson Method for solving equation

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
    int y=x;
	float h = func(x) / derivFunc(x);
	while (absolute(h) >= 0)
	{
		h = func(x)/derivFunc(x);
		x = x - h;
	}

	// cout << "The value of the root is : " << x;
    y=x;
    printf(y);

    return ;
}


int main()
{
	float x = -20; 
	newtonRaphson(x);
	return 0;
}
