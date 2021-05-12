


void createAdjMatrix(int Adj[][],int arr[][2],int N,int M)
{	int i,j,x,y;
	for ( i = 0; i < N + 1; i++) {

		for ( j = 0; j < N + 1; j++) {
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


void printAdjMatrix(int Adj[][],int N)
{	int i,j;
	for ( i = 1; i < N + 1; i++) {
		for ( j = 1; j < N + 1; j++) {
			// printf("%d ", Adj[i][j]);
		}
		// printf("\n");
	}
	return ;
}

// Driver Code
int main()
{

	// Number of vertices
	int N = 5;
	int Adj[N + 1][N + 1];
	// int arr[][2]= { { 1, 2 }, { 2, 3 },{ 4, 5 }, { 1, 5 } };
	int **arr;
	// Number of Edges
	int M = sizeof(arr) / sizeof(arr[0]);
	// For Adjacency Matrix
	createAdjMatrix(Adj, arr,N,M);
	printAdjMatrix(Adj,N);
	return 0;
}
