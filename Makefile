
all: cscanner

cscanner: cscanner.o lex.yy.o
	gcc $< lex.yy.o -o $@

cscanner.o: cscanner.c ctokens.h
	gcc -c $< -o $@

lex.yy.o: lex.yy.c
	gcc -c $< -o $@

lex.yy.c: cscanner.l ctokens.h
	lex $<

.PHONY: clean
clean:
	rm -f lex.yy.c lex.yy.o cscanner.o cscanner
