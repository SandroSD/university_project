%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "y.tab.h"
	#include "constantes.h"
	#include "tercetos.h"
	#include "ts.h"
	#include "pila.h"

	// Declaraciones mandatory para quitar warnings
    int yylineno;
    FILE  *yyin;
    int yylex();
    int yyerror(char *msg);
	int yyparse();

	// Cabecera funciones varias
	void insertarEnArrayDeclaracion(char *);
	void validarDeclaracionTipoDato(char *);

	// Declaro la pila (estructura externa que me servira para resolver GCI)
	t_pila pila;

	// Arrays
	char * arrayDeclaraciones[100];	// array para declaraciones
	int posicion_en_arrayDeclaraciones = 0; // incremento en el array listaDeclaracion

	// Auxiliar para indices de tercetos;
	int indiceExpresion, indiceTermino, indiceFactor;
	int indiceAux, indiceUltimo, indiceDesapilado;

	//Indice terceto
	int indiceTerceto, indiceUltimo;
%}

// Especifica el valor semantico que tendra la variable global propia de bison yylval.
// Como la variable yytext (global de lexico) sera sobrescrita, debera guardarse su valor en yyval.
// Ejemplo: strcpy(yylval.str, yytext);
// Mas info: http://www.gnu.org/software/bison/manual/html_node/Union-Decl.html#Union-Decl
%union {
	char * int_val;
	char * real_val;
	char * str_val;
	char * cmp_val;
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
%token LONG
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

// Seccion 1
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
	{	validarDeclaracionTipoDato("REAL");	}
	| lista_var OP_DOSP STRING			
	{	validarDeclaracionTipoDato("STRING");	}
	| lista_var OP_DOSP INTEGER			
	{	validarDeclaracionTipoDato("INTEGER");	}	;

lista_var:
	ID									
	{	insertarEnArrayDeclaracion(yylval.str_val);	}
	| lista_var CAR_COMA ID				
	{	insertarEnArrayDeclaracion(yylval.str_val);	}	;

bloque:
	sentencia
	| bloque sentencia	;

sentencia:
	ciclo
	| ciclo_especial
	| seleccion
	| asignacion
	| entrada_salida	;

// Seccion 2
ciclo:
	WHILE		
	{	printf("\t\tWHILE\n"); 
		indiceAux=crearTerceto("ETIQ1","_","_"); 
		poner_en_pila(&pila,&indiceAux);
	}
	CAR_PA condicion CAR_PC bloque 
	ENDWHILE	
	{	printf("\t\tFIN DEL WHILE\n"); 
		indiceUltimo=crearTerceto("BI","_","_"); 
		sacar_de_pila(&pila, &indiceDesapilado); 
		char ladoIzquierdo[8];
		sprintf(ladoIzquierdo, "[%d]", indiceDesapilado);
		modificarTerceto(indiceUltimo, 2, ladoIzquierdo);
	}	;

ciclo_especial:
	WHILE		
	{
		// printf("\t\tWHILE (especial) \n"); 
		// indiceTerceto=crearTerceto("ETIQ1","_","_"); 
		// apilar(PILA_WHILE, indiceTerceto); 
	} 
	ID IN CAR_CA lista_expresiones CAR_CC DO bloque 
	ENDWHILE	
	{ 
		// printf("\t\tFIN DEL WHILE\n"); 
		// indiceUltimo=crearTerceto("BI","_","_"); 
		// indiceTerceto=desapilar(PILA_WHILE); 
		// indiceTerceto=desapilar(PILA_WHILE); 
		// modificarTerceto(indiceTerceto, 2, indiceUltimo);
	}	;

longitud: 
			LONG CAR_PA CAR_CA lista_variables_constantes CAR_CC CAR_PC	
			{ printf("\t\tLONGITUD (especial) \n");	} ;

lista_variables_constantes:
			lista_variables_constantes CAR_COMA ID
			| lista_variables_constantes CAR_COMA CONST_INT
			| ID
			| CONST_INT;

// Seccion 3
lista_expresiones: 
			expresion 
			| lista_expresiones CAR_COMA expresion ;

asignacion:
			lista_id OP_ASIG expresion 	{	printf("\t\tFIN LINEA ASIGNACION\n");	}
			| lista_id OP_ASIG longitud 	{	printf("\t\tFIN LINEA ASIGNACION LONGITUD\n");	}	;

lista_id:
	lista_id OP_ASIG ID
	| ID ;
	  
entrada_salida:
	GET	ID				{	crearTerceto("GET",yylval.str_val,"_");	}
	| DISPLAY ID 		{	crearTerceto("DISPLAY",yylval.str_val,"_");	}
	| DISPLAY CONST_STR	{	crearTerceto("DISPLAY",yylval.str_val,"_");	};

seleccion:
	IF CAR_PA condicion CAR_PC THEN 
	bloque 
	ENDIF	{	printf("\t\tENDIF\n");	}
	| IF CAR_PA condicion CAR_PC THEN 
	bloque 
	ELSE 
	bloque
	ENDIF 	{	printf("\t\t IF CON ELSE\n");	}	;

// Seccion 4
condicion:
			comparacion                     {   printf("\t\tCOMPARACION\n");}
			| OP_NOT comparacion			{	printf("\t\tCONDICION NOT\n");	}
			|comparacion OP_AND comparacion	{	printf("\t\tCONDICION DOBLE AND\n");	}
			|comparacion OP_OR  comparacion	{	printf("\t\tCONDICION DOBLE OR\n");		}	;

comparacion:
	   		expresion comparador expresion	
			| longitud comparador expresion;

comparador:
	CMP_MAYOR 
	{ 
		crearTerceto("CMP","_","_"); 
		crearTerceto("BLE","_","_");
	} 
	| CMP_MENOR 
	{
		crearTerceto("CMP","_","_"); 
		crearTerceto("BGE","_","_");
	}
	| CMP_MAYORIGUAL 
	{
		crearTerceto("CMP","_","_");
		crearTerceto("BLT","_","_");
	} 
	| CMP_MENORIGUAL 
	{
		crearTerceto("CMP","_","_");
		crearTerceto("BGT","_","_");
	} 
	| CMP_IGUAL 
	{
		crearTerceto("CMP","_","_"); 
		crearTerceto("BNE","_","_");
	} 
	| CMP_DISTINTO	
	{
		crearTerceto("CMP","_","_"); 
		crearTerceto("BEQ","_","_");
	} ;

expresion:
	termino	{	indiceExpresion = indiceTermino;	}
	| expresion OP_SUM termino
	{
		char ladoIzquierdo[8];
		sprintf(ladoIzquierdo, "[%d]", indiceExpresion);
		char ladoDerecho[8];
		sprintf(ladoDerecho, "[%d]", indiceTermino);
		indiceTermino = crearTerceto("+",ladoIzquierdo,ladoDerecho);
	}
	| expresion OP_RES termino	
	{
		char ladoIzquierdo[8];
		sprintf(ladoIzquierdo, "[%d]", indiceExpresion);
		char ladoDerecho[8];
		sprintf(ladoDerecho, "[%d]", indiceTermino);
		indiceTermino = crearTerceto("-",ladoIzquierdo,ladoDerecho);
	};

termino:
	factor	{	indiceTermino = indiceFactor;	}
	| termino OP_MUL factor		
	{
		char ladoIzquierdo[8];
		sprintf(ladoIzquierdo, "[%d]", indiceTermino);
		char ladoDerecho[8];
		sprintf(ladoDerecho, "[%d]", indiceFactor);
		indiceTermino = crearTerceto("*",ladoIzquierdo,ladoDerecho);
	}
	| termino OP_DIV factor		
	{
		char ladoIzquierdo[8];
		sprintf(ladoIzquierdo, "[%d]", indiceTermino);
		char ladoDerecho[8];
		sprintf(ladoDerecho, "[%d]", indiceFactor);
		indiceTermino = crearTerceto("/",ladoIzquierdo,ladoDerecho);
	}	;

factor:
	ID					{	indiceFactor = crearTerceto(yylval.str_val,"_","_");	}
	| CONST_INT			{	indiceFactor = crearTerceto(yylval.str_val,"_","_");	}
	| CONST_REAL		{	indiceFactor = crearTerceto(yylval.str_val,"_","_");	}
	| CONST_STR			{	indiceFactor = crearTerceto(yylval.str_val,"_","_");	}
	| CAR_PA expresion CAR_PC;

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
		crear_pila(&pila);
	    yyparse();
    }
    fclose(yyin);
    crearArchivoTS();
	crearArchivoTercetosIntermedia();
    return 0;
}

int yyerror(char *msg)
{
    fflush(stderr);
    fprintf(stderr, "\n\n--- ERROR ---\nAt line %d: \'%s\'.\n\n", yylineno, msg);
    exit(1);
}

void insertarEnArrayDeclaracion(char * val)
{
	char * aux = (char *) malloc(sizeof(char) * (strlen(val) + 1));
    strcpy(aux, val);
	arrayDeclaraciones[posicion_en_arrayDeclaraciones] = aux;
	posicion_en_arrayDeclaraciones++;
}
	
void validarDeclaracionTipoDato(char * tipo)
{
	int i;
	for (i=0; i < posicion_en_arrayDeclaraciones; i++)
	{
		if(existeTokenEnTS(arrayDeclaraciones[i]) == NO_EXISTE)
		{
			insertarTokenEnTS(tipo,arrayDeclaraciones[i]);
		}
		else 
		{
			char msg[300];
			sprintf(msg, "ERROR en etapa GCI - Variable \'%s\'ya declarada", arrayDeclaraciones[i]);
			yyerror(msg);
		}
	}
	// Reinicio el contador para leer otro tipo de dato
	posicion_en_arrayDeclaraciones = 0;
}

// // FUNCIONES DE PILA
// void apilar(int nroPila, char * val)
// {
// 	switch(nroPila){
// 		case PILA_IF:
// 			if(pilaLlena(PILA_IF) == TRUE){
// 				printf("Error: Se exedio el tamano de la pila de IF.\n");
// 				system ("Pause");
// 				exit (1);
// 			}
// 			pilaIF[tope_pila_if]=val;
// 			printf("\tAPILAR #CELDA ACTUAL -> %s\n",val);
// 			tope_pila_if++;
// 			break;
		
// 		case PILA_WHILE:
// 			if(pilaLlena(PILA_WHILE) == TRUE){
// 				printf("Error: Se exedio el tamano de la pila de WHILE.\n");
// 				system ("Pause");
// 				exit (1);
// 			}
// 			pilaWhile[tope_pila_while]=val;
// 			printf("\tAPILAR #CELDA ACTUAL -> %s\n",val);
// 			tope_pila_while++;
// 			break;
// 		case PILA_ASIGNACION:
		
// 			if(pilaLlena(PILA_ASIGNACION) == TRUE){
// 				printf("Error: Se exedio el tamano de la pila de ASIGNACION.\n");
// 				system ("Pause");
// 				exit (1);
// 			}
// 			pilaAsignacion[tope_pila_asignacion]=val;
// 			printf("\tAPILAR #CELDA ACTUAL -> %s\n",val);
// 			tope_pila_asignacion++;
// 			break;	
// 		case PILA_REPEAT:
// 			if(pilaLlena(PILA_REPEAT) == TRUE){
// 				printf("Error: Se exedio el tamano de la pila de REPEAT.\n");
// 				system ("Pause");
// 				exit (1);
// 			}
// 			pilaRepeat[tope_pila_repeat]=val;
// 			printf("\tAPILAR #CELDA ACTUAL -> %s\n",val);
// 			tope_pila_repeat++;
// 			break;	
			
// 		case PILA_BETWEEN:
// 			if(pilaLlena(PILA_BETWEEN) == TRUE){
// 				printf("Error: Se exedio el tamano de la pila de BETWEEN.\n");
// 				system ("Pause");
// 				exit (1);
// 			}
// 			pilaBetween[tope_pila_between]=val;
// 			printf("\tAPILAR #CELDA ACTUAL -> %s\n",val);
// 			tope_pila_between++;
// 			break;	
		
// 		default:
// 			printf("\tError: La pila recibida no se reconoce\n",val);
// 			system ("Pause");
// 			exit (1);
// 			break;
// 	}

// }

// int desapilar(int nroPila)
// {
// 	switch(nroPila){
// 		case PILA_IF:
// 			if(pilaVacia(tope_pila_if) == 0)
// 			{
// 				char * dato = pilaIF[tope_pila_if-1];
// 				tope_pila_if--;	
// 				printf("\tDESAPILAR #CELDA -> %s\n",dato);
// 				return atoi(dato);		
// 			} else {
// 				printf("Error: La pila esta vacia.\n");
// 				system ("Pause");
// 				exit (1);
// 			}
			
// 			break;
		
// 		case PILA_WHILE:
		
// 			if(pilaVacia(tope_pila_while) == 0)
// 			{
// 				char * dato = pilaWhile[tope_pila_while-1];
// 				tope_pila_while--;	
// 				printf("\tDESAPILAR #CELDA -> %s\n",dato);
// 				return atoi(dato);		
// 			} else {
// 				finAnormal("Stack Error","La pila esta vacia");
// 			}
		
// 			break;
// 		case PILA_ASIGNACION:
		
// 			if(pilaVacia(tope_pila_asignacion) == 0)
// 			{
// 				char * dato = pilaAsignacion[tope_pila_asignacion-1];
// 				tope_pila_asignacion--;	
// 				printf("\tDESAPILAR #CELDA -> %s\n",dato);
// 				return atoi(dato);		
// 			} else {
// 				finAnormal("Stack Error","La pila esta vacia");
// 			}
		
// 			break;	
// 		case PILA_REPEAT:
		
// 			if(pilaVacia(tope_pila_repeat) == 0)
// 			{
// 				char * dato = pilaRepeat[tope_pila_repeat-1];
// 				tope_pila_repeat--;	
// 				printf("\tDESAPILAR #CELDA -> %s\n",dato);
// 				return atoi(dato);		
// 			} else {
// 				finAnormal("Stack Error","La pila esta vacia");
// 			}
		
// 			break;	
		
// 		case PILA_BETWEEN:
		
// 			if(pilaVacia(tope_pila_between) == 0)
// 			{
// 				char * dato = pilaBetween[tope_pila_between-1];
// 				tope_pila_between--;	
// 				printf("\tDESAPILAR #CELDA -> %s\n",dato);
// 				return atoi(dato);		
// 			} else {
// 				finAnormal("Stack Error","La pila esta vacia");
// 			}
		
// 			break;	

// 		default:
// 			finAnormal("Stack Error","La pila recibida no se reconoce");
// 			break;
		
// 	}
	
// }

// int pilaVacia(int tope)
// {
// 	if (tope-1 == -1){
// 		return TRUE;
// 	} 
// 	return FALSE;
// }

// int pilaLlena(int tope)
// {
// 	if (tope-1 == TAM_PILA-1){
// 		return TRUE;
// 	} 
// 	return FALSE;
// }