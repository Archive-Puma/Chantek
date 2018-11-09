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
	$(CC) -o $(DIST)/hq9-v1 $(HQ9)$(SRC)/v1/*.hs
	$(CC) -o $(DIST)/hq9-v2 $(HQ9)$(SRC)/v2/*.hs

# Clean (Change this $(OS))
clean:
	rm -rf $(BF)$(SRC)/*.o $(BF)$(SRC)/*.hi
	rm -rf $(HQ9)$(SRC)/v1/*.o $(HQ9)$(SRC)/v1/*.hi
	rm -rf $(HQ9)$(SRC)/v2/*.o $(HQ9)$(SRC)/v2/*.hi
