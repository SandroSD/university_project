
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
	@aux0 dd 0.0
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
	@aux33 dd 0.0
	@aux34 dd 0.0
	@aux35 dd 0.0
	@aux36 dd 0.0
	@aux37 dd 0.0
	@aux38 dd 0.0
	@aux39 dd 0.0
	@aux40 dd 0.0
	@aux41 dd 0.0
	@aux42 dd 0.0
	@aux43 dd 0.0
	@aux44 dd 0.0
	@aux45 dd 0.0
	@aux46 dd 0.0
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
	@aux63 dd 0.0
	@aux64 dd 0.0
	@aux65 dd 0.0
	@aux66 dd 0.0
	@aux67 dd 0.0
	@aux68 dd 0.0
	@aux69 dd 0.0
	@aux70 dd 0.0
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
	@aux111 dd 0.0
	@aux112 dd 0.0
	@aux113 dd 0.0
	@aux114 dd 0.0
	@aux115 dd 0.0
	@aux116 dd 0.0
	@aux117 dd 0.0
	@aux118 dd 0.0
	@aux119 dd 0.0
	@aux120 dd 0.0
	@aux121 dd 0.0
	@aux122 dd 0.0
	@aux123 dd 0.0
	@aux124 dd 0.0
	@aux125 dd 0.0
	@aux126 dd 0.0
	@aux127 dd 0.0
	@aux128 dd 0.0
	@aux129 dd 0.0
	@aux130 dd 0.0
	@aux131 dd 0.0
	@aux132 dd 0.0
	@aux133 dd 0.0
	@aux134 dd 0.0
	@aux135 dd 0.0
	@aux136 dd 0.0
	@aux137 dd 0.0
	@aux138 dd 0.0
	@aux139 dd 0.0
	@aux140 dd 0.0
	@aux141 dd 0.0
	@aux142 dd 0.0
	@aux143 dd 0.0
	@aux144 dd 0.0
	@aux145 dd 0.0
	@aux146 dd 0.0
	@aux147 dd 0.0
	@aux148 dd 0.0
	@aux149 dd 0.0
	@aux150 dd 0.0
	@aux151 dd 0.0
	@aux152 dd 0.0
	@aux153 dd 0.0
	@aux154 dd 0.0
	@aux155 dd 0.0
	@aux156 dd 0.0
	@aux157 dd 0.0
	@aux158 dd 0.0
	@aux159 dd 0.0
	@aux160 dd 0.0
	@aux161 dd 0.0
	@aux162 dd 0.0
	@aux163 dd 0.0
	@aux164 dd 0.0
	@aux165 dd 0.0
	@aux166 dd 0.0
	@aux167 dd 0.0
	@aux168 dd 0.0
	@aux169 dd 0.0
	@aux170 dd 0.0
	@aux171 dd 0.0
	@aux172 dd 0.0
	@aux173 dd 0.0
	@aux174 dd 0.0
	@aux175 dd 0.0
	@aux176 dd 0.0
	@aux177 dd 0.0
	@aux178 dd 0.0
	@aux179 dd 0.0
	@aux180 dd 0.0
	@aux181 dd 0.0
	@aux182 dd 0.0
	@aux183 dd 0.0
	@aux184 dd 0.0
	@aux185 dd 0.0
	@aux186 dd 0.0
	@aux187 dd 0.0
	@aux188 dd 0.0
	@aux189 dd 0.0
	@aux190 dd 0.0
	@aux191 dd 0.0
	@aux192 dd 0.0
	@aux193 dd 0.0
	@aux194 dd 0.0
	@aux195 dd 0.0
	@aux196 dd 0.0
	@aux197 dd 0.0
	@aux198 dd 0.0
	@aux199 dd 0.0
	@aux200 dd 0.0
	@aux201 dd 0.0
	@aux202 dd 0.0
	@aux203 dd 0.0
	@aux204 dd 0.0
	@aux205 dd 0.0
	@aux206 dd 0.0
	@aux207 dd 0.0
	@aux208 dd 0.0
	@aux209 dd 0.0
	@aux210 dd 0.0
	@aux211 dd 0.0
	@aux212 dd 0.0
	@aux213 dd 0.0
	@aux214 dd 0.0
	@aux215 dd 0.0
	@aux216 dd 0.0
	@aux217 dd 0.0
	@aux218 dd 0.0
	@aux219 dd 0.0
	@aux220 dd 0.0
	@aux221 dd 0.0
	@aux222 dd 0.0
	@aux223 dd 0.0
	@aux224 dd 0.0
	@aux225 dd 0.0
	@aux226 dd 0.0
	@aux227 dd 0.0
	@aux228 dd 0.0

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

	;ASIGNACIÓN
	ETIQUETA2:
	fld b
	fstp a

	;ASIGNACIÓN
	ETIQUETA5:
	fld d
	fstp c

	;ASIGNACIÓN
	ETIQUETA8:
	fld &cte1
	fstp i

	;ASIGNACIÓN
	ETIQUETA11:
	fld &cte2
	fstp a

	;ASIGNACIÓN
	ETIQUETA14:
	fld &cte3
	fstp n

	;ASIGNACIÓN
	ETIQUETA17:
	fld &cte4
	fstp n

	;ASIGNACIÓN
	ETIQUETA20:
	fld &cte5
	fstp n

	;ASIGNACIÓN
	ETIQUETA23:
	fld &cte6
	fstp n

	;ASIGNACIÓN
	ETIQUETA26:
	mov ax,@DATA
	mov es,ax
	mov si,OFFSET &cte7 ;apunta el origen al auxiliar
	mov di,OFFSET s ;apunta el destino a la cadena
	call COPIAR ;copia los string

	;MULTIPLICACION
	ETIQUETA29:
	fld &cte1
	fld &cte8
	fmul
	fstp @aux29

	;ASIGNACIÓN
	ETIQUETA31:
	fld @aux29
	fstp c

	;CMP
	ETIQUETA35:
	fld a
	fld &cte9
	fcomp
	fstsw ax
	fwait
	sahf

	jb ETIQUETA43
	;SUMA
	ETIQUETA39:
	fld &cte10
	fld b
	fadd
	fstp @aux39

	;ASIGNACIÓN
	ETIQUETA41:
	fld @aux39
	fstp i

	jmp ETIQUETA32
	;SUMA
	ETIQUETA47:
	fld a
	fld &cte1
	fadd
	fstp @aux47

	;CMP
	ETIQUETA48:
	fld a
	fld @aux47
	fcomp
	fstsw ax
	fwait
	sahf

	jne ETIQUETA60
	;SUMA
	ETIQUETA52:
	fld c
	fld &cte8
	fadd
	fstp @aux52

	;CMP
	ETIQUETA53:
	fld c
	fld @aux52
	fcomp
	fstsw ax
	fwait
	sahf

	jne ETIQUETA60
	;DIVISION
	ETIQUETA57:
	fld b
	fld &cte1
	fdiv
	fstp @aux57

	;CMP
	ETIQUETA58:
	fld b
	fld @aux57
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA66
	;SUMA
	ETIQUETA62:
	fld &cte10
	fld b
	fadd
	fstp @aux62

	;ASIGNACIÓN
	ETIQUETA64:
	fld @aux62
	fstp i

	jmp ETIQUETA43
	;ASIGNACIÓN
	ETIQUETA66:
	fld @aux62
	fstp i

	;SUMA
	ETIQUETA67:
	fld @aux62
	fld i
	fadd
	fstp @aux67

	;ASIGNACIÓN
	ETIQUETA68:
	fld @aux62
	fstp @aux67

	;SUMA
	ETIQUETA69:
	fld @aux62
	fld @aux67
	fadd
	fstp @aux69

	;ASIGNACIÓN
	ETIQUETA70:
	fld @aux62
	fstp @aux69

	;SUMA
	ETIQUETA71:
	fld @aux62
	fld @aux69
	fadd
	fstp @aux71

	;ASIGNACIÓN
	ETIQUETA72:
	fld @aux62
	fstp @aux71

	;SUMA
	ETIQUETA73:
	fld @aux62
	fld @aux71
	fadd
	fstp @aux73

	;ASIGNACIÓN
	ETIQUETA74:
	fld @aux62
	fstp @aux73

	;SUMA
	ETIQUETA75:
	fld @aux62
	fld @aux73
	fadd
	fstp @aux75

	;ASIGNACIÓN
	ETIQUETA76:
	fld @aux62
	fstp @aux75

	;SUMA
	ETIQUETA77:
	fld @aux62
	fld @aux75
	fadd
	fstp @aux77

	;ASIGNACIÓN
	ETIQUETA78:
	fld @aux62
	fstp @aux77

	;SUMA
	ETIQUETA79:
	fld @aux62
	fld @aux77
	fadd
	fstp @aux79

	;ASIGNACIÓN
	ETIQUETA80:
	fld @aux62
	fstp @aux79

	;ASIGNACIÓN
	ETIQUETA82:
	fld @aux62
	fstp a

	;CMP
	ETIQUETA85:
	fld i
	fld &cte2
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA94
	;CMP
	ETIQUETA89:
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA94
	;ASIGNACIÓN
	ETIQUETA93:
	fld &cte15
	fstp i

	;CMP
	ETIQUETA96:
	fld i
	fld &cte2
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA105
	;CMP
	ETIQUETA100:
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA105
	;ASIGNACIÓN
	ETIQUETA104:
	fld &cte15
	fstp i

	;CMP
	ETIQUETA107:
	fld i
	fld &cte2
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA116
	;CMP
	ETIQUETA111:
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA116
	;ASIGNACIÓN
	ETIQUETA115:
	fld &cte15
	fstp i

	;CMP
	ETIQUETA118:
	fld i
	fld &cte2
	fcomp
	fstsw ax
	fwait
	sahf

	jne ETIQUETA124
	;CMP
	ETIQUETA122:
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA127
	;ASIGNACIÓN
	ETIQUETA126:
	fld &cte15
	fstp i

	;CMP
	ETIQUETA129:
	fld i
	fld &cte2
	fcomp
	fstsw ax
	fwait
	sahf

	jne ETIQUETA135
	;CMP
	ETIQUETA133:
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA138
	;ASIGNACIÓN
	ETIQUETA137:
	fld &cte15
	fstp i

	;CMP
	ETIQUETA140:
	fld i
	fld &cte2
	fcomp
	fstsw ax
	fwait
	sahf

	jne ETIQUETA146
	;CMP
	ETIQUETA144:
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA149
	;ASIGNACIÓN
	ETIQUETA148:
	fld &cte15
	fstp i

	;CMP
	ETIQUETA151:
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA156
	;ASIGNACIÓN
	ETIQUETA155:
	fld &cte15
	fstp i

	;CMP
	ETIQUETA158:
	fld a
	fld &cte14
	fcomp
	fstsw ax
	fwait
	sahf

	jne ETIQUETA163
	;ASIGNACIÓN
	ETIQUETA162:
	fld &cte15
	fstp i

	;ASIGNACIÓN
	ETIQUETA163:
	fld &cte15
	fstp i

	;SUMA
	ETIQUETA164:
	fld &cte15
	fld i
	fadd
	fstp @aux164

	;ASIGNACIÓN
	ETIQUETA165:
	fld &cte15
	fstp @aux164

	;CMP
	ETIQUETA167:
	fld &cte15
	fld &cte8
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA172
	;ASIGNACIÓN
	ETIQUETA171:
	fld &cte15
	fstp i

	;CMP
	ETIQUETA174:
	fld a
	fld &cte8
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA180
	;ASIGNACIÓN
	ETIQUETA178:
	fld &cte15
	fstp i

	jmp ETIQUETA183
	;ASIGNACIÓN
	ETIQUETA182:
	fld &cte18
	fstp i

	;CMP
	ETIQUETA185:
	fld a
	fld &cte8
	fcomp
	fstsw ax
	fwait
	sahf

	ja ETIQUETA195
	;CMP
	ETIQUETA189:
	fld b
	fld &cte1
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA195
	;ASIGNACIÓN
	ETIQUETA193:
	fld &cte15
	fstp i

	jmp ETIQUETA198
	;ASIGNACIÓN
	ETIQUETA197:
	fld &cte18
	fstp i

	;CMP
	ETIQUETA200:
	fld a
	fld &cte8
	fcomp
	fstsw ax
	fwait
	sahf

	jbe ETIQUETA206
	;CMP
	ETIQUETA204:
	fld b
	fld &cte1
	fcomp
	fstsw ax
	fwait
	sahf

	je ETIQUETA210
	;ASIGNACIÓN
	ETIQUETA208:
	fld &cte15
	fstp i

	jmp ETIQUETA213
	;ASIGNACIÓN
	ETIQUETA212:
	fld &cte18
	fstp i

	;GET
	ETIQUETA214:
	DisplayFloat n 2
	newLine 1

	;DISPLAY
	ETIQUETA216:
	GetFloat b

	;DISPLAY
	ETIQUETA218:
	getString &cte19

	;DISPLAY
	ETIQUETA220:
	getString &cte20

	;GET
	ETIQUETA222:
	DisplayFloat n 2
	newLine 1

	;DISPLAY
	ETIQUETA224:
	GetFloat i

	;DISPLAY
	ETIQUETA226:
	getString &cte21

	;DISPLAY
	ETIQUETA228:
	getString &cte22


TERMINAR: ;Fin de ejecución.
	mov ax, 4C00h ;termina la ejecución.
	int 21h ;syscall

END START ;final del archivo.