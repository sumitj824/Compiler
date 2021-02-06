SRC= ../src
BIN= ../bin
TEST = ../test

all: $(SRC)/compile
	


$(SRC)/compile:
	   @mkdir -p $(BIN)
	   cp $(SRC)/y.tab.h  $(BIN)/y.tab.h
	   lex -o $(BIN)/lex.yy.c  ./lex.l
	   gcc -o $(BIN)/lexer $(BIN)/lex.yy.c -lfl -w


clean: 
		rm -rf $(BIN)