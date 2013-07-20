#include <stdio.h>

int main(){
  int A[] = {  0, 1, 2 ,
               0, 1, 2 , 
               0, 1, 2 };

  int B[] = {  0, 1, 2 ,
               0, 1, 2 , 
               0, 1, 2 };

  int C[9];
  int a = 0 ; 
  int b = 0 ; 
  int c = 0 ; 

  for ( a = 0 ; a < 9 ; a+=3 ){
    for ( b = 0 ; b < 3 ; b++){
      int a1 = a+1;
      int a2 = a+2;
      int b1 = b+3;
      int b2 = b+6;
      printf("\nC[\e[38;5;26m%d\e[0m] = A[\e[38;5;26m%d\e[0m]B[\e[38;5;26m%d\e[0m] + A[\e[38;5;26m%d\e[0m]B[\e[38;5;26m%d\e[0m] + A[\e[38;5;26m%d\e[0m]B[\e[38;5;26m%d\e[0m]",c,a,b,a1,b1,a2,b2);
      //printf "\nA[\e[38;5;26m$c\e[0m]B[\e[38;5;26m$d\e[0m] + A[\e[38;5;26m$(($c+1))\e[0m]B[\e[38;5;26m$(($d+3))\e[0m] +  A[\e[38;5;26m$(($c+2))\e[0m]B[\e[38;5;26m$(($d+6))\e[0m]"
      C[c] = A[a]*B[b] + A[a+1]*B[b+3] + A[a+2]*B[b+6];
      c++ ; 
    }  
  }
  printf("\n");
  for ( a = 0 ; a < 9 ; a++){
    printf("\nC[%d] = %d",a,C[a]);
  }
  printf("\n");
}
