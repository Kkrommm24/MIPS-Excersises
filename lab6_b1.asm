.data
	A: .space 100 #khoi tao mang A
	Message1: .asciiz "Nhap do dai mang: "
	Message2: .asciiz "Nhap phan tu mang : "
.text
main: 
	la $a3,A # gan $a3 la dia chi cua A
	j insert
after_insert:
	la $a0, A
	la $a1, ($t0) #gan lai so phan tu mang vao $a1
	j mspfx # nhay toi ham tinh toan
	nop
continue:
lock: 
	j mspfx_end
	nop
end_of_main:

insert: 
	li $v0, 4 #syscall in ra chuoi
	la $a0, Message1
	syscall
	li $v0, 5
	syscall
	la $t0, ($v0) #luu tam thoi do dai mang vao $t0
	li $t1, 0
loop_insert:
	beq $t1, $t0, after_insert #quay tro lai main 
	li $v0, 4 #syscall in ra chuoi
	la $a0, Message2
	syscall
	li $v0, 5
	syscall
	sw $v0, 0($a3)
	addi $t1, $t1, 1
	add $a3, $a3, 4
	j loop_insert

mspfx: 
	addi $v0,$zero,0 #initialize length in $v0 to 0
	addi $v1,$zero,0 #initialize max sum in $v1 to 0
	addi $t0,$zero,0 #initialize index i in $t0 to 0
	addi $t1,$zero,0 #initialize running sum in $t1 to 0
loop: 
	add $t2,$t0,$t0 #put 2i in $t2
	add $t2,$t2,$t2 #put 4i in $t2
	add $t3,$t2,$a0 #put 4i+A (address of A[i]) in $t3
	lw $t4,0($t3) #load A[i] from mem(t3) into $t4
	add $t1,$t1,$t4 #add A[i] to running sum in $t1
	slt $t5,$v1,$t1 #set $t5 to 1 if max sum < new sum
	bne $t5,$zero,mdfy #if max sum is less, modify results
	j test #done?
mdfy: 
	addi $v0,$t0,1 #new max-sum prefix has length i+1
	addi $v1,$t1,0 #new max sum is the running sum
test: 
	addi $t0,$t0,1 #advance the index i
	slt $t5,$t0,$a1 #set $t5 to 1 if i<n
	bne $t5,$zero,loop #repeat if i<n
done: 
	j continue
mspfx_end:
