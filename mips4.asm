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
    li $t5, 0
    li $t4, ' '
loop1:
    # load characters from input strings
    lb $t2, ($t0)
     # check for end of string
    beqz $t2, check
    # check if character is a space
    beq $t2, $t4, space1
    # check if first character of word
    beqz $t5, lowercase1
loop2:
    # load characters from input strings
    lb $t3, ($t1)
     # check for end of string
    beqz $t3, check
    # check if character is a space
    beq $t3, $t4, space2
    
    # check if first character of word
    beqz $t5, lowercase2

lowercase1:
    # convert to lowercase if necessary
    blt $t2, 'A', skip_lowercase1
    bgt $t2, 'Z', skip_lowercase1
    addi $t2, $t2, 32

skip_lowercase1:
    sb $t2, ($t6)
    addi $t6, $t6, 1
    # go to next character in input string
    addi $t0, $t0, 1
    j loop1

lowercase2:
    # convert to lowercase if necessary
    blt $t3, 'A', skip_lowercase
    bgt $t3, 'Z', skip_lowercase
    addi $t3, $t3, 32

skip_lowercase2:
    sb $t3, ($t7)
    addi $t7, $t7, 1
    # go to next character in input string
    addi $t1, $t1, 1
    j loop2

space1:
    # go to next character in input string
    addi $t0, $t0, 1
    j loop1
space2:
    # go to next character in input string
    addi $t1, $t1, 1
    j loop2
    
check:
beq $t6, $t7, skip_case_check

    # check if characters are alphabetical and have different case
    blt $t6, 'A', not_equal
    bgt $t6, 'z', not_equal
    blt $t7, 'A', not_equal
    bgt $t7, 'z', not_equal
    subu $t4, $t6, $t7
    bne $t4, 32, skip_case_check
    bne $t4, -32, skip_case_check

skip_case_check:
    # check for end of strings
    beqz $t6, equal

    # go to next characters in input strings
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    j check
    
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

# exit program 
li   $v0 ,10 
syscall 