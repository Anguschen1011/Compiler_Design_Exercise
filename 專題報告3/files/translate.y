%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempVarCount = 0;

void yyerror(const char *s);
int yylex();

void generate_code(const char* op, const char* arg1, const char* arg2, const char* result) {
    if (arg2 == NULL) {
        printf("%s = %s\n", result, arg1);
    } else {
        printf("%s = %s %s %s\n", result, arg1, op, arg2);
    }
}

void generate_print(const char* var) {
    printf("print %s\n", var);
}

%}

%union {
    int intval;
    char* strval;
}

%token <intval> NUMBER
%token <strval> IDENTIFIER
%type <strval> expression term factor statement

%token PLUS MINUS MULT DIV ASSIGN PRINT LPAREN RPAREN

%%
program: statements
       ;

statements: statements statement
          | statement
          ;

statement: IDENTIFIER ASSIGN expression {
                generate_code("=", $3, NULL, $1);
            }
          | PRINT LPAREN IDENTIFIER RPAREN {
                generate_print($3);
            }
          ;

expression: expression PLUS term {
                char temp[20];
                sprintf(temp, "t%d", tempVarCount++);
                generate_code("+", $1, $3, temp);
                $$ = strdup(temp);
            }
          | expression MINUS term {
                char temp[20];
                sprintf(temp, "t%d", tempVarCount++);
                generate_code("-", $1, $3, temp);
                $$ = strdup(temp);
            }
          | term {
                $$ = $1;
            }
          ;

term: term MULT factor {
                char temp[20];
                sprintf(temp, "t%d", tempVarCount++);
                generate_code("*", $1, $3, temp);
                $$ = strdup(temp);
            }
    | term DIV factor {
                char temp[20];
                sprintf(temp, "t%d", tempVarCount++);
                generate_code("/", $1, $3, temp);
                $$ = strdup(temp);
            }
    | factor {
                $$ = $1;
            }
    ;

factor: NUMBER {
                char temp[20];
                sprintf(temp, "%d", $1);
                $$ = strdup(temp);
            }
    | IDENTIFIER {
                $$ = $1;
            }
    ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
