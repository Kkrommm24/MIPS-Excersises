.data
     num: .word 3 # create the decimal number
     
.text
    lw $t0, num  # load decimal num to $t0
    li $t1, 0    # p    
    li $t2, 0    # initialize binary num
    li $t3, 2    # khai bao so chia 2
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
    
    li    $v0, 10          #terminate 
    syscall
endmain:

     
luythua:
     beq $s0, $zero,done     # n?u p = 0 thì thoát kh?i vòng l?p
     mul $t4, $t4, $t5       # $t2 = $t2 * $t0
     addi $s0, $s0, -1
done:
     jr $ra
