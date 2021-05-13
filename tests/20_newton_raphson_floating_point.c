// C for implementation of Newton Raphson Method for solving equation

// float absolute(float x){
//     if(x<0){
//         return -x;
//     }
//     return x;
// }

// float func(float x)
// {
// 	return x*x*x - x*x + 2;
// }


// float derivFunc(float x)
// {
// 	return 3*x*x - 2*x;
// }


// void newtonRaphson(float x)
// {   
//     int y;
// 	float h = func(x) / derivFunc(x);
// 	while (h >= 0)
// 	{
// 		h = func(x)/derivFunc(x);
// 		x = x - h;
// 	}

// 	// cout << "The value of the root is : " << x;
//     y=x;
//     printf(y);

//     return ;
// }

struct x
{
	float a;
	float b;
};


int main()
{
	struct x arr[5];
	int i;


	for(i=0; i<1; i++){
		arr[i].a=read_float();
		arr[i].b=read_float();
	}
	
	return 0;
}
