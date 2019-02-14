/*
comment
*/

#include <stdio.h>
#include "ctokens.h"

extern int yylex();
extern char* yytext;

// Map numbers to their corresponding names as defined in ctokens.h
char* names[] = {"END", "UNDEFINED", "KEYWORD", "IDENTIFIER", "CONSTANT",
                "STRING", "SPECIAL", "OPERATOR"};

int main(void) {

  // Scan and print
  for(int token = yylex(); token; token = yylex())
    printf("%s : %s\n", names[token], yytext);

  return 0;
}
