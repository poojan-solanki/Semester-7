%{
#include <stdio.h>
#include <string.h>

int conjunction_count = 0; // Variable to track the number of conjunctions
%}

%%

"and"|"or"|"but"        { conjunction_count++; } // Match conjunctions and increment counter
[a-zA-Z]+               { /* Ignore simple words */ }
[ \t\n]+                { /* Ignore whitespaces and newlines */ }

%%

int main() {
    char input[256];

    while (1) {
        printf("\nEnter a statement (type 'exit' to quit):\n");
        fgets(input, sizeof(input), stdin); // Read user input

        // Check if the user wants to exit
        if (strncmp(input, "exit", 4) == 0) {
            break;
        }

        conjunction_count = 0; // Reset conjunction count for the new input
        yy_scan_string(input); // Pass the input to the lexical analyzer
        yylex();  // Begin scanning the input
        
        // Determine whether the statement is simple or compound
        if (conjunction_count > 0) {
            printf("The given statement is a compound statement.\n");
        } else {
            printf("The given statement is a simple statement.\n");
        }
    }

    printf("Program exited.\n");
    return 0;
}

int yywrap() {
    return 1;
}
