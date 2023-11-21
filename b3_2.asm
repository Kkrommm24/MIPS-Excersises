.data
input: .space 256
output: .space 256

.text
main:
    # read input string
    li $v0, 8
    la $a0, input
    li $a1, 256
    syscall

    # initialize variables
    la $t0, input
    la $t1, output
    li $t2, 1

loop:
    # load character from input string
    lb $t3, ($t0)

    # check for end of string
    beqz $t3, end

    # check if character is a space
    li $t4, ' '
    beq $t3, $t4, space

    # check if first character of word
    beqz $t2, lowercase

uppercase:
    # convert to uppercase if necessary
    blt $t3, 'a', skip_uppercase
    bgt $t3, 'z', skip_uppercase
    subi $t3, $t3, 32

skip_uppercase:
    # store character in output string
    sb $t3, ($t1)
    addi $t1, $t1, 1

    # set flag to indicate not first character of word
    li $t2, 0

    # go to next character in input string
    addi $t0, $t0, 1
    j loop

lowercase:
    # convert to lowercase if necessary
    blt $t3, 'A', skip_lowercase
    bgt $t3, 'Z', skip_lowercase
    addi $t3, $t3, 32

skip_lowercase:
    # store character in output string
    sb $t3, ($t1)
    addi $t1, $t1, 1

    # go to next character in input string
    addi $t0, $t0, 1
    j loop

space:
    # store space in output string
    sb $t3, ($t1)
    addi $t1, $t1, 1

    # set flag to indicate first character of word
    li $t2, 1

    # go to next character in input string
    addi $t0, $t0, 1
    j loop

end:
# print output string 
li   $v0 ,4 
la   $a0 ,output 
syscall 

# exit program 
li   $v0 ,10 
syscall 
