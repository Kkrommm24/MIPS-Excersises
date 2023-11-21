.data
    number: .word 5      # S? nguyên ban ??u

.text
.globl main

main:
    lw $t0, number       # Load giá tr? s? nguyên vào $t0

    sll $t2, $t0, 3   # Nhân s? nguyên v?i l?y th?a c?a 2: 2^3 = 8 => 5*8 = 40

    # In k?t qu?
    li $v0, 1            # System call code ?? in s? nguyên
    move $a0, $t2        # Di chuy?n giá tr? k?t qu? vào $a0
    syscall

    # K?t thúc ch??ng trình
    li $v0, 10           # System call code ?? thoát
    syscall
