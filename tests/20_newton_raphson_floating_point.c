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
	
	// for(i=0; i<1; i++){
	// 	// print_float(arr[i].a);
	// 	// print_float(arr[i].b);
	// }
	if(arr[0].a==1.1){
		printf(1);
	}else
	{
		printf(0);
	}
	if(arr[0].b==2.2){
		printf(3);
	}else
	{
		printf(2);
	}
	
	
	return 0;
}
