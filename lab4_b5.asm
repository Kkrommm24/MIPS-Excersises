#Laboratory Exercise 4, Assignment 5
.text
	li $s1 6
	li $s2 32
	li $s0 0
	LOOP:
	addi $s0,$s0,1
	div $s2,$s2,2
	sll $s1,$s1,1
	beq $s2,1,exit
	j LOOP
	exit:
