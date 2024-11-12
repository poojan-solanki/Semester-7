%{
#include <stdio.h>
#include <ctype.h>

int shift = 3;  // Default shift value for Caesar Cipher

/* Function to perform Caesar Cipher shifting */
char caesarShift(char ch, int shift) {
    if (isupper(ch)) {
        return ((ch - 'A' + shift) % 26) + 'A';
    } else if (islower(ch)) {
        return ((ch - 'a' + shift) % 26) + 'a';
    }
    return ch;  // Non-alphabetic characters remain unchanged
}

%}

%%

[a-zA-Z] { putchar(caesarShift(yytext[0], shift)); }  /* Shift alphabetic characters */
.       { putchar(yytext[0]); }                      /* Print other characters as they are */
\n      { putchar('\n'); }                           /* Preserve newlines */

%%

/* Main function */
int main(int argc, char *argv[]) {
    if (argc > 1) {
        shift = atoi(argv[1]);  // Optional shift argument from the command line
    }
    printf("Enter text for Caesar Cipher (Ctrl+D to end input):\n");
    yylex();  // Start the lexer
    return 0;
}
