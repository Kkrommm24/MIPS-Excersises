.eqv MONITOR_SCREEN 0x10010000
.eqv RED 0x00FF0000
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv YELLOW 0x00FFFF00
.text
        li $k0, MONITOR_SCREEN      #Nap dia chi bat dau cua man hinh
        li $t1 , 64
        li $t2, 0 
        li $a1 ,0
        li $a2, 8
ve_do:
         li $t0, RED
         sw  $t0, 0($k0) 
         nop
         add $k0, $k0, 4 
         addi $t2, $t2, 1 
         addi $a1, $a1, 1
         beq $a1, $t1, exit
         jal check1
         j ve_xanh
ve_xanh:
         li $t0, BLUE
         sw  $t0, 0($k0)
         nop
         add $k0, $k0, 4 
         addi $t2, $t2, 1 
         addi $a1, $a1, 1
         beq $a1, $t1, exit
         jal check2
         j ve_do
exit: 
         li $v0, 10
         syscall
check1: 
         beq $a2, $t2, reset1
         jr $ra
         nop
reset1: 
         li $t2, 0
         j ve_do
         nop
check2: 
         beq $a2, $t2, reset2
         jr $ra
         nop
reset2: 
         li $t2, 0
         j ve_xanh
         nop