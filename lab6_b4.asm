.data
	A: .word 7, 6, 4, 5, 1, 3, 2, 12, 9, 10, 8, 15, 21
.text
main: 	
	li $a2, 13 #a2 = n
	la $a0,A #$a0 = Address(A[0])
	j sort #sort
after_sort: 
	li $v0, 10 #exit
	syscall
end_main:

sort: 	
	li $t1, 0 #i = 0
	addi $t0, $a0, 0 # t0 = *a[0]

for_loop:
	addi $t1, $t1, 1 #i++
	addi $t0, $t0, 4
	beq $t1, $a2, end_for_loop #i = n =>endloop
	
	lw $t2, 0($t0) #t2 = A[i] x=a[i]
	addi $t3,$t1,-1 #t3 = i-1 pos = i-1
	addi $t5, $t0, 0
  while_loop:
	blt $t3, $zero, end_while_loop #pos < 0 =>endloop
	lw $t4, -4($t5) #t4 = A[pos]
	
	#x <a[pos] => s1 = 1
	slt $s1, $t2, $t4
	beq $s1, $zero, end_while_loop
	
	#a[pos+1] = a[pos]
	sw $t4, 0($t5)
	addi $t5, $t5, -4
	addi $t3, $t3, -1
	j while_loop
  end_while_loop:
	sw $t2, 0($t5)
	j for_loop
end_for_loop:
	j after_sort


