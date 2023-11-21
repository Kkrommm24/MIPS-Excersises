#Laboratory Exercise 3, Home Assignment 1
start:
	addi $s2, $zero, 4 # j = 4
	addi $s1, $zero, 1 # i = 1
	add $s3, $s2, $s1
	slt $t0,$zero,$s3 # i+j<=0 => ki?m tra ?i?u ki?n 0<i+j
	bne $t0,$zero,else # Ch?y if n?u i+j<=0, ch?y else n?u 0<i+j
	addi $t1,$t1,1 # x=x+1
	addi $t3,$zero,1 # z=1
	j endif # skip “else” part
else: 	addi $t2,$t2,-1 # begin else part: y=y-1
	add $t3,$t3,$t3 # z=2*z
endif: