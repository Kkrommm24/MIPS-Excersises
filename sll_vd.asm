.data
    number: .word 5      # S? nguy�n ban ??u

.text
.globl main

main:
    lw $t0, number       # Load gi� tr? s? nguy�n v�o $t0

    sll $t2, $t0, 3   # Nh�n s? nguy�n v?i l?y th?a c?a 2: 2^3 = 8 => 5*8 = 40

    # In k?t qu?
    li $v0, 1            # System call code ?? in s? nguy�n
    move $a0, $t2        # Di chuy?n gi� tr? k?t qu? v�o $a0
    syscall

    # K?t th�c ch??ng tr�nh
    li $v0, 10           # System call code ?? tho�t
    syscall
