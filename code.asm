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
       add $t1, $t1, 56
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
       
       # store_float 4.500000  _t1
       li.s $f0, 4.500000
       add $t1, $sp, 0
       swc1 $f0, 0($t1)
       
       # = _t1  x
       add $t0, $sp, 0
       add $t2, $sp, 8
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 1  _t3
       li $t0, 1
       add $t1, $sp, 16
       sw $t0, 0($t1)
       
       # inttoreal _t3  _t5
       add $t0, $sp, 16
       add $t2, $sp, 24
       lw $t3, 0($t0)
       mtc1 $t3, $f0 
       swc1 $f0, 0($t2)
       
       # +float _t5 x _t4
       add $t0, $sp, 24
       add $t1, $sp, 8
       add $t2, $sp, 20
       lwc1.s $f0, 0($t0)
       lwc1.s $f1, 0($t1)
       add.s $f2, $f0, $f1
       swc1.s $f2. 0($t2)
       
       # = _t4  y
       add $t0, $sp, 20
       add $t2, $sp, 12
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # param y  
       
       # CALL_FUNC printf  _t8
       li $t1, 80
       add $t1, $t1, 20
       sub $s0, $sp, $t1
       add $t0, $sp, 12
       lw $t1, 0($t0)
       sw $t1, 0($s0)
       move $sp, $s0
       jal printf
       add $t2, $sp, 36
       sw $v0, 0($t2)
       
       # store_int 0  _t10
       li $t0, 0
       add $t1, $sp, 44
       sw $t0, 0($t1)
       
       # RETURN _t10  
       li $a0, 0
       li $v0, 10
       syscall
       
       # FUNC_END main  
       add $sp, $sp, 56
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


