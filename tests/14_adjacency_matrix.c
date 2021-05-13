


void createAdjMatrix(int Adj[][10],int arr[][2],int N,int M)
{	int i,j,x,y;
	for ( i = 0; i < N; i++) {

		for ( j = 0; j < N; j++) {
			Adj[i][j] = 0;
		}
	}
	for ( i = 0; i < M; i++) {
		 x = arr[i][0];
		 y = arr[i][1];
		Adj[x][y] = 1;
		Adj[y][x] = 1;
	}
	return ;
}


void printAdjMatrix(int Adj[][10],int N)
{	int i,j;
	for ( i = 0; i < N ; i++) {
		for ( j = 0; j < N ; j++) {
			if(Adj[i][j]==1){
				printf(i);
				printf(j);
			}
		}
	}
	return ;
}

// Driver Code
int main()
{

	// Number of vertices
	int N = 10;
	int Adj[10][10];
	int arr[4][2]= { { 1, 2 }, { 2, 3 },{ 4, 5 }, { 1, 5 } };
	// Number of Edges
	int M=4;
	int a[5];
	createAdjMatrix(Adj, arr,N,M);
	printAdjMatrix(Adj,N);
	return 0;
}
