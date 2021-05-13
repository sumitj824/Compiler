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
	   g++  -w -c $(SRC)/codegeneration.cpp -o $(BIN)/codegeneration.o -I$(SRC)
	   g++  -w -c $(SRC)/generation_aid.cpp -o $(BIN)/generation_aid.o -I$(SRC)
	   g++ $(BIN)/lex.yy.c $(BIN)/y.tab.c $(BIN)/node.o $(BIN)/sym.o $(BIN)/type.o $(BIN)/3ac.o $(BIN)/generation_aid.o $(BIN)/codegeneration.o -I$(SRC) -lfl -w  -o $(BIN)/compiler


clean: 
		rm -rf $(BIN)
		rm -f *.dot *.png *.txt *.asm