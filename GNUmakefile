#OBJS= csv.tab.o hand-lex.o
#OBJS= csv.tab.o lex.yy.o hand-lex.o
OBJ2S= build/csv.tab.o build/csv2-lex.yy.o build/driver.o build/semicolon-separated-values.tab.o build/semicolon-separated-values2-lex.yy.o
SRC=comma-separated-values/csv.y comma-separated-values/csv2-lex.l
CC=g++ -g -O2 -std=c++11

build/csv2_ubuntu.exe: $(OBJ2S) $(SRC)
	$(CC) -o $@ $(OBJ2S) 

.PHONY: clean

build/csv.tab.o: comma-separated-values/csv.tab.c comma-separated-values/csv.tab.h
	$(CC) -std=c++11 -I. -c $< -o $@

build/driver.o: common/driver.cpp comma-separated-values/csv.tab.h semicolon-separated-values/semicolon-separated-values.tab.h
	$(CC) -std=c++11 -Icomma-separated-values -Isemicolon-separated-values -Icommon -c $< -o $@

comma-separated-values/csv.tab.h comma-separated-values/csv.tab.c: comma-separated-values/csv.y GNUmakefile
	bison --defines $< -o comma-separated-values/csv.tab.c

semicolon-separated-values/semicolon-separated-values.tab.h semicolon-separated-values/semicolon-separated-values.tab.c: semicolon-separated-values/semicolon-separated-values.y GNUmakefile
	bison --defines $< -o semicolon-separated-values/semicolon-separated-values.tab.c


comma-separated-values/csv2-lex.yy.c: comma-separated-values/csv2-lex.l 
	flex --backup -o $@ $<

semicolon-separated-values/semicolon-separated-values2-lex.yy.c: semicolon-separated-values/semicolon-separated-values2-lex.l 
	flex --backup -o $@ $<
	sed "s/yytext_ptr/semicolonsv_text_ptr/" semicolon-separated-values/semicolon-separated-values2-lex.yy.c > semicolon-separated-values/semicolon-separated-values2-lex.yy.c.temp 
	mv semicolon-separated-values/semicolon-separated-values2-lex.yy.c.temp semicolon-separated-values/semicolon-separated-values2-lex.yy.c


build/csv2-lex.yy.o: comma-separated-values/csv2-lex.yy.c  comma-separated-values/csv.tab.h comma-separated-values/csv2-lex.l
	$(CC) -c $< -o $@

build/semicolon-separated-values2-lex.yy.o: semicolon-separated-values/semicolon-separated-values2-lex.yy.c semicolon-separated-values/semicolon-separated-values.tab.h
	$(CC) -c $< -o $@

valgrind_check: csv2_ubuntu.exe
	valgrind ./csv2_ubuntu.exe --leak-check=full <  comma-separated-values/csv-test-files/inp1.csv || echo "install valgrind and then run this"


#external library
#https://github.com/nlohmann/json
#verify the include is setup properly so we can include it our project
test-nlohmann.o: test-nlohmann-json.cpp
	g++ -c $<

clean:
	rm *.o csv.tab.[hc] csv2-lex.yy.c *.exe


