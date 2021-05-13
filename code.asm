.data

       _t1 : .space 4
       _t21 : .space 4
       _t22 : .space 4
       _t23 : .space 4
       _t75 : .space 4


.text

display : 

       li $t1, 80
       add $t1, $t1, 104
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
       
       # store_int 0  _t76
       li $t0, 0
       add $t1, $sp, 20
       sw $t0, 0($t1)
       
       # = _t76  i
       add $t0, $sp, 20
       add $t2, $sp, 12
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       Label100 :
       
       # < i row _t78
       add $t0, $sp, 12
       add $t1, $sp, 4
       add $t2, $sp, 28
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       slt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t78  107
       add $t0, $sp, 28
       lw $t1 0($t0)
       bnez $t1, Label107
       
       # goto   123
       j Label123
       Label103 :
       
       # store_int 1  _t81
       li $t0, 1
       add $t1, $sp, 40
       sw $t0, 0($t1)
       
       # +int i _t81 _t80
       add $t0, $sp, 12
       add $t1, $sp, 40
       add $t2, $sp, 36
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # = _t80  i
       add $t0, $sp, 36
       add $t2, $sp, 12
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   100
       j Label100
       Label107 :
       
       # store_int 0  _t83
       li $t0, 0
       add $t1, $sp, 48
       sw $t0, 0($t1)
       
       # = _t83  j
       add $t0, $sp, 48
       add $t2, $sp, 16
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       Label109 :
       
       # < j column _t85
       add $t0, $sp, 16
       add $t1, $sp, 8
       add $t2, $sp, 56
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       slt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t85  116
       add $t0, $sp, 56
       lw $t1 0($t0)
       bnez $t1, Label116
       
       # goto   103
       j Label103
       Label112 :
       
       # store_int 1  _t88
       li $t0, 1
       add $t1, $sp, 68
       sw $t0, 0($t1)
       
       # +int j _t88 _t87
       add $t0, $sp, 16
       add $t1, $sp, 68
       add $t2, $sp, 64
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # = _t87  j
       add $t0, $sp, 64
       add $t2, $sp, 16
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   109
       j Label109
       Label116 :
       
       # store_int 0  _t90
       li $t0, 0
       add $t1, $sp, 76
       sw $t0, 0($t1)
       
       # arr_element result[i] i 12
       lw $t0, 76($sp)
       lw $t1, 12($sp)
       li $t2, 12
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 76($sp)
       
       # arr_element result[i][j] j 4
       lw $t0, 76($sp)
       lw $t1, 16($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 76($sp)
       
       # param result[i][j]  
       
       # CALL_FUNC printf  _t94
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 0
       lw $t1, 0($t0)
       lw $t0, 76($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 92
       sw $v0, 0($t2)
       
       # goto   112
       j Label112
       
       # goto   103
       j Label103
       Label123 :
       
       # RETURN   
       li $v0, 0
       add $sp, $sp, 104
       b func_end
       
       # FUNC_END display  
       add $sp, $sp, 104
       b func_end
       
       # FUNC_START main  


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


getMatrixElements : 

       li $t1, 80
       add $t1, $t1, 100
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
       
       # store_int 0  _t2
       li $t0, 0
       add $t1, $sp, 20
       sw $t0, 0($t1)
       
       # = _t2  i
       add $t0, $sp, 20
       add $t2, $sp, 12
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       Label3 :
       
       # < i row _t4
       add $t0, $sp, 12
       add $t1, $sp, 4
       add $t2, $sp, 28
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       slt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t4  10
       add $t0, $sp, 28
       lw $t1 0($t0)
       bnez $t1, Label10
       
       # goto   26
       j Label26
       Label6 :
       
       # store_int 1  _t7
       li $t0, 1
       add $t1, $sp, 40
       sw $t0, 0($t1)
       
       # +int i _t7 _t6
       add $t0, $sp, 12
       add $t1, $sp, 40
       add $t2, $sp, 36
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # = _t6  i
       add $t0, $sp, 36
       add $t2, $sp, 12
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   3
       j Label3
       Label10 :
       
       # store_int 0  _t9
       li $t0, 0
       add $t1, $sp, 48
       sw $t0, 0($t1)
       
       # = _t9  j
       add $t0, $sp, 48
       add $t2, $sp, 16
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       Label12 :
       
       # < j column _t11
       add $t0, $sp, 16
       add $t1, $sp, 8
       add $t2, $sp, 56
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       slt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t11  19
       add $t0, $sp, 56
       lw $t1 0($t0)
       bnez $t1, Label19
       
       # goto   6
       j Label6
       Label15 :
       
       # store_int 1  _t14
       li $t0, 1
       add $t1, $sp, 68
       sw $t0, 0($t1)
       
       # +int j _t14 _t13
       add $t0, $sp, 16
       add $t1, $sp, 68
       add $t2, $sp, 64
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # = _t13  j
       add $t0, $sp, 64
       add $t2, $sp, 16
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   12
       j Label12
       Label19 :
       
       # store_int 0  _t16
       li $t0, 0
       add $t1, $sp, 76
       sw $t0, 0($t1)
       
       # arr_element matrix[i] i 12
       lw $t0, 76($sp)
       lw $t1, 12($sp)
       li $t2, 12
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 76($sp)
       
       # arr_element matrix[i][j] j 4
       lw $t0, 76($sp)
       lw $t1, 16($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 76($sp)
       
       # CALL_FUNC read_int  _t19
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       move $sp, $s0
       jal read_int
       add $t2, $sp, 88
       sw $v0, 0($t2)
       
       # = _t19  matrix[i][j]
       add $t0, $sp, 88
       add $t2, $sp, 0
       lw $t3, 0($t2)
       lw $t2, 76($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   15
       j Label15
       
       # goto   6
       j Label6
       Label26 :
       
       # RETURN   
       li $v0, 0
       add $sp, $sp, 100
       b func_end
       
       # FUNC_END getMatrixElements  
       add $sp, $sp, 100
       b func_end
       
       # FUNC_START multiplyMatrices  


main : 

       li $t1, 80
       add $t1, $t1, 432
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
       
       # store_int 3  _t96
       li $t0, 3
       add $t1, $sp, 0
       sw $t0, 0($t1)
       
       # = _t96  r1
       add $t0, $sp, 0
       add $t2, $sp, 8
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 3  _t98
       li $t0, 3
       add $t1, $sp, 12
       sw $t0, 0($t1)
       
       # = _t98  c1
       add $t0, $sp, 12
       add $t2, $sp, 20
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 3  _t100
       li $t0, 3
       add $t1, $sp, 24
       sw $t0, 0($t1)
       
       # = _t100  r2
       add $t0, $sp, 24
       add $t2, $sp, 32
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 3  _t102
       li $t0, 3
       add $t1, $sp, 36
       sw $t0, 0($t1)
       
       # = _t102  c2
       add $t0, $sp, 36
       add $t2, $sp, 44
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 3  _t104
       li $t0, 3
       add $t1, $sp, 48
       sw $t0, 0($t1)
       
       # store_int 3  _t106
       li $t0, 3
       add $t1, $sp, 56
       sw $t0, 0($t1)
       
       # store_int 1  _t108
       li $t0, 1
       add $t1, $sp, 64
       sw $t0, 0($t1)
       
       # initializer_list _t108  
       
       # store_int 2  _t110
       li $t0, 2
       add $t1, $sp, 72
       sw $t0, 0($t1)
       
       # initializer_list _t110  
       
       # store_int 3  _t112
       li $t0, 3
       add $t1, $sp, 80
       sw $t0, 0($t1)
       
       # initializer_list _t112  
       
       # initializer_list   
       
       # store_int 3  _t114
       li $t0, 3
       add $t1, $sp, 88
       sw $t0, 0($t1)
       
       # initializer_list _t114  
       
       # store_int 4  _t116
       li $t0, 4
       add $t1, $sp, 96
       sw $t0, 0($t1)
       
       # initializer_list _t116  
       
       # store_int 5  _t118
       li $t0, 5
       add $t1, $sp, 104
       sw $t0, 0($t1)
       
       # initializer_list _t118  
       
       # initializer_list   
       
       # store_int 7  _t120
       li $t0, 7
       add $t1, $sp, 112
       sw $t0, 0($t1)
       
       # initializer_list _t120  
       
       # store_int 8  _t122
       li $t0, 8
       add $t1, $sp, 120
       sw $t0, 0($t1)
       
       # initializer_list _t122  
       
       # store_int 9  _t124
       li $t0, 9
       add $t1, $sp, 128
       sw $t0, 0($t1)
       
       # initializer_list _t124  
       
       # initializer_list   
       
       # array_initialized first  
       add $t0, $sp, 64
       add $t2, $sp, 136
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       add $t0, $sp, 72
       add $t2, $sp, 136
       lw $t3, 0($t0)
       sw $t3, 4($t2)
       add $t0, $sp, 80
       add $t2, $sp, 136
       lw $t3, 0($t0)
       sw $t3, 8($t2)
       add $t0, $sp, 88
       add $t2, $sp, 136
       lw $t3, 0($t0)
       sw $t3, 12($t2)
       add $t0, $sp, 96
       add $t2, $sp, 136
       lw $t3, 0($t0)
       sw $t3, 16($t2)
       add $t0, $sp, 104
       add $t2, $sp, 136
       lw $t3, 0($t0)
       sw $t3, 20($t2)
       add $t0, $sp, 112
       add $t2, $sp, 136
       lw $t3, 0($t0)
       sw $t3, 24($t2)
       add $t0, $sp, 120
       add $t2, $sp, 136
       lw $t3, 0($t0)
       sw $t3, 28($t2)
       add $t0, $sp, 128
       add $t2, $sp, 136
       lw $t3, 0($t0)
       sw $t3, 32($t2)
       
       # store_int 3  _t126
       li $t0, 3
       add $t1, $sp, 172
       sw $t0, 0($t1)
       
       # store_int 3  _t128
       li $t0, 3
       add $t1, $sp, 180
       sw $t0, 0($t1)
       
       # store_int 1  _t130
       li $t0, 1
       add $t1, $sp, 188
       sw $t0, 0($t1)
       
       # initializer_list _t130  
       
       # store_int 2  _t132
       li $t0, 2
       add $t1, $sp, 196
       sw $t0, 0($t1)
       
       # initializer_list _t132  
       
       # store_int 3  _t134
       li $t0, 3
       add $t1, $sp, 204
       sw $t0, 0($t1)
       
       # initializer_list _t134  
       
       # initializer_list   
       
       # store_int 3  _t136
       li $t0, 3
       add $t1, $sp, 212
       sw $t0, 0($t1)
       
       # initializer_list _t136  
       
       # store_int 4  _t138
       li $t0, 4
       add $t1, $sp, 220
       sw $t0, 0($t1)
       
       # initializer_list _t138  
       
       # store_int 5  _t140
       li $t0, 5
       add $t1, $sp, 228
       sw $t0, 0($t1)
       
       # initializer_list _t140  
       
       # initializer_list   
       
       # store_int 7  _t142
       li $t0, 7
       add $t1, $sp, 236
       sw $t0, 0($t1)
       
       # initializer_list _t142  
       
       # store_int 8  _t144
       li $t0, 8
       add $t1, $sp, 244
       sw $t0, 0($t1)
       
       # initializer_list _t144  
       
       # store_int 9  _t146
       li $t0, 9
       add $t1, $sp, 252
       sw $t0, 0($t1)
       
       # initializer_list _t146  
       
       # initializer_list   
       
       # array_initialized second  
       add $t0, $sp, 188
       add $t2, $sp, 260
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       add $t0, $sp, 196
       add $t2, $sp, 260
       lw $t3, 0($t0)
       sw $t3, 4($t2)
       add $t0, $sp, 204
       add $t2, $sp, 260
       lw $t3, 0($t0)
       sw $t3, 8($t2)
       add $t0, $sp, 212
       add $t2, $sp, 260
       lw $t3, 0($t0)
       sw $t3, 12($t2)
       add $t0, $sp, 220
       add $t2, $sp, 260
       lw $t3, 0($t0)
       sw $t3, 16($t2)
       add $t0, $sp, 228
       add $t2, $sp, 260
       lw $t3, 0($t0)
       sw $t3, 20($t2)
       add $t0, $sp, 236
       add $t2, $sp, 260
       lw $t3, 0($t0)
       sw $t3, 24($t2)
       add $t0, $sp, 244
       add $t2, $sp, 260
       lw $t3, 0($t0)
       sw $t3, 28($t2)
       add $t0, $sp, 252
       add $t2, $sp, 260
       lw $t3, 0($t0)
       sw $t3, 32($t2)
       
       # store_int 3  _t148
       li $t0, 3
       add $t1, $sp, 296
       sw $t0, 0($t1)
       
       # store_int 3  _t150
       li $t0, 3
       add $t1, $sp, 304
       sw $t0, 0($t1)
       
       # store_int 0  _t152
       li $t0, 0
       add $t1, $sp, 348
       sw $t0, 0($t1)
       
       # param first  
       
       # store_int 0  _t154
       li $t0, 0
       add $t1, $sp, 356
       sw $t0, 0($t1)
       
       # param second  
       
       # store_int 0  _t156
       li $t0, 0
       add $t1, $sp, 364
       sw $t0, 0($t1)
       
       # param result  
       
       # param r1  
       
       # param c1  
       
       # param r2  
       
       # param c2  
       
       # CALL_FUNC multiplyMatrices  _t162
       li $t1, 80
       add $t1, $t1, 248
       sub $s0, $sp, $t1
       add $t1, $sp, 136
       sw $t1, 0($s0)
       add $t1, $sp, 260
       sw $t1, 4($s0)
       add $t1, $sp, 312
       sw $t1, 8($s0)
       add $t0, $sp, 8
       lw $t1, 0($t0)
       sw $t1, 12($s0)
       add $t0, $sp, 20
       lw $t1, 0($t0)
       sw $t1, 16($s0)
       add $t0, $sp, 32
       lw $t1, 0($t0)
       sw $t1, 20($s0)
       add $t0, $sp, 44
       lw $t1, 0($t0)
       sw $t1, 24($s0)
       move $sp, $s0
       jal multiplyMatrices
       add $t2, $sp, 388
       sw $v0, 0($t2)
       
       # store_int 0  _t164
       li $t0, 0
       add $t1, $sp, 396
       sw $t0, 0($t1)
       
       # param result  
       
       # param r1  
       
       # param c2  
       
       # CALL_FUNC display  _t168
       li $t1, 80
       add $t1, $t1, 104
       sub $s0, $sp, $t1
       add $t1, $sp, 312
       sw $t1, 0($s0)
       add $t0, $sp, 8
       lw $t1, 0($t0)
       sw $t1, 4($s0)
       add $t0, $sp, 44
       lw $t1, 0($t0)
       sw $t1, 8($s0)
       move $sp, $s0
       jal display
       add $t2, $sp, 412
       sw $v0, 0($t2)
       
       # store_int 0  _t170
       li $t0, 0
       add $t1, $sp, 420
       sw $t0, 0($t1)
       
       # RETURN _t170  
       li $a0, 0
       li $v0, 10
       syscall
       
       # FUNC_END main  
       add $sp, $sp, 432
       b func_end


multiplyMatrices : 

       li $t1, 80
       add $t1, $t1, 248
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
       
       # store_int 0  _t24
       li $t0, 0
       add $t1, $sp, 40
       sw $t0, 0($t1)
       
       # = _t24  i
       add $t0, $sp, 40
       add $t2, $sp, 28
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       Label31 :
       
       # < i r1 _t26
       add $t0, $sp, 28
       add $t1, $sp, 12
       add $t2, $sp, 48
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       slt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t26  38
       add $t0, $sp, 48
       lw $t1 0($t0)
       bnez $t1, Label38
       
       # goto   54
       j Label54
       Label34 :
       
       # store_int 1  _t29
       li $t0, 1
       add $t1, $sp, 60
       sw $t0, 0($t1)
       
       # +int i _t29 _t28
       add $t0, $sp, 28
       add $t1, $sp, 60
       add $t2, $sp, 56
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # = _t28  i
       add $t0, $sp, 56
       add $t2, $sp, 28
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   31
       j Label31
       Label38 :
       
       # store_int 0  _t31
       li $t0, 0
       add $t1, $sp, 68
       sw $t0, 0($t1)
       
       # = _t31  j
       add $t0, $sp, 68
       add $t2, $sp, 32
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       Label40 :
       
       # < j c9 _t33
       add $t0, $sp, 32
       add $t1, $sp, 24
       add $t2, $sp, 76
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       slt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t33  47
       add $t0, $sp, 76
       lw $t1 0($t0)
       bnez $t1, Label47
       
       # goto   34
       j Label34
       Label43 :
       
       # store_int 1  _t36
       li $t0, 1
       add $t1, $sp, 88
       sw $t0, 0($t1)
       
       # +int j _t36 _t35
       add $t0, $sp, 32
       add $t1, $sp, 88
       add $t2, $sp, 84
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # = _t35  j
       add $t0, $sp, 84
       add $t2, $sp, 32
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   40
       j Label40
       Label47 :
       
       # store_int 0  _t38
       li $t0, 0
       add $t1, $sp, 96
       sw $t0, 0($t1)
       
       # arr_element result[i] i 12
       lw $t0, 96($sp)
       lw $t1, 28($sp)
       li $t2, 12
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 96($sp)
       
       # arr_element result[i][j] j 4
       lw $t0, 96($sp)
       lw $t1, 32($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 96($sp)
       
       # store_int 0  _t41
       li $t0, 0
       add $t1, $sp, 108
       sw $t0, 0($t1)
       
       # = _t41  result[i][j]
       add $t0, $sp, 108
       add $t2, $sp, 8
       lw $t3, 0($t2)
       lw $t2, 96($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   43
       j Label43
       
       # goto   34
       j Label34
       Label54 :
       
       # store_int 0  _t43
       li $t0, 0
       add $t1, $sp, 68
       sw $t0, 0($t1)
       
       # = _t43  i
       add $t0, $sp, 68
       add $t2, $sp, 28
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       Label56 :
       
       # < i r1 _t45
       add $t0, $sp, 28
       add $t1, $sp, 12
       add $t2, $sp, 76
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       slt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t45  63
       add $t0, $sp, 76
       lw $t1 0($t0)
       bnez $t1, Label63
       
       # goto   95
       j Label95
       Label59 :
       
       # store_int 1  _t48
       li $t0, 1
       add $t1, $sp, 88
       sw $t0, 0($t1)
       
       # +int i _t48 _t47
       add $t0, $sp, 28
       add $t1, $sp, 88
       add $t2, $sp, 84
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # = _t47  i
       add $t0, $sp, 84
       add $t2, $sp, 28
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   56
       j Label56
       Label63 :
       
       # store_int 0  _t50
       li $t0, 0
       add $t1, $sp, 96
       sw $t0, 0($t1)
       
       # = _t50  j
       add $t0, $sp, 96
       add $t2, $sp, 32
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       Label65 :
       
       # < j c9 _t52
       add $t0, $sp, 32
       add $t1, $sp, 24
       add $t2, $sp, 104
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       slt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t52  72
       add $t0, $sp, 104
       lw $t1 0($t0)
       bnez $t1, Label72
       
       # goto   59
       j Label59
       Label68 :
       
       # store_int 1  _t55
       li $t0, 1
       add $t1, $sp, 116
       sw $t0, 0($t1)
       
       # +int j _t55 _t54
       add $t0, $sp, 32
       add $t1, $sp, 116
       add $t2, $sp, 112
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # = _t54  j
       add $t0, $sp, 112
       add $t2, $sp, 32
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   65
       j Label65
       Label72 :
       
       # store_int 0  _t57
       li $t0, 0
       add $t1, $sp, 124
       sw $t0, 0($t1)
       
       # = _t57  k
       add $t0, $sp, 124
       add $t2, $sp, 36
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       Label74 :
       
       # < k c1 _t59
       add $t0, $sp, 36
       add $t1, $sp, 16
       add $t2, $sp, 132
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       slt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t59  81
       add $t0, $sp, 132
       lw $t1 0($t0)
       bnez $t1, Label81
       
       # goto   68
       j Label68
       Label77 :
       
       # store_int 1  _t62
       li $t0, 1
       add $t1, $sp, 144
       sw $t0, 0($t1)
       
       # +int k _t62 _t61
       add $t0, $sp, 36
       add $t1, $sp, 144
       add $t2, $sp, 140
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # = _t61  k
       add $t0, $sp, 140
       add $t2, $sp, 36
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   74
       j Label74
       Label81 :
       
       # store_int 0  _t64
       li $t0, 0
       add $t1, $sp, 152
       sw $t0, 0($t1)
       
       # arr_element result[i] i 12
       lw $t0, 152($sp)
       lw $t1, 28($sp)
       li $t2, 12
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 152($sp)
       
       # arr_element result[i][j] j 4
       lw $t0, 152($sp)
       lw $t1, 32($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 152($sp)
       
       # store_int 0  _t67
       li $t0, 0
       add $t1, $sp, 164
       sw $t0, 0($t1)
       
       # arr_element first[i] i 12
       lw $t0, 164($sp)
       lw $t1, 28($sp)
       li $t2, 12
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 164($sp)
       
       # arr_element first[i][k] k 4
       lw $t0, 164($sp)
       lw $t1, 36($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 164($sp)
       
       # store_int 0  _t70
       li $t0, 0
       add $t1, $sp, 176
       sw $t0, 0($t1)
       
       # arr_element second[k] k 12
       lw $t0, 176($sp)
       lw $t1, 36($sp)
       li $t2, 12
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 176($sp)
       
       # arr_element second[k][j] j 4
       lw $t0, 176($sp)
       lw $t1, 32($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 176($sp)
       
       # *int first[i][k] second[k][j] _t73
       add $t0, $sp, 0
       lw $t1, 0($t0)
       lw $t0, 164($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       add $t1, $sp, 4
       lw $t2, 0($t1)
       lw $t1, 176($sp)
       add $t2, $t2, $t1
       move $t1, $t2
       add $t2, $sp, 188
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       mul $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # +int result[i][j] _t73 result[i][j]
       add $t0, $sp, 8
       lw $t1, 0($t0)
       lw $t0, 152($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       add $t1, $sp, 188
       add $t2, $sp, 8
       lw $t3, 0($t2)
       lw $t2, 152($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # goto   77
       j Label77
       
       # goto   68
       j Label68
       
       # goto   59
       j Label59
       Label95 :
       
       # RETURN   
       li $v0, 0
       add $sp, $sp, 248
       b func_end
       
       # FUNC_END multiplyMatrices  
       add $sp, $sp, 248
       b func_end
       
       # FUNC_START display  


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
       lw $t0, 0($sp)
       mtc1 $t0, $f12
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


