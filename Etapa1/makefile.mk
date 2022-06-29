CC=gcc
CFLAGS=-I.
DEPS = tokens.h

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

etapa1: main.o lex.yy.o
	$(CC) -o etapa1 main.o lex.yy.o

