.eqv MONITOR_SCREEN 0x10010000
.eqv RED 0x00FF0000
.eqv GREEN 0x0000FF00
.eqv WHITE 0x00FFFFFF

.text
    li $t0, MONITOR_SCREEN      # ??a ch? b?t ??u c?a màn hình
    li $t1, RED                 # Màu vi?n ??
    li $t2, GREEN               # Màu n?n xanh lá

    # Nh?p vào t?a ?? 2 ?i?m (x1, y1) và (x2, y2)
    li $v0, 5
    syscall
    move $s0, $v0                # L?u t?a ?? x1 vào $s0

    li $v0, 5
    syscall
    move $s1, $v0                # L?u t?a ?? y1 vào $s1

    li $v0, 5
    syscall
    move $s2, $v0                # L?u t?a ?? x2 vào $s2

    li $v0, 5
    syscall
    move $s3, $v0                # L?u t?a ?? y2 vào $s3

    # Tính toán chi?u r?ng và chi?u cao c?a hình ch? nh?t
    sub $t3, $s2, $s0            # Chi?u r?ng (x2 - x1)
    sub $t4, $s3, $s1            # Chi?u cao (y2 - y1)

    # V? vi?n ?? b?ng cách tô màu cho các c?nh
    # V? c?nh trên
    li $t5, 0
    move $t6, $t0
    add $t6, $t6, $s0
    sw $t1, 0($t6)               # Tô màu vi?n ??
    addi $t6, $t6, 4
    sw $t1, 0($t6)               # Tô màu vi?n ??

    # V? c?nh d??i
    add $t5, $t5, $t3
    add $t6, $t6, $t5
    sw $t1, 0($t6)               # Tô màu vi?n ??
    addi $t6, $t6, 4
    sw $t1, 0($t6)               # Tô màu vi?n ??

    # V? c?nh trái
    li $t5, 0
    move $t6, $t0
    add $t6, $t6, $s0
    li $t7, 0
    add $t7, $t7, $s1
    add $t7, $t7, $t5
    add $t7, $t7, $t7
    add $t6, $t6, $t7
    sw $t1, 0($t6)               # Tô màu vi?n ??

    # V? c?nh ph?i
    move $t6, $t0
    add $t6, $t6, $s2
    li $t7, 0
    add $t7, $t7, $s1
    add $t7, $t7, $t4
    add $t7, $t7, $t7
    add $t6, $t6, $t7
    sw $t1, 0($t6)               # Tô màu vi?n ??

    # Tô màu n?n xanh lá
    move $t6, $t0
    add $t6, $t6, $s0
    addi $t5, $t5, 1
fill_color:
    sw $t2, 0($t6)               # Tô màu n?n xanh lá
    add $t6, $t6, 4
    addi $t5, $t5, 1
    bne $t5, $t3, fill_color     # L?p cho ??n khi tô ?? chi?u r?ng

    # K?t thúc ch??ng trình
    li $v0, 10
    syscall
