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


### To get help

```
$ make
$ ./bin/lexer -help

```

### Steps to clean
```
$ make clean

```




### Directory Structure
```
├── makefile
├── README.md
├── src
│   ├── lex.l
│   └── y.tab.h
└── tests
    ├── test1.c
    ├── test2.c
    ├── test3.c
    ├── test4.c
    └── test5.c



```

##


