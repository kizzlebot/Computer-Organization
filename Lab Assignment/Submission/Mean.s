##################################################################
# Data
##################################################################
.data
prompt: .asciiz "\n\nEnter up to 10 characters: " # Prompt asking for user input
newLine: .asciiz "\n"	# Newline character
theString: .asciiz " "	# A ten character string initially filled with whitespace

##################################################################
# Text
##################################################################
.text
##################################################################
##### Procedure: Main
##### Info: Asks user for input, gets input, and then call
##### procedures to manipulate the input and output.
##################################################################
main:

############################################################
# Print Prompt
############################################################
la $a0, prompt # Load address of prompt from memory into $a0
li $v0, 4 # Load Opcode: 4 (print string)
syscall # Init syscall


############################################################
# Read user input
############################################################


############################################################
# Print Prompt
############################################################
la $a0, prompt # Load address of prompt from memory into $a0
li $v0, 4 # Load Opcode: 4 (print string)
syscall # Init syscall

############################################################
# Read user input
############################################################


############################################################
# Calculate Mean for input set 1
############################################################


############################################################
# Calculate Mean for input set 2
############################################################
