
 int partition (int arr[], int low, int high)
{
    int pivot = arr[high]; 
    int temp;
    int i = (low - 1); 
    int j;
 
    for (j = low; j <= high - 1; j++)
    {
        
        if (arr[j] < pivot)
        {
            i++; 
            temp=arr[i];
            arr[i]=arr[j];
            arr[j]=temp;
        }
    }
    temp=arr[i+1];
    arr[i+1]=arr[high];
    arr[high]=temp;
    return (i + 1);
}
 

void quickSort(int arr[], int low, int high)
{
    if (low < high)
    {
        int pi = partition(arr, low, high);
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
    return ;
}
 

void printArray(int arr[], int size)
{
    int i;
    for (i = 0; i < size; i++)
        printf(arr[i]);
    return ;
}
 
// Driver Code
int main()
{
    int arr[] = {2, 7, 8, 9, 1, 5};
    int n = 6;
    quickSort(arr, 0, n - 1);
    printArray(arr,n);
    return 0;
}