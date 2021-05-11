.text
main:

       
       # store_int 1  _t1
       li $t0, 1
       add $t1, $sp, 0
       sw $t0, 0($t1)
       
       # = _t1  a
       add $t0, $sp, 0
       add $t2, $sp, 8
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 2  _t3
       li $t0, 2
       add $t1, $sp, 12
       sw $t0, 0($t1)
       
       # = _t3  b
       add $t0, $sp, 12
       add $t2, $sp, 20
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 1  _t6
       li $t0, 1
       add $t1, $sp, 28
       sw $t0, 0($t1)
       
       # = a  _t5
       add $t0, $sp, 8
       add $t2, $sp, 24
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # +int a _t6 a
       add $t0, $sp, 8
       add $t1, $sp, 28
       add $t2, $sp, 8
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       add $t0, $sp, 8
       add $t1, $sp, 28
       add $t2, $sp, 8
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # = _t5  b
       add $t0, $sp, 24
       add $t2, $sp, 20
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t8
       li $t0, 0
       add $t1, $sp, 36
       sw $t0, 0($t1)
       
       # FUNC_END _t8  
       li $a0, 0
       li $v0, 10
       syscall


