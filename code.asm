func1:

       li $t1, 80
       add $t1, $t1, 24
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
       
       # store_int 1  _t1
       li $t0, 1
       add $t1, $sp, 0
       sw $t0, 0($t1)
       
       # param _t1  
       
       # CALL_FUNC printf  _t3
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 0
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 8
       sw $v0, 0($t2)
       
       # store_int 1  _t5
       li $t0, 1
       add $t1, $sp, 16
       sw $t0, 0($t1)
       
       # FUNC_END _t5  
       add $t2, $sp, 16
       lw $v0, 0($t2)
       add $sp, $sp, 24
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
       add $t1, $t1, 44
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
       
       # store_int 0  _t7
       li $t0, 0
       add $t1, $sp, 0
       sw $t0, 0($t1)
       
       # = _t7  a
       add $t0, $sp, 0
       add $t2, $sp, 8
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # if_goto a  11
       add $t0, $sp, 8
       lw $t1 0($t0)
       bnez $t1, Label11
       
       # goto   17
       j Label17
       Label11 :
       
       # CALL_FUNC func1  _t9
       li $t1, 80
       add $t1, $t1, 24
       sub $s0, $sp, $t1
       move $sp, $s0
       jal func1
       add $t2, $sp, 12
       sw $v0, 0($t2)
       
       # if_goto _t9  14
       add $t0, $sp, 12
       lw $t1 0($t0)
       bnez $t1, Label14
       
       # goto   17
       j Label17
       Label14 :
       
       # store_int 1  _t11
       li $t0, 1
       add $t1, $sp, 20
       sw $t0, 0($t1)
       
       # = _t11  _t10
       add $t0, $sp, 20
       add $t2, $sp, 16
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   20
       j Label20
       Label17 :
       
       # store_int 0  _t11
       li $t0, 0
       add $t1, $sp, 20
       sw $t0, 0($t1)
       
       # = _t11  _t10
       add $t0, $sp, 20
       add $t2, $sp, 16
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # goto   20
       j Label20
       Label20 :
       
       # param a  
       
       # CALL_FUNC printf  _t13
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 8
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 28
       sw $v0, 0($t2)
       
       # store_int 0  _t15
       li $t0, 0
       add $t1, $sp, 36
       sw $t0, 0($t1)
       
       # FUNC_END _t15  
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


