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
	# Upper bounds 
	li $t6,9 # Load number of rows
	li $t7,9 # Load number of columns
	
	# incrementors
	move $t0,$zero # rows
	move $t1,$zero # cols

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

outerLoop:
	beq $t0,$t6,exit
	lw $s1,MatrixA($t0)

	innerLoop:
		lw $s2,MatricB($t1)
		mult $s1,$s2
		mflo $t4
		add $s0,$s0,$t4

		addi $t1,$t1,1
		
	addi $t0,$t0,1
exit:


