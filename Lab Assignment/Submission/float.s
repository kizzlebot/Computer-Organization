##################################################################
#   Data
##################################################################
.data
prompt: .asciiz  "Enter a float: "  # Prompt asking for user input
newLine: .asciiz "\n"								# Newline character
meanLbl: .asciiz "\nMean: "								# Newline characte
dotProdLbl: .asciiz "\nDot Product: "		
sumLbl:  .asciiz "\nSum: "
floatSet1: .float 0.11, 0.34, 1.23, 5.34, 0.76, 0.65, 0.34, 0.12, 0.87, 0.56
floatSet2: .float 7.89, 6.87 ,9.89 ,7.12 ,6.23, 8.76, 8.21, 7.32, 7.32, 8.22  # A eleven-space float array initially filled with whitespace
##################################################################
#   Text
##################################################################
.text 


####****************************************************************************************************####
#####   Procedure: Main
#####   Argument:  n/a
#####   Info:      Asks user for input of ten floats, calculates mean, calculates dot product then exits
####****************************************************************************************************####
main:
	# Initialize incrementors
	move $t0, $zero
	move $t1, $zero
	addi $t7, $zero,10


	
	############################################################
	#  Read floatSet1
	############################################################
	#la $a1,floatSet1 # Load address of floatSet1into syscall argument a1
	#jal read         # Jump to read function   
	#jal printArray
	############################################################
	#  Read floatSet2
	############################################################
	#la $a1,floatSet2 # Load address of floatSet1into syscall argument a1
	#jal read         # Jump to read function   
	#jal printArray

	############################################################
	#  Calculate Mean 
	############################################################
	la $a1,floatSet1
	mtc1 $zero,$f12
	jal mean
	############################################################
	#  Calculate Mean 
	############################################################
	la $a1,floatSet2
	mtc1 $zero,$f12
	jal mean
	

	############################################################
	#  Calculate Dot Product
	############################################################
	la $a1,floatSet1
	la $a2,floatSet2
	jal dotProd
	


	j exit	
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
#!!!!!!!!!!!!!!!!!!!!!!!!! end main !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#

####****************************************************************************************************####
##### Function:    dotProd
##### Argument:    $a1 (baseaddress1), $a2 (baseaddress2), $t0 (lower bound), $t7 (upperbound)
##### Returns :    
##### Description: calculates the mean and places in array[10]
####****************************************************************************************************####
dotProd:
	mtc1 $zero,$f12    # Print arg f12
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
####****************************************************************************************************####
##### Function:    mean
##### Argument:    $a1 (baseaddress), $t0 (lower bound), $t7 (upperbound)
##### Returns :    
##### Description: calculates the mean and places in array[10]
####****************************************************************************************************####
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
		# Calculate mean 
		mtc1 $t7,$f0
		cvt.s.w $f0,$f0
		div.s $f12,$f12,$f0
		#trunc.w.s $f12,$f12

		# Truncate
		# Save ra in stack and goto truncate procedure
		addi $sp,$sp,-4
		sw $ra,0($sp)
		jal truncate
		# bring ra back from stack and move stack pointer back
		lw $ra,0($sp)
		addi $sp,$sp,4

		# print mean label
		la $a0,meanLbl
		li $v0,4
		syscall 
		# print digit
		li $v0,2
		syscall
		

	j done

####****************************************************************************************************####
##### Function:    read  
##### Argument:    $a1 (baseaddress), $t0 (lower bound), $t7 (upperbound)
##### Description: Reads array starting at baseaddress $a1 ten times 
####****************************************************************************************************####
read:
	beq $t0,$t7,done
	# t3 = baseAddr+offset
	add $t2,$a1,$t1 
############################################################################################################

	############################################################
	#  Print Prompt
	############################################################
 	la $a0, prompt   # Load address of prompt from memory into $a0
	li $v0, 4        # Load Opcode: 4 (print string) 
	syscall          # Init syscall

		
	#############################################
	#  Read User Input into address of f0
	#############################################
	li $v0,6          # Load Opcode: 6 (Read float)
	syscall

	#############################################
	#  Store User Input into address of floatSet1 index
	#############################################
	s.s $f0,0($t2)

############################################################################################################
	addi $t0,$t0,1
	sll $t1,$t0,2
	j read
####****************************************************************************************************####
#### read end ##############################################################################################
####****************************************************************************************************####




####****************************************************************************************************####
##### Function:    printArray
##### Argument:    $a1 (baseaddress)
##### Description: Print array starting at baseaddress $a1 ten times 
####****************************************************************************************************####
printArray:
	beq $t0,$t7,done
	# t2 = baseAddr+offset
	add $t2,$a1,$t1
############################################################################################################
	
	####################################
	# Print a index
	####################################	
	l.s $f12,0($t2)
	li $v0, 2
	syscall


	####################################
	# Print a new line
	####################################
	la $a0,newLine
	li $v0,4
	syscall 

############################################################################################################
	addi $t0,$t0,1
	sll $t1,$t0,2
	j printArray
####****************************************************************************************************####
######### Print End ########################################################################################
####****************************************************************************************************####


####****************************************************************************************************####
##### Function:    truncate
##### Argument:    $f12 must contain single float you want to truncate
##### Description: Resets incrementors and jumps back to return address
####****************************************************************************************************####
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

####****************************************************************************************************####
##### Function:    done  
##### Argument:    n/a    
##### Description: Resets incrementors and jumps back to return address
####****************************************************************************************************####
done:
	# Reset incrementors
	move $t0,$zero
	move $t1,$zero
	mtc1 $zero,$f12
	jr $ra 
####****************************************************************************************************####
######### done End #########################################################################################
####****************************************************************************************************####
exit:
