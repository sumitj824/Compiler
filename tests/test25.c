// void merge(int arr[], int l, int m, int r)
// {
//     int n1 = m - l + 1;
//     int n2 = r - m;
//     int i,j,k;
   
//     int L[10], R[10];
    
 
//     for ( i = 0; i < n1; i++)
//         L[i] = arr[l + i];
//     for ( j = 0; j < n2; j++)
//         R[j] = arr[m + 1 + j];
 
//      i = 0;
//      j = 0;
//      k = l;
   
//     while ((i < n1) && (j < n2)) {
//         if (L[i] < R[j]) {
//             arr[k] = L[i];
//             // i++;
//         }
//         // else {
//         //     arr[k] = R[j];
//         //     j++;
//         // }
//         // k++;
//     }
 
    
//     // while (i < n1) {
//     //     arr[k] = L[i];
//     //     i++;
//     //     k++;
//     // }
 
    
//     // while (j < n2) {
//     //     arr[k] = R[j];
//     //     j++;
//     //     k++;
//     // }
//     return ;
// }
 

// void mergeSort(int arr[],int l,int r){
//     int m =l+ (r-l)/2;
//     if(l>=r){
//         return;//returns recursively
//     }
//     mergeSort(arr,l,m);
//     mergeSort(arr,m+1,r);
//     merge(arr,l,m,r);
//     return ;
// }
 
// UTILITY FUNCTIONS
// Function to print an array

// void printArray(int arr[], int size)
// {
//     int i;
//     for (i = 0; i < size; i++)
//         {printf(arr[i]);prints(" ");}
//     return ;
// }
 
 
// Driver code
int main()
{
    // int arr[6] = { 12, 11, 13, 5, 6, 7 };
    // int arr_size =  6;
 
    // mergeSort(arr, 0, arr_size - 1);
    // printArray(arr, arr_size);

    int i=0,j=0,n=10;
    while (i<n && j<n ){
        if(i<j)
        {
            i++;
        }else {j++;}
    }
    return 0;
}