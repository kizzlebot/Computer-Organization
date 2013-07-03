.data
prompt: .asciiz "\n\nEnter an integer: "
answer: .asciiz "\nThe sum is "
.text


main: 
# Display Prompt
li $v0, 4
la $a0, prompt
syscall
# Read integer
li $v0, 5
syscall
move $s0, $v0
# Display Prompt
li $v0, 4
la $a0, prompt
syscall
# Read integer
li $v0, 5
syscall
move $s1, $v0
# Add two numbers
add $s2, $s1, $s0
# Display the answer
li $v0, 4
la $a0, answer
syscall
move $a0, $s2
li $v0, 1
syscall
#Exit
li $v0, 10
syscall
