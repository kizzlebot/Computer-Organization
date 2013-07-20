#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### Name:          James Choi
#### Course:        Computer Organization
#### Assignment:    Project #3
#### Date:          July 14, 2013
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####     
####   Write an assembly program for matrix multiplication where all the elements are 
####   integers and the matrices are stored in main memory.
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####     
#    1.) Hardcode the input matrices A and B each of size 3x3 in program by storing into main memory.
#		 You can choose to either store them in row-major or column-major order.
#        Observe the cache performance (eg hit rate, miss rate, etc) in simulator.
#
#    2.) Optimized Matrix Multiplication for N=3 :
#		   - Optimize your code (by storing matrices in a particular order, code-reordering, etc.) and cache 
#		 	 organization (block size, placement policy, etc.) to get the maximum hit-rate for a fix-cache 
#		     size of 128 bytes.
#		   - Submit the optimized mult3.asm file mentioning the optimized cache organization for N=3.  Give
#			 comprehensive description of how you improved the hit-rate
#
#    3.) Verify the cache hit-rate that you observed from simulator by hand-calculation and include in report.
#
#    4.) Matrix multiplication N >= 8:
#		   - Show the hit-rate of your program for various cache parameters by extending the concept of N>=8
#			 (Choose any number greater than or equal to 8, eg 8x8 ABc) And complete table (Project pdf)
#
#    5.) Optimized Matrix multiplication for N=8:
#		   - Show the optimized cache parameters to achieve the best possible hit-rate for this problem
#		   - Submit the optimized multi8.asm file mentioning the optimized cache organization for N=8 in your report
# 			 and give description of how the hit-rate was improved.
#
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####     
####   Ground rules
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####     
#    (*) You are free to choose the data input method, e.g., by keyboard, file, or fixing in
#        your assembly code. However, the matrices should be stored in main memory
#        instead of just storing in the registers 
#
#	 (*) A fixed Cache size=128 bytes should be used for all the above mentioned tasks
#
#    (*) Your final code should not contain any display type or other redundant
#        instructions. No print instructions
#
#    (*) For associativity >1, assume LRU (Least Recently Used) policy.

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####     
####   
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####     
.data 
MatrixA: .word 9,8,3, 2,4,5, 6,2,4
MatrixB: .word 9,8,3, 2,4,5, 6,2,4
MatrixC: .word 0:9 # Storage for generated 3x3 matrix 


##  { {a,b,c} 
##	  {a,b,c}
##	  {a,b,c} }
.text
main:
	li $t8,9 # rows
	li $t7,9 # cols
	li $t6,9

<<<<<<< HEAD
	move $t0,$zero
	move $t1,$zero
	move $t2,$zero
# c[0] = A[0]B[0] + A[1]B[3] + A[2]B[6]
# c[1] = A[0]B[1] + A[1]B[4] + A[2]B[7]
# c[2] = A[0]B[2] + A[1]B[5] + A[2]B[8]
for (( c=$START; c<'9'; ))
do
  # on every iteration add one and calculate sum
  for (( d=$START; d<'3';d++)); do
    printf "\nA[$d]B[$c] + A[$(($d+3))]B[$(($c+1))] +  A[$(($d+6))]B[$(($c+2))]"
  done
  c="$((c+3))"
done

=======
	# summated calculation, a single cell of answerMatrix
	move $s0,$zero
	
# Matrix Multiplication Algorithm	
#for c = 0 ; c < 9 ; 
	# for d = 0 ; d < '3' ; d++
		# multiply each set (3)
		# summ and assign
	# end for
	# c+=3
# end for
>>>>>>> 35e8db369ba78ca93fca322f5048205bbc588285

# c[3] = A[3]B[0] + A[4]B[3] + A[5]B[6]
# c[4] = A[3]B[1] + A[4]B[4] + A[5]B[7]
# c[5] = A[3]B[2] + A[4]B[5] + A[5]B[8]

# c[6] = A[6]B[0] + A[7]B[3] + A[8]B[6]
# c[7] = A[6]B[1] + A[7]B[4] + A[8]B[7]
# c[8] = A[6]B[2] + A[7]B[5] + A[8]B[8]


