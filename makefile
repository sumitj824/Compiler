SRC= ./src
BIN= ./bin

all: $(SRC)/compile
	
	
$(SRC)/compile:
	   @mkdir -p $(BIN)
	   yacc -dvt $(SRC)/yacc.y -o $(BIN)/y.tab.c
	   lex  -o $(BIN)/lex.yy.c $(SRC)/lex.l
	   g++  -w -c $(SRC)/node.cpp -o $(BIN)/node.o -I$(SRC)
	   g++ $(BIN)/lex.yy.c $(BIN)/y.tab.c $(BIN)/node.o -I$(SRC) -lfl -w  -o $(BIN)/parser


clean: 
		rm -rf $(BIN)
		rm -f *.dot *.png