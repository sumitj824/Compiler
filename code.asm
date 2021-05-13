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
       add $t1, $t1, 316
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
       
       # store_int 2  _t3
       li $t0, 2
       add $t1, $sp, 8
       sw $t0, 0($t1)
       
       # store_int 1  _t5
       li $t0, 1
       add $t1, $sp, 16
       sw $t0, 0($t1)
       
       # unary- _t5  _t6
       add $t0, $sp, 16
       add $t2, $sp, 20
       lw $t3, 0($t0)
       neg $t4, $t3
       sw $t4, 0($t2)
       
       # initializer_list _t6  
       
       # store_int 2  _t8
       li $t0, 2
       add $t1, $sp, 28
       sw $t0, 0($t1)
       
       # unary- _t8  _t9
       add $t0, $sp, 28
       add $t2, $sp, 32
       lw $t3, 0($t0)
       neg $t4, $t3
       sw $t4, 0($t2)
       
       # initializer_list _t9  
       
       # initializer_list   
       
       # store_int 3  _t11
       li $t0, 3
       add $t1, $sp, 40
       sw $t0, 0($t1)
       
       # unary- _t11  _t12
       add $t0, $sp, 40
       add $t2, $sp, 44
       lw $t3, 0($t0)
       neg $t4, $t3
       sw $t4, 0($t2)
       
       # initializer_list _t12  
       
       # store_int 4  _t14
       li $t0, 4
       add $t1, $sp, 52
       sw $t0, 0($t1)
       
       # unary- _t14  _t15
       add $t0, $sp, 52
       add $t2, $sp, 56
       lw $t3, 0($t0)
       neg $t4, $t3
       sw $t4, 0($t2)
       
       # initializer_list _t15  
       
       # initializer_list   
       
       # store_int 6  _t17
       li $t0, 6
       add $t1, $sp, 64
       sw $t0, 0($t1)
       
       # unary- _t17  _t18
       add $t0, $sp, 64
       add $t2, $sp, 68
       lw $t3, 0($t0)
       neg $t4, $t3
       sw $t4, 0($t2)
       
       # initializer_list _t18  
       
       # store_int 7  _t20
       li $t0, 7
       add $t1, $sp, 76
       sw $t0, 0($t1)
       
       # unary- _t20  _t21
       add $t0, $sp, 76
       add $t2, $sp, 80
       lw $t3, 0($t0)
       neg $t4, $t3
       sw $t4, 0($t2)
       
       # initializer_list _t21  
       
       # initializer_list   
       
       # array_initialized a  
       add $t0, $sp, 20
       add $t2, $sp, 88
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       add $t0, $sp, 32
       add $t2, $sp, 88
       lw $t3, 0($t0)
       sw $t3, 4($t2)
       add $t0, $sp, 44
       add $t2, $sp, 88
       lw $t3, 0($t0)
       sw $t3, 8($t2)
       add $t0, $sp, 56
       add $t2, $sp, 88
       lw $t3, 0($t0)
       sw $t3, 12($t2)
       add $t0, $sp, 68
       add $t2, $sp, 88
       lw $t3, 0($t0)
       sw $t3, 16($t2)
       add $t0, $sp, 80
       add $t2, $sp, 88
       lw $t3, 0($t0)
       sw $t3, 20($t2)
       
       # store_int 0  _t23
       li $t0, 0
       add $t1, $sp, 112
       sw $t0, 0($t1)
       
       # store_int 0  _t24
       li $t0, 0
       add $t1, $sp, 116
       sw $t0, 0($t1)
       
       # arr_element a[_t24] _t24 8
       lw $t0, 112($sp)
       lw $t1, 116($sp)
       li $t2, 8
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 112($sp)
       
       # store_int 0  _t26
       li $t0, 0
       add $t1, $sp, 124
       sw $t0, 0($t1)
       
       # arr_element a[_t24][_t26] _t26 4
       lw $t0, 112($sp)
       lw $t1, 124($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 112($sp)
       
       # param a[_t24][_t26]  
       
       # CALL_FUNC printf  _t29
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 88
       lw $t1, 112($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 136
       sw $v0, 0($t2)
       
       # store_int 0  _t31
       li $t0, 0
       add $t1, $sp, 144
       sw $t0, 0($t1)
       
       # store_int 0  _t32
       li $t0, 0
       add $t1, $sp, 148
       sw $t0, 0($t1)
       
       # arr_element a[_t32] _t32 8
       lw $t0, 144($sp)
       lw $t1, 148($sp)
       li $t2, 8
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 144($sp)
       
       # store_int 1  _t34
       li $t0, 1
       add $t1, $sp, 156
       sw $t0, 0($t1)
       
       # arr_element a[_t32][_t34] _t34 4
       lw $t0, 144($sp)
       lw $t1, 156($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 144($sp)
       
       # param a[_t32][_t34]  
       
       # CALL_FUNC printf  _t37
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 88
       lw $t1, 144($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 168
       sw $v0, 0($t2)
       
       # store_int 0  _t39
       li $t0, 0
       add $t1, $sp, 176
       sw $t0, 0($t1)
       
       # store_int 1  _t40
       li $t0, 1
       add $t1, $sp, 180
       sw $t0, 0($t1)
       
       # arr_element a[_t40] _t40 8
       lw $t0, 176($sp)
       lw $t1, 180($sp)
       li $t2, 8
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 176($sp)
       
       # store_int 0  _t42
       li $t0, 0
       add $t1, $sp, 188
       sw $t0, 0($t1)
       
       # arr_element a[_t40][_t42] _t42 4
       lw $t0, 176($sp)
       lw $t1, 188($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 176($sp)
       
       # param a[_t40][_t42]  
       
       # CALL_FUNC printf  _t45
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 88
       lw $t1, 176($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 200
       sw $v0, 0($t2)
       
       # store_int 0  _t47
       li $t0, 0
       add $t1, $sp, 208
       sw $t0, 0($t1)
       
       # store_int 1  _t48
       li $t0, 1
       add $t1, $sp, 212
       sw $t0, 0($t1)
       
       # arr_element a[_t48] _t48 8
       lw $t0, 208($sp)
       lw $t1, 212($sp)
       li $t2, 8
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 208($sp)
       
       # store_int 1  _t50
       li $t0, 1
       add $t1, $sp, 220
       sw $t0, 0($t1)
       
       # arr_element a[_t48][_t50] _t50 4
       lw $t0, 208($sp)
       lw $t1, 220($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 208($sp)
       
       # param a[_t48][_t50]  
       
       # CALL_FUNC printf  _t53
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 88
       lw $t1, 208($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 232
       sw $v0, 0($t2)
       
       # store_int 0  _t55
       li $t0, 0
       add $t1, $sp, 240
       sw $t0, 0($t1)
       
       # store_int 2  _t56
       li $t0, 2
       add $t1, $sp, 244
       sw $t0, 0($t1)
       
       # arr_element a[_t56] _t56 8
       lw $t0, 240($sp)
       lw $t1, 244($sp)
       li $t2, 8
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 240($sp)
       
       # store_int 0  _t58
       li $t0, 0
       add $t1, $sp, 252
       sw $t0, 0($t1)
       
       # arr_element a[_t56][_t58] _t58 4
       lw $t0, 240($sp)
       lw $t1, 252($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 240($sp)
       
       # param a[_t56][_t58]  
       
       # CALL_FUNC printf  _t61
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 88
       lw $t1, 240($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 264
       sw $v0, 0($t2)
       
       # store_int 0  _t63
       li $t0, 0
       add $t1, $sp, 272
       sw $t0, 0($t1)
       
       # store_int 2  _t64
       li $t0, 2
       add $t1, $sp, 276
       sw $t0, 0($t1)
       
       # arr_element a[_t64] _t64 8
       lw $t0, 272($sp)
       lw $t1, 276($sp)
       li $t2, 8
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 272($sp)
       
       # store_int 1  _t66
       li $t0, 1
       add $t1, $sp, 284
       sw $t0, 0($t1)
       
       # arr_element a[_t64][_t66] _t66 4
       lw $t0, 272($sp)
       lw $t1, 284($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 272($sp)
       
       # param a[_t64][_t66]  
       
       # CALL_FUNC printf  _t69
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 88
       lw $t1, 272($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 296
       sw $v0, 0($t2)
       
       # store_int 0  _t71
       li $t0, 0
       add $t1, $sp, 304
       sw $t0, 0($t1)
       
       # RETURN _t71  
       li $a0, 0
       li $v0, 10
       syscall
       
       # FUNC_END main  
       add $sp, $sp, 316
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


