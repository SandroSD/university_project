%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"

    // Variables externa (propia de bison) para poder ser utilizadas tanto en lexico.l como en sintactico.y
    // extern char *yytext;

    int yylineno;
    FILE  *yyin;
    int yylex();
    void yyerror(char *msg);
%}

// Especifica el valor semantico que tendra la variable global propia de bison yylval.
// Como la variable yytext (global) sera sobrescrita, debera guardarse su valor en yyval.
// Ejemplo: strcpy(yylval.str, yytext);
// Mas info: http://www.gnu.org/software/bison/manual/html_node/Union-Decl.html#Union-Decl
%union {
  char str[500];
}

// Tokens
%token ID
%token ENTERO OP_SUMA OP_RESTA OP_MUL OP_DIV ASIG P_A P_C

// Reglas gramaticales
%%
programa : {printf("Compilacion OK\n");}
%%

// Sección código
int main(int argc, char *argv[])
{
    if ((yyin = fopen(argv[1], "rt")) == NULL)
    {
	    printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
    }
    else
    {
	    yyparse();
    }
    fclose(yyin);
    return 0;
}

void yyerror(char *msg)
{
    fflush(stderr);
    fprintf(stderr, "\n\n--- ERROR ---\nAt line %d: \'%s\'.\n\n", yylineno, msg);
    exit(1);
}