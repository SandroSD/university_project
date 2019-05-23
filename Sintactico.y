%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "y.tab.h"
	#include "h_files/constantes.h"
	#include "h_files/tercetos.h"
	#include "h_files/ts.h"
	#include "h_files/pila.h"

	// Declaraciones mandatory para quitar warnings
    int yylineno;
    FILE  *yyin;
    int yylex();
    int yyerror(char *msg);
	int yyparse();

	// Cabecera funciones varias
	void insertarEnArrayDeclaracion(char *);
	void validarDeclaracionTipoDato(char *);
	char * negarComparador(char*);
	char * obtenerNuevoNombreEtiqueta();

	// Declaro la pila (estructura externa que me servira para resolver GCI)
	t_pila pila;
	t_pila pila_condicion_doble;
	t_pila pila_ciclo_especial;
	char condicion[5]; // puede ser AND u OR

	// Contador para el incremento de etiquetas en los ciclos, solo se usa en obtenerNuevoNombreEtiqueta()
	int incremento_etiqueta = 1;

	// Arrays
	char * arrayDeclaraciones[100];	// array para declaraciones
	int posicion_en_arrayDeclaraciones = 0; // incremento en el array listaDeclaracion

	// Auxiliar para manejar tercetos;
	int indiceExpresion, indiceTermino, indiceFactor, indiceLongitud;
	int indiceAux, indiceUltimo, indiceIzq, indiceDer, indiceComparador, indiceComparador1, indiceComparador2,
	indiceId;
	int indicePrincipioBloque;

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

ciclo:
	WHILE		
	{	printf("\t\tWHILE\n"); 
		indiceAux=crearTerceto(obtenerNuevoNombreEtiqueta(),"_","_"); 
		poner_en_pila(&pila,&indiceAux);
	}
	CAR_PA condicion CAR_PC { indicePrincipioBloque = obtenerIndiceActual(); }
	bloque 
	ENDWHILE	
	{	printf("\t\tFIN DEL WHILE\n"); 
		int indiceDesapilado;
		int indiceActual = obtenerIndiceActual();
		if(pila_vacia(&pila_condicion_doble) == PILA_VACIA)
		{
			sacar_de_pila(&pila, &indiceDesapilado); 
			modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceActual+1));
		}
		else
		{
			if(strcmp(condicion,"AND") == 0)
			{
				sacar_de_pila(&pila_condicion_doble, &indiceDesapilado); 
				modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceActual+1));
				sacar_de_pila(&pila_condicion_doble, &indiceDesapilado); 
				modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceActual+1));
			}
			if(strcmp(condicion,"OR") == 0)
			{
				sacar_de_pila(&pila_condicion_doble, &indiceDesapilado); 
				modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceActual+1));
				sacar_de_pila(&pila_condicion_doble, &indiceDesapilado); 
				modificarTerceto(indiceDesapilado, 2, armarIndiceI(indicePrincipioBloque));
			}
			// Debo desapilar el ultimo porque no me sirve
			sacar_de_pila(&pila, &indiceDesapilado); 
		}
		sacar_de_pila(&pila, &indiceDesapilado); 
		crearTerceto("BI",armarIndiceI(indiceDesapilado),"_"); 
	}	;

ciclo_especial:
	WHILE		
	{
		printf("\t\tWHILE (especial) \n"); 
		indiceAux=crearTerceto(obtenerNuevoNombreEtiqueta(),"_","_"); 
		poner_en_pila(&pila,&indiceAux);
	} 
	ID { indiceId = crearTerceto(yylval.str_val,"_","_"); } IN 
	CAR_CA lista_expresiones CAR_CC 
	{
		int indiceDesapilado;
		sacar_de_pila(&pila_ciclo_especial, &indiceDesapilado);
		modificarTerceto(indiceDesapilado, 1, "BNE");
		poner_en_pila(&pila,&indiceDesapilado);
	}
	DO { indicePrincipioBloque = obtenerIndiceActual(); }
	bloque 
	ENDWHILE	
	{ 
		printf("\t\tFIN DEL WHILE ESPECIAL\n");
		int indiceDesapilado;
		int indiceActual = obtenerIndiceActual();
		while(pila_vacia(&pila_ciclo_especial) != PILA_VACIA)
		{
			sacar_de_pila(&pila_ciclo_especial, &indiceDesapilado); 
			modificarTerceto(indiceDesapilado, 2, armarIndiceI(indicePrincipioBloque));
		}
		sacar_de_pila(&pila, &indiceDesapilado); 
		modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceActual+1));
		sacar_de_pila(&pila, &indiceDesapilado); 
		crearTerceto("BI",armarIndiceI(indiceDesapilado),"_");
	}	;

lista_expresiones: 
			expresion 
			{	
				crearTerceto("CMP",armarIndiceI(indiceId),armarIndiceD(indiceExpresion));
				indiceComparador = crearTerceto("BEQ","_","_");
				poner_en_pila(&pila_ciclo_especial,&indiceComparador);
			}
			| lista_expresiones CAR_COMA expresion 
			{	
				crearTerceto("CMP",armarIndiceI(indiceId),armarIndiceD(indiceExpresion));
				indiceComparador = crearTerceto("BEQ","_","_");
				poner_en_pila(&pila_ciclo_especial,&indiceComparador);
			};

longitud: 
			LONG CAR_PA CAR_CA lista_variables_constantes CAR_CC CAR_PC	
			{ printf("\t\tLONGITUD (especial) \n");	} ;

lista_variables_constantes:
			lista_variables_constantes CAR_COMA ID
			{ 
				indiceAux = crearTerceto("+","_auxLong","1");
				indiceLongitud = crearTerceto("=","_auxLong",armarIndiceD(indiceAux));
			}
			| lista_variables_constantes CAR_COMA CONST_INT	
			{ 
				indiceAux = crearTerceto("+","_auxLong","1");
				indiceLongitud = crearTerceto("=","_auxLong",armarIndiceD(indiceAux));
			}
			| ID		{ crearTerceto("=","_auxLong","1"); }
			| CONST_INT { crearTerceto("=","_auxLong","1"); };

asignacion:
			lista_id OP_ASIG expresion 	
			{	printf("\t\tFIN LINEA ASIGNACION\n");
				int indiceDesapilado;
				sacar_de_pila(&pila, &indiceDesapilado); 
				modificarTerceto(indiceDesapilado, 3, armarIndiceD(indiceExpresion));
			}
			| lista_id OP_ASIG longitud 	
			{	printf("\t\tFIN LINEA ASIGNACION LONGITUD\n");
				int indiceDesapilado;
				sacar_de_pila(&pila, &indiceDesapilado); 
				modificarTerceto(indiceDesapilado, 3, armarIndiceD(indiceLongitud));
			}	;

lista_id:
	lista_id OP_ASIG ID
	{ 
		crearTerceto("=",yylval.str_val,"_auxCte");
	}
	| ID 
	{ 
		indiceAux = crearTerceto("=","_auxCte","_");
		poner_en_pila(&pila,&indiceAux);
		crearTerceto("=",yylval.str_val,"_auxCte");
	};
	  
entrada_salida:
	GET	ID				{	crearTerceto("GET",yylval.str_val,"_");	}
	| DISPLAY ID 		{	crearTerceto("DISPLAY",yylval.str_val,"_");	}
	| DISPLAY CONST_STR	{	crearTerceto("DISPLAY",yylval.str_val,"_");	};

seleccion:
	IF CAR_PA condicion CAR_PC THEN
	bloque 
	ENDIF	
	{	printf("\t\tENDIF\n");	
		int indiceDesapilado;
		int indiceActual = obtenerIndiceActual();
		if(pila_vacia(&pila_condicion_doble) == PILA_VACIA)
		{
			sacar_de_pila(&pila, &indiceDesapilado); 
			modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceActual));
		}
		else
		{
			if(strcmp(condicion,"AND") == 0)
			{
				sacar_de_pila(&pila_condicion_doble, &indiceDesapilado); 
				modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceActual));
				sacar_de_pila(&pila_condicion_doble, &indiceDesapilado); 
				modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceActual));
			}
			if(strcmp(condicion,"OR") == 0)
			{
				sacar_de_pila(&pila_condicion_doble, &indiceDesapilado); 
				modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceActual));
				sacar_de_pila(&pila_condicion_doble, &indiceDesapilado); 
				modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceComparador));
			}
		}
	}
	| IF CAR_PA condicion CAR_PC THEN 
	bloque 
	ELSE 
	{
		int indiceDesapilado;
		int indiceActual = obtenerIndiceActual();
		if(pila_vacia(&pila_condicion_doble) == PILA_VACIA)
		{
			sacar_de_pila(&pila, &indiceDesapilado); 
			modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceActual+1));
		}
		else
		{
			if(strcmp(condicion,"AND") == 0)
			{
				sacar_de_pila(&pila_condicion_doble, &indiceDesapilado); 
				modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceActual+1));
				sacar_de_pila(&pila_condicion_doble, &indiceDesapilado); 
				modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceActual+1));
			}
			if(strcmp(condicion,"OR") == 0)
			{
				sacar_de_pila(&pila_condicion_doble, &indiceDesapilado); 
				modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceActual+1));
				sacar_de_pila(&pila_condicion_doble, &indiceDesapilado); 
				modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceComparador+1));
			}
		}
		indiceAux = crearTerceto("BI","_","_");
		poner_en_pila(&pila, &indiceAux);
	}
	bloque
	ENDIF 	
	{	
		printf("\t\tENDIF (con else)\n");
		int indiceDesapilado;
		int indiceActual = obtenerIndiceActual();
		sacar_de_pila(&pila, &indiceDesapilado); 
		modificarTerceto(indiceDesapilado, 2, armarIndiceI(indiceActual));
	}	; 

condicion:
			comparacion {   printf("\t\tCOMPARACION\n");}
			| OP_NOT comparacion			
			{	printf("\t\tCONDICION NOT\n");
				char *operador = obtenerTerceto(indiceComparador,1);
				char *operadorNegado = negarComparador(operador);
				modificarTerceto(indiceComparador,1,operadorNegado);
			}
			| comparacion { indiceComparador1 = indiceComparador; } OP_AND comparacion	
			{	printf("\t\tCONDICION DOBLE AND\n");
				indiceComparador2 = indiceComparador;
				strcpy(condicion, "AND");
				poner_en_pila(&pila_condicion_doble,&indiceComparador1);
				poner_en_pila(&pila_condicion_doble,&indiceComparador2);
			}
			| comparacion 
			{ 	indiceComparador1 = indiceComparador; 
				char *operador = obtenerTerceto(indiceComparador1,1);
				char *operadorNegado = negarComparador(operador);
				modificarTerceto(indiceComparador1,1,operadorNegado);
			} 
			OP_OR  comparacion	
			{	printf("\t\tCONDICION DOBLE OR\n");		
				indiceComparador2 = indiceComparador;
				strcpy(condicion, "OR");
				poner_en_pila(&pila_condicion_doble,&indiceComparador1);
				poner_en_pila(&pila_condicion_doble,&indiceComparador2);
			}	;

comparacion:
	   		expresion { indiceIzq = indiceExpresion; } comparador expresion 
			{
				indiceDer = indiceExpresion;
				crearTerceto("CMP",armarIndiceI(indiceIzq),armarIndiceD(indiceDer));
				char comparadorDesapilado[8];
				sacar_de_pila(&pila, &comparadorDesapilado); 
				indiceComparador = crearTerceto(comparadorDesapilado,"_","_");
				poner_en_pila(&pila,&indiceComparador);
			}
			| longitud { indiceIzq = indiceLongitud; } comparador expresion
			{
				indiceDer = indiceExpresion;
				crearTerceto("CMP",armarIndiceI(indiceIzq),armarIndiceD(indiceDer));
				char comparadorDesapilado[8];
				sacar_de_pila(&pila, &comparadorDesapilado); 
				indiceComparador = crearTerceto(comparadorDesapilado,"_","_");
				poner_en_pila(&pila,&indiceComparador);
			};

comparador:
	CMP_MAYOR 
	{
		char comparadorApilado[8] = "BLE";
		poner_en_pila(&pila,&comparadorApilado);
	} 
	| CMP_MENOR 
	{
		char comparadorApilado[8] = "BGE";
		poner_en_pila(&pila,&comparadorApilado);
	}
	| CMP_MAYORIGUAL 
	{
		char comparadorApilado[8] = "BLT";
		poner_en_pila(&pila,&comparadorApilado);
	} 
	| CMP_MENORIGUAL 
	{
		char comparadorApilado[8] = "BGT";
		poner_en_pila(&pila,&comparadorApilado);
	} 
	| CMP_IGUAL 
	{
		char comparadorApilado[8] = "BNE";
		poner_en_pila(&pila,&comparadorApilado);
	} 
	| CMP_DISTINTO	
	{
		char comparadorApilado[8] = "BEQ";
		poner_en_pila(&pila,&comparadorApilado);
	} ;

expresion:
	termino	{	indiceExpresion = indiceTermino;	}
	| expresion OP_SUM termino
	{
		indiceExpresion = crearTerceto("+",armarIndiceI(indiceExpresion),armarIndiceD(indiceTermino));
	}
	| expresion OP_RES termino	
	{
		indiceExpresion = crearTerceto("-",armarIndiceI(indiceExpresion),armarIndiceD(indiceTermino));
	};

termino:
	factor	{	indiceTermino = indiceFactor;	}
	| termino OP_MUL factor		
	{
		indiceTermino = crearTerceto("*",armarIndiceI(indiceTermino),armarIndiceD(indiceFactor));
	}
	| termino OP_DIV factor		
	{
		indiceTermino = crearTerceto("/",armarIndiceI(indiceTermino),armarIndiceD(indiceFactor));
	}	;

factor:
	ID					{	indiceFactor = crearTerceto(yylval.str_val,"_","_");	}
	| CONST_INT			{	indiceFactor = crearTerceto(yylval.str_val,"_","_");}
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

char * negarComparador(char* comparador)
{
	if(strcmp(comparador,"BLE") == 0)
		return "BGT";
	if(strcmp(comparador,"BGE") == 0)
		return "BLT";
	if(strcmp(comparador,"BLT") == 0)
		return "BGE";
	if(strcmp(comparador,"BGT") == 0)
		return "BLE";
	if(strcmp(comparador,"BNE") == 0)
		return "BEQ";
	if(strcmp(comparador,"BEQ") == 0)
		return "BNE";
	return NULL;
}

char * obtenerNuevoNombreEtiqueta()
{
	static char nombreEtiqueta[30];
	sprintf(nombreEtiqueta, "ETIQ%d", incremento_etiqueta);
	incremento_etiqueta++;
	return nombreEtiqueta;
}