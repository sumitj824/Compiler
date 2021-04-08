# Compiler Project

Source Language: C \
Implementation Language : C++   \
Target Language : Not-decided (we will decide it)

## Part 1 : Scanner
In this we have constructed a scanner of source language to output tokens in a tabular form


### Steps to Build and Run 

```
$ make
$ ./bin/lexer -i ./tests/test1.c

```
OR

```
$ make
$ ./bin/lexer -i ./tests/test1.c -o output.txt 

```


## Part 3 : Semantics
In this we have constructed a Parser of source language to output Abstract Syntax Tree


### Steps to Build and Run 

```
$ make
$ ./bin/parser -i ./tests/test1.c -o ast.dot
$ dot -Tpng ast.dot -o ast.png

```

### To get help

```
$ make
$ ./bin/parser -help

```

### Steps to clean
```
$ make clean

```




### Directory Structure
```
.
├── makefile
├── README.md
├── src
│   ├── lex.l
│   ├── node.cpp
│   ├── node.h
│   └── yacc.y
└── tests
    ├── test1.c
    ├── test2.c
    ├── test3.c
    ├── test4.c
    ├── test5.c
    ├── test6.c
    └── test7.c



```

##


