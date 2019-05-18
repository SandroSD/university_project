#ifndef TS_H
#define TS_H

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define TODO_OK 1
#define ERROR 0

// TABLA DE SIMBOLOS
struct struct_tablaSimbolos
{
    char nombre[100];
    char tipo[100];
    char valor[100];
    char longitud[100];
};
struct struct_tablaSimbolos tablaSimbolos[10000];

int crear_TS();
int push_TS(char *, char *);
int crearArchivoTS2();
int insertar_TS(char *, char *);
char *recuperarTipoTS(char *);
int crearArchivoTS();
void debugTS();
char *recuperarValorTS(char *);

#endif