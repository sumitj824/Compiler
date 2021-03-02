SRC= ./src
BIN= ./bin

all: $(SRC)/compile
	
	
$(SRC)/compile:
	   @mkdir -p $(BIN)
	   cp 	$(SRC)/node.h $(BIN)/
	   yacc -dvt $(SRC)/yacc.y -o $(BIN)/y.tab.c
	   lex -o $(BIN)/lex.yy.c  $(SRC)/lex.l
	   gcc -o $(BIN)/parser $(BIN)/lex.yy.c $(BIN)/y.tab.c $(SRC)/node.c -lfl -w

clean: 
		rm -rf $(BIN)