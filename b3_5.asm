.data
input1: .space 256
input2: .space 256
output1: .space 256
output2: .space 256

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
    la $t6, output1
    la $t7, output2
    li $t5, 0
    li $t4, ' '
loop1:
    # load characters from input strings
    lb $t2, ($t0)
     # check for end of string
    beqz $t2, loop2
    # check if character is a space
    beq $t2, $t4, space1
    # check if first character of word
    beqz $t5, lowercase1
loop2:
    # load characters from input strings
    lb $t3, ($t1)
     # check for end of string
    beqz $t3, end
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
    blt $t3, 'A', skip_lowercase2
    bgt $t3, 'Z', skip_lowercase2
    addi $t3, $t3, 32

skip_lowercase2:
    sb $t3, ($t7)
    addi $t7, $t7, 1
    # go to next character in input string
    addi $t1, $t1, 1
    j loop2

space1:
    sb $t2, ($t6)
    addi $t6, $t6, 1
    # go to next character in input string
    addi $t0, $t0, 1
    j loop1
space2:
    sb $t3, ($t7)
    addi $t7, $t7, 1
    # go to next character in input string
    addi $t1, $t1, 1
    j loop2

end:
# print output string 
li   $v0 ,4 
la   $a0 ,output1 
syscall 
li   $v0 ,4 
la   $a0 ,output2
syscall 
# exit program 
li   $v0 ,10 
syscall 
