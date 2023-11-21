.data
    prompt: .asciiz "Nhap so nguyen duong N: "
    result: .asciiz "Tong cac chu so trong bieu dien nhi phan cua N la: "
     
.text
    # Hien thi prompt va nhap N tu ban phim
    li $v0, 4
    la $a0, prompt
    syscall
     
    li $v0, 5
    syscall
    move $t0, $v0   # Luu tru gia tri N vao thanh ghi $t0
     
    # Tinh tong cac chu so trong bieu dien nhi phan cua N
    li $t1, 0       # Khoi tao tong ban dau bang 0
    loop:
        andi $t2, $t0, 1   # Lay chu so thap nhat cua N
        add $t1, $t1, $t2  # Cong chu so nay vao tong
     
        srl $t0, $t0, 1    # Dich phai N de loai bo chu so vua lay ra
     
        bnez $t0, loop     # Lap khi N khac 0
     
    # Hien thi ket qua
    li $v0, 4
    la $a0, result
    syscall
     
    li $v0, 1
    move $a0, $t1
    syscall
     
    # Thoat khoi chuong trinh
    li $v0, 10
    syscall
