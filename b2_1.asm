.data
    arr: .space 1024     # Khai b�o m?ng v?i ?? d�i t?i ?a l� 256 s? nguy�n (m?i s? c� k�ch th??c l� 4 byte)
    comma: .asciiz ", "  # Chu?i ph�n c�ch gi?a c�c ph?n t? c?a m?ng

.text
main:
    # Nh?p gi� tr? M t? b�n ph�m
    li $v0, 5        # L?nh s? d?ng ?? ??c gi� tr? t? b�n ph�m (Code 5: ??c s? nguy�n)
    syscall         # G?i l?nh h? th?ng ?? ??c gi� tr? t? b�n ph�m
    move $s0, $v0   # L?u gi� tr? M v�o thanh ghi $s0

    # Nh?p gi� tr? N t? b�n ph�m
    li $v0, 5        # L?nh s? d?ng ?? ??c gi� tr? t? b�n ph�m (Code 5: ??c s? nguy�n)
    syscall         # G?i l?nh h? th?ng ?? ??c gi� tr? t? b�n ph�m
    move $s1, $v0   # L?u gi� tr? N v�o thanh ghi $s1

    # Nh?p s? ph?n t? c?a m?ng t? b�n ph�m
    li $v0, 5        # L?nh s? d?ng ?? ??c gi� tr? t? b�n ph�m (Code 5: ??c s? nguy�n)
    syscall         # G?i l?nh h? th?ng ?? ??c gi� tr? t? b�n ph�m
    move $s2, $v0   # L?u s? ph?n t? c?a m?ng v�o thanh ghi $s2

    # Nh?p c�c ph?n t? c?a m?ng t? b�n ph�m
    la $a0, arr     # ??a ??a ch? c?a m?ng v�o thanh ghi $a0 ?? truy?n v�o h�m ??c m?ng
    move $a1, $s2   # ??a s? ph?n t? c?a m?ng v�o thanh ghi $a1 ?? truy?n v�o h�m ??c m?ng
    jal read_array  # G?i h�m ??c m?ng

    # In ra c�c ph?n t? c?a m?ng n?m trong ?o?n (M, N)
    la $a0, arr      # ??a ??a ch? c?a m?ng v�o thanh ghi $a0 ?? truy?n v�o h�m in m?ng
    move $a1, $s2    # ??a s? ph?n t? c?a m?ng v�o thanh ghi $a1 ?? truy?n v�o h�m in m?ng
    move $a2, $s0    # ??a gi� tr? M v�o thanh ghi $a2 ?? truy?n v�o h�m in m?ng
    move $a3, $s1    # ??a gi� tr? N v�o thanh ghi $a3 ?? truy?n v�o h�m in m?ng
    jal print_array  # G?i h�m in m?ng

# H�m in m?ng
print_array:
    li $v0, 1          # L?nh s? d?ng ?? in ra k?t qu? (Code 1: In s? nguy�n)
    move $t0, $a0      # L?u ??a ch? c?a m?ng v�o thanh ghi $t0
    li $t2, 0          # Kh?i t?o bi?n $t2 l� gi� tr? ??u ti�n c?a m?ng
    li $t3, 0          # Kh?i t?o bi?n $t3 l� s? l??ng ph?n t? ?� in ra
    loop_print_array:
        beq $t3, $a1, end_print_array  # N?u ?� in ra ?? s? l??ng ph?n t? c?n thi?t th� tho�t kh?i v�ng l?p
        lw $t1, ($t0)     # Load gi� tr? c?a ph?n t? th? i v�o thanh ghi $t1
        ble $t1, $a2, skip_print_array   # N?u ph?n t? b� h?n gi� tr? M th� b? qua kh�ng in
        bgt $t1, $a3, skip_print_array   # N?u ph?n t? l?n h?n gi� tr? N th� b? qua kh�ng in
        move $a0, $t1     # G�n gi� tr? c?a ph?n t? ??n thanh ghi s? d?ng ?? in ra
        syscall          # G?i l?nh h? th?ng ?? in ra gi� tr? c?a ph?n t?
        li $v0, 4         # L?nh s? d?ng ?? in ra k?t qu? (Code 4: In chu?i)
        la $a0, comma     # Load ??a ch? c?a chu?i "," v�o thanh ghi $a0
        syscall          # G?i l?nh h? th?ng ?? in ra chu?i ","
        addi $t3, $t3, 1  # T?ng bi?n ??m s? l??ng ph?n t? ?� in ra l�n 1
        skip_print_array:
            addi $t0, $t0, 4      # T?ng con tr? c?a m?ng l�n 4 byte ?? truy c?p ph?n t? ti?p theo
            j loop_print_array    # Quay l?i v�ng l?p ?? ti?p t?c in c�c ph?n t? kh�c
    end_print_array:
        jr $ra             # Tr? v?

# H�m nh?p m?ng
read_array:
    move $t0, $a0       # L?u ??a ch? c?a m?ng v�o thanh ghi $t0
    li $t1, 0           # Kh?i t?o bi?n $t1 l� s? l??ng ph?n t? ?� nh?p
    loop_read_array:
        beq $t1, $a1, end_read_array   # N?u ?� nh?p ?? s? l??ng ph?n t? c?n thi?t th� tho�t kh?i v�ng l?p
        li $v0, 5         # L?nh s? d?ng ?? ??c gi� tr? t? b�n ph�m (Code 5: ??c s? nguy�n)
        syscall          # G?i l?nh h? th?ng ?? ??c gi� tr? t? b�n ph�m
        sw $v0, ($t0)     # L?u gi� tr? v?a nh?p v�o m?ng
        addi $t0, $t0, 4  # T?ng con tr? c?a m?ng l�n 4 byte ?? truy c?p ph?n t? ti?p theo
        addi $t1, $t1, 1  # T?ng bi?n ??m s? l??ng ph?n t? ?� nh?p l�n 1
        j loop_read_array  # Quay l?i v�ng l?p ?? ti?p t?c nh?p c�c ph?n t? kh�c
    end_read_array:
        jr $ra
    # K?t th�c ch??ng tr�nh
    li $v0, 10       # L?nh s? d?ng ?? tho�t ch??ng tr�nh (Code 10: Tho�t)
    syscall         # G?i l?nh h? th?ng ?? tho�t ch??ng tr�nh
