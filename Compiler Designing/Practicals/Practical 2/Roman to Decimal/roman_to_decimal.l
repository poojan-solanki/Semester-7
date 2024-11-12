%{
#include <stdio.h>

int total = 0;  // To store the result of Roman to Decimal conversion

/* Function to add the value of a Roman numeral to total */
void addValue(char roman) {
    switch (roman) {
        case 'I': total += 1; break;
        case 'V': total += 5; break;
        case 'X': total += 10; break;
        case 'L': total += 50; break;
        case 'C': total += 100; break;
        case 'D': total += 500; break;
        case 'M': total += 1000; break;
    }
}

/* Function to subtract value for cases like IV, IX, etc. */
void subtractValue(char roman) {
    switch (roman) {
        case 'I': total -= 1; break;
        case 'X': total -= 10; break;
        case 'C': total -= 100; break;
    }
}
%}

%%

"IV"    { subtractValue('I'); addValue('V'); } /* 4 */
"IX"    { subtractValue('I'); addValue('X'); } /* 9 */
"XL"    { subtractValue('X'); addValue('L'); } /* 40 */
"XC"    { subtractValue('X'); addValue('C'); } /* 90 */
"CD"    { subtractValue('C'); addValue('D'); } /* 400 */
"CM"    { subtractValue('C'); addValue('M'); } /* 900 */

"I"     { addValue('I'); }
"V"     { addValue('V'); }
"X"     { addValue('X'); }
"L"     { addValue('L'); }
"C"     { addValue('C'); }
"D"     { addValue('D'); }
"M"     { addValue('M'); }

\n      { printf("Decimal value: %d\n", total); total = 0; }  /* On newline, print the result and reset total */

.       { /* Ignore other characters */ }

%%

/* Main function */
int main() {
    printf("Enter Roman numerals (Ctrl+D to end input):\n");
    yylex();  // Start lexical analysis
    return 0;
}
