#include <stdio.h>
#include <ctype.h>
#include <string.h>

// Global variables to hold input string and index pointer
char input[100];  // To store the input string
int idx = 0;      // Current index in the input string

// Function declarations for non-terminals
void E();        // For Expression
void E_prime();  // For Expression Prime
void T();        // For Term
void T_prime();  // For Term Prime
void F();        // For Factor

// Function to print which production rule is used
void display_rule(int rule) {
    printf("Using production: %d\n", rule);
}

// Function to match a terminal symbol and advance input pointer
int match(char terminal) {
    if (input[idx] == terminal) {
        idx++;  // Move to the next character
        return 1;
    }
    return 0;
}

// Recursive descent parser functions for grammar

// E -> T E'
void E() {
    display_rule(1);  // Production: E -> T E'
    T();
    E_prime();
}

// E' -> + T E' | ε
void E_prime() {
    if (input[idx] == '+') {
        display_rule(2);  // Production: E' -> + T E'
        match('+');
        T();
        E_prime();  // Recursive call for E'
    } else {
        display_rule(3);  // Production: E' -> ε (empty)
        // ε is handled implicitly by returning without consuming input
    }
}

// T -> F T'
void T() {
    display_rule(4);  // Production: T -> F T'
    F();
    T_prime();
}

// T' -> * F T' | ε
void T_prime() {
    if (input[idx] == '*') {
        display_rule(5);  // Production: T' -> * F T'
        match('*');
        F();
        T_prime();  // Recursive call for T'
    } else {
        display_rule(6);  // Production: T' -> ε (empty)
        // ε is handled implicitly by returning without consuming input
    }
}

// F -> ( E ) | id
void F() {
    if (input[idx] == '(') {
        display_rule(7);  // Production: F -> ( E )
        match('(');
        E();
        if (!match(')')) {
            printf("Error: expected ')'\n");
            return;
        }
    } else if (isalpha(input[idx])) {  // Match an identifier (id)
        display_rule(8);  // Production: F -> id
        // Handle multi-character identifier (consume all alphanumeric characters)
        while (isalnum(input[idx])) {
            idx++;  // Move to the next character
        }
    } else {
        printf("Error: expected id or '('\n");
    }
}

// Main function to check if the input is successfully parsed
int main() {
    printf("Enter the string to be parsed: ");
    scanf("%s", input);  // Read input string

    E();  // Start parsing with the start symbol E

    // If all input is consumed and there is no remaining unparsed part
    if (input[idx] == '\0') {
        printf("String parsed successfully!\n");
    } else {
        printf("Error: unparsed input remaining at index %d: '%s'\n", idx, &input[idx]);
    }

    return 0;
}
