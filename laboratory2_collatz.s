# Author: Nicholas Almeida
# Lab 2

# write a MIPS program which will recursively compute the 
# Collatz number and print a Collatz sequence of a positive value provided by the user.
.data
initial_message: .asciiz "This program will compute the Collatz number of a positive integer. Please enter a positive integer: "
collatz_message: .asciiz "The Collatz number is: "
collatz_sequence: .asciiz "The Collatz sequence is: "
spacing: .asciiz ", "
nl: .asciiz "\n"
.text
collatz:
    # put the value of the user input into $t0
	move $t0, $a0

	# add 1 to the value of $a1
	addi $a1, $a1, 1

	# store the return address on the stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	li $v0, 1

	# if the value is 1, print it and return
	beq $t0, $v0, collatz_end_1

	# print the value
	li $v0, 1
	move $a0, $t0
	syscall

	# print a comma
	li $v0, 4
	la $a0, spacing
	syscall

	# check if the value is even
	li $t1, 1
	and $t1, $t0, $t1
	beq $t1, $zero, collatz_even

	# if the value is odd, multiply by 3 and add 1
	li $t1, 3
	mult $t0, $t1
	mflo $t0
	addi $t0, $t0, 1
	move $a0, $t0
	j collatz

	# if the value is even, divide by 2
collatz_even:
	li $t1, 2
	div $t0, $t1
	mflo $a0
	j collatz

	# print the value and return



collatz_end_1:
	# the value is 1, print it and return
	li $v0, 1
	move $a0, $t0
	syscall

	# print nl
	li $v0, 4
	la $a0, nl
	syscall

	# move the value to the return register
	move $v0, $a1

	# restore the return address
	addi $sp, $sp, 4
	lw $ra, 0($sp)

	# return 
	jr $ra

main:
	# print initial message
	li $v0, 4
	la $a0, initial_message
	syscall

	# read in user input
	li $v0, 5
	syscall

	# store the user input in $s1
	move $s1, $v0

	# put the value of the user input into $t1
	# print the sequence message
	li $v0, 4
	la $a0, collatz_sequence
	syscall

	# store the input in argument register
	move $a0, $s1

	# put zero in arg 2
	li $a1, 0

	# call collatz function
	jal collatz

	# store the result 
	move $s0, $v0

	# print the collatz number
	li $v0, 4
	la $a0, collatz_message
	syscall

	li $v0, 1
	move $a0, $s0
	syscall

	# print a new line
	li $v0, 4
	la $a0, nl
	syscall
	
	li $v0, 10
	syscall
