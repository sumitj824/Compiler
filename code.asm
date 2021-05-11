main:

       
       # store_int 5  _t1
       li $t0, 5
       add $t1, $sp, 0
       sw $t0, 0($t1)
       li $t0, 5
       add $t1, $sp, 0
       sw $t0, 0($t1)
       
       # store_int 1  _t3
       li $t0, 1
       add $t1, $sp, 8
       sw $t0, 0($t1)
       li $t0, 1
       add $t1, $sp, 8
       sw $t0, 0($t1)
       
       # store_int 2  _t5
       li $t0, 2
       add $t1, $sp, 16
       sw $t0, 0($t1)
       li $t0, 2
       add $t1, $sp, 16
       sw $t0, 0($t1)
       
       # store_int 3  _t7
       li $t0, 3
       add $t1, $sp, 24
       sw $t0, 0($t1)
       li $t0, 3
       add $t1, $sp, 24
       sw $t0, 0($t1)
       
       # store_int 4  _t9
       li $t0, 4
       add $t1, $sp, 32
       sw $t0, 0($t1)
       li $t0, 4
       add $t1, $sp, 32
       sw $t0, 0($t1)
       
       # store_int 5  _t11
       li $t0, 5
       add $t1, $sp, 40
       sw $t0, 0($t1)
       li $t0, 5
       add $t1, $sp, 40
       sw $t0, 0($t1)
       
       # =   a
       la $t0, 
       la $t2, a
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t13
       li $t0, 0
       add $t1, $sp, 68
       sw $t0, 0($t1)
       li $t0, 0
       add $t1, $sp, 68
       sw $t0, 0($t1)
       
       # store_int 4  _t14
       li $t0, 4
       add $t1, $sp, 72
       sw $t0, 0($t1)
       li $t0, 4
       add $t1, $sp, 72
       sw $t0, 0($t1)
       
       # arr_element a[_t14] _t14 4
       lw $t0, 68($sp)
       lw $t1, 72($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 68($sp)
       
       # store_int 0  _t16
       li $t0, 0
       add $t1, $sp, 80
       sw $t0, 0($t1)
       li $t0, 0
       add $t1, $sp, 80
       sw $t0, 0($t1)
       
       # store_int 2  _t17
       li $t0, 2
       add $t1, $sp, 84
       sw $t0, 0($t1)
       li $t0, 2
       add $t1, $sp, 84
       sw $t0, 0($t1)
       
       # arr_element a[_t17] _t17 4
       lw $t0, 80($sp)
       lw $t1, 84($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 80($sp)
       
       # store_int 0  _t19
       li $t0, 0
       add $t1, $sp, 92
       sw $t0, 0($t1)
       li $t0, 0
       add $t1, $sp, 92
       sw $t0, 0($t1)
       
       # store_int 3  _t20
       li $t0, 3
       add $t1, $sp, 96
       sw $t0, 0($t1)
       li $t0, 3
       add $t1, $sp, 96
       sw $t0, 0($t1)
       
       # arr_element a[_t20] _t20 4
       lw $t0, 92($sp)
       lw $t1, 96($sp)
       li $t2, 4
       mul $t3, $t1 , $t2
       add $t0, $t3, $t0
       sw $t0, 92($sp)
       
       # +int a[_t17] a[_t20] _t22
       la $t2, _t22
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       la $t2, _t22
       lw $t3, 0($t0)
       lw $t4, 0($t1)
       add $t5, $t3, $t4
       sw $t5, 0($t2)
       
       # = _t22  a[_t14]
       la $t0, _t22
       lw $t3, 0($t0)
       sw $t3, 0($t2)
       
       # store_int 0  _t24
       li $t0, 0
       add $t1, $sp, 112
       sw $t0, 0($t1)
       li $t0, 0
       add $t1, $sp, 112
       sw $t0, 0($t1)
       
       # FUNC_END _t24  
       li $a0, 0
       li $v0, 10
       syscall


