.data

	String1:  .asciiz  "                                           *************    \n"
	String2:  .asciiz  "**************                            *3333333333333*   \n"
	String3:  .asciiz  "*222222222222222*                         *33333********    \n"
	String4:  .asciiz  "*22222******222222*                       *33333*           \n"
	String5:  .asciiz  "*22222*      *22222*                      *33333********    \n"
	String6:  .asciiz  "*22222*       *22222*      *************  *3333333333333*   \n"
	String7:  .asciiz  "*22222*       *22222*    **11111*****111* *33333********    \n"
	String8:  .asciiz  "*22222*       *22222*  **1111**       **  *33333*           \n"
	String9:  .asciiz  "*22222*      *222222*  *1111*             *33333********    \n"
	String10: .asciiz  "*22222*******222222*  *11111*             *3333333333333*   \n"
	String11: .asciiz  "*2222222222222222*    *11111*              *************    \n"
	String12: .asciiz  "***************       *11111*                               \n"
 	String13: .asciiz  "      ---              *1111**                              \n"
 	String14: .asciiz  "    / o o \\             *1111****   *****                   \n"
	String15: .asciiz  "    \\  >  /              **111111***111*                    \n"
	String16: .asciiz  "     -----                 ***********    dce.hust.edu.vn   \n"

	
	Message0: 	.asciiz "------------IN CHU-----------\n"
	P1:		.asciiz"1. In ra chu\n"
	P2:		.asciiz"2. In ra chu rong\n"
	P3:		.asciiz"3. Thay doi vi tri\n"
	P4:		.asciiz"4. Doi mau cho chu\n"
	Exit:		.asciiz"5. Exit\n"
	Input:		.asciiz"Nhap gia tri: "
	ChuD:		.asciiz"Nhap màu cho chu D(0->9): "
	ChuC:		.asciiz"Nhap màu cho chu C(0->9): "
	ChuE:		.asciiz"Nhap màu cho chu E(0->9): "
.text

	li $t5, 50 #t5 mau chu hien tai cua chu D
	li $t6, 49 #t6 mau chu hien tai cua chu C
	li $t7, 51 #t7 mau chu hien tai cua chu E

main:
	la $a0, Message0	# nhap menu
	li $v0, 4
	syscall
	
	la $a0, P1	
	li $v0, 4
	syscall
	
	la $a0, P2	
	li $v0, 4
	syscall
	
	la $a0, P3	
	li $v0, 4
	syscall
	
	la $a0, P4	
	li $v0, 4
	syscall
	
	la $a0, Exit	
	li $v0, 4
	syscall
	
	la $a0, Input	
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	Case1:
		addi $v1, $0, 1
		bne $v0, $v1, Case2
		j Menu1
	Case2:
		addi $v1, $0, 2
		bne $v0, $v1, Case3
		j Menu2
	Case3:
		addi $v1, $0, 3
		bne $v0 $v1 Case4
		j Menu3
	Case4:
		addi $v1, $0, 4
		bne $v0, $v1, Case5
		j Menu4
	Case5:
		addi $v1 $0 5
		bne $v0 $v1 default
		j Exitall
	default:
		j main

Menu1:	
	addi $t0, $0, 0	#bien dem =0
	addi $t1, $0, 16 # Kh?i t?o bi?n t1 = s? hàng = 16.
	
	la $a0, String1 # L?y ??a ch? c?a chu?i String1 và l?u vào thanh ghi $a0
Loop:		
	beq $t1, $t0, main # Ki?m tra n?u t1 b?ng t0, nh?y t?i nhãn main.
	li $v0, 4
	syscall
		
	addi $a0, $a0, 62 # T?ng ??a ch? chu?i a0 lên 62 (di chuy?n sang hàng ti?p theo).
	addi $t0, $t0, 1 #  T?ng bi?n ??m t0 lên 1
	j Loop # Quay l?i vòng l?p

Menu2: 	addi $s0, $0, 0	#bien dem tung hang =0
	addi $s1, $0, 16
	la $s2, String1	# $s2 la dia chi cua string1
		
Loop2:	beq $s1, $s0, main
	addi $t0, $0, 0	# $t0 la bien dem tung kí tu cua 1 hang =0
	addi $t1, $0, 62 # $t1 max 1 hang là 62 ki tu
	
print_1_line:
	beq $t1, $t0, End #t1 = t0 tuc la da het 1 hang thi chuyen den End
	lb $t2, 0($s2) #load tung ki tu vao $t2
	bgt	$t2, 47, Checklaso #neu >= 0 (trong bang ascii) thi nhay den Checklaso
	j print_1_char
Checklaso: 
	bgt	$t2, 57, print_1_char #neu lon hon 9 thi giu nguyen nhay den print_1_char de in ra
	addi $t2, $0, 0x20 # thay doi $t2 thanh dau cach
	j print_1_char	
	
print_1_char: 	
	li $v0, 11 # in tung ki tu
	addi $a0, $t2, 0
	syscall
	
	addi $s2, $s2, 1 #sang chu tiep theo
	addi $t0, $t0, 1# bien dem chu
	j print_1_line
	
End:	addi $s0, $s0, 1 # tang bien dem hang lên 1
	j Loop2

Menu3:	addi $s0, $0, 0	#bien dem tung hàng =0
	addi $s1, $0, 16 # Kh?i t?o bi?n t1 = s? hàng = 16.
	la $s2, String1 #$s2 luu dia chi cua string1
	
Loop3:	beq $s1, $s0, main
	#tao thanh 3 string nho
	sb $0, 21($s2) # Gán giá tr? 0 vào v? trí 21 c?a chu?i String1.
	sb $0, 41($s2) # Gán giá tr? 0 vào v? trí 41 c?a chu?i String1.
	sb $0, 57($s2) # Gán giá tr? 0 vào v? trí 57 c?a chu?i String1.
	#doi vi tri
	li $v0, 4 
	la $a0, 42($s2) # L?y ??a ch? c?a kí t? t?i v? trí 42 c?a chu?i String1 và l?u vào thanh ghi $a0 ?? in kí t? E.
	syscall
	
	li $v0, 4 
	la $a0, 22($s2) # L?y ??a ch? c?a kí t? t?i v? trí 22 c?a chu?i String1 và l?u vào thanh ghi $a0 ?? in kí t? C.
	syscall
	
	li $v0, 4 
	la $a0, 0($s2) # L?y ??a ch? c?a kí t? t?i v? trí 0 c?a chu?i String1 và l?u vào thanh ghi $a0 ?? in kí t? D.
	syscall
	
	li $v0, 4 
	la $a0, 58($s2) #  L?y ??a ch? c?a kí t? t?i v? trí 58 c?a chu?i String1 và l?u vào thanh ghi $a0 ?? in kí t?.
	syscall
	# ghep lai thanh string ban dau
	addi $t1, $0, 0x20 # 0x20: Gán giá tr? 0x20 vào thanh ghi t1 (d?u cách
	sb $t1, 21($s2) # Gán giá tr? trong thanh ghi t1 vào v? trí 21 c?a chu?i String1
	sb $t1, 41($s2) # Gán giá tr? trong thanh ghi t1 vào v? trí 41 c?a chu?i String1.
	sb $t1, 57($s2) # Gán giá tr? trong thanh ghi t1 vào v? trí 57 c?a chu?i String1.
	
	addi $s0, $s0, 1 # T?ng bi?n ??m hàng s0 lên 1.
	addi $s2, $s2, 62 # T?ng ??a ch? c?a chu?i String1 lên 62 (di chuy?n sang chu?i k? ti?p).
	j Loop3 # Nh?y t?i nhãn Loop3 ?? ti?p t?c vòng l?p.

Menu4: 
NhapmauD:	li $v0, 4		
		la $a0, ChuD 
		syscall
	
		li $v0, 5		# lay mau cua ki tu D
		syscall

		blt $v0,0, NhapmauD # Ki?m tra n?u giá tr? trong $v0 nh? h?n 0, quay l?i nhãn NhapmauD
		bgt $v0,9, NhapmauD # Ki?m tra n?u giá tr? trong $v0 l?n h?n 9, quay l?i nhãn NhapmauD.
		
		addi $s3, $v0, 48	# Thêm 48 vào giá tr? trong $v0 và l?u k?t qu? vào thanh ghi $s3 (chuy?n giá tr? thành mã ASCII t??ng ?ng).

NhapmauC:	li $v0, 4		
		la $a0, ChuC
		syscall
	
		li $v0, 5		# lay mau cua ki tu C
		syscall

		blt $v0, 0, NhapmauC # Ki?m tra n?u giá tr? trong $v0 nh? h?n 0, quay l?i nhãn NhapmauC.
		bgt $v0, 9, NhapmauC # Ki?m tra n?u giá tr? trong $v0 l?n h?n 9, quay l?i nhãn NhapmauC.
				
		addi $s4, $v0, 48	# Thêm 48 vào giá tr? trong $v0 và l?u k?t qu? vào thanh ghi $s4 (chuy?n giá tr? thành mã ASCII t??ng ?ng).

NhapmauE:	li $v0, 4		
		la $a0, ChuE
		syscall
	
		li $v0, 5		# lay mau cua ki tu E
		syscall

		blt $v0, 0, NhapmauE # Ki?m tra n?u giá tr? trong $v0 nh? h?n 0, quay l?i nhãn NhapmauE.
		bgt $v0, 9, NhapmauE # Ki?m tra n?u giá tr? trong $v0 l?n h?n 9, quay l?i nhãn NhapmauE.
			
		addi $s5, $v0, 48	# Thêm 48 vào giá tr? trong $v0 và l?u k?t qu? vào thanh ghi $s5 (chuy?n giá tr? thành mã ASCII t??ng ?ng).
	
		addi $s0, $0, 0	# bien dem tung hàng =0
		addi $s1, $0, 16 # Kh?i t?o bi?n s1 b?ng 16.
		la $s2,String1	#  L?y ??a ch? c?a chu?i String1 và l?u vào thanh ghi $s2.
		li $a1, 48 # ??t giá tr? 48 (mã ASCII c?a s? 0) vào thanh ghi $a1.
		li $a2, 57 # ??t giá tr? 57 (mã ASCII c?a s? 9) vào thanh ghi $a2.

Loop4:	beq $s1, $s0, update_color # Ki?m tra n?u s1 b?ng s0, nh?y t?i nhãn update_color.
	addi $t0, $0, 0	# Kh?i t?o bi?n ??m kí t? trong m?t hàng t0 b?ng 0.
	addi $t1, $0, 62 # ??t giá tr? 62 vào thanh ghi $t1 (s? kí t? t?i ?a trong m?t hàng).
	
store_1_line_change_color:
	beq $t1, $t0, End_change_color # Ki?m tra n?u t1 b?ng t0, nh?y t?i nhãn End_change_color.
	lb $t2, 0($s2)	# ??c giá tr? t? v? trí hi?n t?i trong chu?i String1 và l?u vào thanh ghi $t2.
CheckD: bgt $t0, 21, CheckC # Ki?m tra n?u t0 l?n h?n 21, nh?y t?i nhãn CheckC.
	beq $t2, $t5, fixD # Ki?m tra n?u giá tr? trong $t2 b?ng $t5, nh?y t?i nhãn fixD.
	j Tmpdoimau # Nh?y t?i nhãn Tmpdoimau ?? th?c hi?n các l?nh ti?p theo.
CheckC: bgt $t0, 41, CheckE # Ki?m tra n?u t0 l?n h?n 41, nh?y t?i nhãn CheckE.
	beq $t2, $t6, fixC # Ki?m tra n?u giá tr? trong $t2 b?ng $t6, nh?y t?i nhãn fixC.
	j Tmpdoimau # Nh?y t?i nhãn Tmpdoimau ?? th?c hi?n các l?nh ti?p theo.
CheckE: beq $t2, $t7, fixE # Ki?m tra n?u giá tr? trong $t2 b?ng $t7, nh?y t?i nhãn fixE
	j Tmpdoimau # Nh?y t?i nhãn Tmpdoimau ?? th?c hi?n các l?nh ti?p theo.
		
fixD: 	sb $s3, 0($s2) # L?u giá tr? t? thanh ghi $s3 (mã ASCII c?a màu cho kí t? D) vào v? trí hi?n t?i trong chu?i String1.
	j Tmpdoimau
fixC: 	sb $s4, 0($s2) # L?u giá tr? t? thanh ghi $s4 (mã ASCII c?a màu cho kí t? C) vào v? trí hi?n t?i trong chu?i String1.
	j Tmpdoimau
fixE: 	sb $s5, 0($s2) #  L?u giá tr? t? thanh ghi $s5 (mã ASCII c?a màu cho kí t? E) vào v? trí hi?n t?i trong chu?i String1.
	j Tmpdoimau
Tmpdoimau: 	
	addi $s2, $s2, 1 #sang chu tiep theo
	addi $t0, $t0, 1# bien dem chu
	j store_1_line_change_color
End_change_color:		
	li $v0, 4  
	addi $a0, $s2, -62 # ??t ??a ch? b?t ??u c?a chu?i String1 vào $a0 ?? in chu?i ?ã thay ??i màu.
	syscall
	addi $s0, $s0, 1 # T?ng bi?n ??m hàng s0 lên 1.
	j Loop4 # Nh?y t?i nhãn Loop4 ?? ti?p t?c vòng l?p.
update_color: 
	move $t5, $s3 # Di chuy?n giá tr? trong $s3 vào $t5.
	move $t6, $s4 # Di chuy?n giá tr? trong $s4 vào $t6
	move $t7, $s5 # i chuy?n giá tr? trong $s5 vào $t7
	j main	# Nh?y t?i nhãn main ?? ti?p t?c th?c hi?n các l?nh trong ch??ng trình chính.
Exitall:
