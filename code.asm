func1:

       li $t1, 80
       add $t1, $t1, 28
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
       
       # = v.x  p.a
       add $t0, $sp, 36
       add $t2, $sp, 0
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # = v.z  p.c
       add $t0, $sp, 36
       add $t2, $sp, 4
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # FUNC_END p  
       add $t2, $sp, 0
       lw $v0, 0($t2)
       add $sp, $sp, 28
       b func_end


func2:

       li $t1, 80
       add $t1, $t1, 32
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
       
       # = p.a  v.x
       add $t0, $sp, 0
       add $t2, $sp, 36
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # = p.b  v.y
       add $t0, $sp, 8
       add $t2, $sp, 24
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # = p.c  v.z
       add $t0, $sp, 4
       add $t2, $sp, 36
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # FUNC_END v  
       add $t2, $sp, 12
       lw $v0, 0($t2)
       add $sp, $sp, 32
       b func_end


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
       
       # store_int 1  _t8
       li $t0, 1
       add $t1, $sp, 16
       sw $t0, 0($t1)
       
       # = _t8  p.a
       add $t0, $sp, 16
       add $t2, $sp, 0
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 2  _t10
       li $t0, 2
       add $t1, $sp, 24
       sw $t0, 0($t1)
       
       # = _t10  p.b
       add $t0, $sp, 24
       add $t2, $sp, 8
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 99  _t12
       li $t0, 99
       add $t1, $sp, 32
       sw $t0, 0($t1)
       
       # = _t12  p.c
       add $t0, $sp, 32
       add $t2, $sp, 4
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 10  _t14
       li $t0, 10
       add $t1, $sp, 40
       sw $t0, 0($t1)
       
       # = _t14  v.x
       add $t0, $sp, 40
       add $t2, $sp, 36
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 20  _t16
       li $t0, 20
       add $t1, $sp, 48
       sw $t0, 0($t1)
       
       # = _t16  v.y
       add $t0, $sp, 48
       add $t2, $sp, 24
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 67  _t18
       li $t0, 67
       add $t1, $sp, 56
       sw $t0, 0($t1)
       
       # = _t18  v.z
       add $t0, $sp, 56
       add $t2, $sp, 36
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # param p  
       
       # param v  
       
       # CALL_FUNC func1  _t22
       li $t1, 80
       add $t1, $t1, 28
       sub $s0, $sp, $t1
       add $t0, $sp, 0
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       add $t0, $sp, 12
       lw $t1, 0($t0)
       sw $t1, 12($s0)
       move $sp, $s0
       jal func1
       add $t2, $sp, 72
       sw $v0, 0($t2)
       
       # param p  
       
       # param v  
       
       # CALL_FUNC func2  _t26
       li $t1, 80
       add $t1, $t1, 32
       sub $s0, $sp, $t1
       add $t0, $sp, 0
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       add $t0, $sp, 12
       lw $t1, 0($t0)
       sw $t1, 12($s0)
       move $sp, $s0
       jal func2
       add $t2, $sp, 96
       sw $v0, 0($t2)
       
       # store_int 0  _t28
       li $t0, 0
       add $t1, $sp, 104
       sw $t0, 0($t1)
       
       # FUNC_END _t28  
       li $a0, 0
       li $v0, 10
       syscall


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


