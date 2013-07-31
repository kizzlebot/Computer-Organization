#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####     
####   
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####     
.data 
MatrixA: .word 1,5,2,5,8,2,1,3, 1,5,2,5,8,2,1,3, 1,5,2,5,8,2,1,3, 1,5,2,5,8,2,1,3, 1,5,2,5,8,2,1,3, 1,5,2,5,8,2,1,3, 1,5,2,5,8,2,1,3, 1,5,2,5,8,2,1,3,
MatrixB: .word 5,6,7,5,6,7,5,6, 5,6,7,5,6,7,5,6, 5,6,7,5,6,7,5,6, 5,6,7,5,6,7,5,6, 5,6,7,5,6,7,5,6, 5,6,7,5,6,7,5,6, 5,6,7,5,6,7,5,6, 5,6,7,5,6,7,5,6,
MatrixC: .word 0:256 # Storage for generated 8x8
newLine: .asciiz "\n" # Newline character

##  { {a,b,c} 
##    {a,b,c}
##    {a,b,c} }
.text
main:

  la $s7,MatrixC
  la $s6,MatrixB
  la $s5,MatrixA

  addi $t7,$zero,64 # A/C upper bound
  addi $t6,$zero,8 # B upper bound
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
  	beq $t0,$t7,print
  	sll $s0,$t0,2
  	add $s0,$s5,$s0  # s0 = A[i]
  	  	
	innerLoop:
		sll $s1,$t1,2   # s1 = sll($t1,2)
		add $s1,$s6,$s1 # s1 = B[j]
		move $t5,$zero  # t5 = j 
	
		# Load t3 = A[i+0] , t4 = B[j+0]
		lw $t3,0($s0) 
		lw $t4,0($s1)   
 		# Multiply and summate
		mult $t3,$t4  # t3*t4
		mflo $t3 # t3 = t3*t4
		add $t5,$t5,$t3 # t5+=t3

		
		# Load t3 = A[i+1], t4 = B[j+3]
		lw $t3,4($s0)
		lw $t4,32($s1)
		# Multiply and summate			
		mult $t4,$t3
		mflo $t3
		add $t5,$t5,$t3				

		
		# Load t3 = A[i+2], t4 = B[j+6]
		lw $t3,8($s0)
		lw $t4,64($s1)
		# Multiply and summate			
		mult $t4,$t3 
		mflo $t3 # t3 = t3*t4
		add $t5,$t5,$t3 # t5 += t3


		# Load t3 = A[i+2], t4 = B[j+6]
		lw $t3,12($s0)
		lw $t4,96($s1)
		# Multiply and summate			
		mult $t4,$t3 
		mflo $t3 # t3 = t3*t4
		add $t5,$t5,$t3 # t5 += t3


		# Load t3 = A[i+0] , t4 = B[j+0]
		lw $t3,16($s0) 
		lw $t4,128($s1)   
 		# Multiply and summate
		mult $t3,$t4  # t3*t4
		mflo $t3 # t3 = t3*t4
		add $t5,$t5,$t3 # t5+=t3

		
		# Load t3 = A[i+1], t4 = B[j+3]
		lw $t3,20($s0)
		lw $t4,160($s1)
		# Multiply and summate			
		mult $t4,$t3
		mflo $t3
		add $t5,$t5,$t3				

		
		# Load t3 = A[i+2], t4 = B[j+6]
		lw $t3,24($s0)
		lw $t4,192($s1)
		# Multiply and summate			
		mult $t4,$t3 
		mflo $t3 # t3 = t3*t4
		add $t5,$t5,$t3 # t5 += t3

		
		# Load t3 = A[i+2], t4 = B[j+6]
		lw $t3,28($s0)
		lw $t4,224($s1)
		# Multiply and summate			
		mult $t4,$t3 
		mflo $t3 # t3 = t3*t4
		add $t5,$t5,$t3 # t5 += t3

		# C[k] = t5
		sll $s2,$t2,2
		add $s2,$s7,$s2
		sw  $t5,0($s2)

		
		addi $t1,$t1,1 # j++
		addi $t2,$t2,1 # k++
		bne $t1,$t6,innerLoop
		
	move $t1,$zero # j = 0 
	addi $t0,$t0,8 # i += 3
    j outerLoop   


print:
	move $t0,$zero	
	move $s2,$s7
	printLoop:

		###Print###
		la $a0,newLine # Print a new line
		li $v0,4
		syscall 
		lw $a0,0($s2) 
		li $v0,1
		syscall		
		
		addi $t0,$t0,1
		sll  $s2,$t0,2
		add  $s2,$s7,$s2
		bne $t0,$t7, printLoop
		j exit
exit:
