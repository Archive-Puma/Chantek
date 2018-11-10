CC = ghc
SRC = src
DIST = dist/linux


B! = \!\!\!Batch/

# Directives
all:
	make -s batch
	make -s clean

batch:
	$(CC) -o $(DIST)/!batch $(B!)$(SRC)/*.hs

# Clean (Change this $(OS))
clean:
	rm -rf $(B!)$(SRC)/*.o $(B!)$(SRC)/*.hi
