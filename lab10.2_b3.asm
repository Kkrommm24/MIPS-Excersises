.eqv 	KEY_CODE 0xFFFF0004 		# ASCII code from keyboard, 1 byte
.eqv 	KEY_READY 0xFFFF0000 		# =1 if has a new keycode ?
 						# Auto clear after lw
.eqv 	DISPLAY_CODE 0xFFFF000C 	# ASCII code to show, 1 byte
.eqv 	DISPLAY_READY 0xFFFF0008 	# =1 if the display has already to do
 						# Auto clear after sw
.eqv 	HEADING 0xffff8010 		# Integer: An angle between 0 and 359
.eqv	MOVING 0xffff8050 		# Boolean: whether or not to move
.eqv 	LEAVETRACK 0xffff8020 		# Boolean (0 or non-0):
 						# whether or not to leave a track
.eqv 	WHEREX 0xffff8030 		# Integer: Current x-location of MarsBot
.eqv 	WHEREY 0xffff8040 		# Integer: Current y-location of MarsBot
.eqv	ONE 1
.text
  	li $k0, KEY_CODE
   	li $k1, KEY_READY
  	li $s0, DISPLAY_CODE
  	li $s1, DISPLAY_READY
  	jal	TRACK
loop: 
	nop
WaitForKey: 
	lw 	$t1, 0($k1) 		# $t1 = [$k1] = KEY_READY
 	beq 	$t1, $zero, WaitForKey	# if $t1 == 0 then Polling
ReadKey: 
	lw 	$t0, 0($k0) 		# $t0 = [$k0] = KEY_CODE
Process:
	beq	$t0,' ',space
	beq	$t0,'W',up
	beq	$t0,'w',up
	beq	$t0,'S',down
	beq	$t0,'s',down
	beq	$t0,'A',left
	beq	$t0,'a',left
	beq	$t0,'D',right
	beq	$t0,'d',right
	j	loop
	
space:
	li	$at,MOVING
	lb	$t1,0($at)
	li	$t2,ONE
	sub	$t3,$t2,$t1
	sb	$t3,0($at)
	j	loop
up:
	li	$a0,0
	jal	ROTATE
	j	loop
down:
	li	$a0,180
	jal	ROTATE
	j	loop
left:
	li	$a0,270
	jal	ROTATE
	j	loop
right:
	li	$a0,90
	jal	ROTATE
	j	loop

#-----------------------------------------------------------
# TRACK procedure, to start drawing line
# param[in] none
#-----------------------------------------------------------
TRACK: 
	li 	$at, LEAVETRACK 	# change LEAVETRACK port
  	li	$t9, ONE	 	# to logic 1,
 	sb 	$t9, 0($at) 	# to start tracking
 	jr 	$ra
#-----------------------------------------------------------
# UNTRACK procedure, to stop drawing line
# param[in] none
#-----------------------------------------------------------
UNTRACK:
	li 	$at, LEAVETRACK 	# change LEAVETRACK port to 0
 	sb 	$zero, 0($at)	# to stop drawing tail
 	jr 	$ra
#-----------------------------------------------------------
# ROTATE procedure, to rotate the robot
# param[in] $a0, An angle between 0 and 359
# 0 : North (up)
# 90: East (right)
# 180: South (down)
# 270: West (left)
#-----------------------------------------------------------
ROTATE: 
	sw	$ra,-4($sp)
	jal	UNTRACK
	jal	TRACK
	li 	$at, HEADING 	# change HEADING port
 	sw 	$a0, 0($at) 	# to rotate robot
 	lw	$ra,-4($sp)
 	jr	$ra