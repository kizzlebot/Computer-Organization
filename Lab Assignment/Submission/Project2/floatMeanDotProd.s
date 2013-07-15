.data
prompt: .asciiz  "(List A) Enter a float: "               # Label to print out when asking user for input
newLine: .asciiz "\n"					              	  # Newline character just in case
meanLbl: .asciiz "\nThe Mean of A = "		              # Label to print out when displaying mean
dotProdLbl: .asciiz "\nThe dot product of A and B = "	  # Label to print out when displaying dotproduct
# Two lists of 	
floatSet1: .float 0.11, 0.34, 1.23, 5.34, 0.76, 0.65, 0.34, 0.12, 0.87, 0.56
floatSet2: .float 7.89, 6.87 ,9.89 ,7.12 ,6.23, 8.76, 8.21, 7.32, 7.32, 8.22  




.text 
.globl main
##################################################################
#   Text
##################################################################


####****************************************************************************************************####
#####   Procedure: main
#####   Argument:  n/a
#####   Info:      Asks user for input of ten floats, calculates mean, calculates dot product then exits
####****************************************************************************************************####
main:
	############################################################
	#  Initialize 
	############################################################
	move $t0, $zero
	move $t1, $zero
	addi $t7, $zero,10

	############################################################
	#  Read floatSet1
	############################################################
	la $a1,floatSet1 # Load address of floatSet1into syscall argument a1
	jal read         # Jump to read function   	
	############################################################
	#  Read floatSet2
	############################################################
	la $a1,floatSet2 # Load address of floatSet1into syscall argument a1
	jal read         # Jump to read function   
	

	############################################################
	#  Calculate Mean1 
	############################################################
	la $a1,floatSet1
	jal mean
	############################################################
	#  Calculate Mean2
	############################################################
	la $a1,floatSet2
	jal mean

	############################################################
	#  Calculate Dot Product
	############################################################
	la $a1,floatSet1
	la $a2,floatSet2
	jal dotProd
	
	j exit	
####****************************************************************************************************###############
#### main end #########################################################################################################
####****************************************************************************************************###############



####****************************************************************************************************####
##### Procedure:    read  
##### Argument:     $a1 (baseaddress), $t0 (lower bound), $t7 (upperbound)
##### Description:  Reads userinput and saves to list starting at baseaddress $a1 ten times 
####****************************************************************************************************####
read:
	beq $t0,$t7,readChangePrompt
	# t3 = baseAddr+offset
	add $t2,$a1,$t1


############ Loop Body #####################################################################################
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
############ Loop Body end #################################################################################

	addi $t0,$t0,1
	sll $t1,$t0,2
	j read

	####****************************************************************************************************####
	##### Procedure:   readChangePrompt 
	##### Returns :    n/a
	##### Description: changes the prompt to read "(List B) Enter a float"  
	####****************************************************************************************************####
	readChangePrompt:
		# Change the prompt label to say "(List B) Enter a float "
		la $s5,prompt
		lb $t5,6($s5)
		addi $t5,$t5,1
		sb $t5,6($s5)
		
	j done
####****************************************************************************************************###############
#### read end #########################################################################################################
####****************************************************************************************************###############


####****************************************************************************************************####
##### Procedure:    dotProd
##### Argument:     $a1 (baseaddress1), $a2 (baseaddress2), $t0 (lower bound), $t7 (upperbound)
##### Returns :     n/a
##### Description:  calculates the dotproduct between list with baseaddress a1 and a2, then prints result
####****************************************************************************************************####
dotProd:
	# Initialize f12, where we save calculation
	mtc1 $zero,$f12    
	####****************************************************************************************************####
	##### Procedure:   dotCalculate
	##### Returns :    n/a
	##### Description: Uses loop to calculate dotProduct between lists with baseAddress in a1 and a2
	####****************************************************************************************************####
	dotCalculate:
		beq $t0,$t7,dotPrint
		add $t2,$a1,$t1 	
		add	$t3,$a2,$t1
		l.s $f2,0($t2)
		l.s $f3,0($t3)

############ Loop Body #####################################################################################
		# Multiply a[i] and b[i]
		mul.s $f2,$f2,$f3 
		# Summate f12
		add.s $f12,$f12,$f2
############ Loop Body end #################################################################################

		addi $t0,$t0,1
		sll $t1,$t0,2
		j dotCalculate 
	####****************************************************************************************************####
	##### Procedure:    dotPrint
	##### Argument:     $a1 (baseAddress for floatSet1), $a2 (baseAddress for floatSet2), $t0 (Lower bound), $t7 (upper bound)
	##### Returns :     n/a
	##### Description:  Truncates calculated value and then prints dotProduct label with dotProduct value
	####****************************************************************************************************####
	dotPrint:
		####### Truncate ########
		# Save ra in stack and goto truncate procedure
		addi $sp,$sp,-4
		sw $ra,0($sp)
		jal truncate
		# bring ra back from stack and move stack pointer back
		lw $ra,0($sp)
		addi $sp,$sp,4


		####### Print label and value ########
		# Print the dot product label
		la $a0,dotProdLbl
		li $v0,4
		syscall 
		# Print the dot product value
		li $v0,2
		syscall
		
	j done		
####****************************************************************************************************###############
#### dotProduct end ###################################################################################################
####****************************************************************************************************###############


####****************************************************************************************************####
##### Procedure:    mean
##### Argument:     $a1 (baseaddress), $t0 (lower bound), $t7 (upperbound)
##### Returns :     n/a
##### Description:  calculates the mean of list in $a1 
####****************************************************************************************************####
mean:
	mtc1 $zero,$f12 # Clear whatever is in f12
	####****************************************************************************************************####
	##### Procedure:   meanCalculate
	##### Returns :    n/a
	##### Description: Uses loop to calculate dotProduct between lists with baseAddress in a1 and a2
	####****************************************************************************************************####
	meanCalculate:
		beq $t0,$t7,meanPrint
		add $t2,$a1,$t1 	

############ Loop Body #####################################################################################
		l.s $f2,0($t2)
		add.s $f12,$f12,$f2
############ Loop Body end #################################################################################

		addi $t0,$t0,1
		sll $t1,$t0,2
		j meanCalculate
	####****************************************************************************************************####
	##### Procedure:    meanPrint
	##### Returns :     n/a
	##### Description:  Does division operation, truncates answer, and then prints meanLabel and calculated value
	####****************************************************************************************************####
	meanPrint:
		# Calculate mean 
		mtc1 $t7,$f0
		cvt.s.w $f0,$f0
		div.s $f12,$f12,$f0
		#trunc.w.s $f12,$f12

		# Truncate answer
		# Save ra in stack and goto truncate procedure
		addi $sp,$sp,-4    # move stack pointer down one space 
		sw $ra,0($sp)	   # store return address in created space
		jal truncate       # jump and link to truncate procedure
		# bring ra back from stack and move stack pointer back
		lw $ra,0($sp)
		addi $sp,$sp,4

		# print mean label
		la $a0,meanLbl
		li $v0,4
		syscall 
		# print mean value 
		li $v0,2
		syscall
		
		# Change the mean label to say "The Mean of B" for the next call
		la $s5,meanLbl
		lb $t5,13($s5)
		addi $t5,$t5,1
		sb $t5,13($s5)

	j done
####****************************************************************************************************###############
#### mean end ###################################################################################################
####****************************************************************************************************###############




####****************************************************************************************************####
##### Procedure:    truncate
##### Argument:     $f12 must contain single float you want to truncate
##### Description:  truncates the whatever float is contained in f12
####****************************************************************************************************####
truncate:
	li $t5,100            # Load 100 (word)  
	mtc1 $t5,$f5          # move 100 (word) to coprocessor1
	cvt.s.w $f5,$f5		  # convert f5 (word) to f5 (single float)
	mul.s $f12,$f12,$f5	  # multiply f12 (single float) and f5 (single float)
	
	trunc.w.s $f12,$f12	  # truncate single precision to word

	cvt.s.w $f12,$f12     # convert f12 (word) to f12 (single float)
	div.s $f12,$f12,$f5	  # divide f12 (single float) with f5 (single float)
	jr $ra  			  # jump back
####****************************************************************************************************###############
#### truncate end #####################################################################################################
####****************************************************************************************************###############



####****************************************************************************************************####
##### Procedure:    done  
##### Argument:     n/a    
##### Description:  Resets incrementors and jumps back to return address
####****************************************************************************************************####
done:
	# Reset incrementors
	move $t0,$zero
	move $t1,$zero
	jr $ra 
####****************************************************************************************************####
######### done End #########################################################################################
####****************************************************************************************************####

exit:
    li      $v0, 10              # terminate program run and
    syscall                      # Ex