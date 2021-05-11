f:

       li $t0, 0
       add $t1, $sp, 8
       sw $t0, 0($t1)
       li $t0, 0
       add $t1, $sp, 8
       sw $t0, 0($t1)
       li $t0, 2
       add $t1, $sp, 12
       sw $t0, 0($t1)
       li $t0, 2
       add $t1, $sp, 12
       sw $t0, 0($t1)
       lw $t0, 8($sp)
       lw $t1, 12($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 8($sp)
       li $t0, 1
       add $t1, $sp, 20
       sw $t0, 0($t1)
       li $t0, 1
       add $t1, $sp, 20
       sw $t0, 0($t1)
       add $t0, $sp, 20
       add $t2, $sp, 0
       lw $t3, 8($sp)
       add $t3, $t3, $t2
       move $t2, $t3
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       li $v0, 0
       b func_end
       add $sp, $sp, 28


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
       add $sp, $sp, 80
       jal $ra


main:

       li $t0, 5
       add $t1, $sp, 0
       sw $t0, 0($t1)
       li $t0, 5
       add $t1, $sp, 0
       sw $t0, 0($t1)
       li $t0, 0
       add $t1, $sp, 32
       sw $t0, 0($t1)
       li $t0, 0
       add $t1, $sp, 32
       sw $t0, 0($t1)
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
       move $s0, $sp
       li $t1, 80
       add $t1, $t1, 28
       sub $sp, $sp, $t1
       li $t0, 8
       add $t0, $s0, $t0
       sw $t0, 0($sp)
       jal f
       li $t0, 0
       add $t1, $sp, 44
       sw $t0, 0($t1)
       li $t0, 0
       add $t1, $sp, 44
       sw $t0, 0($t1)
       li $t0, 2
       add $t1, $sp, 48
       sw $t0, 0($t1)
       li $t0, 2
       add $t1, $sp, 48
       sw $t0, 0($t1)
       lw $t0, 44($sp)
       lw $t1, 48($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 44($sp)
       add $t0, $sp, 8
       move $t1, $t0
       add $t1, $t1, 44
       move $t0, $t1
       add $t2, $sp, 28
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       li $t0, 0
       add $t1, $sp, 60
       sw $t0, 0($t1)
       li $t0, 0
       add $t1, $sp, 60
       sw $t0, 0($t1)
       li $a0, 0
       li $v0, 10
       syscall


