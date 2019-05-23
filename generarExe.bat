c:\GnuWin32\bin\flex Lexico.l
pause
c:\GnuWin32\bin\bison -dyv Sintactico.y
pause
c:\MinGW\bin\gcc.exe lex.yy.c y.tab.c c_files\ts.c c_files\tercetos.c c_files\pila.c -o Primera.exe
pause
pause
Primera.exe prueba_WHILE.txt
del lex.yy.c
del y.tab.c
del y.output
del y.tab.h
del Primera.exe
pause
