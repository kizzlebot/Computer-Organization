# James Choi
# EEL 3801 - Lab Project #1
# June 16, 2013
# BubbleSort.s
#
# This program takes a user input of 10 characters and sorts 
# them using bubble sort algorithm.
#    a.) Input assumed to be within ascii range 65 - 123
#    b.) ASCII range 97-122 are converted to uppercase
.data
prompt: .asciiz  "\n\nEnter up to 10 characters: "
answer: .asciiz  "Sorted: "
newLine: .asciiz "\n"
charList: .word 10 # 10 byte space 
theString: .asciiz "           "

.text 
main:
	# print prompt
	la $a0, prompt   # Load address of prompt from memory into $a0
	li $v0, 4        # Load Opcode: 4 (print string) 
	syscall          # Init syscall
	
	# read theSTring
	la $a0,theString  # load address of theString
	li $a1,11  # length+1
	li $v0,8   # opcode 8
	syscall
	
	li $s7,10           # s7 upper index
	
	jal uppercase
	jal sort
	jal print
	j exit

uppercase:
	la $t0, theString   # Load address to theString into $t0
	add $t6,$zero,$zero # Set index i = 0 $t6
	addi $t7,$zero,10   # Set upper bound to ten $t7
	

	lupper:
		beq $t6,$t7,finishUppercase 

		add $s2,$t0,$t6 # t1 = addressofTheString+i
		lb  $t1,0($s2)
		# if t1 > 96 && t1 < 123
		sgt  $t2,$t1,96
		slti $t3,$t1,123
		and $t3,$t2,$t3
		beq $t3,$zero,good
		addi $t1,$t1,-32
		sb   $t1, 0($s2)
		good:
		
		addi $t6,$t6,1

		j lupper
finishUppercase:
	jr $ra

sort:	
	add $t0,$zero,$zero # t0 = 0
	la  $s0,theString
	
	loop:
		beq $t0,$s7,done
		sub $t7,$s7,$t0
		addi $t7,$t7,-1
		
		add $t1,$zero,$zero
		jLoop:
			beq $t1,$t7,continue
			
			# load s1 = array[j], s2 = array[j+1]
			add $t6,$s0,$t1
			lb  $s1,0($t6)
			lb  $s2,1($t6)
			
		
			good2:
			# if a[j] > a[j+1] swap
			sgt $t2, $s1,$s2
			beq $t2, $zero, afterIf
			sb  $s2,0($t6)
			sb  $s1,1($t6)
			
			afterIf:
			addi $t1,$t1,1
			j jLoop
		continue:
		addi $t0,$t0,1
		j loop
done:
	jr $ra
	
	

print:
	la $t0, theString   # Load address to theString into $t0
	add $t6,$zero,$zero # Set index i = 0 $t6
	addi $t7,$zero,10   # Set upper bound to ten $t7
	
	# print a new line
	la $a0,newLine
	li $v0,4
	syscall 
	
	lprint:
		beq $t6,$t7,finishPrint  

		add $t1,$t0,$t6 # t1 = addressofTheString+i

		lb $a0, 0($t1)  # 
		li $v0, 11      # System Call Code 11 is for print
		syscall

		addi $t6,$t6,1
		j lprint
finishPrint:
	jr $ra
exit:
