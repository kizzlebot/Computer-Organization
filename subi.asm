.data
list: .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20

.text
la $s0,list			
addi $t0,$zero,20
start:
	addi $t0,$t0,-1  # decrement loop index first so the 0th iteration will execute
	
	sll $t1,$t0,2  # t1: 4-byte increment of index 
	add $t1,$t1,$s0 # t1[0] = A[t1]
	lw  $t2,0($t1)  # t2 = t1[0]
	
	andi $t3,$t0,1  # Mask
	bne  $t3,$zero,odd # if odd then go to odd
	addi $t3,$t2,1     # else just increment (reuse t3)
	
	addi $s6,$s6,1	   # use T6 to count evens
	
	j afterDecInc      # jump to steps after inc or dec
odd:
	addi $t3,$t2,-1    # decrement
	addi $s7,$s7,1	   # use T7 to count evens
afterDecInc:
	sw $t3,0($t1)      # store to index

	bne $t0,$zero,start  #
exit:
	lw $t0,0($s0) #1 - 0
	lw $t1,4($s0) #2 - 3
	lw $t2,8($s0) #3 - 2
	lw $t3,12($s0)#4 - 5
	lw $t4,16($s0)#5 - 4
	lw $t5,20($s0)#6 - 7
	lw $t6,24($s0)#7 - 6
	lw $t7,28($s0)#8 - 9
	lw $t0,52($s0)#9 - 8
	lw $t1,56($s0)#10 - b
	lw $t2,60($s0)#11 - a
	lw $t3,64($s0)#12 - d
	lw $t4,68($s0)#13 - c
	lw $t5,72($s0)#14 - e
	lw $t6,76($s0)#15 - f
	lw $t7,80($s0)#16 - 1