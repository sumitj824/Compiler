//recursion
int ack(int m, int n)
{	
	int x;
	if (m == 0){
		return n+1;
	}
	else if((m > 0) && (n == 0)){
		return ack(m-1, 1);
	}
	else if((m > 0) && (n > 0)){
		x=ack(m, n-1);
		return ack(m-1,x );
	}
	return 0;
}

int main(){
	int a;
	a= ack(1, 2);
	printf(a); //4
	return 0;
}

