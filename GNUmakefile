#OBJS= csv.tab.o hand-lex.o
#OBJS= csv.tab.o lex.yy.o hand-lex.o
OBJS= csv.tab.o lex.yy.o
OBJ2S= csv.tab.o csv2-lex.yy.o
SRC=csv.y csv2-lex.l

csv2.exe: $(OBJ2S) $(SRC)
	g++ -o $@ $(OBJ2S) 

csv.exe: $(OBJS)
	g++ -o $@ $(OBJS) 

csv.tab.o: csv.tab.c
	g++ -c $<

# hand-lex.o: hand-lex.c calc.h csv.tab.h
# 	gcc -c $<

lex.yy.o: lex.yy.c  csv.tab.h lex.l
	g++ -c $<

lex.yy.c: lex.l  csv.tab.h
	flex $<

csv.tab.h csv.tab.c: csv.y
	bison --defines csv.y


csv2-lex.yy.c: csv2-lex.l 
	flex -o $@ $<


csv2-lex.yy.o: csv2-lex.yy.c  csv.tab.h csv2-lex.l
	g++ -c $<

valgrind_check: csv2.exe
	valgrind ./csv2.exe --leak-check=full <  csv-test-files/inp1.csv || echo "install valgrind and then run this"
