#Laboratory 3, Home Assigment 2
.data
	A: .word -2, -1, -5, 4, 0, 6, 7, -8, -9
.text
	li $s0, 0 #max
	li $s1, -1
	addi $s2, $s2, -1 # khoi tao gia tri $s2
	li $s3, 9 # n=9
	li $s4, 1 # step
	la $s2, A # luu dia chi cua A
loop:	
	add $t1, $s1, $s1 # $t1 = 2 * $s1
	add $t1, $t1, $t1 # $t1 = 4 * $s1
	add $t1, $t1, $s2 # $t1 store the address of A[i]
	lw $t0, 0($t1) # load value of A[i] in $t0
	add $s1, $s1, $s4 # i = i + step
	
	# gia tri tuyet doi
	start: 
	slt $t4, $zero, $t0 # A[i] duong => $t4 = 1 else $t4 = 0
	beq $t4, $zero, else # if t4 = 0 (A[i] am) => else
	j endif
	else: mul $t0,$t0,-1
	endif: 
	
	# update max
	startt:
	slt $t5,$t0,$s0 # A[i] < max => $t5 = 1
	
	beq $t5,$zero,elsee # if t5 = 0 (A[i] >= max) => else
	j endiff:
	elsee: add $s0,$t0,$zero
	endiff:
	
	slt $t3,$s3,$s1 #n < i => t3=1
	beq $t3,0,loop # if i<=n, loop