#OBJS= csv.tab.o hand-lex.o
#OBJS= csv.tab.o lex.yy.o hand-lex.o
OBJS= csv.tab.o lex.yy.o

csv.exe: $(OBJS)
	g++ -o $@ $(OBJS) 

csv.tab.o: csv.tab.c
	g++ -c $<

# hand-lex.o: hand-lex.c calc.h csv.tab.h
# 	gcc -c $<

lex.yy.o: lex.yy.c  csv.tab.h
	g++ -c $<

lex.yy.c: lex.l  csv.tab.h
	flex $<

csv.tab.c: csv.y
	bison --defines csv.y

