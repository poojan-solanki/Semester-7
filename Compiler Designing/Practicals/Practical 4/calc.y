%{
#include <stdio.h>
#include <stdlib.h>

/* Declare tokens for the operators and numbers */
int yylex(void);
void yyerror(const char *);

int result;  /* Variable to store the result */
%}

%token NUMBER
%left '+' '-'
%left '*' '/'

%%

calculation:
    expression '\n'  { printf("Result = %d\n", $1); result = $1; }
    | /* empty */
;

expression:
    expression '+' expression   { $$ = $1 + $3; }
    | expression '-' expression { $$ = $1 - $3; }
    | expression '*' expression { $$ = $1 * $3; }
    | expression '/' expression { 
        if ($3 == 0) {
            yyerror("Division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
    | '(' expression ')'        { $$ = $2; }
    | NUMBER                    { $$ = $1; }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Enter an expression:\n");
    yyparse();
    return 0;
}
