
void bubbleSort(int arr[], int n)
{
    int i, j,temp;
    for (i = 0; i < n-1; i++){	
        for (j = 0; j < n-i-1; j++){
            if (arr[j] > arr[j+1]){
                temp=arr[j];
                arr[j]=arr[j+1];
                arr[j+1]=temp;  
            }
        }
    }
    return ;
}

void printArray(int arr[], int size)
{
	int i;
	for (i=0; i < size; i++)
		printf(arr[i]);
    return ;
}

int main()
{
    int arr[7];
	int n = 7;
    arr[0]=9;
    arr[1]=7;
    arr[2]=8;
    arr[3]=1;
    arr[4]=6;
    arr[5]=5;
    arr[6]=2;
	bubbleSort(arr, n);
	printArray(arr, n);
	return 0;
}
