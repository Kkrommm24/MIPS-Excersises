.data
    n: .word 0
    prompt: .asciiz "Nh?p N: "
    max_digit: .byte '0'     # Ch? s? l?n nh?t ban ??u ???c thi?t l?p là '0'

.text
    # Prompt user for input
    li $v0, 4
    la $a0, prompt
    syscall
    # Nh?p s? nguyên d??ng N t? bàn phím
    li $v0, 5
    syscall
    sw $v0, n
    
    # L?y giá tr? c?a N
    lw $t0, n
    
    # Kh?i t?o các bi?n
    li $t1, 10      # ?? th?c hi?n phép chia cho 10
    li $t2, 0       # Bi?n l?u tr? ch? s? l?n nh?t

loop:
    div $t0, $t1    # Chia N cho 10
    mfhi $t3        # L?y ph?n d? ?? l?u tr? ch? s? hi?n t?i
    
    # So sánh ch? s? hi?n t?i v?i ch? s? l?n nh?t hi?n t?i
    ble $t2, $t3, skip
    move $t2, $t3

skip:
    # Ki?m tra xem N ?ã h?t ch? s? hay ch?a
    beqz $t0, end_loop
    
    # C?p nh?t giá tr? c?a N ?? ti?p t?c vòng l?p
    move $t0, $t3
    j loop

end_loop:
    # In ra ch? s? l?n nh?t
    la $a0, max_digit
    addi $a1, $t2, 0    # Chuy?n giá tr? c?a t2 sang ki?u ký t?
    addi $a1, $a1, -48  # Chuy?n sang mã ASCII
    sb $a1, 0($a0)
    li $v0, 4
    la $a0, max_digit
    syscall
    
    # K?t thúc ch??ng trình
    li $v0, 10
    syscall
