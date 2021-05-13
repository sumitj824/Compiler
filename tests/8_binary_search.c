
int binarySearch(int arr[],int l, int r, int x)
{
    if (r >= l) {
        int mid = l + (r - l) / 2;


        if (arr[mid] == x)
            return mid;

        if (arr[mid] > x)
            return binarySearch(arr,l, mid - 1, x);

        return binarySearch(arr,mid + 1, r, x);
    }


    return -1;
}

int main(void)
{   
    int arr[]={1,5,10,15,16};
    int n = 5;
    int x = 10,index;
    index = binarySearch(arr,0, n - 1, x);
    printf(index);
    return 0;
}
