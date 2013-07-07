.text
.globl main
main:

 la $s0,size
 lw $s1,0($s0)      # size in $s1
 ori $s2,$zero,0    # i in $s2
 la $s3,arr         # arr in $s3

 li $v0,4
 la $a0,msg1
 syscall

 L1:
  beq $s2,$s1,DONE
  li $v0,6
  syscall
  swc1 $f0,0($s3)
  j UPDATE

 UPDATE:
  addi $s3,$s3,4
  addi $s1,$s1,1
  j L1

 DONE:
  li $v0,4
  la $a0,msg2
  syscall

  la $t0,arr
  ori $t1,$zero,0
  L2:
   beq $t1,$s1,EXIT
   lwc1 $f20,0($t0)
   li $v0,2
   mov.s $f12,$f20
   syscall
   addi $t0,$t0,4
   addi $t1,$t1,1
   j L2

  EXIT:
  li $v0,10
  syscall
    .data
  size: .word  9
  arr:  .float  0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0 
  msg1: .asciiz "Enter the elements:-"
  msg2: .asciiz "The elements are:-" 0.0
