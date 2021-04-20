SRC= ./src
BIN= ./bin

all: $(SRC)/compile
	
	
$(SRC)/compile:
	   @mkdir -p $(BIN)
	   yacc -dvt -Wnone $(SRC)/yacc.y -o $(BIN)/y.tab.c
	   lex  -o $(BIN)/lex.yy.c $(SRC)/lex.l
	   g++  -w -c $(SRC)/node.cpp -o $(BIN)/node.o -I$(SRC)
	   g++  -w -c $(SRC)/symtable.cpp -o $(BIN)/sym.o -I$(SRC)
	   g++  -w -c $(SRC)/type.cpp -o $(BIN)/type.o -I$(SRC)
	   g++  -w -c $(SRC)/3ac.cpp -o $(BIN)/3ac.o -I$(SRC)
	   g++ $(BIN)/lex.yy.c $(BIN)/y.tab.c $(BIN)/node.o $(BIN)/sym.o $(BIN)/type.o $(BIN)/3ac.o -I$(SRC) -lfl -w  -o $(BIN)/parser


clean: 
		rm -rf $(BIN)
		rm -f *.dot *.png *.txt