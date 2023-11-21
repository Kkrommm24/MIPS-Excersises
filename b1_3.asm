.data
    prompt: .asciiz "Enter a positive integer N: "
    result: .asciiz "Perfect squares smaller than N: "
    newline: .asciiz "\n"
.text   
.globl main
main:
    # Prompt user for input
    li $v0, 4
    la $a0, prompt
    syscall
    
    # Read input from user
    li $v0, 5
    syscall
    move $t1, $v0     # Store N in $t1
    
    # Print output message
    li $v0, 4
    la $a0, result
    syscall
# H�m ki?m tra m?t s? c� ph?i l� s? ch�nh ph??ng
isPerfectSquare:
        li $t2, 0             # Kh?i t?o bi?n ??m $t2 = 0   
loop:
	addi $t2, $t2, 1   # T?ng bi?n ??m $t2 l�n 1
        mul $t3, $t2, $t2  # T�nh b�nh ph??ng $t2
        blt $t3, $t1, printPerfectSquares  # N?u b�nh ph??ng b?ng s? c?n ki?m tra, chuy?n ??n nh�n foundSquare
	blt $t3, $t1, loop # N?u b�nh ph??ng nh? h?n s? c?n ki?m tra, ti?p t?c v�ng l?p
	j exit                 # Jump to exit if N is zero
# H�m in c�c s? ch�nh ph??ng nh? h?n N
printPerfectSquares:
	li $v0, 1
   	move $a0, $t3
   	syscall
    	li $v0, 4
    	la $a0, newline
    	syscall
    	blt $t3, $t1, loop # N?u b�nh ph??ng nh? h?n s? c?n ki?m tra, ti?p t?c v�ng l?p
exit:
    li $v0, 10
    syscall
        

