.data
	arr: .space 100
	khaibao: .asciiz "Nh?p kí t?: "
	
.eqv SEVENSEG_LEFT 0xFFFF0010 	# Dia chi cua den led 7 doan trai.
				# Bit 0 = doan a;
				# Bit 1 = doan b; ...
				# Bit 7 = dau .
.eqv SEVENSEG_RIGHT 0xFFFF0011 	# Dia chi cua den led 7 doan phai
.text
main:
la $t9 ,arr

li $t8 , 0x3F # set value for segments =0
sw $t8 , 0($t9)

li $t8 , 0x6 # set value for segments =1
sw $t8 , 4($t9)

li $t8 , 0x5b # set value for segments =2
sw $t8 , 8($t9)

li $t8 , 0x4F # set value for segments =3
sw $t8 , 12($t9)

li $t8 , 0x66 # set value for segments =4
sw $t8 , 16($t9)

li $t8 , 0x6D # set value for segments =5
sw $t8 , 20($t9)

li $t8 , 0x7D # set value for segments =6
sw $t8 , 24($t9)

li $t8 , 0x7 # set value for segments =7
sw $t8 , 28($t9)

li $t8 , 0x7f # set value for segments =8
sw $t8 , 32($t9)

li $t8 , 0x6f # set value for segments =9
sw $t8 , 36($t9)

# In prompt ?? nh?p kí t?
        li $v0, 4
        la $a0, khaibao
        syscall

        # Nh?p kí t? t? bàn phím
        li $v0, 12
        syscall
        move $s1, $v0   # L?u giá tr? kí t? vào thanh ghi $t0

	div $s1, $s1, 10    # Chia cho 10 ?? l?y ph?n nguyên 
        mfhi $t1        # L?y ph?n d? (ch? s? cu?i) vào thanh ghi $t1
        
        div $s1, $s1, 10   # Chia ti?p cho 10 ?? l?y ph?n nguyên 
        mfhi $t2        # L?y ph?n d? (ch? s? cu?i) vào thanh ghi $t2

	mul $t1, $t1 ,4
	mul $t2, $t2 ,4

	add $t1, $t9, $t1
	add $t2, $t9, $t2
loadword1:
	lw $t1 , 0($t1)
	move $a0 , $t1
	j SHOW_7SEG_LEFT # show
	nop
loadword2:
	lw $t2 , 0($t2)
	move $a0 , $t2
	j SHOW_7SEG_RIGHT # show
	
exit: 	li $v0, 10
	syscall
endmain:

SHOW_7SEG_LEFT: li $t0, SEVENSEG_LEFT # assign port's address
		sb $a0, 0($t0) # assign new value
		j loadword2
#---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_RIGHT:li $t0, SEVENSEG_RIGHT # assign port's address
		sb $a0, 0($t0) # assign new value
		j exit