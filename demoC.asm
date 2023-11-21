.data
    input1: .space 256   # chu?i ??u tiên
    input2: .space 256   # chu?i th? hai
    output: .space 256   # chu?i k?t qu?
    Message1: .asciiz "Nhap chuoi 1: "
    Message2: .asciiz "Nhap chuoi 2: "
    Message3: .asciiz "Cac ky tu giong nhau: "

.text
main:
    # Nh?p chu?i 1 t? bàn phím
    li $v0, 4
    la $a0, Message1
    syscall

    li $v0, 8
    la $a0, input1
    li $a1, 256
    syscall

    # Nh?p chu?i 2 t? bàn phím
    li $v0, 4
    la $a0, Message2
    syscall

    li $v0, 8
    la $a0, input2
    li $a1, 256
    syscall

    # Kh?i t?o con tr? và bi?n ??m
    la $t0, input1   # Con tr? chu?i 1
    la $t1, input2   # Con tr? chu?i 2
    la $t2, output   # Con tr? chu?i k?t qu?
    li $t3, 0        # Bi?n ??m ký t? gi?ng nhau

loop:
    lb $s0, ($t0)    # Ký t? ti?p theo trong chu?i 1
    lb $s1, ($t1)    # Ký t? ti?p theo trong chu?i 2

    # Ki?m tra k?t thúc chu?i
    beqz $s0, print_result
    beqz $s1, print_result

    # So sánh ký t?
    beq $s0, $s1, found_match

    # Chuy?n ??n ký t? ti?p theo trong chu?i 2
    addi $t1, $t1, 1
    j loop

found_match:
    # Ghi ký t? gi?ng nhau vào chu?i k?t qu?
    sb $s0, ($t2)
    addi $t2, $t2, 1

    # T?ng bi?n ??m
    addi $t3, $t3, 1

    # Chuy?n ??n ký t? ti?p theo trong c? hai chu?i
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    j loop

print_result:
    # In k?t qu?
    li $v0, 4
    la $a0, Message3
    syscall

    li $v0, 4
    la $a0, output
    syscall

    # K?t thúc ch??ng trình
    li $v0, 10
    syscall
