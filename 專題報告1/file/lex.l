%{
#include <stdio.h>

int keyword_count = 0;
int identifier_count = 0;
int integer_count = 0;
int string_count = 0;
int operator_count = 0;
int unrecognized_count = 0;
%}

%%
print                   { keyword_count++; printf("Keyword: print\n"); }
[0-9]+                  { integer_count++; printf("Integer: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*  { identifier_count++; printf("Identifier: %s\n", yytext); }
\".*\"                  { string_count++; printf("String: %s\n", yytext); }
[+\-*/=]                { operator_count++; printf("Operator: %s\n", yytext); }
[ \t\n]                 ; // Ignore whitespace and newline
.                       { unrecognized_count++; printf("Unrecognized: %s\n", yytext); }
%%

int main() {
    yyin = fopen("test.py", "r"); // Open input file
    if (!yyin) {
        fprintf(stderr, "Failed to open input file.\n");
        return 1;
    }
    
    yylex(); // Perform lexical analysis
    
    fclose(yyin); // Close input file
    printf("********** Output Count **********\n");
    printf("Keyword count: %d\n", keyword_count);
    printf("Identifier count: %d\n", identifier_count);
    printf("Integer count: %d\n", integer_count);
    printf("String count: %d\n", string_count);
    printf("Operator count: %d\n", operator_count);
    printf("Unrecognized count: %d\n", unrecognized_count);
    
    return 0;
}
