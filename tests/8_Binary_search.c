int binarySearch(int arr[], int l, int r, int x)
{
    if (r >= l) {
        int mid = l + (r - l) / 2;


        if (arr[mid] == x)
            return mid;

        if (arr[mid] > x)
            return binarySearch(arr, l, mid - 1, x);

        return binarySearch(arr, mid + 1, r, x);
    }


    return -1;
}

int main(void)
{
    int arr[5];
    int n = 5;
    int x = 10,index;
    arr[0]=1;
    arr[1]=5;
    arr[2]=10;
    arr[3]=15;
    arr[4]=16;
    index = binarySearch(arr, 0, n - 1, x);
    printf(index);
    return 0;
}
