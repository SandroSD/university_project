#!/bin/bash
flex Lexico.l
bison -dyv Sintactico.y
gcc lex.yy.c y.tab.c ts.c tercetos.c -o Primera.bin
./Primera.bin prueba_mi.txt
rm Primera.bin lex.yy.c y.tab.c y.tab.h y.output
