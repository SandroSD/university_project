#!/bin/bash
flex Lexico.l
bison -dyv Sintactico.y
gcc lex.yy.c y.tab.c c_files/ts.c c_files/tercetos.c c_files/pila.c -o Segunda.bin
./Segunda.bin prueba.txt
rm Segunda.bin lex.yy.c y.tab.c y.tab.h y.output
