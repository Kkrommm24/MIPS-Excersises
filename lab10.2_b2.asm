.eqv KEY_CODE 0xFFFF0004 	# ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 	# =1 if has a new keycode ?
				# Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C 	# ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 	# =1 if the display has already to do
				# Auto clear after sw
.text
		li $k0, KEY_CODE
		li $k1, KEY_READY
		li $s0, DISPLAY_CODE
		li $s1, DISPLAY_READY
loop: nop
WaitForKey: 	lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY
		beq $t1, $zero, WaitForKey # if $t1 == 0 then Polling
ReadKey: 	lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE
check_uppercase1: blt $t0, 65, check_number1
check_uppercase2: bgt $t0, 90, check_lowercase1
WaitForDis1:	lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
		beq $t2, $zero, WaitForDis1 # if $t2 == 0 then Polling
convert_u2l: 	addi $t0, $t0, 32 # change input key
 		sw $t0, 0($s0) # show key
		nop
		j loop
check_number1: blt  $t0, 48, print_nor
check_number2: bgt  $t0, 57, print_nor
WaitForDis2: 	lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
		beq $t2, $zero, WaitForDis2 # if $t2 == 0 then Polling
print_num: 	addi $t0, $t0, 0 # change input key
 		sw $t0, 0($s0) # show key
		nop
		j loop
check_lowercase1: blt  $t0, 97, print_nor
check_lowercase2: bgt  $t0, 122, print_nor
WaitForDis3:	lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
		beq $t2, $zero, WaitForDis3 # if $t2 == 0 then Polling
convert_l2u: 	addi $t0, $t0, -32 # change input key
 		sw $t0, 0($s0) # show key
		nop
		j loop
WaitForDis4:	lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
		beq $t2, $zero, WaitForDis4 # if $t2 == 0 then Polling
print_nor: 	li $t0, 42 # change input key
 		sw $t0, 0($s0) # show key
		nop
		j loop