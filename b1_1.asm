.data
prompt: .asciiz "Nh?p N: "
output: .asciiz "Các s? chia h?t cho 3 ho?c 5 nh? h?n N là : "
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
    move $t0, $v0     # Store N in $t0
    
    # Print output message
    li $v0, 4
    la $a0, output
    syscall
    subi $t0, $t0, 1      # Decrement N by 1
loop:
	addi, $s1, $zero, 3
	addi, $s2, $zero, 5
    
    # Check if N is divisible by 3 or 5
    div $t0, $s1
    mfhi $t1
    beqz $t1, print_num    # Jump to print_num if N is divisible by 3
    div $t0, $s2
    mfhi $t1
    beqz $t1, print_num    # Jump to print_num if N is divisible by 5
    subi $t0, $t0, 1      # Decrement N by 1
    bgtz $t0, loop        # If N is not zero, go back to loop
    j exit                 # Jump to exit if N is zero
    
print_num:
    # Print the number that is divisible by 5 or 7
    li $v0, 1
    move $a0, $t0
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall
    
    subi $t0, $t0, 1      # Decrement N by 1
    bgtz $t0, loop         # If N is not zero, go back to loop
    
exit:
    li $v0, 10
    syscall
