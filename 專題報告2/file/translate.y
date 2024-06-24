%{
#include <stdio.h>
extern int yylex();
extern int yyerror(const char *);
%}

%token PRINT INTEGER IDENTIFIER STRING OPERATOR

%%

program:
    statements
    | /* empty */
    ;

statements:
    statement
    | statements statement
    ;

statement:
    PRINT expression
    | assignment
    ;

assignment:
    IDENTIFIER '=' expression
    ;

expression:
    INTEGER
    | IDENTIFIER
    | STRING
    | OPERATOR
    //| expression OPERATOR expression
    ;

%%

int yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
    return 0;
}

