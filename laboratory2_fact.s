# Author: Nicholas Almeida
# Lab 2

# write a MIPS program which will recursively compute the factorial 
# of a non-negative value provided by the user.
.data
intial_message: .asciiz "This program will compute the factorial of a non-negative value provided by the user. Please enter a non-negative value: "
nl: .asciiz "\n"
factorial_message: .asciiz "The factorial of the value you entered is: "
.text

factorial:
	# using recursion to compute the factorial of a non-negative value
	# the base case is when the value is 0 or 1
	# the value is held in $a0
	# remember to store the return address before calling a function
	# and to restore the return address after the function returns

	# store the return address
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# if the value is 0 or 1, return 1
	li $t0, 1
	beq $a0, $t0, factorial_return_1
	li $t0, 0
	beq $a0, $t0, factorial_return_0

	# the number is greater than 1 so we need to call the function again
	# decrement the value by 1
	addi $a0, $a0, -1
	# call the function again
	jal factorial
	# if we get here then x = 1 so we need to multiply the value by x
	# add 1 to t0
	# add 1 to t0
	addi $t0, $t0, 1
	# multiply $a0 by $a1
	mult $a0, $t0
	# move the result into $a0
	mflo $a0
	# move the result into $v0
	move $v0, $a0
	# if the stack pointer does not match the original value in $a1
	# then we need pull the next value off the stack

	# restore the return address
	# and go to the address
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

factorial_return_1:
	# if the value is 1, so we start reversing the stack

	# store 1 in $t0 and $v0
	li $t0, 1
	move $v0, $t0

	# restore the return address
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
factorial_return_0:
	# if we get here the original value is zero, so no recursion has been done
	# restore the return address
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	# return 0
	li $v0, 0
	jr $ra

main:

	# print the initial message
	li $v0, 4
	la $a0, intial_message
	syscall

	# read the value from the user
	li $v0, 5
	syscall

	# store the value in $s0
	move $s0, $v0

	# move the value into $a0
	move $a0, $s0

	# store the original stack pointer location in $a1
	move $a1, $sp

	# call the factorial function
	jal factorial

	# move the result into $s1
	move $s1, $v0

	# print the factorial message
	li $v0, 4
	la $a0, factorial_message
	syscall

	# print the result
	li $v0, 1
	move $a0, $s1
	syscall

	# print a new line
	li $v0, 4
	la $a0, nl
	syscall
	
	li $v0, 10
	syscall
