
void getMatrixElements(int matrix[][10], int row, int column) {
   int i,j;
//    printf("\nEnter elements: \n");
   
   for ( i = 0; i < row; ++i) {
      for ( j = 0; j < column; ++j) {
        //  printf("Enter a%d%d: ", i + 1, j + 1);
        //  scanf("%d", &matrix[i][j]);
      }
   }
   return ;
}


void multiplyMatrices(int first[][10],int second[][10],int result[][10],int r1, int c1, int r2, int c2) {

   int i,j,k;
   for ( i = 0; i < r1; ++i) {
      for ( j = 0; j < c2; ++j) {
         result[i][j] = 0;
      }
   }

  
   for ( i = 0; i < r1; ++i) {
      for ( j = 0; j < c2; ++j) {
         for ( k = 0; k < c1; ++k) {
            result[i][j] += first[i][k] * second[k][j];
         }
      }
   }
   return ;
}


void display(int result[][10], int row, int column) {
   int i,j;
   // printf("\nOutput Matrix:\n");
   for ( i = 0; i < row; ++i) {
      for ( j = 0; j < column; ++j) {
         // printf("%d  ", result[i][j]);
         if (j == column - 1){
            // printf("\n");
         }

      }
   }
   return ;
}

int main() {
    int first[10][10], second[10][10], result[10][10], r1, c1, r2, c2;
    // printf("Enter rows and column for the first matrix: ");
    // scanf("%d %d", &r1, &c1);
    // printf("Enter rows and column for the second matrix: ");
    // scanf("%d %d", &r2, &c2);


    getMatrixElements(first, r1, c1);
    getMatrixElements(second, r2, c2);
    multiplyMatrices(first, second, result, r1, c1, r2, c2);
    // display(result, r1, c2);

   return 0;
}