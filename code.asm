func_end : 

       lw $ra, 0($sp)
       lw $fp, 4($sp)
       lw $a0, 8($sp)
       lw $t0, 12($sp)
       lw $t1, 16($sp)
       lw $t2, 20($sp)
       lw $t3, 24($sp)
       lw $t4, 28($sp)
       lw $t5, 32($sp)
       lw $t6, 36($sp)
       lw $t7, 40($sp)
       lw $t8, 44($sp)
       lw $t9, 48($sp)
       lw $s0, 52($sp)
       lw $s1, 56($sp)
       lw $s2, 60($sp)
       lw $s3, 64($sp)
       lw $s4, 68($sp)
       lw $s5, 72($sp)
       lw $s6, 76($sp)
       add $sp, $sp, 80
       jr $ra


main : 

       li $t1, 80
       add $t1, $t1, 280
       add $sp, $sp, $t1
       sub $sp, $sp, 80
       sw $ra, 0($sp)
       sw $fp, 4($sp)
       la $fp, 80($sp)
       sw $t0, 12($sp)
       sw $t1, 16($sp)
       sw $t2, 20($sp)
       sw $t3, 24($sp)
       sw $t4, 28($sp)
       sw $t5, 32($sp)
       sw $t6, 36($sp)
       sw $t7, 40($sp)
       sw $t8, 44($sp)
       sw $t9, 48($sp)
       sw $s0, 52($sp)
       sw $s1, 56($sp)
       sw $s2, 60($sp)
       sw $s3, 64($sp)
       sw $s4, 68($sp)
       sw $s5, 72($sp)
       sw $s6, 76($sp)
       add $sp, $sp, 80
       sub $sp, $sp, $t1
       
       # store_int 5  _t1
       li $t0, 5
       add $t1, $sp, 0
       sw $t0, 0($t1)
       
       # store_int 0  _t3
       li $t0, 0
       add $t1, $sp, 52
       sw $t0, 0($t1)
       
       # = _t3  i
       add $t0, $sp, 52
       add $t2, $sp, 48
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       Label4 :
       
       # store_int 1  _t5
       li $t0, 1
       add $t1, $sp, 60
       sw $t0, 0($t1)
       
       # < i _t5 _t6
       add $t0, $sp, 48
       add $t1, $sp, 60
       add $t2, $sp, 64
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       slt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t6  12
       add $t0, $sp, 64
       lw $t1 0($t0)
       bnez $t1, Label12
       
       # goto   23
       j Label23
       Label8 :
       
       # store_int 1  _t9
       li $t0, 1
       add $t1, $sp, 76
       sw $t0, 0($t1)
       
       # = i  _t8
       add $t0, $sp, 48
       add $t2, $sp, 72
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # +int i _t9 i
       add $t0, $sp, 48
       add $t1, $sp, 76
       add $t2, $sp, 48
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # goto   4
       j Label4
       Label12 :
       
       # store_int 0  _t11
       li $t0, 0
       add $t1, $sp, 84
       sw $t0, 0($t1)
       
       # arr_element arr[i] i 8
       lw $t0, 84($sp)
       lw $t1, 48($sp)
       li $t2, 8
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 84($sp)
       
       # struct_array arr[i] 0 
       li $t0, 0
       lw $t1, 84($sp)
       add $t1, $t1, $t0
       sw $t1, 84($sp)
       
       # CALL_FUNC read_float  _t13
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       move $sp, $s0
       jal read_float
       add $t2, $sp, 92
       sw $v0, 0($t2)
       
       # = _t13  arr[i].a
       add $t0, $sp, 92
       add $t2, $sp, 8
       lw $t3, 84($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t15
       li $t0, 0
       add $t1, $sp, 100
       sw $t0, 0($t1)
       
       # arr_element arr[i] i 8
       lw $t0, 100($sp)
       lw $t1, 48($sp)
       li $t2, 8
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 100($sp)
       
       # struct_array arr[i] 4 
       li $t0, 4
       lw $t1, 100($sp)
       add $t1, $t1, $t0
       sw $t1, 100($sp)
       
       # CALL_FUNC read_float  _t17
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       move $sp, $s0
       jal read_float
       add $t2, $sp, 108
       sw $v0, 0($t2)
       
       # = _t17  arr[i].b
       add $t0, $sp, 108
       add $t2, $sp, 8
       lw $t3, 100($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   8
       j Label8
       Label23 :
       
       # store_int 0  _t19
       li $t0, 0
       add $t1, $sp, 84
       sw $t0, 0($t1)
       
       # = _t19  i
       add $t0, $sp, 84
       add $t2, $sp, 48
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       Label25 :
       
       # store_int 1  _t21
       li $t0, 1
       add $t1, $sp, 92
       sw $t0, 0($t1)
       
       # < i _t21 _t22
       add $t0, $sp, 48
       add $t1, $sp, 92
       add $t2, $sp, 96
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       slt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t22  33
       add $t0, $sp, 96
       lw $t1 0($t0)
       bnez $t1, Label33
       
       # goto   64
       j Label64
       Label29 :
       
       # store_int 1  _t25
       li $t0, 1
       add $t1, $sp, 108
       sw $t0, 0($t1)
       
       # = i  _t24
       add $t0, $sp, 48
       add $t2, $sp, 104
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # +int i _t25 i
       add $t0, $sp, 48
       add $t1, $sp, 108
       add $t2, $sp, 48
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # goto   25
       j Label25
       Label33 :
       
       # store_int 0  _t27
       li $t0, 0
       add $t1, $sp, 116
       sw $t0, 0($t1)
       
       # store_int 0  _t28
       li $t0, 0
       add $t1, $sp, 120
       sw $t0, 0($t1)
       
       # arr_element arr[_t28] _t28 8
       lw $t0, 116($sp)
       lw $t1, 120($sp)
       li $t2, 8
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 116($sp)
       
       # struct_array arr[_t28] 0 
       li $t0, 0
       lw $t1, 116($sp)
       add $t1, $t1, $t0
       sw $t1, 116($sp)
       
       # store_float 11.100000  _t30
       li.s $f0, 11.100000
       add $t1, $sp, 128
       swc1 $f0, 0($t1)
       
       # float_== arr[_t28].a _t30 _t32
       add $t0, $sp, 8
       lw $t1, 116($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       add $t1, $sp, 128
       add $t2, $sp, 136
       lwc1 $f0, 0($t0)
       lwc1 $f1, 0($t1)
       c.eq.s $f0, $f1
       cfc1 $t5,$25
       andi $t5, 1
       sw $t5, 0($t2)
       
       # if_goto _t32  41
       add $t0, $sp, 136
       lw $t1 0($t0)
       bnez $t1, Label41
       
       # goto   45
       j Label45
       Label41 :
       
       # store_int 1  _t34
       li $t0, 1
       add $t1, $sp, 144
       sw $t0, 0($t1)
       
       # param _t34  
       
       # CALL_FUNC printf  _t36
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 144
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 152
       sw $v0, 0($t2)
       
       # goto   48
       j Label48
       Label45 :
       
       # store_int 0  _t38
       li $t0, 0
       add $t1, $sp, 144
       sw $t0, 0($t1)
       
       # param _t38  
       
       # CALL_FUNC printf  _t40
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 144
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 152
       sw $v0, 0($t2)
       Label48 :
       
       # store_int 0  _t42
       li $t0, 0
       add $t1, $sp, 144
       sw $t0, 0($t1)
       
       # store_int 0  _t43
       li $t0, 0
       add $t1, $sp, 148
       sw $t0, 0($t1)
       
       # arr_element arr[_t43] _t43 8
       lw $t0, 144($sp)
       lw $t1, 148($sp)
       li $t2, 8
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 144($sp)
       
       # struct_array arr[_t43] 4 
       li $t0, 4
       lw $t1, 144($sp)
       add $t1, $t1, $t0
       sw $t1, 144($sp)
       
       # store_float 12.100000  _t45
       li.s $f0, 12.100000
       add $t1, $sp, 156
       swc1 $f0, 0($t1)
       
       # float_== arr[_t43].b _t45 _t47
       add $t0, $sp, 8
       lw $t1, 144($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       add $t1, $sp, 156
       add $t2, $sp, 164
       lwc1 $f0, 0($t0)
       lwc1 $f1, 0($t1)
       c.eq.s $f0, $f1
       cfc1 $t5,$25
       andi $t5, 1
       sw $t5, 0($t2)
       
       # if_goto _t47  56
       add $t0, $sp, 164
       lw $t1 0($t0)
       bnez $t1, Label56
       
       # goto   60
       j Label60
       Label56 :
       
       # store_int 3  _t49
       li $t0, 3
       add $t1, $sp, 172
       sw $t0, 0($t1)
       
       # param _t49  
       
       # CALL_FUNC printf  _t51
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 172
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 180
       sw $v0, 0($t2)
       
       # goto   29
       j Label29
       Label60 :
       
       # store_int 2  _t53
       li $t0, 2
       add $t1, $sp, 172
       sw $t0, 0($t1)
       
       # param _t53  
       
       # CALL_FUNC printf  _t55
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 172
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 180
       sw $v0, 0($t2)
       
       # goto   29
       j Label29
       Label64 :
       
       # store_int 0  _t57
       li $t0, 0
       add $t1, $sp, 116
       sw $t0, 0($t1)
       
       # RETURN _t57  
       li $a0, 0
       li $v0, 10
       syscall
       
       # FUNC_END main  
       add $sp, $sp, 280
       b func_end


print_float : 

       li $t1, 80
       add $t1, $t1, 20
       add $sp, $sp, $t1
       sub $sp, $sp, 80
       sw $ra, 0($sp)
       sw $fp, 4($sp)
       la $fp, 80($sp)
       sw $t0, 12($sp)
       sw $t1, 16($sp)
       sw $t2, 20($sp)
       sw $t3, 24($sp)
       sw $t4, 28($sp)
       sw $t5, 32($sp)
       sw $t6, 36($sp)
       sw $t7, 40($sp)
       sw $t8, 44($sp)
       sw $t9, 48($sp)
       sw $s0, 52($sp)
       sw $s1, 56($sp)
       sw $s2, 60($sp)
       sw $s3, 64($sp)
       sw $s4, 68($sp)
       sw $s5, 72($sp)
       sw $s6, 76($sp)
       add $sp, $sp, 80
       sub $sp, $sp, $t1
       lwc1 $f12, 0($sp)
       li $v0, 2
       syscall
       li $v0, 0
       add $sp, $sp, 20
       b func_end


printf : 

       li $t1, 80
       add $t1, $t1, 20
       add $sp, $sp, $t1
       sub $sp, $sp, 80
       sw $ra, 0($sp)
       sw $fp, 4($sp)
       la $fp, 80($sp)
       sw $t0, 12($sp)
       sw $t1, 16($sp)
       sw $t2, 20($sp)
       sw $t3, 24($sp)
       sw $t4, 28($sp)
       sw $t5, 32($sp)
       sw $t6, 36($sp)
       sw $t7, 40($sp)
       sw $t8, 44($sp)
       sw $t9, 48($sp)
       sw $s0, 52($sp)
       sw $s1, 56($sp)
       sw $s2, 60($sp)
       sw $s3, 64($sp)
       sw $s4, 68($sp)
       sw $s5, 72($sp)
       sw $s6, 76($sp)
       add $sp, $sp, 80
       sub $sp, $sp, $t1
       lw $t0, 0($sp)
       li $v0, 1
       move $a0, $t0
       syscall
       li $v0, 0
       add $sp, $sp, 20
       b func_end


read_float : 

       li $t1, 80
       add $t1, $t1, 20
       add $sp, $sp, $t1
       sub $sp, $sp, 80
       sw $ra, 0($sp)
       sw $fp, 4($sp)
       la $fp, 80($sp)
       sw $t0, 12($sp)
       sw $t1, 16($sp)
       sw $t2, 20($sp)
       sw $t3, 24($sp)
       sw $t4, 28($sp)
       sw $t5, 32($sp)
       sw $t6, 36($sp)
       sw $t7, 40($sp)
       sw $t8, 44($sp)
       sw $t9, 48($sp)
       sw $s0, 52($sp)
       sw $s1, 56($sp)
       sw $s2, 60($sp)
       sw $s3, 64($sp)
       sw $s4, 68($sp)
       sw $s5, 72($sp)
       sw $s6, 76($sp)
       add $sp, $sp, 80
       sub $sp, $sp, $t1
       li $v0, 6
       syscall
       mfc1 $t0, $f0
       move $v0, $t0
       add $sp, $sp, 20
       b func_end


read_int : 

       li $t1, 80
       add $t1, $t1, 20
       add $sp, $sp, $t1
       sub $sp, $sp, 80
       sw $ra, 0($sp)
       sw $fp, 4($sp)
       la $fp, 80($sp)
       sw $t0, 12($sp)
       sw $t1, 16($sp)
       sw $t2, 20($sp)
       sw $t3, 24($sp)
       sw $t4, 28($sp)
       sw $t5, 32($sp)
       sw $t6, 36($sp)
       sw $t7, 40($sp)
       sw $t8, 44($sp)
       sw $t9, 48($sp)
       sw $s0, 52($sp)
       sw $s1, 56($sp)
       sw $s2, 60($sp)
       sw $s3, 64($sp)
       sw $s4, 68($sp)
       sw $s5, 72($sp)
       sw $s6, 76($sp)
       add $sp, $sp, 80
       sub $sp, $sp, $t1
       li $v0, 5
       syscall
       add $sp, $sp, 20
       b func_end


