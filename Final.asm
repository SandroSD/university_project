
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
	_auxLong dd 0
	&cte14 dd 4
	&cte15 dd 16
	&cte16 dd 30
	&cte17 dd 60
	&cte18 dd 32
	&cte19 db "HOLA", '$', 26 dup(?)
	&cte20 db "hello", '$', 25 dup(?)
	&cte21 db "mundo", '$', 25 dup(?)
	&cte22 db "world", '$', 25 dup(?)
	@aux1 dd 0.0
	@aux2 dd 0.0
	@aux3 dd 0.0
	@aux4 dd 0.0
	@aux5 dd 0.0
	@aux6 dd 0.0
	@aux7 dd 0.0
	@aux8 dd 0.0
	@aux9 dd 0.0
	@aux10 dd 0.0
	@aux11 dd 0.0
	@aux12 dd 0.0
	@aux13 dd 0.0
	@aux14 dd 0.0
	@aux15 dd 0.0
	@aux16 dd 0.0
	@aux17 dd 0.0
	@aux18 dd 0.0
	@aux19 dd 0.0
	@aux20 dd 0.0
	@aux21 dd 0.0
	@aux22 dd 0.0
	@aux23 dd 0.0
	@aux24 dd 0.0
	@aux25 dd 0.0
	@aux26 dd 0.0
	@aux27 dd 0.0
	@aux28 dd 0.0
	@aux29 dd 0.0
	@aux30 dd 0.0
	@aux31 dd 0.0
	@aux32 dd 0.0
	@aux34 dd 0.0
	@aux35 dd 0.0
	@aux36 dd 0.0
	@aux37 dd 0.0
	@aux39 dd 0.0
	@aux40 dd 0.0
	@aux41 dd 0.0
	@aux42 dd 0.0
	@aux43 dd 0.0
	@aux44 dd 0.0
	@aux47 dd 0.0
	@aux48 dd 0.0
	@aux49 dd 0.0
	@aux50 dd 0.0
	@aux51 dd 0.0
	@aux52 dd 0.0
	@aux53 dd 0.0
	@aux54 dd 0.0
	@aux55 dd 0.0
	@aux56 dd 0.0
	@aux57 dd 0.0
	@aux58 dd 0.0
	@aux59 dd 0.0
	@aux60 dd 0.0
	@aux61 dd 0.0
	@aux62 dd 0.0
	@aux64 dd 0.0
	@aux65 dd 0.0
	@aux66 dd 0.0
	@aux67 dd 0.0
	@aux68 dd 0.0
	@aux69 dd 0.0
	@aux71 dd 0.0
	@aux72 dd 0.0
	@aux73 dd 0.0
	@aux74 dd 0.0
	@aux75 dd 0.0
	@aux76 dd 0.0
	@aux77 dd 0.0
	@aux78 dd 0.0
	@aux79 dd 0.0
	@aux80 dd 0.0
	@aux81 dd 0.0
	@aux82 dd 0.0
	@aux83 dd 0.0
	@aux84 dd 0.0
	@aux85 dd 0.0
	@aux86 dd 0.0
	@aux87 dd 0.0
	@aux88 dd 0.0
	@aux89 dd 0.0
	@aux90 dd 0.0
	@aux91 dd 0.0
	@aux92 dd 0.0
	@aux93 dd 0.0
	@aux94 dd 0.0
	@aux95 dd 0.0
	@aux96 dd 0.0
	@aux97 dd 0.0
	@aux98 dd 0.0
	@aux99 dd 0.0
	@aux100 dd 0.0
	@aux101 dd 0.0
	@aux102 dd 0.0
	@aux103 dd 0.0
	@aux104 dd 0.0
	@aux105 dd 0.0
	@aux106 dd 0.0
	@aux107 dd 0.0
	@aux108 dd 0.0
	@aux109 dd 0.0
	@aux110 dd 0.0
	@aux112 dd 0.0
	@aux113 dd 0.0
	@aux114 dd 0.0
	@aux115 dd 0.0
	@aux116 dd 0.0
	@aux117 dd 0.0
	@aux118 dd 0.0
	@aux119 dd 0.0
	@aux121 dd 0.0
	@aux122 dd 0.0
	@aux123 dd 0.0
	@aux126 dd 0.0
	@aux127 dd 0.0
	@aux128 dd 0.0
	@aux129 dd 0.0
	@aux130 dd 0.0
	@aux131 dd 0.0
	@aux132 dd 0.0
	@aux133 dd 0.0
	@aux135 dd 0.0
	@aux136 dd 0.0
	@aux137 dd 0.0
	@aux140 dd 0.0
	@aux141 dd 0.0
	@aux142 dd 0.0
	@aux143 dd 0.0
	@aux144 dd 0.0
	@aux145 dd 0.0
	@aux146 dd 0.0
	@aux147 dd 0.0
	@aux149 dd 0.0
	@aux150 dd 0.0
	@aux151 dd 0.0
	@aux154 dd 0.0
	@aux155 dd 0.0
	@aux156 dd 0.0
	@aux157 dd 0.0
	@aux159 dd 0.0
	@aux160 dd 0.0
	@aux161 dd 0.0
	@aux162 dd 0.0
	@aux164 dd 0.0
	@aux165 dd 0.0
	@aux166 dd 0.0
	@aux169 dd 0.0
	@aux170 dd 0.0
	@aux171 dd 0.0
	@aux172 dd 0.0
	@aux174 dd 0.0
	@aux175 dd 0.0
	@aux176 dd 0.0
	@aux177 dd 0.0
	@aux179 dd 0.0
	@aux180 dd 0.0
	@aux181 dd 0.0
	@aux184 dd 0.0
	@aux185 dd 0.0
	@aux186 dd 0.0
	@aux187 dd 0.0
	@aux189 dd 0.0
	@aux190 dd 0.0
	@aux191 dd 0.0
	@aux192 dd 0.0
	@aux194 dd 0.0
	@aux195 dd 0.0
	@aux196 dd 0.0
	@aux199 dd 0.0
	@aux200 dd 0.0
	@aux201 dd 0.0
	@aux202 dd 0.0
	@aux204 dd 0.0
	@aux205 dd 0.0
	@aux206 dd 0.0
	@aux209 dd 0.0
	@aux210 dd 0.0
	@aux211 dd 0.0
	@aux212 dd 0.0
	@aux214 dd 0.0
	@aux215 dd 0.0
	@aux216 dd 0.0
	@aux218 dd 0.0
	@aux219 dd 0.0
	@aux220 dd 0.0
	@aux221 dd 0.0
	@aux222 dd 0.0
	@aux223 dd 0.0
	@aux224 dd 0.0
	@aux225 dd 0.0
	@aux227 dd 0.0
	@aux228 dd 0.0
	@aux229 dd 0.0
	@aux231 dd 0.0
	@aux232 dd 0.0
	@aux233 dd 0.0
	@aux236 dd 0.0
	@aux237 dd 0.0
	@aux238 dd 0.0
	@aux239 dd 0.0
	@aux241 dd 0.0
	@aux242 dd 0.0
	@aux243 dd 0.0
	@aux244 dd 0.0
	@aux246 dd 0.0
	@aux247 dd 0.0
	@aux248 dd 0.0
	@aux251 dd 0.0
	@aux252 dd 0.0
	@aux253 dd 0.0
	@aux254 dd 0.0
	@aux255 dd 0.0
	@aux256 dd 0.0
	@aux257 dd 0.0
	@aux258 dd 0.0
	@aux260 dd 0.0
	@aux261 dd 0.0
	@aux262 dd 0.0
	@aux263 dd 0.0
	@aux265 dd 0.0
	@aux266 dd 0.0
	@aux267 dd 0.0
	@aux270 dd 0.0
	@aux271 dd 0.0
	@aux272 dd 0.0
	@aux273 dd 0.0
	@aux275 dd 0.0
	@aux276 dd 0.0
	@aux277 dd 0.0
	@aux278 dd 0.0
	@aux280 dd 0.0
	@aux281 dd 0.0
	@aux282 dd 0.0
	@aux283 dd 0.0
	@aux285 dd 0.0
	@aux286 dd 0.0
	@aux287 dd 0.0
	@aux289 dd 0.0
	@aux290 dd 0.0
	@aux291 dd 0.0
	@aux292 dd 0.0
	@aux293 dd 0.0
	@aux294 dd 0.0
	@aux295 dd 0.0
	@aux296 dd 0.0
	@aux297 dd 0.0
	@aux298 dd 0.0
	@aux299 dd 0.0
	@aux300 dd 0.0
	@aux301 dd 0.0
	@aux302 dd 0.0
	@aux303 dd 0.0
	@aux304 dd 0.0

.CODE ;Comienzo de la zona de codigo

;************************************************************
; devuelve en BX la cantidad de caracteres que tiene un string
; DS:SI apunta al string.
;************************************************************
STRLEN PROC
    mov bx,0

STRL01:
    cmp BYTE PTR [SI+BX],'$'
    je STREND
    inc BX
    jmp STRL01
STREND:
    ret

STRLEN ENDP

;************************************************************
; copia DS:SI a ES:DI; busca la cantidad de caracteres
;************************************************************
COPIAR PROC
    call STRLEN    ; busco la cantidad de caracteres
    cmp bx,MAXTEXTSIZE
    jle COPIARSIZEOK

    mov bx,MAXTEXTSIZE

COPIARSIZEOK:
    mov cx,bx
    cld

    rep movsb
    mov al,'$'
    mov BYTE PTR [DI],al

    ret
COPIAR ENDP

;************************************************************
; concatena DS:SI al final de ES:DI.
;
; busco el size del primer string
; sumo el size del segundo string
; si la suma excede MAXTEXTSIZE, copio solamente MAXTEXTSIZE caracteres
; si la suma NO excede MAXTEXTSIZE, copio el total de caracteres que tiene el segundo string
;************************************************************
CONCAT PROC
    push ds
    push si
    
    call STRLEN ; busco la cantidad de caracteres del 2do string

    mov dx,bx  ; guardo en DX la cantidad de caracteres en el origen.
    mov si,di
    push es
    pop ds

    call STRLEN ; tamaño del 1er string
        
    add di,bx ; DI ya queda apuntando al final del primer string    
    add bx,dx ; tamaño total

    cmp bx,MAXTEXTSIZE
    jg CONCATSIZEMAL

CONCATSIZEOK:
        mov cx,dx
        jmp CONCATSIGO

CONCATSIZEMAL:
        sub bx,MAXTEXTSIZE
        sub dx,bx
        mov cx,dx

CONCATSIGO:
        push ds
        pop es
        pop si
        pop ds
        cld ; cld es para que la copia se realice hacia adelante
        
        rep movsb ; copia la cadena
        mov al,'$' ; carácter terminador
        mov BYTE PTR [DI],al ; el registro DI quedo apuntando al final

        ret ;return
CONCAT ENDP

START: 		;Código assembler resultante de compilar el programa fuente.
	mov AX,@DATA 		;Inicializa el segmento de datos
	mov DS,AX
	finit



ETIQ_inicio_0:
	;ASIGNACIÓN
	fld b
	fstp a

	;ASIGNACIÓN
	fld d
	fstp c

	;ASIGNACIÓN
	fld &cte1
	fstp i

	;ASIGNACIÓN
	fld &cte2
	fstp a

	;ASIGNACIÓN
	fld &cte3
	fstp n

	;ASIGNACIÓN
	fld &cte4
	fstp n

	;ASIGNACIÓN
	fld &cte5
	fstp n

	;ASIGNACIÓN
	fld &cte6
	fstp n

	;ASIGNACIÓN
	mov ax,@DATA
	mov es,ax
	mov si,OFFSET &cte7 ;apunta el origen al auxiliar
	mov di,OFFSET s ;apunta el destino a la cadena
	call COPIAR ;copia los string

	;MULTIPLICACION
	fld &cte1
	fld &cte8
	fmul
	fstp @aux30

	;ASIGNACIÓN
	fld @aux30
	fstp c



ETIQ_inicio_while_33:
	;CMP
	fld a
	fld &cte9
	fcomp
	fstsw ax
	fwait
	sahf

	jb ETIQ_fin_while_45


ETIQ_inicio_38:
	;SUMA
	fld &cte10
	fld b
	fadd
	fstp @aux41

	;ASIGNACIÓN
	fld @aux41
	fstp i

	jmp ETIQ_inicio_while_33


ETIQ_fin_while_45:


ETIQ_inicio_while_46:
	;SUMA
	fld a
	fld &cte1
	fadd
	fstp @aux50

	;CMP
	fld a
	fld @aux50
	fcomp
	fstsw ax
	fwait
	sahf

	jne ETIQ_inicio_63
	;SUMA
	fld c
	fld &cte8
	fadd
	fstp @aux55

	;CMP
	fld c
	fld @aux55
	fcomp
	fstsw ax
	fwait
	sahf

	jne ETIQ_inicio_63
	;DIVISION
	fld b
	fld &cte1
	fdiv
	fstp @aux60

	;CMP
	fld b
	fld @aux60
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_fin_while_especial_70


ETIQ_inicio_63:
	;SUMA
	fld &cte10
	fld b
	fadd
	fstp @aux66

	;ASIGNACIÓN
	fld @aux66
	fstp i

	jmp ETIQ_inicio_while_46


ETIQ_fin_while_especial_70:
	;ASIGNACIÓN
	fld _auxLong
	fstp &cte1

	;SUMA
	fld _auxLong
	fld &cte1
	fadd
	fstp @aux76

	;ASIGNACIÓN
	fld @aux76
	fstp _auxLong

	;SUMA
	fld _auxLong
	fld &cte1
	fadd
	fstp @aux81

	;ASIGNACIÓN
	fld @aux81
	fstp _auxLong

	;SUMA
	fld _auxLong
	fld &cte1
	fadd
	fstp @aux86

	;ASIGNACIÓN
	fld @aux86
	fstp _auxLong

	;SUMA
	fld _auxLong
	fld &cte1
	fadd
	fstp @aux91

	;ASIGNACIÓN
	fld @aux91
	fstp _auxLong

	;SUMA
	fld _auxLong
	fld &cte1
	fadd
	fstp @aux96

	;ASIGNACIÓN
	fld @aux96
	fstp _auxLong

	;SUMA
	fld _auxLong
	fld &cte1
	fadd
	fstp @aux101

	;ASIGNACIÓN
	fld @aux101
	fstp _auxLong

	;SUMA
	fld _auxLong
	fld &cte1
	fadd
	fstp @aux106

	;ASIGNACIÓN
	fld @aux106
	fstp _auxLong

	;ASIGNACIÓN
	fld @aux106
	fstp a



ETIQ_inicio_111:
	;CMP
	fld i
	fld &cte2
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_fin_seleccion_124
	;CMP
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_fin_seleccion_124


ETIQ_inicio_120:
	;ASIGNACIÓN
	fld &cte15
	fstp i



ETIQ_fin_seleccion_124:


ETIQ_inicio_125:
	;CMP
	fld i
	fld &cte2
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_fin_seleccion_138
	;CMP
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_fin_seleccion_138


ETIQ_inicio_134:
	;ASIGNACIÓN
	fld &cte15
	fstp i



ETIQ_fin_seleccion_138:


ETIQ_inicio_139:
	;CMP
	fld i
	fld &cte2
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_fin_seleccion_152
	;CMP
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_fin_seleccion_152


ETIQ_inicio_148:
	;ASIGNACIÓN
	fld &cte15
	fstp i



ETIQ_fin_seleccion_152:


ETIQ_inicio_153:
	;CMP
	fld i
	fld &cte2
	fcomp
	fstsw ax
	fwait
	sahf

	jne ETIQ_inicio_163


ETIQ_inicio_158:
	;CMP
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_fin_seleccion_167


ETIQ_inicio_163:
	;ASIGNACIÓN
	fld &cte15
	fstp i



ETIQ_fin_seleccion_167:


ETIQ_inicio_168:
	;CMP
	fld i
	fld &cte2
	fcomp
	fstsw ax
	fwait
	sahf

	jne ETIQ_inicio_178


ETIQ_inicio_173:
	;CMP
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_fin_seleccion_182


ETIQ_inicio_178:
	;ASIGNACIÓN
	fld &cte15
	fstp i



ETIQ_fin_seleccion_182:


ETIQ_inicio_183:
	;CMP
	fld i
	fld &cte2
	fcomp
	fstsw ax
	fwait
	sahf

	jne ETIQ_inicio_193


ETIQ_inicio_188:
	;CMP
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_fin_seleccion_197


ETIQ_inicio_193:
	;ASIGNACIÓN
	fld &cte15
	fstp i



ETIQ_fin_seleccion_197:


ETIQ_inicio_198:
	;CMP
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_fin_seleccion_207


ETIQ_inicio_203:
	;ASIGNACIÓN
	fld &cte15
	fstp i



ETIQ_fin_seleccion_207:


ETIQ_inicio_208:
	;CMP
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	jne ETIQ_fin_seleccion_217


ETIQ_inicio_213:
	;ASIGNACIÓN
	fld &cte15
	fstp i



ETIQ_fin_seleccion_217:
	;ASIGNACIÓN
	fld _auxLong
	fstp &cte1

	;SUMA
	fld _auxLong
	fld &cte1
	fadd
	fstp @aux223

	;ASIGNACIÓN
	fld @aux223
	fstp _auxLong



ETIQ_inicio_226:
	;CMP
	fld @aux223
	fld &cte8
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_fin_seleccion_234


ETIQ_inicio_230:
	;ASIGNACIÓN
	fld &cte15
	fstp i



ETIQ_fin_seleccion_234:


ETIQ_inicio_235:
	;CMP
	fld a
	fld &cte8
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_inicio_245


ETIQ_inicio_240:
	;ASIGNACIÓN
	fld &cte15
	fstp i

	jmp ETIQ_fin_seleccion_249


ETIQ_inicio_245:
	;ASIGNACIÓN
	fld &cte18
	fstp i



ETIQ_fin_seleccion_249:


ETIQ_inicio_250:
	;CMP
	fld a
	fld &cte8
	fcomp
	fstsw ax
	fwait
	sahf

	ja ETIQ_inicio_264
	;CMP
	fld b
	fld &cte1
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_inicio_264


ETIQ_inicio_259:
	;ASIGNACIÓN
	fld &cte15
	fstp i

	jmp ETIQ_fin_seleccion_268


ETIQ_inicio_264:
	;ASIGNACIÓN
	fld &cte18
	fstp i



ETIQ_fin_seleccion_268:


ETIQ_inicio_269:
	;CMP
	fld a
	fld &cte8
	fcomp
	fstsw ax
	fwait
	sahf

	jbe ETIQ_inicio_279


ETIQ_inicio_274:
	;CMP
	fld b
	fld &cte1
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQ_inicio_284


ETIQ_inicio_279:
	;ASIGNACIÓN
	fld &cte15
	fstp i

	jmp ETIQ_fin_seleccion_288


ETIQ_inicio_284:
	;ASIGNACIÓN
	fld &cte18
	fstp i



ETIQ_fin_seleccion_288:
	;GET
	DisplayFloat n 2
	newLine 1

	;DISPLAY
	GetFloat b

	;DISPLAY
	getString &cte19

	;DISPLAY
	getString &cte20

	;GET
	DisplayFloat n 2
	newLine 1

	;DISPLAY
	GetFloat i

	;DISPLAY
	getString &cte21

	;DISPLAY
	getString &cte22


TERMINAR: ;Fin de ejecución.
	mov ax, 4C00h ;termina la ejecución.
	int 21h ;syscall

END START ;final del archivo.