##################################################################
##   Data
##################################################################
.data
prompt: .asciiz  "\n\nEnter a float: "  # Prompt asking for user input
newLine: .asciiz "\n"
dotProdLbl: .asciiz "\ndotProduct: "								# 
sumLbl:  .asciiz "\nSum: "
floatSet1: .float 0.11, 0.34, 1.23, 5.34, 0.76, 0.65, 0.34, 0.12, 0.87, 0.56 # A eleven-space float array initially filled with whitespace
floatSet2: .float 7.89, 6.87, 9.89, 7.12, 6.23, 8.76, 8.21, 7.32, 7.32, 8.22
##################################################################
#   Text
##################################################################
.text 
##################################################################
#####   Procedure: Main
####   Info:      Asks user for input of ten floats, then 
##################################################################
.globl main
main:
	# Initialize registers
	move $t0, $zero    # Lower bound
	move $t1, $zero    # lowerBound<<2
	addi $t7, $zero,10 # Upper Bound
	mtc1 $zero,$f12    # Print arg f12

	# Load the two float lists
	la $a1,floatSet1 # Load into a1 address of floatSet1 
	la $a2,floatSet2 # Load into a2 address of floatSet2
	
	# Calculate Dot Product
	jal dotProd
	
	j exit
dotProd:
	dotSub:
		beq $t0,$t7,dotAfter
		add $t2,$a1,$t1 	
		add	$t3,$a2,$t1
		l.s $f2,0($t2)
		l.s $f3,0($t3)
		
		mul.s $f2,$f2,$f3 
		add.s $f12,$f12,$f2

		
		addi $t0,$t0,1
		sll $t1,$t0,2
		j dotSub 
	dotAfter:

		# Save ra in stack and goto truncate procedure
		addi $sp,$sp,-4
		sw $ra,0($sp)
		jal truncate
		# bring ra back from stack and move stack pointer back
		lw $ra,0($sp)
		addi $sp,$sp,4


		# Print the dot product label
		la $a0,dotProdLbl
		li $v0,4
		syscall 
		# Print the dot product value
		li $v0,2
		syscall
		
		# Reset value of param
		mtc1 $zero,$f12
	j done
truncate:
	## Multply by 100
	li $t5,100
	mtc1 $t5,$f5
	cvt.s.w $f5,$f5
	mul.s $f12,$f12,$f5
	
	trunc.w.s $f12,$f12

	cvt.s.w $f12,$f12
	div.s $f12,$f12,$f5
	jr $ra
done:
	move $t0, $zero
	move $t1, $zero
	jr $ra
exit:
