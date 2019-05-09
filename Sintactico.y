%{
    #include <stdio.h>
    #include <stdlib.h>
	#include <string.h>
    #include "y.tab.h"
    #define OK 1
    #define ERROR 0

    int yylineno;
    FILE  *yyin;
    int yylex();
    int yyerror(char *msg);

    // Variables y metodos para la tabla de simbolos. 
    struct struct_tablaSimbolos
    {
	    char nombre[100];
	    char tipo[100];
	    char valor[50];
	    char longitud[100];
    };
    struct struct_tablaSimbolos tablaSimbolos[10000];
    int crear_TS();
    int push_TS(char*, char*);
    int posicion_en_ts = 0;
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
%token WHILE DO IN ENDWHILE
%token OP_AND
%token OP_OR
%token OP_NOT
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
			{	printf("\tInicia el COMPILADOR\n\n");	} 
			est_declaracion bloque 
			{	printf("\n\tFin COMPILADOR OK\n");	}	;
		
est_declaracion:
			DEFVAR {	printf("\t\tDECLARACIONES DEFVAR\n");	} 
			declaraciones 
			ENDDEF {	printf("\t\tFIN DECLARACIONES ENDDEFF\n");	}	;

declaraciones:         	        	
             declaracion
             | declaraciones declaracion	;

declaracion:  
           lista_var OP_DOSP REAL
			| lista_var OP_DOSP STRING
			| lista_var OP_DOSP INTEGER	;

lista_var:  
	 		ID
	 		| lista_var CAR_COMA ID	;

bloque:  
      		sentencia
      		| bloque sentencia	;

sentencia:
			ciclo
			| ciclo_especial
			| seleccion  
			| asignacion
			| entrada_salida	;

ciclo:
    		WHILE {	printf("\t\tWHILE\n");	}
			CAR_PA condicion CAR_PC bloque 
			ENDWHILE {	printf("\t\tFIN DEL WHILE\n");	}	;

ciclo_especial:
    		WHILE	{ printf("\t\tWHILE (especial) \n");	} 
			ID IN CAR_CA lista_expresiones CAR_CC DO bloque 
			ENDWHILE	{ printf("\t\tFIN DEL WHILE\n");	}	;

lista_expresiones: 
			expresion 
			| lista_expresiones CAR_COMA expresion ;

asignacion:
			lista_id OP_ASIG expresion 	{	printf("\t\tFIN LINEA ASIGNACION\n");	}	;

lista_id:
			lista_id OP_ASIG ID 
			| ID ;
	  
entrada_salida: 
			GET			{	printf("\t\tGET\n"); 	} ID 
			| DISPLAY	{	printf("\t\tDISPLAY\n");} ID 
			| DISPLAY	{	printf("\t\tDISPLAY\n");} CONST_STR	;

seleccion: 
    	 	IF CAR_PA condicion CAR_PC THEN 
			bloque 
			ENDIF	{	printf("\t\tENDIF\n");	}
			| IF CAR_PA condicion CAR_PC THEN 
			bloque 
			ELSE 
			bloque 
			ENDIF 	{	printf("\t\t IF CON ELSE\n");	}	;

condicion:
			comparacion
			| OP_NOT comparacion			{	printf("\t\tCONDICION NOT\n");	}
			|comparacion OP_AND comparacion	{	printf("\t\tCONDICION DOBLE AND\n");	}
			|comparacion OP_OR  comparacion	{	printf("\t\tCONDICION DOBLE OR\n");		}	;

comparacion:
	   		expresion comparador expresion	;

comparador:
	   		CMP_MAYOR | CMP_MENOR | CMP_MAYORIGUAL | CMP_MENORIGUAL | CMP_IGUAL | CMP_DISTINTO	;

expresion:
			termino
			|expresion OP_SUM termino
			|expresion OP_RES termino	;

termino: 
			factor
			|termino OP_MUL factor
			|termino OP_DIV factor	;

factor: 
			ID
			| CONST_INT
			| CONST_REAL
			| CONST_STR 
			| CAR_PA expresion CAR_PC ;

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
    crear_TS();
    return 0;
}

int yyerror(char *msg)
{
    fflush(stderr);
    fprintf(stderr, "\n\n--- ERROR ---\nAt line %d: \'%s\'.\n\n", yylineno, msg);
    exit(1);
}

int crear_TS()
{
	FILE *archivo; 
	int i;
	archivo = fopen("ts.txt","w"); 

	if (!archivo){	return ERROR; }

	// fprintf(archivo, "Nombre\t\t\tTipo\t\t\tValor\t\t\tLongitud\n");
	// Cabecera del archivo
	fprintf(archivo, "%-30s%-12s%-30s%-12s\n","Nombre","Tipo","Valor","Longitud");
	
	for (i = 0; i < posicion_en_ts; i++)
	{
		if (strcmp(tablaSimbolos[i].tipo, "ID") == 0 )
		{  
			fprintf(archivo,"%-30s%-12s\n", tablaSimbolos[i].nombre, tablaSimbolos[i].tipo);
		}
		else
		{
			int longitud = strlen(tablaSimbolos[i].nombre);
			fprintf(archivo,"_%-29s%-12s%-30s%-12d\n", 
			tablaSimbolos[i].nombre, tablaSimbolos[i].tipo, tablaSimbolos[i].nombre, longitud);
		}
	}
	fclose(archivo); 

	return OK;
}

int push_TS(char* tipo, char* nombre)
{
	int i, posicion;
	
	for(i = 0; i < posicion_en_ts; i++)
	{
		if(strcmp(tablaSimbolos[i].nombre, nombre) == 0)
		{
			return i;
		}
	}
	strcpy(tablaSimbolos[posicion_en_ts].tipo, tipo);
	strcpy(tablaSimbolos[posicion_en_ts].nombre, nombre);
	posicion = posicion_en_ts;
	posicion_en_ts++;
	return posicion;
}