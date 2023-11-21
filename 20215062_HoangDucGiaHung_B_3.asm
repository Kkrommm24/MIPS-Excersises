.data
arr:	.word 100
A: .asciiz "Nhap vao so phan tu cua mang: "
B: .asciiz "Nhap phan tu: "
space:	.asciiz " "
output:	.asciiz "Cap phan tu lien ke co tich lon nhat la: "
.text
.globl main

main:
	li $v0, 4
	la $a0, A
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0  # Store value in $t0
	
# Insert array's elements
	li $t1, 0 # count element index
	la $t2, arr	
	li $v0, 4
	la $a0, B
	syscall
	
input:
	li $v0, 5
	syscall
	sw $v0, 0($t2)	# Save element's value into array
	
	addi $t1, $t1, 1	# +1 thêm vào index
	addi $t2, $t2, 4	# +4 vào ??a ch?
	
	beq $t1, $t0, start	# n?u i = n => nh?y ??n start
	j input

start:
	la $t2, arr	# load array's address into $t2
	
	lw $s1, 0($t2)	# Load A[i]
	lw $s2, 4($t2)	# Load A[i+1]
	mul $t3, $s1, $s2 # A[i] * A[i+1]
	addi $t2, $t2, 4 #point to array's new address
	move $s4, $s1	# luu gia tri s1 vao
	move $s5, $s2	# luu gia tri s2 vao
	li $t1, 1	# increment (Equals to 1 because first one has already been counted)
	beq $t1, $t0, print	# neu chuoi chi co 2 phan tu thi nhay den print

compare:
	
	lw $s1, 0($t2)
	lw $s2, 4($t2)
	mul $t4, $s1, $s2
	addi $t2, $t2, 4# tang gia tri con tro mang len 1
	addi $t1, $t1, 1# tang gia tri index len 1

	sgt $s3, $t4, $t3
	beq $t1, $t0, print
	beq $s3, 1, update_values	# If A[i] * A[i+1] new is greater than older one, then update values
	j compare

update_values:
	move $s4, $s1
	move $s5, $s2
	move $t3, $t4
	j compare

print:
#Print output
	la $t3, output
	li $v0, 4
	addi $a0, $t3, 0
	syscall
	
	li $v0, 1
	addi $a0, $s4, 0
	syscall
	
	la $t3, space
	li $v0, 4
	addi $a0, $t3, 0
	syscall
	
	li $v0, 1
	addi $a0, $s5, 0
	syscall
exit:
	li $v0, 10      
	syscall