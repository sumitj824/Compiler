
void getMatrixElements(int matrix[][9], int row, int column) {
   int i,j;
//    printf("\nEnter elements: \n");
   
   for ( i = 0; i < row; ++i) {
      for ( j = 0; j < column; ++j) {
        //  printf("Enter a%d%d: ", i + 1, j + 1);
        //  scanf("%d", &matrix[i][j]);
        matrix[i][j] =1;
      }
   }
   return ;
}


void multiplyMatrices(int first[][9],int second[][9],int result[][9],int r1, int c1, int r9, int c9) {

   int i,j,k;
   for ( i = 0; i < r1; ++i) {
      for ( j = 0; j < c9; ++j) {
         result[i][j] = 0;
      }
   }

  
   for ( i = 0; i < r1; ++i) {
      for ( j = 0; j < c9; ++j) {
         for ( k = 0; k < c1; ++k) {
            result[i][j] += first[i][k] * second[k][j];
         }
      }
   }
   return ;
}


void display(int result[][9], int row, int column) {
   int i,j;
   // printf("\nOutput Matrix:\n");
   for ( i = 0; i < row; ++i) {
      for ( j = 0; j < column; ++j) {
         printf( result[i][j]);
         // if (j == column - 1){
         //    // printf("\n");
         // }

      }
   }
   return ;
}

int main() {
    int first[9][9], second[9][9], result[9][9], r1, c1, r9, c9;
    // printf("Enter rows and column for the first matrix: ");
    // scanf("%d %d", &r1, &c1);
    // printf("Enter rows and column for the second matrix: ");
    // scanf("%d %d", &r9, &c9);
   r1=9;
   r9=9;
   c1=9;
   c9=9;

    getMatrixElements(first, r1, c1);
    getMatrixElements(second, r9, c9);
    multiplyMatrices(first, second, result, r1, c1, r9, c9);
    display(result, r1, c9);

   return 0;
}