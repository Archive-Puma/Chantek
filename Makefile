CC = ghc
SRC = src
DIST = dist
BF = Brainfuck/
HQ9 = HQ9+/

# Directives
all:
	make -s brainfuck
	make -s hq9
	make -s clean

brainfuck:
	$(CC) -o $(DIST)/brainfuck $(BF)$(SRC)/*.hs

hq9:
	$(CC) -o $(DIST)/hq9 $(HQ9)$(SRC)/*.hs

# Clean (Change this $(OS))
clean:
	rm -rf $(BF)$(SRC)/*.o $(BF)$(SRC)/*.hi
	rm -rf $(HQ9)$(SRC)/*.o $(HQ9)$(SRC)/*.hi
