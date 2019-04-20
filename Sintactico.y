%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"

    // Variables externa (propia de bison) para poder ser utilizadas tanto en lexico.l como en sintactico.y
    // extern char *yytext;

    int yylineno;
    FILE  *yyin;
    int yylex();
    int yyerror(char *msg);
%}

// Especifica el valor semantico que tendra la variable global propia de bison yylval.
// Como la variable yytext (global) sera sobrescrita, debera guardarse su valor en yyval.
// Ejemplo: strcpy(yylval.str, yytext);
// Mas info: http://www.gnu.org/software/bison/manual/html_node/Union-Decl.html#Union-Decl
%union {
  char str[500];
}

// Start symbol
%start programa 

// Tokens
%token DEFVAR
%token ENDDEF
%token REAL
%token INTEGER
%token STRING
%token IF THEN ELSE ENDIF
%token WHILE DO ENDWHILE
%token OP_AND
%token OP_OR
%token CMP_MAYOR
%token CMP_MENOR
%token CMP_MAYORIGUAL
%token CMP_MENORIGUAL
%token CMP_DISTINTO
%token CMP_IGUAL
%token OP_ASIG 
%token OP_DOSP
%token OP_SUM
%token OP_RES
%token OP_MUL
%token OP_DIV
%token CAR_COMA
%token CAR_PUNTO
%token CAR_PYC
%token CAR_PA 
%token CAR_PC
%token CAR_CA 
%token CAR_CC
%token CAR_LA 
%token CAR_LC 
%token DISPLAY
%token GET
%token CONST_INT
%token CONST_REAL
%token CONST_STR
%token ID

// Reglas gramaticales
%%

programa:   
    {printf("\tInicia el COMPILADOR\n");} est_declaracion bloque {printf("\tFin COMPILADOR ok\n");}
    ;
		
est_declaracion:
	DEFVAR {printf("\t\tDECLARACIONES DEF\n");} declaraciones ENDDEF {printf("\tFin de las Declaraciones DEF\n");}
        ;

declaraciones:         	        	
             declaracion
             | declaraciones declaracion
    	     ;

declaracion:  
           lista_var OP_DOSP REAL
			| lista_var OP_DOSP STRING
			| lista_var OP_DOSP INTEGER
           ;

lista_var:  
	 ID
	 | lista_var CAR_COMA ID   
 	 ;

bloque:  
      sentencia
      |bloque sentencia
      ;

sentencia:
  	 ciclo
	 |seleccion  
	 |asignacion
	 ;

ciclo:
    WHILE { printf("\t\tWHILE\n");}CAR_PA condicion CAR_PC bloque ENDWHILE { printf("\t\tFIN DEL WHILE\n");}
     ;

asignacion:
			lista_id OP_ASIG expresion {printf("\t\tFIN LINEA ASIGNACION\n");}
	  ;

lista_id:
			lista_id OP_ASIG ID 
			| ID 
		;
	  
entrada_salida: 
	GET{printf("\t\tGET\n"); } ID 
	|DISPLAY{printf("\t\tDISPLAY\n");} ID 
	|DISPLAY{printf("\t\tDISPLAY\n");} CONST_STR
;

seleccion: 
    	 IF CAR_PA condicion CAR_PC THEN bloque ENDIF{printf("\t\tENDIF\n");}
		| IF CAR_PA condicion CAR_PC THEN bloque ELSE bloque ENDIF {printf("\t\t IF CON ELSE\n");}	 
;

condicion:
         comparacion
         |comparacion OP_AND comparacion{printf("\t\tCONDICION DOBLE AND\n");}
		 |comparacion OP_OR  comparacion{printf("\t\tCONDICION DOBLE OR\n");}
		 |OP_NOT CAR_PA comparacion OP_AND comparacion CAR_PC{printf("\t\tNOT CONDICION DOBLE AND\n");}
		 |OP_NOT CAR_PA comparacion OP_OR  comparacion CAR_PC{printf("\t\tNOT CONDICION DOBLE OR\n");}
	 ;

comparacion:
	   expresion comparador expresion
	   ;

comparador:
	   CMP_MAYOR | CMP_MENOR | CMP_MAYORIGUAL | CMP_MENORIGUAL | CMP_IGUAL | CMP_DISTINTO
	   ;

expresion:
         termino
		|expresion OP_SUM termino
		|expresion OP_RES termino
 	 ;
	 
	 
termino: 
       factor
       |termino OP_MUL factor
	   |termino OP_DIV factor
       ;

factor: 
      ID
      | CONST_INT
      | CONST_REAL
      | CONST_STR 
	  | CAR_PA expresion CAR_PC 	  
      ;

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

int yyerror(char *msg)
{
    fflush(stderr);
    fprintf(stderr, "\n\n--- ERROR ---\nAt line %d: \'%s\'.\n\n", yylineno, msg);
    exit(5);
}