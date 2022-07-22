all: etapa2

parser.tab.h: parser.y
	bison -d parser.y

parser.tab.c: parser.y
	bison -d parser.y

lex.yy.c: scanner.l
	flex scanner.l
	
etapa2: lex.yy.c main.c parser.tab.h
	gcc -o etapa2 main.c lex.yy.c parser.tab.c parser.tab.h
