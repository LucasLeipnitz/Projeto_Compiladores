all: etapa2

lex.yy.c: scanner.l
	flex scanner.l
	
etapa2: lex.yy.c main.c parser.tab.h
	gcc -o etapa1 main.c lex.yy.c
