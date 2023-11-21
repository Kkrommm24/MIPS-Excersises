.data
input1: .space 256
input2: .space 256

.text
main:
    # read first input string
    li $v0, 8
    la $a0, input1
    li $a1, 256
    syscall

    # read second input string
    li $v0, 8
    la $a0, input2
    li $a1, 256
    syscall

    # initialize variables
    la $t0, input1
    la $t1, input2

loop:
    # load characters from input strings
    lb $t2, ($t0)
    lb $t3, ($t1)

    # check if characters are equal without considering case
    beq $t2, $t3, skip_case_check

    # check if characters are alphabetical and have different case
    blt $t2, 'A', not_equal
    bgt $t2, 'z', not_equal
    blt $t3, 'A', not_equal
    bgt $t3, 'z', not_equal
    subu $t4, $t2, $t3
    bne $t4, 32, skip_case_check
    bne $t4, -32, skip_case_check

skip_case_check:
    # check for end of strings
    beqz $t2, equal

    # go to next characters in input strings
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    j loop

not_equal:
# print not equal message 
li   $v0 ,4 
la   $a0 ,not_equal_msg 
syscall 

# exit program 
li   $v0 ,10 
syscall 

equal: 
# print equal message 
li   $v0 ,4 
la   $a0 ,equal_msg 
syscall 

# exit program 
li   $v0 ,10 
syscall 

.data 
not_equal_msg: .asciiz "The strings are not equal.\n" 
equal_msg: .asciiz "The strings are equal.\n" 
