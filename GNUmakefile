OBJ2S= build/driver.o \
	build/csv.tab.o \
	build/semicolon-separated-values.tab.o \
	build/tab-separated-values.tab.o \
	build/csv2-lex.yy.o \
	build/semicolon-separated-values2-lex.yy.o \
	build/tab-separated-values2-lex.yy.o
SRC=comma-separated-values/csv.y comma-separated-values/csv2-lex.l
CC=g++ -g -O2 -std=c++11

build/csv2_ubuntu.exe: $(OBJ2S) $(SRC)
	$(CC) -o $@ $(OBJ2S) 

.PHONY: clean

build/driver.o: common/driver.cpp comma-separated-values/csv.tab.h semicolon-separated-values/semicolon-separated-values.tab.h
	$(CC) -std=c++11 -Itab-separated-values -Icomma-separated-values -Isemicolon-separated-values -Icommon -c $< -o $@

# bison files c -> obj
build/csv.tab.o: comma-separated-values/csv.tab.c comma-separated-values/csv.tab.h
	$(CC) -std=c++11 -I. -c $< -o $@

build/semicolon-separated-values.tab.o: semicolon-separated-values/semicolon-separated-values.tab.c semicolon-separated-values/semicolon-separated-values.tab.h
	$(CC) -std=c++11 -I. -c $< -o $@

build/tab-separated-values.tab.o: tab-separated-values/tab-separated-values.tab.c tab-separated-values/tab-separated-values.tab.h
	$(CC) -std=c++11 -I. -c $< -o $@

# bison files y -> c
comma-separated-values/csv.tab.h comma-separated-values/csv.tab.c: comma-separated-values/csv.y GNUmakefile
	bison --defines $< -o comma-separated-values/csv.tab.c

semicolon-separated-values/semicolon-separated-values.tab.h semicolon-separated-values/semicolon-separated-values.tab.c: semicolon-separated-values/semicolon-separated-values.y GNUmakefile
	bison --defines $< -o semicolon-separated-values/semicolon-separated-values.tab.c

tab-separated-values/tab-separated-values.tab.h tab-separated-values/tab-separated-values.tab.c: tab-separated-values/tab-separated-values.y GNUmakefile
	bison --defines $< -o tab-separated-values/tab-separated-values.tab.c

# flex files l -> c
comma-separated-values/csv2-lex.yy.c: comma-separated-values/csv2-lex.l 
	flex --backup -o $@ $<

semicolon-separated-values/semicolon-separated-values2-lex.yy.c: semicolon-separated-values/semicolon-separated-values2-lex.l 
	flex --backup -o $@ $<
	sed "s/yytext_ptr/semicolonsv_text_ptr/" semicolon-separated-values/semicolon-separated-values2-lex.yy.c > semicolon-separated-values/semicolon-separated-values2-lex.yy.c.temp 
	mv semicolon-separated-values/semicolon-separated-values2-lex.yy.c.temp semicolon-separated-values/semicolon-separated-values2-lex.yy.c


tab-separated-values/tab-separated-values2-lex.yy.c: tab-separated-values/tab-separated-values2-lex.l tab-separated-values/tab-separated-values.tab.h
	flex --backup -o $@ $<
	sed "s/yytext_ptr/tabsv_text_ptr/" tab-separated-values/tab-separated-values2-lex.yy.c > tab-separated-values/tab-separated-values2-lex.yy.c.temp 
	mv tab-separated-values/tab-separated-values2-lex.yy.c.temp tab-separated-values/tab-separated-values2-lex.yy.c

# flex file c -> o

build/csv2-lex.yy.o: comma-separated-values/csv2-lex.yy.c  comma-separated-values/csv.tab.h comma-separated-values/csv2-lex.l
	$(CC) -c $< -o $@

build/semicolon-separated-values2-lex.yy.o: semicolon-separated-values/semicolon-separated-values2-lex.yy.c semicolon-separated-values/semicolon-separated-values.tab.h
	$(CC) -c $< -o $@

build/tab-separated-values2-lex.yy.o: tab-separated-values/tab-separated-values2-lex.yy.c tab-separated-values/tab-separated-values.tab.h
	$(CC) -c $< -o $@

# valgrind

valgrind_check: build/csv2_ubuntu.exe
	valgrind --leak-check=full ./build/csv2_ubuntu.exe  comma-separated-values/csv-test-files/inp1.csv || echo "install valgrind and then run this"


#external library
#https://github.com/nlohmann/json
#verify the include is setup properly so we can include it our project
test-nlohmann.o: test-nlohmann-json.cpp
	g++ -c $<


clean:
	rm build/*.o comma-separated-values/csv.tab.[hc] \
		comma-separated-values/csv2-lex.yy.c \
		build/*.exe \
		semicolon-separated-values/semicolon-separated-values2-lex.yy.c \
		semicolon-separated-values/semicolon-separated-values.tab.[hc]


