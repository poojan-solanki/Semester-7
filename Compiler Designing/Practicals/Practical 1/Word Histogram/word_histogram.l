%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Define a structure to hold word and frequency */
typedef struct {
    char word[100];  /* Word */
    int count;       /* Frequency of the word */
} WordFreq;

/* Array to store words and their frequencies */
WordFreq wordList[1000]; /* A simple array to hold words and their frequencies */
int wordCount = 0;       /* Number of words processed */

/* Function to add or update a word in the wordList */
void addWord(char *word) {
    for (int i = 0; i < wordCount; i++) {
        if (strcmp(wordList[i].word, word) == 0) {
            wordList[i].count++;
            return;
        }
    }
    strcpy(wordList[wordCount].word, word);
    wordList[wordCount].count = 1;
    wordCount++;
}

/* Function to print the histogram */
void printHistogram() {
    printf("\nWord Histogram:\n");
    printf("-----------------\n");
    for (int i = 0; i < wordCount; i++) {
        printf("%s: ", wordList[i].word);
        for (int j = 0; j < wordList[i].count; j++) {
            printf("*");
        }
        printf(" (%d)\n", wordList[i].count);
    }
}

%}

%%

[ \t\n]+        { /* Do nothing, skip whitespace */ }


[a-zA-Z]+       { addWord(yytext); }

%%

/* Main function */
int main() {
    printf("Enter text (Ctrl+D to end input):\n");
    yylex();  /* Start the lexer */
    printHistogram(); /* Print the histogram */
    return 0;
}
