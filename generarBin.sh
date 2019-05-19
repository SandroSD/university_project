#!/bin/bash
flex Lexico.l
bison -dyv Sintactico.y
gcc lex.yy.c y.tab.c ts.c tercetos.c pila.c -o Primera.bin
./Primera.bin prueba.txt
rm Primera.bin lex.yy.c y.tab.c y.tab.h y.output
