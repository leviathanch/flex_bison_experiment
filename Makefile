all: clean
	bison -d readcells_parser.y
	mv readcells_parser.tab.h readcells_parser.h
	mv readcells_parser.tab.c readcells_parser.y.c
	#flex readcells_parser.lex
	flex -d readcells_parser.lex
	gcc -g -DYYINITDEPTH=40000 -c lex.yy.c -o readcells_parser.lex.o
	gcc -g -DYYINITDEPTH=40000 -c readcells_parser.y.c -o readcells_parser.y.o
	gcc -g -DYYINITDEPTH=40000 -o readcells_parser readcells_parser.lex.o readcells_parser.y.o -lfl

clean:
	rm -f readcells_parser.lex.o 
	rm -f readcells_parser.y.o
	rm -f readcells_parser
	rm -f readcells_parser.h
	rm -f readcells_parser.y.c
	rm -f lex.yy.c
