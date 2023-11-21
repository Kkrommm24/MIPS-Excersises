# Bo mon Ky thuat may tinh 
# IT3280 - Thuc hanh kien truc may tinh 
# Mai Minh Khoi 20210492
# vẽ hình trên Bitmap 
# Di chuyen qua bong tren man hinh Bitmap cua Mars  
# Su dung cac phim a, s, d, w de di chuyen
# Su dung z de tang toc, x de giam toc
# Kich thuoc man hinh bitmap 512 * 512 
# Kich thuoc o vuong don vi 1 * 1 
# Base_Address 0x10010000 
 
# Bo khoi dong mac dinh 
.eqv KEY_CODE 0xFFFF0004       # ASCII code to show, 1 byte  
.eqv KEY_READY 0xFFFF0000      # =1 if has a new keycode ?                                   
                               # Auto clear after lw  
.eqv DISPLAY_CODE 0xFFFF000C   # ASCII code to show, 1 byte  
.eqv DISPLAY_READY 0xFFFF0008  # =1 if the display has already to do                                   
                               # Auto clear after sw  
                               
.text    
    li $k0, KEY_CODE    # chứa ký tự nhập vào   
    li $k1, KEY_READY   # check xem đã có ký tự nào được nhập vào chưa   
    li $s2, DISPLAY_CODE    # hiển thị ký tự   
    li $s1, DISPLAY_READY   # check xem màn hình đã sẵn sàng hiển thị hay chưa 
     
    addi    $s7, $0, 512            # $s7 là độ rộng của màn hình
    #circle: 
    # Ta set up hình tròn ở vị trí chính giữa màn hình
    addi    $a0, $0, 256       	#x = 256 
    addi    $a1, $0, 256       	#y = 256     
    addi    $a2, $0, 20     	#r = 20 
    addi    $s0, $0, 0x00FF0000     # $s0 là màu của hình tròn, ta dùng màu đỏ
    jal     DrawCircle   
    nop 
    li $a3,2
    moving:          
           # nhan ki tu tu ban phim va di chuyen  
    # so sanh trong ma ASCII 
    beq $t0,97,left         # 97 = 'a' 
    beq $t0,100,right       # 100 = 'd' 
    beq $t0,115,down        # 115 = 's' 
    beq $t0,119,up          # 119 = 'w' 
    beq $t0,122,increase    # 122 = 'x'
    beq $t0,120,decrease    # 120 = 'z'
    j Input 
 
    left:               		# di chuyen sang trai 
        addi $s0,$0,0x00000000  	# Chuyển hình tròn thành màu đen 
        jal DrawCircle      		# xóa hình tròn vị trí cũ, bằng cách tô đen 
	sub $a0,$a0,$a3     		# giảm hoành độ để di chuyển sang bên trái 
        add $a1,$a1, $0     		# tung độ tâm đường tròn giữ nguyên     
        addi $s0,$0,0x00FF0000  	# đặt lại màu đỏ cho hình tròn 
        jal DrawCircle      		# vẽ hình tròn ở vị trí mới 
        jal Pause        
        bltu $a0,20,ToTheRight 	# nếu khoảng cách từ tâm đến trục < r = 20 thì đổi hướng   
        j Input 
    
    right:              		# di chuyển sang phải  
        addi $s0,$0,0x00000000  	# Chuyển hình tròn thành màu đen 
        jal DrawCircle      		# xoá hình tròn cũ 
        add $a0,$a0,$a3      		# tăng hoành độ để di chuyển sang bên trái 
        add $a1,$a1, $0     		# tung độ giữ nguyên 
        addi $s0,$0,0x00FF0000 
        jal DrawCircle      		# vẽ hình tròn mới 
        jal Pause 
        bgtu $a0,492,ToTheLeft	# nếu khoảng cách từ tâm đến trục > 512 - r = 492 thì đổi hướng 
        j Input 
    
    up:                 		# di chuyển lên trên  
        addi $s0,$0,0x00000000   
        jal DrawCircle      		# xoá hình tròn cũ 
        sub $a1,$a1,$a3     		# tung độ giảm 1 
        add $a0,$a0,$0      		# hoành độ giữ nguyên 
        addi $s0,$0,0x00FF0000   
        jal DrawCircle      		# vẽ hình tròn mới 
        jal Pause 
        bltu $a1,20,TurnDown 	# đập thành thì nảy xuống dưới 
        j Input 
   
   down:  				# di chuyển xuống dưới
        addi $s0,$0,0x00000000 
        jal DrawCircle  		# xoá hình tròn cũ 
        add $a1,$a1,$a3  		# tung độ tăng them a3 
        add $a0,$a0,$0  		# hoành độ giữ nguyên  
        addi $s0,$0,0x00FF0000 
        jal DrawCircle  		# vẽ hình tròn mới 
        jal Pause 
        bgtu $a1,492,TurnUp  	# đập thành thì nảy lên trên  
        j Input 
    increase:
	 li $a3,3
	 add $t0,$0,$t7
	 j moving
    decrease:
    	 li $a3,1
    	 add $t0,$0,$t7
    	 j moving
    ToTheLeft: 
        li $t3 97    
        sw $t3,0($k0)    # thay đổi giá trị ở địa chỉ KEY_CODE để nhảy đến left 
        j Input 
        
    ToTheRight: 
        li $t3 100 
        sw $t3,0($k0)   # thay đổi giá trị ở địa chỉ KEY_CODE để nhảy đến right 
        j Input
        
    TurnDown:  
    	 li $t3 115 
        sw $t3,0($k0)    # thay đổi giá trị ở địa chỉ KEY_CODE để nhảy đến down 
        j Input 
        
    TurnUp: 
        li $t3 119 
        sw $t3,0($k0)   # thay đổi giá trị ở địa chỉ KEY_CODE để nhảy đến up 
        j Input
Input: 
    ReadKey: lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE 
    # Ta lưu lại hướng di chuyển trước đó, để khi tăng tốc quả bóng giữ nguyên hướng di chuyển
    beq $t0,97,store
    beq $t0,100,store
    beq $t0,115, store
    beq $t0,119, store 
    j moving 
store: 
    	add $t7, $0, $t0
    	j moving
    	
Pause: 
    # delay ve 
    addiu $sp,$sp,-4 
    sw $a0, ($sp) 
    #la $a0, 5   #system_sleep  
    #li $v0, 32  #syscall value for sleep 
    #syscall 
 
    lw $a0,($sp) 
    addiu $sp,$sp,4 
    jr $ra 
    
DrawCircle:          
    # Dung thuat toan Bresenham de ve duong tron 
    # Toa do tam duong tron can ve la (cx, cy) 
    # Toa do diem can to mau la (cx +- x, cy +- y) 
    # s0 = colour mau vang 
    # Khoi tao x = r = 20, y = 0 
    # Cach tinh cac cap (x, y) tiep theo: 
    # p = 3 - 2*r 
    # neu p < 0 thi  p = p + 4y + 6 va (x, y) = (x, y+1) 
    # neu p > 0 thi p = p + 4(y-x) +10 va (x, y) = (x-1, y+1) 
    # neu y > x thì vẽ xong đường tròn, kết thúc phần vẽ đường tròn
     
    # Tạo một ngăn xếp để lưu trữ giá trị thanh ghi ra, để truy cập trở về hàm
    addiu   $sp, $sp, -32 
    sw  $ra, 28($sp) 
    sw  $a0, 24($sp) # $a0 = cx va hoanh do pixel can to mau 
    sw  $a1, 20($sp) # a1 = cy và tung độ pixel cần tô màu
    sw  $a2, 16($sp) # $a2 = bán kính
    sw  $s4, 12($sp) 
    sw  $s3, 8($sp) 
    sw  $s2, 4($sp) 
    sw  $s0, ($sp) 
     
    #code goes here 
    sll     $t4, $a2, 1 		# a2 = r => $t4 = 2r
    li  $t3, 3  
    sub $s2, $t3, $t4          	# p = 3 - 2r 
    add $s3, $0, $a2           		# x = r = 20 
    add $s4, $0, $0         		# y = 0  
     
    DrawCircleLoop: 
    bgt     $s4, $s3, exitDrawCircle #neu y > x thi ta ve xong hinh tron, thoat khoi vong lap 
    nop 
     
    # Vẽ 4 điểm đối xứng nhau qua trục tung và trục hoành, rồi hoán đổi x, y cho nhau để vẽ tiếp 4 điểm đối xứng qua phân giác 
    jal plot8points 
    nop 
    # Tính toán (x, y) tiếp theo, rồi vẽ các điểm mới 
    sll $t3, $s4, 2             # $t3 = 4y 
    add     $s2, $s2, $t3 
    addi    $s2, $s2, 6         # p = p + 4y +6  
    addi    $s4, $s4, 1         # y = y + 1 
     
    blt $s2, 0, DrawCircleLoop      # if error >= 0, start loop again 
    nop 
     
    sll $t4, $s3, 2 
    sub $s2, $s2, $t4 
    addi    $s2, $s2, 4 
    addi    $s3, $s3, -1 
     
    j   DrawCircleLoop 
    nop 
    
    exitDrawCircle: 
     
    lw  $s0, ($sp) 
    lw  $s2, 4($sp) 
    lw  $s3, 8($sp) 
    lw  $s4, 12($sp) 
    lw  $a2, 16($sp) 
    lw  $a1, 20($sp) 
    lw  $a0, 24($sp) 
    lw  $ra, 28($sp) 
     
    addiu   $sp, $sp, 32 
     
    jr  $ra 
    nop 
    
plot8points: 
    addiu   $sp, $sp, -4 
    sw  $ra, 0($sp) 
     
    jal plot4points 
    nop 
     
    beq     $s4, $s3, skipSecondplot 
    nop 
     
    # Đổi giá trị x và y cho nhau để vẽ 4 điểm đối xứng qua đường phân giác 
    add $t2, $0, $s4            # t = y 
    add $s4, $0, $s3            # y = x 
    add $s3, $0, $t2            # x = t 
     
    jal plot4points 
    nop 
     
    # doi gia tri x va y về như cũ 
    add $t2, $0, $s4            # t = y 
    add $s4, $0, $s3            # y = x  
    add $s3, $0, $t2            # x = t 
         
    skipSecondplot: 
         
    lw  $ra, ($sp) 
    addiu   $sp, $sp, 4 
     
    jr  $ra 
    nop 

plot4points: 
     
    addiu   $sp, $sp -4 
    sw  $ra, ($sp) 
     
    #$a0 = a0 + s3, $a2 = a1 + s4 
    add $t0, $0, $a0            # $t0 luu cx 
    add $t1, $0, $a1            # $t1 luu cy 
     
    add $a0, $t0, $s3           # hoanh do diem can to mau: cx + x 
    add $a2, $t1, $s4           # tung do diem can to mau: cy + y 
     
    jal SetPixel                    # (cx + x, cy + y) 
    nop 
     
    sub $a0, $t0, $s3               #cx - x 
    #add    $a2, $t1, $s4           #cy + y 
    beq $s3, $0, skipXnotequal0     #if s3 (x) equals 0, skip 
    nop 
     
    jal     SetPixel                # (cx - x, cy +y) 
    nop 
     
    skipXnotequal0:  
    sub $a2, $t1, $s4          	  # cy - y (a0 already equals cx - x) 
    jal     SetPixel                    # (cx - x, cy - y) 
    nop 
     
    add $a0, $t0, $s3 
     
    beq $s4, $0, skipYnotequal0  
    nop 
     
    jal SetPixel                #(cx + x, cy - y) 
    nop
    
      
    skipYnotequal0: 
     
    add $a0, $0, $t0             
    add $a2, $0, $t1             
     
    lw  $ra, ($sp) 
    addiu   $sp, $sp, 4 
     
    jr  $ra 
    nop 
SetPixel: 	
    #a0 x 
    #a1 y 
    #s0 colour 
    addiu   $sp, $sp, -20           	# Save return address on stack 
    sw  $ra, 16($sp) 
    sw  $s1, 12($sp) 
    sw  $s0, 8($sp)         		# Save original values of a0, s0, a2 
    sw  $a0, 4($sp) 
    sw  $a2, ($sp) 
 
    lui $s1, 0x1001         		# Dia chi bat dau bo nho man hinh 
    sll $a0, $a0, 2               
    add $s1, $s1, $a0            
    mul     $a2, $a2, $s7            
    mul $a2, $a2, 4          
    add $s1, $s1, $a2           	# Dia chi pixel can to mau 
     sw  $s0, ($s1)          		# Luu gia tri màu vao dia chi pixel 
     
    lw  $a2, ($sp)          		#retrieve original values and return address 
    lw  $a0, 4($sp) 
    lw  $s0, 8($sp) 
    lw  $s1, 12($sp) 
    lw  $ra, 16($sp) 
    addiu   $sp, $sp, 20     
     
    jr  $ra 
    nop
