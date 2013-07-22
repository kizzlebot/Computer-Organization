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
#    You can choose to either store them in row-major or column-major order.
#        Observe the cache performance (eg hit rate, miss rate, etc) in simulator.
#
#    2.) Optimized Matrix Multiplication for N=3 :
#      - Optimize your code (by storing matrices in a particular order, code-reordering, etc.) and cache 
#      organization (block size, placement policy, etc.) to get the maximum hit-rate for a fix-cache 
#        size of 128 bytes.
#      - Submit the optimized mult3.asm file mentioning the optimized cache organization for N=3.  Give
#      comprehensive description of how you improved the hit-rate
#
#    3.) Verify the cache hit-rate that you observed from simulator by hand-calculation and include in report.
#
#    4.) Matrix multiplication N >= 8:
#      - Show the hit-rate of your program for various cache parameters by extending the concept of N>=8
#      (Choose any number greater than or equal to 8, eg 8x8 ABc) And complete table (Project pdf)
#
#    5.) Optimized Matrix multiplication for N=8:
#      - Show the optimized cache parameters to achieve the best possible hit-rate for this problem
#      - Submit the optimized multi8.asm file mentioning the optimized cache organization for N=8 in your report
#        and give description of how the hit-rate was improved.
#
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####     
####   Ground rules
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####     
#    (*) You are free to choose the data input method, e.g., by keyboard, file, or fixing in
#        your assembly code. However, the matrices should be stored in main memory
#        instead of just storing in the registers 
#
#  (*) A fixed Cache size=128 bytes should be used for all the above mentioned tasks
#
#    (*) Your final code should not contain any display type or other redundant
#        instructions. No print instructions
#
#    (*) For associativity >1, assume LRU (Least Recently Used) policy.

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####     
####   
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####     
.data 
MatrixA: .word 0,1,2,0,1,2,0,1,2
MatrixB: .word 0,1,2,0,1,2,0,1,2
MatrixC: .word 1,3,2,1,3,2,1,3,2 # Storage for generated 3x3 matrix 
newLine: .asciiz "\n" # Newline character

##  { {a,b,c} 
##    {a,b,c}
##    {a,b,c} }
.text
main:
  la $s7,MatrixC
  la $s6,MatrixB
  la $s5,MatrixA

  addi $t7,$zero,9 # A/C upper bound
  addi $t6,$zero,3 # B upper bound
  move $t2,$zero   # C incrementor
  move $t1,$zero   # B incrementor
  move $t0,$zero   # A incrementor

  move $t3,$zero   # Load a into here
  move $t4,$zero   # Load b into here
  move $t5,$zero   # sum in to here
  move $s2,$zero   # Store address of C[] here
  move $s1,$zero   # Store address of B[] here
  move $s0,$zero   # Store address of A[] here 

  move $s3,$zero
  outerLoop:
  	beq $t0,$t7,exit
  	sll $s0,$t0,2
  	add $s0,$s5,$s0  # s0 = address of A
  	  	
	innerLoop:
		sll $s1,$t1,2
		add $s1,$s6,$s1 # S1 = address of B
		move $t5,$zero
		mtlo $zero
		lw $t3,0($s0)
		lw $t4,0($s1)
		
 
		
		
		mult $t4,$t3
		mflo $t3
		add $t5,$t5,$t3
		

		
		
		lw $t3,4($s0)
		lw $t4,12($s1)
		

		
		mult $t4,$t3
		mflo $t3
		add $t5,$t5,$t3				

		
		
		lw $t3,8($s0)
		lw $t4,24($s1)
		mult $t4,$t3
		mflo $t3
		add $t5,$t5,$t3

		
		sll $s2,$t2,2
		add $s2,$s7,$s2
		sw  $t5,0($s2)

		###Print###
		la $a0,newLine
		li $v0,4
		syscall
		lw $a0,0($s2)
		li $v0,1
		syscall		
		###Print###
		addi $t1,$t1,1
		addi $t2,$t2,1
		bne $t1,$t6,innerLoop
		
	move $t1,$zero
	addi $t0,$t0,3
    j outerLoop   

exit:
