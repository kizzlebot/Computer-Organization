#include <stdio.h>

int main(){
  int A[] = {  0, 1, 2 ,
               0, 1, 2 , 
               0, 1, 2 };

  int B[] = {  0, 1, 2 ,
               0, 1, 2 , 
               0, 1, 2 };

  int C[9];
  int c = 0 ; 
  int d = 0 ; 
  int e = 0 ; 

  for ( c = 0 ; c < 9 ; c+=3 ){
    for ( d = 0 ; d < 3 ; d++){
      int c1 = c+1;
      int c2 = c+2;
      int d1 = d+3;
      int d2 = d+6;
      printf("\nC[\e[38;5;26m%d\e[0m] = A[\e[38;5;26m%d\e[0m]B[\e[38;5;26m%d\e[0m] + A[\e[38;5;26m%d\e[0m]B[\e[38;5;26m%d\e[0m] + A[\e[38;5;26m%d\e[0m]B[\e[38;5;26m%d\e[0m]",e,c,d,c1,d1,c2,d2);
      //printf "\nA[\e[38;5;26m$c\e[0m]B[\e[38;5;26m$d\e[0m] + A[\e[38;5;26m$(($c+1))\e[0m]B[\e[38;5;26m$(($d+3))\e[0m] +  A[\e[38;5;26m$(($c+2))\e[0m]B[\e[38;5;26m$(($d+6))\e[0m]"
      C[e] = A[c]*B[d] + A[c+1]*B[d+3] + A[c+2]*B[d+6];
      e++ ; 
    }  
  }
  printf("\n");
  for ( c = 0 ; c < 9 ; c++){
    printf("\nC[%d] = %d",c,C[c]);
  }
  printf("\n");
}
