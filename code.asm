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
       add $t1, $t1, 124
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
       
       # unary& a  _t2
       add $t0, $sp, 0
       add $t2, $sp, 12
       sw $t0, 0($t2)
       
       # = a  b
       add $t0, $sp, 12
       add $t2, $sp, 20
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 5  _t4
       li $t0, 5
       add $t1, $sp, 24
       sw $t0, 0($t1)
       
       # = _t4  a.a
       add $t0, $sp, 24
       add $t2, $sp, 0
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 3  _t6
       li $t0, 3
       add $t1, $sp, 32
       sw $t0, 0($t1)
       
       # = _t6  a.b
       add $t0, $sp, 32
       add $t2, $sp, 4
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t8
       li $t0, 0
       add $t1, $sp, 40
       sw $t0, 0($t1)
       
       # unary& a  _t10
       add $t0, $sp, 0
       add $t2, $sp, 48
       sw $t0, 0($t2)
       
       # = a  b
       add $t0, $sp, 48
       add $t2, $sp, 20
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 7  _t12
       li $t0, 7
       add $t1, $sp, 56
       sw $t0, 0($t1)
       
       # = _t12  a.a
       add $t0, $sp, 56
       add $t2, $sp, 0
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 9  _t14
       li $t0, 9
       add $t1, $sp, 64
       sw $t0, 0($t1)
       
       # = _t14  a.b
       add $t0, $sp, 64
       add $t2, $sp, 4
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t16
       li $t0, 0
       add $t1, $sp, 72
       sw $t0, 0($t1)
       
       # param b->a  
       
       # CALL_FUNC printf  _t19
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 20
       lw $t1, 0($t0)
       add $t0, $t1, 76
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 84
       sw $v0, 0($t2)
       
       # store_int 0  _t21
       li $t0, 0
       add $t1, $sp, 92
       sw $t0, 0($t1)
       
       # param b->b  
       
       # CALL_FUNC printf  _t24
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 20
       lw $t1, 0($t0)
       add $t0, $t1, 96
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 104
       sw $v0, 0($t2)
       
       # store_int 0  _t26
       li $t0, 0
       add $t1, $sp, 112
       sw $t0, 0($t1)
       
       # RETURN _t26  
       li $a0, 0
       li $v0, 10
       syscall
       
       # FUNC_END main  
       add $sp, $sp, 124
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


