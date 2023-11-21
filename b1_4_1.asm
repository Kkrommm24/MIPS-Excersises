.data
input: .space 256
prompt: .asciiz "Nh?p N: "
.text
main:
    # Prompt user for input
    li $v0, 4
    la $a0, prompt
    syscall
    # read input string
    li $v0, 8
    la $a0, input
    li $a1, 256
    syscall

    # initialize variables
    la $t0, input
    li $t1, 0

loop:
    # load character from input string
    lb $t2, ($t0)
    
    # check for end of string
    beqz $t2, end

    # check if character is a digit
    blt $t2, '0', skip_max_check
    bgt $t2, '9', skip_max_check

    # check if digit is greater than current max digit
    subu $t3, $t2, '0'
    bgt $t3, $t1, update_max

skip_max_check:
    # go to next character in input string
    addi $t0, $t0, 1
    j loop

update_max:
    # update max digit
    move $t1, $t3

    # go to next character in input string
    addi $t0, $t0, 1
    j loop

end:
# print max digit 
li   $v0 ,1 
move   $a0 ,$t1 
syscall 

# exit program 
li   $v0 ,10 
syscall
