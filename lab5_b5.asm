#Laboratory Exercise 5, Assignment 5
.data
	string: .space 50
	Message1: .asciiz "Nhap xau: "
	Message2: .asciiz "Xau dao nguoc la: "
	x: .space 50 # string x, empty
.text
main:
get_string: 
	li $v0, 54
	la $a0, Message1
	la $a1, string
	la $a2, 50
	syscall
get_length:
	la $a0,string # $a0 = address(string[0])
	xor $v1, $zero, $zero # v1 = length = 0
	xor $t0, $zero, $zero # t0 = i =0
check_char: 
	add $t1,$a0,$t0 # $t1 = $a0 + $t0
			# = address(string[i])
	lb $t2, 0($t1) # $t2 = string[i]
	beq $t2, $zero, end_of_str # is null char?
	addi $v1, $v1, 1 #length = length + 1
	addi $t0, $t0, 1 # $t0 = $t0 + 1 -> i = i + 1
	j check_char
end_of_str:
end_of_get_length:
	move $t4, $a0
inverse:
	addi $v1,$v1, -1
	li $v0, 4
	la $a0, Message2
	syscall
strcpy:
	add $s0,$zero,$zero # $s0 = i = 0
	la $a3, x #l?u ??a ch? x vào thanh ghi $a3
L1:
	add $t1,$v1,$t4 # $t1 = $v1 + $t4 = i + y[0]
			# = address of y[i]
	lb $t2,0($t1) # $t2 = value at $t1 = y[i]
	add $t3,$s0,$a3 # $t3 = $s0 + $a3 = i + x[0]
			# = address of x[i]
	sb $t2,0($t3) # x[i]= $t2 = y[i]
	beq $t2,$zero,end_of_strcpy # if y[i] == 0, exit
	nop
	addi $s0,$s0,1 # $s0 = $s0 + 1 <-> i = i + 1
	addi $v1, $v1, -1
	j L1 # next character
	nop
end_of_strcpy:
	li $v0, 4
	move $a0, $a3 #In ra giá tr? thanh ghi a3
	syscall
# K?t thúc ch??ng trình
  	li $v0, 10
 	 syscall
