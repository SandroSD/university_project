%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"
    #include "h_files/constantes.h"
    #include "h_files/ts.h"

    // Funciones que no es necesario incluirlas (Ya que se importa desde y.tab.h). 
    // Se declaran unicamente para evitar warning [-Wimplicit-function-declaration] al complilar.
    int yyerror(char *msg);
%}

%option noyywrap
%option yylineno

DIGITO			        [0-9]
LETRA			        [a-zA-Z]
ID			            {LETRA}({LETRA}|{DIGITO}|_)*
CONST_INT		        "-"?({DIGITO})+
CONST_REAL		        "-"?({DIGITO})+"."({DIGITO})*|({DIGITO})*"."({DIGITO})+
CONST_STR      	        \"([^"]|\\.)*\"
COMENTARIO              "*/"([^*/]|\n)*?"/*"
COMENTARIO_ANIDADO      "*/"([^*/]|\n|{COMENTARIO})*?"/*"

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
in|IN 			        {	return IN;	    }
do|DO                   {	return DO;	    }
endwhile|ENDWHILE       {	return ENDWHILE;	}
and|AND					{	return OP_AND;	}
"&&"					{	return OP_AND;	}
or|OR					{	return OP_OR;	}
"||"					{	return OP_OR;	}
not|NOT                 {	return OP_NOT;	}
display|DISPLAY 		{	return DISPLAY;	}
get|GET    			    {	return GET;	    }
long|LONG  			    {	return LONG;    }
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
							yylval.str_val = strdup(yytext);
                            int num = atoi(yylval.str_val); 
                            if(num >= COTA_INT*(-1) && num <= COTA_INT){
                                insertarTokenEnTS("CONST_INT", yylval.str_val);
                                return CONST_INT; 
                            } else {
                                char msg[300];
                                sprintf(msg, "ERROR Lexico - Constante entera \'%d\' fuera de rango. Debe estar entre [-+ %d]", num, COTA_INT);
								yyerror(msg);
                            }
						}
{CONST_REAL}      		{
							yylval.str_val = strdup(yytext);
                            double n = atof(yylval.str_val);
				            if(n >= COTA_FLOAT*(-1) && n <= COTA_FLOAT){
					            insertarTokenEnTS("CONST_REAL", yylval.str_val);
					            return CONST_REAL; 
				            } else {
                                char msg[300];
                                sprintf(msg, "ERROR Lexico - Constante real \'%f\' fuera de rango. Debe estar entre [-+ %f]", n, COTA_FLOAT);
								yyerror(msg);
				            }
						}
{CONST_STR}    			{	
							yylval.str_val = strdup(yytext);
							int cantCaracteres = strlen(yylval.str_val);
					        if(cantCaracteres <= COTA_STR) { // Se cuentan las comillas tambien
						        insertarTokenEnTS("CONST_STR", yylval.str_val);
						        return CONST_STR;
					        } else {
                                char msg[300];
                                sprintf(msg, "ERROR Lexico - Constante string \'%s\' demasiado larga. Maximo de 30 caracteres y contiene: %d", yytext, cantCaracteres-2);
                                yyerror(msg);
					        }
						}
{ID}        			{	yylval.str_val = strdup(yytext);
							int cantCaracteres = strlen(yylval.str_val);
					        if(cantCaracteres <= COTA_ID) {
						        return ID; 
					        } else {
                                char msg[300];
                                sprintf(msg, "ERROR Lexico - ID: \'%s\' demasiado largo. Maximo de 20 caracteres y contiene: %d", yytext, cantCaracteres);
								yyerror(msg);
					        }	
                        }
{COMENTARIO} 			{ }
{COMENTARIO_ANIDADO}	{ }
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
