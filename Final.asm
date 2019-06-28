
INCLUDE macros2.asm		 ;incluye macros
INCLUDE number.asm		 ;incluye el asm para impresion de numeros

.MODEL LARGE		 ; tipo del modelo de memoria usado.
.386
.387
.STACK 200h		 ; bytes en el stack
	
.DATA		 ; comienzo de la zona de datos.
	TRUE equ 1
	FALSE equ 0
	MAXTEXTSIZE equ 32
	n dd 0.0
	a dd 0
	b dd 0
	d dd 0
	i dd 0
	c dd 0
	cadena db MAXTEXTSIZE dup(?), '$'
	s db MAXTEXTSIZE dup(?), '$'
	&cte1 dd 1
	&cte2 dd 15
	&cte3 dd 99.99
	&cte4 dd .99
	&cte5 dd 99.
	&cte6 dd -542.43
	&cte7 db "", '$', 30 dup(?)
	&cte8 dd 2
	&cte9 dd 7
	&cte10 dd 5
	&cte11 dd 3
	&cte12 dd 6
	&cte13 dd 20
	&cte14 dd 4
	&cte15 dd 16
	&cte16 dd 30
	&cte17 dd 60
	&cte18 dd 32
	&cte19 db "HOLA", '$', 26 dup(?)
	&cte20 db "hola", '$', 26 dup(?)
	&cte21 db "mundo", '$', 25 dup(?)
	&cte22 db "hola mundo", '$', 20 dup(?)

.CODE ;Comienzo de la zona de codigo
START: 		;Código assembler resultante de compilar el programa fuente.
	mov AX,@DATA 		;Inicializa el segmento de datos
	mov DS,AX
	finit

	;ASIGNACIÓN
	;ASIGNACIÓN
	;ASIGNACIÓN
	;ASIGNACIÓN
	;ASIGNACIÓN
	;ASIGNACIÓN
	;ASIGNACIÓN
	;ASIGNACIÓN
	;ASIGNACIÓN
	;MULTIPLICACION
	;ASIGNACIÓN
	;CMP
	;SUMA
	;ASIGNACIÓN
	;SUMA
	;CMP
	;SUMA
	;CMP
	;DIVISION
	;CMP
	;SUMA
	;ASIGNACIÓN
	;ASIGNACIÓN
	;SUMA
	;ASIGNACIÓN
	;SUMA
	;ASIGNACIÓN
	;SUMA
	;ASIGNACIÓN
	;SUMA
	;ASIGNACIÓN
	;SUMA
	;ASIGNACIÓN
	;SUMA
	;ASIGNACIÓN
	;SUMA
	;ASIGNACIÓN
	;ASIGNACIÓN
	;CMP
	;CMP
	;ASIGNACIÓN
	;CMP
	;CMP
	;ASIGNACIÓN
	;CMP
	;CMP
	;ASIGNACIÓN
	;CMP
	;CMP
	;ASIGNACIÓN
	;CMP
	;CMP
	;ASIGNACIÓN
	;CMP
	;CMP
	;ASIGNACIÓN
	;CMP
	;ASIGNACIÓN
	;CMP
	;ASIGNACIÓN
	;ASIGNACIÓN
	;SUMA
	;ASIGNACIÓN
	;CMP
	;ASIGNACIÓN
	;CMP
	;ASIGNACIÓN
	;ASIGNACIÓN
	;CMP
	;CMP
	;ASIGNACIÓN
	;ASIGNACIÓN
	;CMP
	;CMP
	;ASIGNACIÓN
	;ASIGNACIÓN
	;GET
	;DISPLAY
	;DISPLAY
	;DISPLAY
	;GET
	;DISPLAY
	;DISPLAY
	;DISPLAY

TERMINAR: ;Fin de ejecución.
	mov ax, 4C00h ;termina la ejecución.
	int 21h ;syscall

END START ;final del archivo.