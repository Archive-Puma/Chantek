CC = ghc
SRC = src
DIST = dist/linux


B! = \!\!\!Batch/
D = $$/

# Directives
all:
	echo $(D)$(SRC)
	make -s batch
	make -s dollar
	make -s clean

batch:
	$(CC) -o $(DIST)/!batch $(B!)$(SRC)/*.hs

dollar:
	$(CC) -o $(DIST)/$$ $(D)$(SRC)/*.hs

# Clean (Change this $(OS))
clean:
	find . -name "*.o"  -type f -print0 | xargs -0 /bin/rm -f
	find . -name "*.hi" -type f -print0 | xargs -0 /bin/rm -f
