CC = ghc
SRC = src
DIST = dist
BF = Brainfuck/

# Directives
brainfuck:
	$(CC) -o $(DIST)/brainfuck $(BF)$(SRC)/Main $(BF)$(SRC)/Parser
	make -s clean

# Clean (Change this)
clean:
	rm -rf $(BF)$(SRC)/*.o $(BF)$(SRC)/*.hi
