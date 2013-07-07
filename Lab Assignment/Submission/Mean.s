##################################################################
#   Data
##################################################################
.data
prompt: .asciiz  "\n\nEnter a float: "  # Prompt asking for user input
newLine: .asciiz "\n"
meanLbl: .asciiz "\nMean: "								# 
sumLbl:  .asciiz "\nSum: "
floatSet1: .float 0.11, 0.34, 1.23, 5.34, 0.76, 0.65, 0.34, 0.12, 0.87, 0.56 # A eleven-space float array initially filled with whitespace
floatSet2: .float 7.89, 6.87, 9.89, 7.12, 6.23, 8.76, 8.21, 7.32, 7.32, 8.22
##################################################################
#   Text
##################################################################
.text 
##################################################################
#####   Procedure: Main
#####   Info:      Asks user for input of ten floats, then 
##################################################################
.globl main
main:
	# Initialize incrementors
	move $t0, $zero
	move $t1, $zero
	addi $t7, $zero,10

	la $a1,floatSet1 # Load address of floatSet1into syscall argument a1
	mtc1 $zero,$f1
	jal mean
	
	la $a1,floatSet2 # Load address of floatSet1into syscall argument a1
	mtc1 $zero,$f1
	jal mean
	
	
	j exit
mean:
	meanSubroutine:
		beq $t0,$t7,meanDiv
		add $t2,$a1,$t1 	

		l.s $f2,0($t2)
		add.s $f12,$f12,$f2

		addi $t0,$t0,1
		sll $t1,$t0,2
		j meanSubroutine
	meanDiv:
		# Print the sum
		la $a0,sumLbl 
		li $v0,4
		syscall 

		li $v0,2
		syscall


		la $a0,meanLbl
		li $v0,4
		syscall 
		
		mtc1 $t7,$f0
		cvt.s.w $f0,$f0
		div.s $f12,$f12,$f0
		li $v0,2
		syscall
		
		mtc1 $zero,$f12
		mtc1 $zero,$f1
	j done
done:
	move $t0, $zero
	move $t1, $zero
	jr $ra
exit:
