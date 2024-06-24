%{
#include "translate.tab.h"
#include <stdio.h>
%}

%%

[ \t\n]+           ;
print              { return PRINT; }
"("                { return LPAREN; }
")"                { return RPAREN; }
"+"                { return PLUS; }
"-"                { return MINUS; }
"*"                { return MULT; }
"/"                { return DIV; }
"="                { return ASSIGN; }
[0-9]+             { yylval.intval = atoi(yytext); return NUMBER; }
[a-zA-Z][a-zA-Z0-9]* { yylval.strval = strdup(yytext); return IDENTIFIER; }
.                  { printf("Unexpected character: %s\n", yytext); exit(1); }

%%

int yywrap() {
    return 1;
}

