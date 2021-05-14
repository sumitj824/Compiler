# Compiler Project

Source Language: C \
Implementation Language : C++   \
Target Language : MIPS 


## Final part: Compiler
In this we have constructed a compiler of source language to output mips assembly


### Steps to Build and Run 

```
$ make
$ ./bin/compiler -i ./tests/test1.c
$ dot -Tpng ast.dot -o ast.png

```

### To get help

```
$ make
$ ./bin/compiler -help

```

### Steps to clean
```
$ make clean

```




### Directory Structure
```
.
├── makefile
├── presentation.pdf
├── README.md
├── src
│   ├── 3ac.cpp
│   ├── 3ac.h
│   ├── codegeneration.cpp
│   ├── codegeneration.h
│   ├── generation_aid.cpp
│   ├── generation_aid.h
│   ├── lex.l
│   ├── node.cpp
│   ├── node.h
│   ├── symtable.cpp
│   ├── symtable.h
│   ├── type.cpp
│   ├── type.h
│   └── yacc.y
└── tests
    ├── 10_bubbleSort.c
    ├── 11_matrix_multiplication.c
    ├── 14_adjacency_matrix.c
    ├── 15_union_in_func.c
    ├── 16_struct_in_func.c
    ├── 17_func_with_many_param.c
    ├── 18_large_expression.c
    ├── 1_unary_and_binary_Minus.c
    ├── 20_newton_raphson_floating_point.c
    ├── 21_tertiary_operator.c
    ├── 22_float.c
    ├── 23_ptr_op.c
    ├── 25_typecasting.c
    ├── 26_fenwick_tree.c
    ├── 27_INC_OP.c
    ├── 28_global_and_local_intializn.c
    ├── 2_operator.c
    ├── 3_fibonacci.c
    ├── 4_short_circuit_evaluation.c
    ├── 5_nested_if.c
    ├── 6_ackermann.c
    ├── 7_quicksort.c
    ├── 8_binary_search.c
    ├── 9_mergeSort.c
    ├── test10.c
    ├── test1.c
    ├── test22.c
    ├── test4.c
    ├── test8.c
    └── test9.c



```

##


