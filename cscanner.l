%{
#include "ctokens.h"
%}

%option noyywrap
%x COMMENT

IS_KW auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while
IS_ID [_a-zA-Z][_a-zA-Z0-9]*
IS_CONST [1-9][0-9]*|[0-9](\.[0-9]*)?
IS_STR \"[^"\n]*\"
IS_SP "("|")"|"["|"]"|"{"|"}"|";"|":"|","
IS_OP "="|"?"|"+"|"-"|"*"|"/"|"%"|"++"|"--"|"=="|"!="|">"|"<"|">="|"<="|"&&"|"||"|"!"|"&"|"|"|"^"|"~"|"<<"|">>"|"."|"->"

%%
  /* Eat up comments, precompiler commands and white space */
[ \t\n]       ;
"//"[^\n]*    ;
"#"[^\n]*     ;

"/*"            BEGIN(COMMENT);
<COMMENT>"*/"   BEGIN(INITIAL);
<COMMENT>.|\n   ;

  /* Read recognized C */
{IS_KW}     return KEYWORD;
{IS_ID}     return IDENTIFIER;
{IS_CONST}  return CONSTANT;
{IS_STR}    return STRING;
{IS_SP}     return SPECIAL;
{IS_OP}     return OPERATOR;

  /* Mark unrecognized text */
.         return UNDEFINED;

  /* Return end of file */
<<EOF>>   return 0;
