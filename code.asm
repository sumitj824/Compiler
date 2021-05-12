func_end:

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


main:

       li $t1, 80
       add $t1, $t1, 228
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
       
       # store_int 6  _t89
       li $t0, 6
       add $t1, $sp, 0
       sw $t0, 0($t1)
       
       # store_int 6  _t91
       li $t0, 6
       add $t1, $sp, 32
       sw $t0, 0($t1)
       
       # = _t91  n
       add $t0, $sp, 32
       add $t2, $sp, 40
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t93
       li $t0, 0
       add $t1, $sp, 44
       sw $t0, 0($t1)
       
       # store_int 0  _t94
       li $t0, 0
       add $t1, $sp, 48
       sw $t0, 0($t1)
       
       # arr_element arr[_t94] _t94 4
       lw $t0, 44($sp)
       lw $t1, 48($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 44($sp)
       
       # store_int 9  _t96
       li $t0, 9
       add $t1, $sp, 56
       sw $t0, 0($t1)
       
       # = _t96  arr[_t94]
       add $t0, $sp, 56
       add $t2, $sp, 8
       lw $t3, 44($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t98
       li $t0, 0
       add $t1, $sp, 64
       sw $t0, 0($t1)
       
       # store_int 1  _t99
       li $t0, 1
       add $t1, $sp, 68
       sw $t0, 0($t1)
       
       # arr_element arr[_t99] _t99 4
       lw $t0, 64($sp)
       lw $t1, 68($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 64($sp)
       
       # store_int 7  _t101
       li $t0, 7
       add $t1, $sp, 76
       sw $t0, 0($t1)
       
       # = _t101  arr[_t99]
       add $t0, $sp, 76
       add $t2, $sp, 8
       lw $t3, 64($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t103
       li $t0, 0
       add $t1, $sp, 84
       sw $t0, 0($t1)
       
       # store_int 2  _t104
       li $t0, 2
       add $t1, $sp, 88
       sw $t0, 0($t1)
       
       # arr_element arr[_t104] _t104 4
       lw $t0, 84($sp)
       lw $t1, 88($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 84($sp)
       
       # store_int 8  _t106
       li $t0, 8
       add $t1, $sp, 96
       sw $t0, 0($t1)
       
       # = _t106  arr[_t104]
       add $t0, $sp, 96
       add $t2, $sp, 8
       lw $t3, 84($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t108
       li $t0, 0
       add $t1, $sp, 104
       sw $t0, 0($t1)
       
       # store_int 3  _t109
       li $t0, 3
       add $t1, $sp, 108
       sw $t0, 0($t1)
       
       # arr_element arr[_t109] _t109 4
       lw $t0, 104($sp)
       lw $t1, 108($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 104($sp)
       
       # store_int 1  _t111
       li $t0, 1
       add $t1, $sp, 116
       sw $t0, 0($t1)
       
       # = _t111  arr[_t109]
       add $t0, $sp, 116
       add $t2, $sp, 8
       lw $t3, 104($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t113
       li $t0, 0
       add $t1, $sp, 124
       sw $t0, 0($t1)
       
       # store_int 4  _t114
       li $t0, 4
       add $t1, $sp, 128
       sw $t0, 0($t1)
       
       # arr_element arr[_t114] _t114 4
       lw $t0, 124($sp)
       lw $t1, 128($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 124($sp)
       
       # store_int 6  _t116
       li $t0, 6
       add $t1, $sp, 136
       sw $t0, 0($t1)
       
       # = _t116  arr[_t114]
       add $t0, $sp, 136
       add $t2, $sp, 8
       lw $t3, 124($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t118
       li $t0, 0
       add $t1, $sp, 144
       sw $t0, 0($t1)
       
       # store_int 5  _t119
       li $t0, 5
       add $t1, $sp, 148
       sw $t0, 0($t1)
       
       # arr_element arr[_t119] _t119 4
       lw $t0, 144($sp)
       lw $t1, 148($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 144($sp)
       
       # store_int 5  _t121
       li $t0, 5
       add $t1, $sp, 156
       sw $t0, 0($t1)
       
       # = _t121  arr[_t119]
       add $t0, $sp, 156
       add $t2, $sp, 8
       lw $t3, 144($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t123
       li $t0, 0
       add $t1, $sp, 164
       sw $t0, 0($t1)
       
       # param arr  
       
       # store_int 0  _t125
       li $t0, 0
       add $t1, $sp, 172
       sw $t0, 0($t1)
       
       # param _t125  
       
       # store_int 1  _t127
       li $t0, 1
       add $t1, $sp, 180
       sw $t0, 0($t1)
       
       # -int n _t127 _t128
       add $t0, $sp, 40
       add $t1, $sp, 180
       add $t2, $sp, 184
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       neg $t6, $t4
       add $t5, $t3, $t6
       sw $t5, 0($t2)
       
       # param _t128  
       
       # CALL_FUNC quickSort  _t130
       li $t1, 80
       add $t1, $t1, 112
       sub $s0, $sp, $t1
       li $t0, 8
       add $t0, $sp, $t0
       sw $t0, 0($s0)
       add $t0, $sp, 172
       lw $t1, 0($t0)
       sw $t1, 4($s0)
       add $t0, $sp, 184
       lw $t1, 0($t0)
       sw $t1, 8($s0)
       move $sp, $s0
       jal quickSort
       add $t2, $sp, 192
       sw $v0, 0($t2)
       
       # store_int 0  _t132
       li $t0, 0
       add $t1, $sp, 200
       sw $t0, 0($t1)
       
       # param arr  
       
       # param n  
       
       # CALL_FUNC printArray  _t135
       li $t1, 80
       add $t1, $t1, 60
       sub $s0, $sp, $t1
       li $t0, 8
       add $t0, $sp, $t0
       sw $t0, 0($s0)
       add $t0, $sp, 40
       lw $t1, 0($t0)
       sw $t1, 4($s0)
       move $sp, $s0
       jal printArray
       add $t2, $sp, 212
       sw $v0, 0($t2)
       
       # store_int 0  _t137
       li $t0, 0
       add $t1, $sp, 220
       sw $t0, 0($t1)
       
       # FUNC_END _t137  
       li $a0, 0
       li $v0, 10
       syscall


partition:

       li $t1, 80
       add $t1, $t1, 236
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
       
       # store_int 0  _t1
       li $t0, 0
       add $t1, $sp, 12
       sw $t0, 0($t1)
       
       # arr_element arr[high] high 4
       lw $t0, 12($sp)
       lw $t1, 8($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 12($sp)
       
       # = arr[high]  pivot
       add $t0, $sp, 0
       lw $t1, ($t0)
       lw $t0, 12($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       add $t2, $sp, 24
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 1  _t4
       li $t0, 1
       add $t1, $sp, 32
       sw $t0, 0($t1)
       
       # -int low _t4 _t5
       add $t0, $sp, 4
       add $t1, $sp, 32
       add $t2, $sp, 36
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       neg $t6, $t4
       add $t5, $t3, $t6
       sw $t5, 0($t2)
       
       # = _t5  i
       add $t0, $sp, 36
       add $t2, $sp, 48
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # = low  j
       add $t0, $sp, 4
       add $t2, $sp, 52
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       Label8 :
       
       # store_int 1  _t9
       li $t0, 1
       add $t1, $sp, 60
       sw $t0, 0($t1)
       
       # -int high _t9 _t10
       add $t0, $sp, 8
       add $t1, $sp, 60
       add $t2, $sp, 64
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       neg $t6, $t4
       add $t5, $t3, $t6
       sw $t5, 0($t2)
       
       # <= j _t10 _t11
       add $t0, $sp, 52
       add $t1, $sp, 64
       add $t2, $sp, 68
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       sle $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t11  17
       add $t0, $sp, 68
       lw $t1 0($t0)
       bnez $t1, Label17
       
       # goto   37
       j Label37
       Label13 :
       
       # store_int 1  _t14
       li $t0, 1
       add $t1, $sp, 80
       sw $t0, 0($t1)
       
       # = j  _t13
       add $t0, $sp, 52
       add $t2, $sp, 76
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # +int j _t14 j
       add $t0, $sp, 52
       add $t1, $sp, 80
       add $t2, $sp, 52
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # goto   8
       j Label8
       Label17 :
       
       # store_int 0  _t16
       li $t0, 0
       add $t1, $sp, 88
       sw $t0, 0($t1)
       
       # arr_element arr[j] j 4
       lw $t0, 88($sp)
       lw $t1, 52($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 88($sp)
       
       # < arr[j] pivot _t18
       add $t0, $sp, 0
       lw $t1, ($t0)
       lw $t0, 88($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       add $t1, $sp, 24
       add $t2, $sp, 96
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       slt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t18  22
       add $t0, $sp, 96
       lw $t1 0($t0)
       bnez $t1, Label22
       
       # goto   13
       j Label13
       Label22 :
       
       # store_int 1  _t21
       li $t0, 1
       add $t1, $sp, 108
       sw $t0, 0($t1)
       
       # = i  _t20
       add $t0, $sp, 48
       add $t2, $sp, 104
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # +int i _t21 i
       add $t0, $sp, 48
       add $t1, $sp, 108
       add $t2, $sp, 48
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # store_int 0  _t23
       li $t0, 0
       add $t1, $sp, 116
       sw $t0, 0($t1)
       
       # arr_element arr[i] i 4
       lw $t0, 116($sp)
       lw $t1, 48($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 116($sp)
       
       # = arr[i]  temp
       add $t0, $sp, 0
       lw $t1, ($t0)
       lw $t0, 116($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       add $t2, $sp, 28
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t26
       li $t0, 0
       add $t1, $sp, 128
       sw $t0, 0($t1)
       
       # arr_element arr[i] i 4
       lw $t0, 128($sp)
       lw $t1, 48($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 128($sp)
       
       # store_int 0  _t28
       li $t0, 0
       add $t1, $sp, 136
       sw $t0, 0($t1)
       
       # arr_element arr[j] j 4
       lw $t0, 136($sp)
       lw $t1, 52($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 136($sp)
       
       # = arr[j]  arr[i]
       add $t0, $sp, 0
       lw $t1, ($t0)
       lw $t0, 136($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       add $t2, $sp, 0
       lw $t3, ($t2)
       lw $t2, 128($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t31
       li $t0, 0
       add $t1, $sp, 148
       sw $t0, 0($t1)
       
       # arr_element arr[j] j 4
       lw $t0, 148($sp)
       lw $t1, 52($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 148($sp)
       
       # = temp  arr[j]
       add $t0, $sp, 28
       add $t2, $sp, 0
       lw $t3, ($t2)
       lw $t2, 148($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   13
       j Label13
       Label37 :
       
       # store_int 0  _t34
       li $t0, 0
       add $t1, $sp, 88
       sw $t0, 0($t1)
       
       # store_int 1  _t35
       li $t0, 1
       add $t1, $sp, 92
       sw $t0, 0($t1)
       
       # +int i _t35 _t36
       add $t0, $sp, 48
       add $t1, $sp, 92
       add $t2, $sp, 96
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # arr_element arr[_t36] _t36 4
       lw $t0, 88($sp)
       lw $t1, 96($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 88($sp)
       
       # = arr[_t36]  temp
       add $t0, $sp, 0
       lw $t1, ($t0)
       lw $t0, 88($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       add $t2, $sp, 28
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t39
       li $t0, 0
       add $t1, $sp, 108
       sw $t0, 0($t1)
       
       # store_int 1  _t40
       li $t0, 1
       add $t1, $sp, 112
       sw $t0, 0($t1)
       
       # +int i _t40 _t41
       add $t0, $sp, 48
       add $t1, $sp, 112
       add $t2, $sp, 116
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # arr_element arr[_t41] _t41 4
       lw $t0, 108($sp)
       lw $t1, 116($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 108($sp)
       
       # store_int 0  _t43
       li $t0, 0
       add $t1, $sp, 124
       sw $t0, 0($t1)
       
       # arr_element arr[high] high 4
       lw $t0, 124($sp)
       lw $t1, 8($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 124($sp)
       
       # = arr[high]  arr[_t41]
       add $t0, $sp, 0
       lw $t1, ($t0)
       lw $t0, 124($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       add $t2, $sp, 0
       lw $t3, ($t2)
       lw $t2, 108($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t46
       li $t0, 0
       add $t1, $sp, 136
       sw $t0, 0($t1)
       
       # arr_element arr[high] high 4
       lw $t0, 136($sp)
       lw $t1, 8($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 136($sp)
       
       # = temp  arr[high]
       add $t0, $sp, 28
       add $t2, $sp, 0
       lw $t3, ($t2)
       lw $t2, 136($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 1  _t49
       li $t0, 1
       add $t1, $sp, 148
       sw $t0, 0($t1)
       
       # +int i _t49 _t50
       add $t0, $sp, 48
       add $t1, $sp, 148
       add $t2, $sp, 152
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # FUNC_END _t50  
       add $t2, $sp, 152
       lw $v0, 0($t2)
       add $sp, $sp, 236
       b func_end
       
       # FUNC_START quickSort  


printArray:

       li $t1, 80
       add $t1, $t1, 60
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
       
       # store_int 0  _t77
       li $t0, 0
       add $t1, $sp, 12
       sw $t0, 0($t1)
       
       # = _t77  i
       add $t0, $sp, 12
       add $t2, $sp, 8
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       Label83 :
       
       # < i size _t79
       add $t0, $sp, 8
       add $t1, $sp, 4
       add $t2, $sp, 20
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       slt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t79  90
       add $t0, $sp, 20
       lw $t1 0($t0)
       bnez $t1, Label90
       
       # goto   95
       j Label95
       Label86 :
       
       # store_int 1  _t82
       li $t0, 1
       add $t1, $sp, 32
       sw $t0, 0($t1)
       
       # = i  _t81
       add $t0, $sp, 8
       add $t2, $sp, 28
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # +int i _t82 i
       add $t0, $sp, 8
       add $t1, $sp, 32
       add $t2, $sp, 8
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # goto   83
       j Label83
       Label90 :
       
       # store_int 0  _t84
       li $t0, 0
       add $t1, $sp, 40
       sw $t0, 0($t1)
       
       # arr_element arr[i] i 4
       lw $t0, 40($sp)
       lw $t1, 8($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 40($sp)
       
       # param arr[i]  
       
       # CALL_FUNC printf  _t87
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 0
       lw $t1, ($t0)
       lw $t0, 40($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 52
       sw $v0, 0($t2)
       
       # goto   86
       j Label86
       Label95 :
       
       # FUNC_END   
       li $v0, 0
       add $sp, $sp, 60
       b func_end
       
       # FUNC_START main  


printf:

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


quickSort:

       li $t1, 80
       add $t1, $t1, 112
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
       
       # < low high _t53
       add $t0, $sp, 4
       add $t1, $sp, 8
       add $t2, $sp, 12
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       slt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t53  59
       add $t0, $sp, 12
       lw $t1 0($t0)
       bnez $t1, Label59
       
       # goto   79
       j Label79
       Label59 :
       
       # store_int 0  _t55
       li $t0, 0
       add $t1, $sp, 20
       sw $t0, 0($t1)
       
       # param arr  
       
       # param low  
       
       # param high  
       
       # CALL_FUNC partition  _t59
       li $t1, 80
       add $t1, $t1, 236
       sub $s0, $sp, $t1
       li $t0, 0
       add $t0, $sp, $t0
       sw $t0, 0($s0)
       add $t0, $sp, 4
       lw $t1, 0($t0)
       sw $t1, 4($s0)
       add $t0, $sp, 8
       lw $t1, 0($t0)
       sw $t1, 8($s0)
       move $sp, $s0
       jal partition
       add $t2, $sp, 36
       sw $v0, 0($t2)
       
       # = _t59  pi
       add $t0, $sp, 36
       add $t2, $sp, 44
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t61
       li $t0, 0
       add $t1, $sp, 48
       sw $t0, 0($t1)
       
       # param arr  
       
       # param low  
       
       # store_int 1  _t64
       li $t0, 1
       add $t1, $sp, 60
       sw $t0, 0($t1)
       
       # -int pi _t64 _t65
       add $t0, $sp, 44
       add $t1, $sp, 60
       add $t2, $sp, 64
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       neg $t6, $t4
       add $t5, $t3, $t6
       sw $t5, 0($t2)
       
       # param _t65  
       
       # CALL_FUNC quickSort  _t67
       li $t1, 80
       add $t1, $t1, 112
       sub $s0, $sp, $t1
       li $t0, 0
       add $t0, $sp, $t0
       sw $t0, 0($s0)
       add $t0, $sp, 4
       lw $t1, 0($t0)
       sw $t1, 4($s0)
       add $t0, $sp, 64
       lw $t1, 0($t0)
       sw $t1, 8($s0)
       move $sp, $s0
       jal quickSort
       add $t2, $sp, 72
       sw $v0, 0($t2)
       
       # store_int 0  _t69
       li $t0, 0
       add $t1, $sp, 80
       sw $t0, 0($t1)
       
       # param arr  
       
       # store_int 1  _t71
       li $t0, 1
       add $t1, $sp, 88
       sw $t0, 0($t1)
       
       # +int pi _t71 _t72
       add $t0, $sp, 44
       add $t1, $sp, 88
       add $t2, $sp, 92
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # param _t72  
       
       # param high  
       
       # CALL_FUNC quickSort  _t75
       li $t1, 80
       add $t1, $t1, 112
       sub $s0, $sp, $t1
       li $t0, 0
       add $t0, $sp, $t0
       sw $t0, 0($s0)
       add $t0, $sp, 92
       lw $t1, 0($t0)
       sw $t1, 4($s0)
       add $t0, $sp, 8
       lw $t1, 0($t0)
       sw $t1, 8($s0)
       move $sp, $s0
       jal quickSort
       add $t2, $sp, 104
       sw $v0, 0($t2)
       Label79 :
       
       # FUNC_END   
       li $v0, 0
       add $sp, $sp, 112
       b func_end
       
       # FUNC_START printArray  


