#OBJS= csv.tab.o hand-lex.o
#OBJS= csv.tab.o lex.yy.o hand-lex.o
OBJS= csv.tab.o lex.yy.o
OBJ2S= csv.tab.o csv2-lex.yy.o
SRC=csv.y csv2-lex.l
CC=g++ -std=c++11

csv2_ubuntu.exe: $(OBJ2S) $(SRC)
	$(CC) -o $@ $(OBJ2S) 

.PHONY: clean

csv.exe: $(OBJS)
	$(CC) -o $@ $(OBJS) 

csv.tab.o: csv.tab.c
	$(CC) -std=c++11 -I. -c $<

# hand-lex.o: hand-lex.c calc.h csv.tab.h
# 	gcc -c $<

lex.yy.o: lex.yy.c  csv.tab.h lex.l
	$(CC) -c $<

lex.yy.c: lex.l  csv.tab.h  GNUmakefile
	flex -Cf --backup $<

csv.tab.h csv.tab.c: csv.y GNUmakefile
	bison --defines csv.y


csv2-lex.yy.c: csv2-lex.l 
	flex -Cf --backup -o $@ $<


csv2-lex.yy.o: csv2-lex.yy.c  csv.tab.h csv2-lex.l
	$(CC) -c $<

valgrind_check: csv2.exe
	valgrind ./csv2.exe --leak-check=full <  csv-test-files/inp1.csv || echo "install valgrind and then run this"


#external library
#https://github.com/nlohmann/json
#verify the include is setup properly so we can include it our project
test-nlohmann.o: test-nlohmann-json.cpp
	g++ -c $<

clean:
	rm *.o csv.tab.[hc] csv2-lex.yy.c *.exe

