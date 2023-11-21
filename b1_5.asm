.data
    prompt: .asciiz "Nhap so nguyen duong N (>=10): "
    output: .asciiz "Cac chu so cua N theo chieu nguoc lai la: "

.text
main:
    # In ra th�ng b�o nh?p s?
    li $v0, 4       # syscall 4 l� in chu?i
    la $a0, prompt  # ??a ??a ch? c?a prompt v�o $a0 ?? in ra
    syscall

    # Nh?p s? nguy�n d??ng N
    li $v0, 5       # syscall 5 l� ??c gi� tr? nguy�n
    syscall
    move $s0, $v0   # l?u gi� tr? N v�o $s0 ?? x? l�

    # Ki?m tra N c� t? 2 ch? s? tr? l�n kh�ng
    blt $s0, 10, main   # n?u N < 10 th� quay l?i nh?p l?i

    # In ra th�ng b�o k?t qu?
    li $v0, 4       # syscall 4 l� in chu?i
    la $a0, output  # ??a ??a ch? c?a output v�o $a0 ?? in ra
    syscall

    # In ra c�c ch? s? c?a N theo chi?u ng??c l?i
    li $t0, 10       # kh?i t?o bi?n ??m ch? s?
    move $t1, $s0   # l?u gi� tr? c?a N v�o $t1 ?? x? l�
    loop:
        div $t1, $t0   # chia N cho 10
        mflo $t1
        mfhi $t2       # l?u ph?n d? v�o $t2
        bnez $t2, print_digit   # n?u ch? s? kh�c 0 th� in ra v� ti?p t?c x? l�
        blt $t1, $t0, end   # n?u N ?� h?t ch? s? th� k?t th�c v�ng l?p
        j loop         # quay l?i x? l� c�c ch? s? c�n l?i

    print_digit:
        addi $t2, $t2, 48   # chuy?n sang m� ASCII c?a ch? s?
        li $v0, 11      # syscall 11 l� in k� t?
        move $a0, $t2     # ??a gi� tr? ASCII c?a ch? s? v�o $a0 ?? in ra
        syscall
        j loop         # quay l?i x? l� c�c ch? s? c�n l?i

    end:
        li $v0, 10      # syscall 10 l� tho�t kh?i ch??ng tr�nh
        syscall
