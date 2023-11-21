.eqv MONITOR_SCREEN 0x10010000
.eqv RED 0x00FF0000
.eqv GREEN 0x0000FF00
.eqv WHITE 0x00FFFFFF

.text
    li $t0, MONITOR_SCREEN      # ??a ch? b?t ??u c?a m�n h�nh
    li $t1, RED                 # M�u vi?n ??
    li $t2, GREEN               # M�u n?n xanh l�

    # Nh?p v�o t?a ?? 2 ?i?m (x1, y1) v� (x2, y2)
    li $v0, 5
    syscall
    move $s0, $v0                # L?u t?a ?? x1 v�o $s0

    li $v0, 5
    syscall
    move $s1, $v0                # L?u t?a ?? y1 v�o $s1

    li $v0, 5
    syscall
    move $s2, $v0                # L?u t?a ?? x2 v�o $s2

    li $v0, 5
    syscall
    move $s3, $v0                # L?u t?a ?? y2 v�o $s3

    # T�nh to�n chi?u r?ng v� chi?u cao c?a h�nh ch? nh?t
    sub $t3, $s2, $s0            # Chi?u r?ng (x2 - x1)
    sub $t4, $s3, $s1            # Chi?u cao (y2 - y1)

    # V? vi?n ?? b?ng c�ch t� m�u cho c�c c?nh
    # V? c?nh tr�n
    li $t5, 0
    move $t6, $t0
    add $t6, $t6, $s0
    sw $t1, 0($t6)               # T� m�u vi?n ??
    addi $t6, $t6, 4
    sw $t1, 0($t6)               # T� m�u vi?n ??

    # V? c?nh d??i
    add $t5, $t5, $t3
    add $t6, $t6, $t5
    sw $t1, 0($t6)               # T� m�u vi?n ??
    addi $t6, $t6, 4
    sw $t1, 0($t6)               # T� m�u vi?n ??

    # V? c?nh tr�i
    li $t5, 0
    move $t6, $t0
    add $t6, $t6, $s0
    li $t7, 0
    add $t7, $t7, $s1
    add $t7, $t7, $t5
    add $t7, $t7, $t7
    add $t6, $t6, $t7
    sw $t1, 0($t6)               # T� m�u vi?n ??

    # V? c?nh ph?i
    move $t6, $t0
    add $t6, $t6, $s2
    li $t7, 0
    add $t7, $t7, $s1
    add $t7, $t7, $t4
    add $t7, $t7, $t7
    add $t6, $t6, $t7
    sw $t1, 0($t6)               # T� m�u vi?n ??

    # T� m�u n?n xanh l�
    move $t6, $t0
    add $t6, $t6, $s0
    addi $t5, $t5, 1
fill_color:
    sw $t2, 0($t6)               # T� m�u n?n xanh l�
    add $t6, $t6, 4
    addi $t5, $t5, 1
    bne $t5, $t3, fill_color     # L?p cho ??n khi t� ?? chi?u r?ng

    # K?t th�c ch??ng tr�nh
    li $v0, 10
    syscall
