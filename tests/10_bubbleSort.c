
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
    prints("Sorted array :\n");
	for (i=0; i < size; i++)
	{
        printf(arr[i]);
        prints(" ");
    
    }
    return ;
}

int main()
{
    int arr[]={9,7,8,1,6,2,5};
	int n = 7;
	bubbleSort(arr, n);
	printArray(arr, n);
	return 0;
}
