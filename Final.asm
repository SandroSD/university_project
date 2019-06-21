;
;ARCHIVO FINAL.ASM
;

INCLUDE macros2.asm		 ;incluye macros
INCLUDE number.asm		 ;incluye el asm para impresion de numeros

.MODEL LARGE ; tipo del modelo de memoria usado.
.386
.STACK 200h ; bytes en el stack

TERMINAR: ;Fin de ejecución.
	mov ax, 4C00h ; termina la ejecución.
	int 21h; syscall

END START;final del archivo.