//recursion
int ack(int m, int n)
{
	if (m == 0){
		return n+1;
	}
	else if((m > 0) && (n == 0)){
		return ack(m-1, 1);
	}
	else if((m > 0) && (n > 0)){
		return ack(m-1, ack(m, n-1));
	}
	return 0;
}

int main(){
	int a;
	a= ack(1, 2);
	// printf("%d", A);
	return 0;
}

