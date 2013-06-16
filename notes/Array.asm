.data
list: .word 1, 2, 3, 14, 5, 6

.text
Start:
# Load base address of array
la $s0, list


lw $t1, 8($s0)

subi $t0, $t1,14
addi $t2, $t1,7

sw $t0,12($s0)
sw $t2,16($s0)
