#ifndef TERCETO_H
#define TERCETO_H

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "constantes.h"

#define TERC_ASIG -1
#define TERC_SUMA -2
#define TERC_RESTA -3
#define TERC_MULT -4
#define TERC_DIV -5
#define TERC_MENOR -6
#define TERC_MENOR_IGUAL -7
#define TERC_IGUAL -8
#define TERC_MAYOR -9
#define TERC_MAYOR_IGUAL -10
#define TERC_DISTINTO -11
#define TERC_CONCAT -12
#define TERC_WRITE -13
#define TERC_READ -14
#define TERC_FIN -15

#define TERC_JMP -16
#define TERC_JE -17
#define TERC_JNE -18
#define TERC_JB -19
#define TERC_JBE -20
#define TERC_JA -21
#define TERC_JAE -22
#define TERC_ETIQ -23

#define TERC_IGUAL_STRING -24
#define TERC_DISTINTO_STRING -25

#define TERC_MU -26

#define TERC_AND -27
#define TERC_OR -28
#define TERC_CMP -29

#define TERC_AVG -30
#define TERC_FACT -31
#define TERC_NROCOMB -32

#define TERC_END -33

#define TERC_NULL -1
#define NO_MODIF -1
#define NEGAR -99

// Variable para debug
#define DEBUG 0

typedef struct
{
    int operacion;
    int opIzq;
    int opDer;
} terceto_t;
typedef struct s_node
{
    terceto_t info;
    struct s_node *sig, *ant;
} t_node;

typedef t_node *lista_tercetos_t;

struct struct_Terceto
{
    char operador[100];
    char operandoIzq[100];
    char operandoDer[100];
};
struct struct_Terceto tercetos[10000];
typedef lista_tercetos_t *listaTercetos;

int crearTerceto(char*, char*, char*);
// int CrearTerceto(int, int, int, lista_tercetos_t *);
// int InsertarEnLT(lista_tercetos_t *, terceto_t *);
// void VaciarLT(lista_tercetos_t *);
// void ObtenerItemLT(lista_tercetos_t *, int, terceto_t *);
// int BuscarPosLT(lista_tercetos_t *, terceto_t *);
void ModificarTerceto(int, int, int, lista_tercetos_t *, int);
int insertarEnLT(lista_tercetos_t *p, struct_Terceto *d);
// void NegarOperadorTerceto(int, lista_tercetos_t *);
int NegarOperador(int);
void DumpLista(lista_tercetos_t *);
int NumeroUltimoTerceto();
// void EliminarUltimoTerceto(lista_tercetos_t *);
// int informeError(char *error);

int crearArchivoTercetosIntermedia();

#endif