
void getMatrixElements(int matrix[][3], int row, int column) {
   int i,j;
   
   for ( i = 0; i < row; ++i) {
      for ( j = 0; j < column; ++j) {
            matrix[i][j] =read_int();
      }
   }
   return ;
}


void multiplyMatrices(int first[][3],int second[][3],int result[][3],int r1, int c1, int r9, int c9) {

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


void display(int result[][3], int row, int column) {
   int i,j;
   // printf("\nOutput Matrix:\n");
   for ( i = 0; i < row; ++i) {
      for ( j = 0; j < column; ++j) {
         printf( result[i][j]);
      }
   }
   return ;
}

int main() {
   int r1=3,c1=3,r2=3,c2=3;
   int first[3][3] ={{1,2,3},{3,4,5},{7,8,9}};
   int second[3][3] ={{1,2,3},{3,4,5},{7,8,9}};
   int result[3][3];
   
   // int first[r1][c1],second[r2][c2];
   // r1=read_int();c1=read_int();r2=read_int();c2=read_int();
   // getMatrixElements(first, r1, c1);
   // getMatrixElements(second, r2, c2);
   multiplyMatrices(first, second, result, r1, c1, r2, c2);
   display(result, r1, c2);

   return 0;
}