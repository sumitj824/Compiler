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
       add $t1, $t1, 204
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
       
       # store_int 3  _t1
       li $t0, 3
       add $t1, $sp, 0
       sw $t0, 0($t1)
       
       # store_int 1  _t3
       li $t0, 1
       add $t1, $sp, 8
       sw $t0, 0($t1)
       
       # initializer_list _t3  
       
       # store_int 2  _t5
       li $t0, 2
       add $t1, $sp, 16
       sw $t0, 0($t1)
       
       # initializer_list _t5  
       
       # store_int 3  _t7
       li $t0, 3
       add $t1, $sp, 24
       sw $t0, 0($t1)
       
       # initializer_list _t7  
       
       # store_int 4  _t9
       li $t0, 4
       add $t1, $sp, 32
       sw $t0, 0($t1)
       
       # initializer_list _t9  
       
       # store_int 5  _t11
       li $t0, 5
       add $t1, $sp, 40
       sw $t0, 0($t1)
       
       # initializer_list _t11  
       
       # array_initialized a  
       add $t0, $sp, 8
       add $t2, $sp, 48
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       add $t0, $sp, 16
       add $t2, $sp, 48
       lw $t3, 0($t0)
       sw $t3, 4($t2)
       add $t0, $sp, 24
       add $t2, $sp, 48
       lw $t3, 0($t0)
       sw $t3, 8($t2)
       add $t0, $sp, 32
       add $t2, $sp, 48
       lw $t3, 0($t0)
       sw $t3, 12($t2)
       add $t0, $sp, 40
       add $t2, $sp, 48
       lw $t3, 0($t0)
       sw $t3, 16($t2)
       
       # store_int 9  _t13
       li $t0, 9
       add $t1, $sp, 60
       sw $t0, 0($t1)
       
       # = _t13  c
       add $t0, $sp, 60
       add $t2, $sp, 68
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t15
       li $t0, 0
       add $t1, $sp, 72
       sw $t0, 0($t1)
       
       # store_int 0  _t16
       li $t0, 0
       add $t1, $sp, 76
       sw $t0, 0($t1)
       
       # arr_element a[_t16] _t16 4
       lw $t0, 72($sp)
       lw $t1, 76($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 72($sp)
       
       # param a[_t16]  
       
       # CALL_FUNC printf  _t19
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 48
       lw $t1, 72($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 88
       sw $v0, 0($t2)
       
       # store_int 0  _t21
       li $t0, 0
       add $t1, $sp, 96
       sw $t0, 0($t1)
       
       # store_int 1  _t22
       li $t0, 1
       add $t1, $sp, 100
       sw $t0, 0($t1)
       
       # arr_element a[_t22] _t22 4
       lw $t0, 96($sp)
       lw $t1, 100($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 96($sp)
       
       # param a[_t22]  
       
       # CALL_FUNC printf  _t25
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 48
       lw $t1, 96($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 112
       sw $v0, 0($t2)
       
       # store_int 0  _t27
       li $t0, 0
       add $t1, $sp, 120
       sw $t0, 0($t1)
       
       # store_int 2  _t28
       li $t0, 2
       add $t1, $sp, 124
       sw $t0, 0($t1)
       
       # arr_element a[_t28] _t28 4
       lw $t0, 120($sp)
       lw $t1, 124($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 120($sp)
       
       # param a[_t28]  
       
       # CALL_FUNC printf  _t31
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 48
       lw $t1, 120($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 136
       sw $v0, 0($t2)
       
       # store_int 0  _t33
       li $t0, 0
       add $t1, $sp, 144
       sw $t0, 0($t1)
       
       # store_int 3  _t34
       li $t0, 3
       add $t1, $sp, 148
       sw $t0, 0($t1)
       
       # arr_element a[_t34] _t34 4
       lw $t0, 144($sp)
       lw $t1, 148($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 144($sp)
       
       # param a[_t34]  
       
       # CALL_FUNC printf  _t37
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 48
       lw $t1, 144($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 160
       sw $v0, 0($t2)
       
       # store_int 0  _t39
       li $t0, 0
       add $t1, $sp, 168
       sw $t0, 0($t1)
       
       # store_int 4  _t40
       li $t0, 4
       add $t1, $sp, 172
       sw $t0, 0($t1)
       
       # arr_element a[_t40] _t40 4
       lw $t0, 168($sp)
       lw $t1, 172($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 168($sp)
       
       # param a[_t40]  
       
       # CALL_FUNC printf  _t43
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 48
       lw $t1, 168($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 184
       sw $v0, 0($t2)
       
       # store_int 0  _t45
       li $t0, 0
       add $t1, $sp, 192
       sw $t0, 0($t1)
       
       # RETURN _t45  
       li $a0, 0
       li $v0, 10
       syscall
       
       # FUNC_END main  
       add $sp, $sp, 204
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


