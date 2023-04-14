#ifndef __TRABALHO2SD_H__
#define __TRABALHO2SD_H__
#define LINHAS 2
#define COLUNAS 2
#include <stdio.h>

typedef unsigned char mat_a; //8bits
typedef unsigned char mat_b; //8bits
typedef unsigned char mat_c; //8bits
typedef unsigned char mat_d; //8bits
typedef unsigned short mat_MR1; //16bits
typedef unsigned short mat_MR2; //16bits
typedef unsigned short mat_MP; //16bits
typedef unsigned short mat_MF; //16bits

void projectSD(
      mat_a A[LINHAS][COLUNAS],
      mat_b B[LINHAS][COLUNAS],
      mat_c C[LINHAS][COLUNAS],
      mat_d D[LINHAS][COLUNAS],
      mat_MF MF[LINHAS][COLUNAS]);

#endif