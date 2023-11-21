#Laboratory Exercise 5, Assignment 2
.data
	x: .asciiz "Enter value for s0: "
	y: .asciiz "Enter value for s1: "
	the_sum_of: .asciiz "The sum of "
	s0_and : .asciiz " and "
	s1_text: .asciiz " is "
.text
     main:
     	# x
	li $v0, 4
	la $a0, x
	syscall
	
	#Read s0
	li $v0, 5
	syscall
	move $s0, $v0
	
	# y
	li $v0, 4
	la $a0, y
	syscall
	
	# Read s1
	li $v0, 5
	syscall
	move $s1, $v0
	
	# add s0, s1
	add $t0, $s0, $s1
	
	#Print result_msq
	li $v0, 4  
	la $a0, the_sum_of     
	syscall             

	move $a0, $s0
	li $v0, 1
	syscall
	
	li $v0, 4  
	la $a0, s0_and   
	syscall 
	
	move $a0, $s1
	li $v0, 1
	syscall
	
	li $v0, 4  
	la $a0, s1_text  
	syscall 
	
	move $a0, $t0       
	li $v0, 1           
	syscall             

	# End the program
	li $v0, 10          
	syscall       