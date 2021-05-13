binarySearch : 

       li $t1, 80
       add $t1, $t1, 180
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
       
       # >= r l _t1
       add $t0, $sp, 8
       add $t1, $sp, 4
       add $t2, $sp, 16
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       sge $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t1  4
       add $t0, $sp, 16
       lw $t1 0($t0)
       bnez $t1, Label4
       
       # goto   38
       j Label38
       Label4 :
       
       # -int r l _t3
       add $t0, $sp, 8
       add $t1, $sp, 4
       add $t2, $sp, 24
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       neg $t6, $t4
       add $t5, $t3, $t6
       sw $t5, 0($t2)
       
       # store_int 2  _t5
       li $t0, 2
       add $t1, $sp, 32
       sw $t0, 0($t1)
       
       # /int _t3 _t5 _t6
       add $t0, $sp, 24
       add $t1, $sp, 32
       add $t2, $sp, 36
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       div $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # +int l _t6 _t7
       add $t0, $sp, 4
       add $t1, $sp, 36
       add $t2, $sp, 40
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # = _t7  mid
       add $t0, $sp, 40
       add $t2, $sp, 48
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t9
       li $t0, 0
       add $t1, $sp, 52
       sw $t0, 0($t1)
       
       # arr_element arr[mid] mid 4
       lw $t0, 52($sp)
       lw $t1, 48($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 52($sp)
       
       # == arr[mid] x _t12
       add $t0, $sp, 0
       lw $t1, 0($t0)
       lw $t0, 52($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       add $t1, $sp, 12
       add $t2, $sp, 64
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       seq $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t12  14
       add $t0, $sp, 64
       lw $t1 0($t0)
       bnez $t1, Label14
       
       # goto   15
       j Label15
       Label14 :
       
       # RETURN mid  
       add $t2, $sp, 48
       lw $v0, 0($t2)
       add $sp, $sp, 180
       b func_end
       Label15 :
       
       # store_int 0  _t15
       li $t0, 0
       add $t1, $sp, 76
       sw $t0, 0($t1)
       
       # arr_element arr[mid] mid 4
       lw $t0, 76($sp)
       lw $t1, 48($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 76($sp)
       
       # > arr[mid] x _t17
       add $t0, $sp, 0
       lw $t1, 0($t0)
       lw $t0, 76($sp)
       add $t1, $t1, $t0
       move $t0, $t1
       add $t1, $sp, 12
       add $t2, $sp, 84
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       sgt $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # if_goto _t17  20
       add $t0, $sp, 84
       lw $t1 0($t0)
       bnez $t1, Label20
       
       # goto   29
       j Label29
       Label20 :
       
       # store_int 0  _t19
       li $t0, 0
       add $t1, $sp, 92
       sw $t0, 0($t1)
       
       # param arr  
       
       # param l  
       
       # store_int 1  _t22
       li $t0, 1
       add $t1, $sp, 104
       sw $t0, 0($t1)
       
       # -int mid _t22 _t23
       add $t0, $sp, 48
       add $t1, $sp, 104
       add $t2, $sp, 108
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       neg $t6, $t4
       add $t5, $t3, $t6
       sw $t5, 0($t2)
       
       # param _t23  
       
       # param x  
       
       # CALL_FUNC binarySearch  _t26
       li $t1, 80
       add $t1, $t1, 180
       sub $s0, $sp, $t1
       li $t0, 0
       add $t0, $sp, $t0
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       add $t0, $sp, 4
       lw $t1, 0($t0)
       sw $t1, 8($s0)
       add $t0, $sp, 108
       lw $t1, 0($t0)
       sw $t1, 12($s0)
       add $t0, $sp, 12
       lw $t1, 0($t0)
       sw $t1, 16($s0)
       move $sp, $s0
       jal binarySearch
       add $t2, $sp, 120
       sw $v0, 0($t2)
       
       # RETURN _t26  
       add $t2, $sp, 120
       lw $v0, 0($t2)
       add $sp, $sp, 180
       b func_end
       Label29 :
       
       # store_int 0  _t28
       li $t0, 0
       add $t1, $sp, 128
       sw $t0, 0($t1)
       
       # param arr  
       
       # store_int 1  _t30
       li $t0, 1
       add $t1, $sp, 136
       sw $t0, 0($t1)
       
       # +int mid _t30 _t31
       add $t0, $sp, 48
       add $t1, $sp, 136
       add $t2, $sp, 140
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # param _t31  
       
       # param r  
       
       # param x  
       
       # CALL_FUNC binarySearch  _t35
       li $t1, 80
       add $t1, $t1, 180
       sub $s0, $sp, $t1
       li $t0, 0
       add $t0, $sp, $t0
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       add $t0, $sp, 140
       lw $t1, 0($t0)
       sw $t1, 8($s0)
       add $t0, $sp, 8
       lw $t1, 0($t0)
       sw $t1, 12($s0)
       add $t0, $sp, 12
       lw $t1, 0($t0)
       sw $t1, 16($s0)
       move $sp, $s0
       jal binarySearch
       add $t2, $sp, 156
       sw $v0, 0($t2)
       
       # RETURN _t35  
       add $t2, $sp, 156
       lw $v0, 0($t2)
       add $sp, $sp, 180
       b func_end
       Label38 :
       
       # store_int 1  _t37
       li $t0, 1
       add $t1, $sp, 24
       sw $t0, 0($t1)
       
       # unary- _t37  _t38
       add $t0, $sp, 24
       add $t2, $sp, 28
       lw $t3, 0($t0)
       neg $t4, $t3
       sw $t4, 0($t2)
       
       # RETURN _t38  
       add $t2, $sp, 28
       lw $v0, 0($t2)
       add $sp, $sp, 180
       b func_end
       
       # FUNC_END binarySearch  
       add $sp, $sp, 180
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


main : 

       li $t1, 80
       add $t1, $t1, 152
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
       
       # store_int 1  _t40
       li $t0, 1
       add $t1, $sp, 0
       sw $t0, 0($t1)
       
       # initializer_list _t40  
       
       # store_int 5  _t42
       li $t0, 5
       add $t1, $sp, 8
       sw $t0, 0($t1)
       
       # initializer_list _t42  
       
       # store_int 10  _t44
       li $t0, 10
       add $t1, $sp, 16
       sw $t0, 0($t1)
       
       # initializer_list _t44  
       
       # store_int 15  _t46
       li $t0, 15
       add $t1, $sp, 24
       sw $t0, 0($t1)
       
       # initializer_list _t46  
       
       # store_int 16  _t48
       li $t0, 16
       add $t1, $sp, 32
       sw $t0, 0($t1)
       
       # initializer_list _t48  
       
       # array_initialized arr  
       add $t0, $sp, 0
       add $t2, $sp, 40
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       add $t0, $sp, 8
       add $t2, $sp, 40
       lw $t3, 0($t0)
       sw $t3, 4($t2)
       add $t0, $sp, 16
       add $t2, $sp, 40
       lw $t3, 0($t0)
       sw $t3, 8($t2)
       add $t0, $sp, 24
       add $t2, $sp, 40
       lw $t3, 0($t0)
       sw $t3, 12($t2)
       add $t0, $sp, 32
       add $t2, $sp, 40
       lw $t3, 0($t0)
       sw $t3, 16($t2)
       
       # store_int 5  _t50
       li $t0, 5
       add $t1, $sp, 60
       sw $t0, 0($t1)
       
       # = _t50  n
       add $t0, $sp, 60
       add $t2, $sp, 68
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 10  _t52
       li $t0, 10
       add $t1, $sp, 72
       sw $t0, 0($t1)
       
       # = _t52  x
       add $t0, $sp, 72
       add $t2, $sp, 80
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t54
       li $t0, 0
       add $t1, $sp, 88
       sw $t0, 0($t1)
       
       # param arr  
       
       # store_int 0  _t56
       li $t0, 0
       add $t1, $sp, 96
       sw $t0, 0($t1)
       
       # param _t56  
       
       # store_int 1  _t58
       li $t0, 1
       add $t1, $sp, 104
       sw $t0, 0($t1)
       
       # -int n _t58 _t59
       add $t0, $sp, 68
       add $t1, $sp, 104
       add $t2, $sp, 108
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       neg $t6, $t4
       add $t5, $t3, $t6
       sw $t5, 0($t2)
       
       # param _t59  
       
       # param x  
       
       # CALL_FUNC binarySearch  _t62
       li $t1, 80
       add $t1, $t1, 180
       sub $s0, $sp, $t1
       add $t1, $sp, 40
       sw $t1, 0($s0)
       add $t0, $sp, 96
       lw $t1, 0($t0)
       sw $t1, 4($s0)
       add $t0, $sp, 108
       lw $t1, 0($t0)
       sw $t1, 8($s0)
       add $t0, $sp, 80
       lw $t1, 0($t0)
       sw $t1, 12($s0)
       move $sp, $s0
       jal binarySearch
       add $t2, $sp, 120
       sw $v0, 0($t2)
       
       # = _t62  index
       add $t0, $sp, 120
       add $t2, $sp, 84
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # param index  
       
       # CALL_FUNC printf  _t65
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 84
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 132
       sw $v0, 0($t2)
       
       # store_int 0  _t67
       li $t0, 0
       add $t1, $sp, 140
       sw $t0, 0($t1)
       
       # RETURN _t67  
       li $a0, 0
       li $v0, 10
       syscall
       
       # FUNC_END main  
       add $sp, $sp, 152
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


