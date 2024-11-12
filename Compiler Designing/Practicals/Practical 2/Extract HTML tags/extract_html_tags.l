%{
#include <stdio.h>
%}

%%

"<"[^>]*">"    { printf("Tag found: %s\n", yytext); } // Match HTML tags and print them
[^<]+          { /* Ignore text outside of tags */ }

%%

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <html_file>\n", argv[0]);
        return 1;
    }

    FILE *html_file = fopen(argv[1], "r");
    if (!html_file) {
        printf("Error: Could not open file %s\n", argv[1]);
        return 1;
    }

    // Redirect the file input to Lex
    yyin = html_file;
    yylex();  // Start the lexical analysis

    fclose(html_file);
    return 0;
}

int yywrap() {
    return 1;
}
