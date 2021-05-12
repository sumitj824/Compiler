


int odd(int number){
	if (number==0) 
		return 0;
	else
		return even(number-1);
}

int even(int number){
	if(number==0) 
		return 1;
	else
		return odd(number-1);
}



int main ()
{
	int number = 23945;
	if(odd(number)==1)
		printf(1);
	
	return 0;
}
