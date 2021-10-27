#OBJS= semicolon-separated-values.tab.o hand-lex.o
#OBJS= semicolon-separated-values.tab.o lex.yy.o hand-lex.o
OBJS= ../build/semicolon-separated-values.tab.o ../build/lex.yy.o
OBJ2S= ../build/semicolon-separated-values.tab.o ../build/semicolon-separated-values2-lex.yy.o ../build/driver.o
SRC=semicolon-separated-values.y semicolon-separated-values2-lex.l
CC=g++ -g -O2 -std=c++11

../build/semicolon-separated-values_ubuntu.exe: $(OBJ2S) $(SRC)
	$(CC) -o $@ $(OBJ2S) 

.PHONY: clean

semicolon-separated-values.exe: $(OBJS)
	$(CC) -o $@ $(OBJS) 

../build/semicolon-separated-values.tab.o: semicolon-separated-values.tab.c semicolon-separated-values.tab.h
	$(CC) -std=c++11 -I. -c $< -o $@

# hand-lex.o: hand-lex.c calc.h semicolon-separated-values.tab.h
# 	gcc -c $<

../build/lex.yy.o: lex.yy.c  semicolon-separated-values.tab.h lex.l
	$(CC) -c $<

../build/driver.o: driver.cpp
	$(CC) -std=c++11 -I. -c $< -o $@

lex.yy.c: lex.l  semicolon-separated-values.tab.h  GNUmakefile
	flex --backup $<

semicolon-separated-values.tab.h semicolon-separated-values.tab.c: semicolon-separated-values.y GNUmakefile
	bison --defines semicolon-separated-values.y


semicolon-separated-values2-lex.yy.c: semicolon-separated-values2-lex.l 
	flex --backup -o $@ $<


../build/semicolon-separated-values2-lex.yy.o: semicolon-separated-values2-lex.yy.c  semicolon-separated-values.tab.h semicolon-separated-values2-lex.l
	$(CC) -c $< -o $@

valgrind_check: semicolon-separated-values2.exe
	valgrind ./semicolon-separated-values2.exe --leak-check=full <  semicolon-separated-values-test-files/inp1.csv || echo "install valgrind and then run this"


#external library
#https://github.com/nlohmann/json
#verify the include is setup properly so we can include it our project
test-nlohmann.o: test-nlohmann-json.cpp
	g++ -c $<

clean:
	rm *.o semicolon-separated-values.tab.[hc] semicolon-separated-values2-lex.yy.c *.exe

