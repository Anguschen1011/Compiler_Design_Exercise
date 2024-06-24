%{
#include <stdio.h>
int line_count = 0;
%}

%%
print                   { printf("Keyword: print\n"); }
[0-9]+                  { printf("Integer: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*  { printf("Identifier: %s\n", yytext); }
\".*\"                  { printf("String: %s\n", yytext); }
[+\-*/=]                { printf("Operator: %s\n", yytext); }
[()]                    { printf("Parentheses: %s\n", yytext); }
[\n]                { line_count++; printf("\n");}
[ \t]                 ;
.                       { printf("Unrecognized: %s\n", yytext); }
%%

int main() {
    yyin = fopen("test.py", "r");
    if (!yyin) {
        fprintf(stderr, "Failed to open input file.\n");
        return 1;
    }
    
    yylex();
    fclose(yyin); // Close input file
    
    printf("********** Output Count **********\n");
    printf("Total lines: %d\n", line_count); // Print total lines
    
    return 0;
}

