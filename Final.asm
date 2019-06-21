;
;ARCHIVO FINAL.ASM
;

INCLUDE macros2.asm		 ;incluye macros
INCLUDE number.asm		 ;incluye el asm para impresion de numeros

.MODEL LARGE ; tipo del modelo de memoria usado.
.386
.STACK 200h ; bytes en el stack
	
.DATA ; comienzo de la zona de datos.
	TRUE equ 1
	FALSE equ 0
	MAXTEXTSIZE equ 32
	1 dd 1
	15 dd 15
	99.99 dd 99.99
	.99 dd .99
	99. dd 99.
	-542.43 dd -542.43
	"" db "", '$', 32 dup(?)
	2 dd 2
	7 dd 7
	5 dd 5
	3 dd 3
	6 dd 6
	20 dd 20
	4 dd 4
	16 dd 16
	30 dd 30
	60 dd 60
	32 dd 32
	"ewr" db "ewr", '$', 32 dup(?)
	"@%asdr" db "@%asdr", '$', 32 dup(?)
	"@% > = FA <asdr" db "@% > = FA <asdr", '$', 32 dup(?)

TERMINAR: ;Fin de ejecución.
	mov ax, 4C00h ;termina la ejecución.
	int 21h ;syscall

END START ;final del archivo.