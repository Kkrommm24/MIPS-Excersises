.data
    prompt: .asciiz "Nhap so nguyen duong N (>=10): "
    output: .asciiz "Cac chu so cua N theo chieu nguoc lai la: "

.text
main:
    # In ra thông báo nh?p s?
    li $v0, 4       # syscall 4 là in chu?i
    la $a0, prompt  # ??a ??a ch? c?a prompt vào $a0 ?? in ra
    syscall

    # Nh?p s? nguyên d??ng N
    li $v0, 5       # syscall 5 là ??c giá tr? nguyên
    syscall
    move $s0, $v0   # l?u giá tr? N vào $s0 ?? x? lý

    # Ki?m tra N có t? 2 ch? s? tr? lên không
    blt $s0, 10, main   # n?u N < 10 thì quay l?i nh?p l?i

    # In ra thông báo k?t qu?
    li $v0, 4       # syscall 4 là in chu?i
    la $a0, output  # ??a ??a ch? c?a output vào $a0 ?? in ra
    syscall

    # In ra các ch? s? c?a N theo chi?u ng??c l?i
    li $t0, 10       # kh?i t?o bi?n ??m ch? s?
    move $t1, $s0   # l?u giá tr? c?a N vào $t1 ?? x? lý
    loop:
        div $t1, $t0   # chia N cho 10
        mflo $t1
        mfhi $t2       # l?u ph?n d? vào $t2
        bnez $t2, print_digit   # n?u ch? s? khác 0 thì in ra và ti?p t?c x? lý
        blt $t1, $t0, end   # n?u N ?ã h?t ch? s? thì k?t thúc vòng l?p
        j loop         # quay l?i x? lý các ch? s? còn l?i

    print_digit:
        addi $t2, $t2, 48   # chuy?n sang mã ASCII c?a ch? s?
        li $v0, 11      # syscall 11 là in ký t?
        move $a0, $t2     # ??a giá tr? ASCII c?a ch? s? vào $a0 ?? in ra
        syscall
        j loop         # quay l?i x? lý các ch? s? còn l?i

    end:
        li $v0, 10      # syscall 10 là thoát kh?i ch??ng trình
        syscall
