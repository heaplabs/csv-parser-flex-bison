OBJ2S= ../build/tab-separated-values.tab.o ../build/tab-separated-values2-lex.yy.o ../build/driver.o
SRC=tab-separated-values.y tab-separated-values2-lex.l
CC=g++ -g -O2 -std=c++11

../build/tab-separated-values_ubuntu.exe: $(OBJ2S) $(SRC)
	$(CC) -o $@ $(OBJ2S) 

.PHONY: clean

tab-separated-values.exe: $(OBJ2S)
	$(CC) -o $@ $(OBJ2S) 

../build/tab-separated-values.tab.o: tab-separated-values.tab.c tab-separated-values.tab.h
	$(CC) -std=c++11 -I../common -c $< -o $@

../build/tab-separated-values2-lex.yy.o: tab-separated-values2-lex.yy.c tab-separated-values.tab.h
	$(CC) -std=c++11 -I../common -c $< -o $@

../build/driver.o: driver.cpp
	$(CC) -std=c++11 -I. -c $< -o $@

tab-separated-values.tab.h tab-separated-values.tab.c: tab-separated-values.y GNUmakefile
	bison --defines tab-separated-values.y


tab-separated-values2-lex.yy.c: tab-separated-values2-lex.l tab-separated-values.tab.h
	flex --backup -o $@ $<


../build/tab-separated-values2-lex.yy.o: tab-separated-values2-lex.yy.c  tab-separated-values.tab.h tab-separated-values2-lex.l
	$(CC) -c $< -o $@

valgrind_check: tab-separated-values2.exe
	valgrind --leak-check=full ./tab-separated-values2.exe <  tab-separated-values-test-files/inp1.csv || echo "install valgrind and then run this"


#external library
#https://github.com/nlohmann/json
#verify the include is setup properly so we can include it our project
test-nlohmann.o: test-nlohmann-json.cpp
	g++ -c $<

clean:
	rm ../build/$(OBJ2S) tab-separated-values.tab.[hc] tab-separated-values2-lex.yy.c *.exe

