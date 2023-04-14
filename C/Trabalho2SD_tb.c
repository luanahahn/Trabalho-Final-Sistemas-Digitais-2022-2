#include "Trabalho2SD.h"

int main(int argc, char **argv){

    mat_a matrixA[2][2] = {
		  {5,9},
		  {15,6}
   };
   mat_b matrixB[2][2] = {
		   {8,10},
		   {9,3}
   };
   mat_c matrixC[2][2] = {
		   {8,4},
		   {1,2}
   };
   mat_d matrixD[2][2] = {
		   {9,4},
		   {5,7}
   };

   mat_a mat_error[2][2] = {
		   {0,0},
		   {0,0}
   };


   mat_MF hw_result[2][2];
   mat_MF sw_result[2][2], mr1_result[2][2], mr2_result[2][2], mp_result[2][2];
   int err_cnt = 0;

   // Generate the expected result

   // Iterate over the rows of the A matrix
   for(int i = 0; i < LINHAS; i++) {
      for(int j = 0; j < COLUNAS; j++) {
         // Iterate over the columns of the B matrix
         mr1_result[i][j] = 0;
         // Do the inner product of a row of A and col of B
         for(int k = 0; k < LINHAS; k++) {
            mr1_result[i][j] += matrixA[i][k] * matrixB[k][j];
         }
      }
   }

   // Iterate over the rows of the C matrix
     for(int i = 0; i < LINHAS; i++) {
        for(int j = 0; j < COLUNAS; j++) {
           // Iterate over the columns of the D matrix
           mr2_result[i][j] = 0;
           // Do the inner product of a row of C and col of D
           for(int k = 0; k < LINHAS; k++) {
              mr2_result[i][j] += matrixC[i][k] * matrixD[k][j];
           }
        }
     }

   // ADD
     for(int i = 0; i < LINHAS; i++){
    	 for(int j = 0; j < COLUNAS; j++){
    		 mp_result[i][j] = mr1_result[i][j] + mr2_result[i][j];
    	 }
     }

   //TEST
     for(int i = 0; i < LINHAS; i++){
    	 for(int j = 0; j < COLUNAS; j++){
    		if(mp_result[i][j] >= 1050){
    			sw_result[i][j] = 0;
    		}
    		else{
    			sw_result[i][j] = mp_result[i][j];
    		}
    	 }
     }

   // Compare TB vs HW C-model and/or RTL




   // Run matrix multiply block
   projectSD(matrixA, matrixB, matrixC, matrixD, hw_result);

   //matrixmul(matrixA,mat_error, hw_result); //simulate error



   // Compare hw_result with sw_result
   for (int i = 0; i < LINHAS; i++) {
      for (int j = 0; j < COLUNAS; j++) {
         // Check HW result against SW
         if (hw_result[i][j] != sw_result[i][j]) {
            err_cnt++;
         }

      }
   }


   if (err_cnt){
	  printf("/n");
      printf("Error: %d mismatches detected!", err_cnt);
      //print matrix error results
      printf("Matriz resultado:");
	  for (int i = 0; i < LINHAS; i++) {
		  printf("/n");
		  for (int j = 0; j < COLUNAS; j++) {
			 printf("%d", hw_result[i][j]);
		  }
	  }
	 printf("/n");

   }
   else{
	  printf("/n");
      printf("Não foram encontrados erros!");

     //print matrix results
     printf("Matriz resultado:");
   	 for (int i = 0; i < LINHAS; i++) {
   		  printf("/n");
   		  for (int j = 0; j < COLUNAS; j++) {
   			 printf("%d", hw_result[i][j]);
   		  }
   	   }
   	 printf("/n");
   }
 // return err_cnt;

}