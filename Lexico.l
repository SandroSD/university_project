%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "y.tab.h"
    #define COTA_INT 2147483647
    #define COTA_FLOAT 3.402823E+38
    #define OK 1
    #define ERROR 0

    int yyerror(char *msg);

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
    int puntero_array = 0;
%}

%option noyywrap
%option yylineno

DIGITO			[0-9]
LETRA			[a-zA-Z]
ID			    {LETRA}({LETRA}|{DIGITO}|_)*
CONST_INT		"-"?({DIGITO})+
CONST_REAL		"-"?({DIGITO})+"."({DIGITO})*|({DIGITO})*"."({DIGITO})+
CONST_STR      	\"([^"]|\\.)*\"
COMENTARIO		\*\/.*\/\*

%%
DEFVAR      			{	return DEFVAR;	}
ENDDEF      			{	return ENDDEF;	}
int|INT|INTEGER			{	return INTEGER; }
float|FLOAT    			{	return REAL;	}
string|STRING  			{	return STRING;	}
if|IF          			{	return IF;		}
then|THEN          		{	return THEN;	}
else|ELSE     			{	return ELSE;	}
endif|ENDIF     		{	return ENDIF;	}
while|WHILE 			{	return WHILE;	}
in|IN 			        {	return IN;	}
do|DO                   {	return DO;	}
endwhile|ENDWHILE       {	return ENDWHILE;	}
and|AND					    {	return OP_AND;	}
"&&"					{	return OP_AND;	}
or|OR					    {	return OP_OR;	}
"||"					{	return OP_OR;	}
display|DISPLAY 		{	return DISPLAY;	}
get|GET    			    {	return GET;	}
":="        			{	return OP_ASIG;	}
"+"         			{	return OP_SUM;	}
"-"         			{	return OP_RES;	}
"/"         			{	return OP_DIV;	}
"*"         			{	return OP_MUL;	}
":"         			{	return OP_DOSP;	}
","         			{	return CAR_COMA;}
";"         			{	return CAR_PYC;	}
"("         			{	return CAR_PA;	}
")"         			{	return CAR_PC;	}
"["  					{	return CAR_CA;	}
"]"						{	return CAR_CC;	}
"{"         			{	return CAR_LA;	}
"}"         			{	return CAR_LC;	}
">"         			{	return CMP_MAYOR;	}
"<"         			{	return CMP_MENOR;	}
">="        			{	return CMP_MAYORIGUAL;	}
"<="        			{	return CMP_MENORIGUAL;	}
"!="        			{	return CMP_DISTINTO;	}
"=="        			{	return CMP_IGUAL;	}
{CONST_INT}    			{   
                            int num = atoi(yytext); 
                            if(num >= COTA_INT*(-1) && num <= COTA_INT){
                                push_TS("CONST_INT", yytext);
                                return CONST_INT; 
                            } else {
                                char msg[300];
                                sprintf(msg, "ERROR Lexico - Constante entera \'%d\' fuera de rango. Debe estar entre [-+ %d]", num, COTA_INT);
								yyerror(msg);
                            }
						}
{CONST_REAL}      		{
                            double n;
				            n = atof(yytext);
				            if(n >= COTA_FLOAT*(-1) && n <= COTA_FLOAT){
					            push_TS("CONST_REAL", yytext);
					            return CONST_REAL; 
				            } else {
                                char msg[300];
                                sprintf(msg, "ERROR Lexico - Constante real \'%f\' fuera de rango. Debe estar entre [-+ %f]", n, COTA_FLOAT);
								yyerror(msg);
				            }
						}
{CONST_STR}    			{	int cantCaracteres = strlen(yytext);
					        if(cantCaracteres <= 32) { // Se cuentan las comillas tambien
						        push_TS("CONST_STR", yytext);
						        return CONST_STR;
					        } else {
                                char msg[300];
                                sprintf(msg, "ERROR Lexico - Constante string \'%s\' demasiado larga. Maximo de 30 caracteres y contiene: %d", yytext, cantCaracteres-2);
                                yyerror(msg);
					        }
						}
{ID}        			{	int cantCaracteres = strlen(yytext);
					        if(cantCaracteres <= 20) {
						        push_TS("ID", yytext); 
						        return ID; 
					        } else {
                                char msg[300];
                                sprintf(msg, "ERROR Lexico - ID: \'%s\' demasiado largo. Maximo de 20 caracteres y contiene: %d", yytext, cantCaracteres);
								yyerror(msg);
					        }	
                        }
{COMENTARIO} 			{ }
"\n"					{ }
"\r\n"					{ }
"\t"					{ }
" "						{ }
.						{	
							char msg[300];
							sprintf(msg, "ERROR Lexico - Caracter \'%s\' invalido", yytext);
							yyerror(msg);	
						}

%%

int crear_TS()
{
	FILE *archivo; 
	int i;
	archivo = fopen("ts.txt","w"); 

	if (!archivo){	return ERROR; }

	fprintf(archivo, "Nombre                        Tipo      Valor     Longitud\n");
	
	for (i = 0; i < puntero_array; i++)
	{
		if (strcmp(tablaSimbolos[i].tipo, "ID") == 0 )
		{  
			fprintf(archivo,"%-30s%-10s\n", tablaSimbolos[i].nombre, tablaSimbolos[i].tipo);
		}
		else
		{
			fprintf(archivo,"_%-29s%-10s\n", tablaSimbolos[i].nombre, tablaSimbolos[i].tipo);
		}
	}
	fclose(archivo); 

	return OK;
}

int push_TS(char* tipo, char* nombre)
{
	int i, posicion;
	
	for(i = 0; i < puntero_array; i++)
	{
		if(strcmp(tablaSimbolos[i].nombre, nombre) == 0)
		{
			return i;
		}
	}
	strcpy(tablaSimbolos[puntero_array].tipo, tipo);
	strcpy(tablaSimbolos[puntero_array].nombre, nombre);
	posicion = puntero_array;
	puntero_array++;
	return posicion;
}