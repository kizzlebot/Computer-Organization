##################################################################
#   Data
##################################################################
.data
prompt: .asciiz  "\n\nEnter a float: "  # Prompt asking for user input
newLine: .asciiz "\n"
lbl: .asciiz "\nMean:"								# Newline character
floatSet1: .float 0.11, 0.34, 1.23, 5.34, 0.76, 0.65, 0.34, 0.12, 0.87, 0.56 # A eleven-space float array initially filled with whitespace
floatSet2: .float 0.0, 42.2, 78.8, 129.4, 133.0, 0.0, 42.2, 78.8, 129.4, 133.0 
##################################################################
#   Text
##################################################################
.text 
##################################################################
#####   Procedure: Main
#####   Info:      Asks user for input of ten floats, then 
##################################################################
main:
	# Initialize incrementors
	move $t0, $zero
	move $t1, $zero
	addi $t7, $zero,10

	la $a1,floatSet1 # Load address of floatSet1into syscall argument a1
	mtc1 $zero,$f12

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
		
		
		la $a0,lbl
		li $v0,4
		syscall 

		li $v0,2
		syscall	
	j done
done:
	jr $ra
exit:
