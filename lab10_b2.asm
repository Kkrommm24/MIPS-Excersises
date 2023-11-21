.data
prompt: .asciiz "Nh?p N: "

.eqv SEVENSEG_LEFT 0xFFFF0010 	# Dia chi cua den led 7 doan trai.
				# Bit 0 = doan a;
				# Bit 1 = doan b; ...
				# Bit 7 = dau .
.eqv SEVENSEG_RIGHT 0xFFFF0011 	# Dia chi cua den led 7 doan phai
.text
main:
	# Prompt user for input
    	li $v0, 4
    	la $a0, prompt
    	syscall
    
    	# Read input from user
    	li $v0, 5
    	syscall
    	move $t0, $v0     # Store N in $t0
    	
    	div $t0, $t0, 10    # Chia cho 10 ?? l?y ph?n nguyên 
        mfhi $t1        # L?y ph?n d? (ch? s? cu?i) vào thanh ghi $t1
        
        div $t0, $t0, 10   # Chia ti?p cho 10 ?? l?y ph?n nguyên 
        mfhi $t2        # L?y ph?n d? (ch? s? cu?i) vào thanh ghi $t2
        
switcha: 
	beq $t1,0,case0a
	beq $t1,1,case1a
	beq $t1,2,case2a
	beq $t1,3,case3a
	beq $t1,4,case4a
	beq $t1,5,case5a
	beq $t1,6,case6a
	beq $t1,7,case7a
	beq $t1,8,case8a
	beq $t1,9,case9a
	
case0a:
	li $a0, 0x3F
	j SHOW_7SEG_LEFT # show
	nop
case1a:
	li $a0, 0x3
	j SHOW_7SEG_LEFT # show
	nop
case2a:
	li $a0, 0x5B
	j SHOW_7SEG_LEFT # show
	nop
case3a:
	li $a0, 0x4F
	j SHOW_7SEG_LEFT # show
	nop
case4a:
	li $a0, 0x66
	j SHOW_7SEG_LEFT # show
	nop
case5a:
	li $a0, 0x6D
	j SHOW_7SEG_LEFT # show
	nop
case6a:
	li $a0, 0x7D
	j SHOW_7SEG_LEFT # show
	nop
case7a:
	li $a0, 0x7
	j SHOW_7SEG_LEFT # show
	nop
	
case8a:
	li $a0, 0x7F
	j SHOW_7SEG_LEFT # show
	nop
case9a:
	li $a0, 0x6F
	j SHOW_7SEG_LEFT # show
	
switchb: 
	beq $t2,0,case0b
	beq $t2,1,case1b
	beq $t2,2,case2b
	beq $t2,3,case3b
	beq $t2,4,case4b
	beq $t2,5,case5b
	beq $t2,6,case6b
	beq $t2,7,case7b
	beq $t2,8,case8b
	beq $t2,9,case9b
	
case0b:
	li $a0, 0x3F
	j SHOW_7SEG_RIGHT # show
	nop
case1b:
	li $a0, 0x3
	j SHOW_7SEG_RIGHT # show
	nop
case2b:
	li $a0, 0x5B
	j SHOW_7SEG_RIGHT # show
	nop
case3b:
	li $a0, 0x4F
	j SHOW_7SEG_RIGHT # show
	nop
case4b:
	li $a0, 0x66
	j SHOW_7SEG_RIGHT # show
	nop
case5b:
	li $a0, 0x6D
	j SHOW_7SEG_RIGHT # show
	nop
case6b:
	li $a0, 0x7D
	j SHOW_7SEG_RIGHT # show
	nop
case7b:
	li $a0, 0x7
	j SHOW_7SEG_RIGHT # show
	nop
	
case8b:
	li $a0, 0x7F
	j SHOW_7SEG_RIGHT # show
	nop
	
case9b:
	li $a0, 0x6F
	j SHOW_7SEG_RIGHT # show	
	nop
        
exit: 	li $v0, 10
	syscall
endmain:
#---------------------------------------------------------------
# Function SHOW_7SEG_LEFT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_LEFT: li $t0, SEVENSEG_LEFT # assign port's address
		sb $a0, 0($t0) # assign new value
		j switchb
#---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_RIGHT:li $t0, SEVENSEG_RIGHT # assign port's address
		sb $a0, 0($t0) # assign new value
		j exit