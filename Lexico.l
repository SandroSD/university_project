%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <float.h>
    #include "y.tab.h"
%}

%option noyywrap
%option yylineno

DIGITO			[0-9]
LETRA			[a-zA-Z]
ID			    {LETRA}({LETRA}|{DIGITO}|_)*
REAL            -?{DIGITO}*["."]{DIGITO}+
ENTERO          -?{DIGITO}+
STRING         	\"([^"]|\\.)*\"
COMENTARIO		\*\/.*\/\*

%%
DEFVAR      			{	return DEFVAR;	}
ENDDEF      			{	return ENDDEF;	}
int|INT        			{	return INT;		}
float|FLOAT    			{	return FLOAT;	}
string|STRING  			{	return STRING;	}
if|IF          			{	return IF;		}
else|ELSE     			{	return ELSE;	}
while|WHILE    			{	return WHILE;	}
do|DO                   {	return DO;	}
endwhile|ENDWHILE       {	return ENDWHILE;	}
AND					    {	return AND;	}
OR					    {	return OR;	}
display|DISPLAY 		{	return WRITE;	}
get|GET    			    {	return READ;	}
":="        			{	return ASIG;	}
","         			{	return COMA;	}
":"         			{	return D_P;	}
";"         			{	return PUNTO_Y_COMA;	}
"("         			{	return P_A;	}
")"         			{	return P_C;	}
"["  					{	return C_A;	}
"]"						{	return C_C;	}
"{"         			{	return L_A;	}
"}"         			{	return L_C;	}
"+"         			{	return OP_SUM;	}
"-"         			{	return OP_RES;	}
"/"         			{	return OP_DIV;	}
"*"         			{	return OP_MUL;	}
">"         			{	return CMP_MAY;	}
"<"         			{	return CMP_MEN;	}
">="        			{	return CMP_MAYI;	}
"<="        			{	return CMP_MENI;	}
"!="        			{	return CMP_DIST;	}
"=="        			{	return CMP_IGUAL;	}
{ENTERO}    			{
							strcpy(yylval.str, yytext);
							int casteado = atoi(yytext);
							if(casteado < -32768 || casteado > 32767) {
								char msg[100];
								sprintf(msg, "ERROR Lexico - Entero \'%d\' fuera de rango. Debe estar entre [-32768; 32767]", casteado);
								yyerror(msg);
							}
                            guardar_en_ts();
							return ENTERO;
						}
{REAL}      			{
							strcpy(yylval.str, yytext);	
							double casteado = atof(yytext);
							if(casteado < -32768.000000 || casteado > FLT_MAX) {
								char msg[100];
								sprintf(msg, "ERROR Lexico - Float \'%f\' fuera de rango. Debe estar entre [-32768.000000; 3.40282e38]", casteado);
								yyerror(msg);
							}
                            guardar_en_ts();
							return REAL;
						}
{STRING}    			{	strcpy(yylval.str, yytext);
							int longitud = strlen(yytext);
							if(longitud > 32){
								char msg[150];
								sprintf(msg, "ERROR Lexico - Cadena \'%s\' demasiado larga. Maximo de 30 caracteres y contiene: %d", yytext, longitud-2);
								yyerror(msg);
							}
                            guardar_en_ts();
							return STRING_CONST;	
						}
{ID}        			{	strcpy(yylval.str, yytext);
                            guardar_en_ts();
							return ID;	}
{COMENTARIO} 			{	;	}
"\n"					{	;	}
"\r\n"					{	;	}
"\t"					{	;	}
" "						{	;	}
.						{	
							char msg[300];
							sprintf(msg, "ERROR Lexico - Caracter \'%s\' invalido", yytext);
							yyerror(msg);	
						}

%%