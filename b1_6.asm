.data
	prompt: .asciiz "Nh?p N: "
     output: .asciiz "s? bát phân c?a N là:  "
     
.text
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
   
    li $t1, 0    # p    
    li $t2, 0    # initialize bát phân
    li $t3, 8    # khai bao so chia 8
    li $t4, 1    # 10^p
    li $t5, 10
main:  
    div $t0,$t0, $t3  
    mfhi $s1
    move $s0, $t1
    jal luythua
    nop
    mul $t6, $s1, $t4 
    add $t2, $t2, $t6
    addi $t1, $t1, 1    
    #div $t0, $t3
    bgtz $t0, main
     li $v0, 1
    move $a0, $t2
    syscall
    li    $v0, 10          #terminate 
    syscall
endmain:

     
luythua:
     beq $s0, $zero,done     # n?u p = 0 thì thoát kh?i vòng l?p
     mul $t4, $t4, $t5       # $t2 = $t2 * $t0
     addi $s0, $s0, -1
done:
     jr $ra
