#include "Trabalho2SD.h"

void projectSD(

      mat_a A[LINHAS][COLUNAS],
      mat_b B[LINHAS][COLUNAS],
      mat_c C[LINHAS][COLUNAS],
      mat_d D[LINHAS][COLUNAS],
      mat_MF MF[LINHAS][COLUNAS])
{
    mat_MR1 MR1[LINHAS][COLUNAS];
      mat_MR2 MR2[LINHAS][COLUNAS];
      mat_MP MP[LINHAS][COLUNAS];
  // Iterate over the rows of the A matrix
   Row1: for(int i = 0; i < LINHAS; i++) {
      // Iterate over the columns of the B matrix
      Col1: for(int j = 0; j < COLUNAS; j++) {
         MR1[i][j] = 0;
         // Do the inner product of a row of A and col of B
         Product1: for(int k = 0; k < LINHAS; k++) {
            MR1[i][j] += A[i][k] * B[k][j];
         }
      }
   }
 Row2: for(int i = 0; i < LINHAS; i++) {
      // Iterate over the columns of the B matrix
      Col2: for(int j = 0; j < COLUNAS; j++) {
         MR2[i][j] = 0;
         // Do the inner product of a row of A and col of B
         Product2: for(int k = 0; k < LINHAS; k++) {
            MR2[i][j] += C[i][k] * D[k][j];
         }
      }
   }
    Row3: for(int i = 0; i < LINHAS; i++) {
      Col3: for(int j = 0; j < COLUNAS; j++) {
         MP[i][j] = MR1[i][j]+MR2[i][j];
      }
   }
   Row4: for(int i = 0; i < LINHAS; i++) {
      Col4: for(int j = 0; j < COLUNAS; j++) {
         if(MP[i][j] >= 1050){
            MF[i][j] = 0;
         }
         else{
            MF[i][j] = MP[i][j];
         }
      }
   }

}

