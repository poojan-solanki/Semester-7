%{
#include <stdio.h>

/* Function to print comments */
void printComment(const char *comment) {
    printf("%s\n", comment);
}

%}

%%

"//".*              { printComment(yytext); }   /* Match single-line comments starting with // */
"/*"(.|\n)*?"*/"    { printComment(yytext); }   /* Match multi-line comments, allowing newlines */

.                   { /* Ignore other characters */ }
\n                  { /* Ignore newlines unless part of a comment */ }

%%

/* Main function */
int main() {
    printf("Enter C code to extract comments (Ctrl+D to end input):\n");
    yylex();  // Start lexical analysis
    return 0;
}
