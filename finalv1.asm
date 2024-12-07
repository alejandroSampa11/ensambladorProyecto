Imprimir MACRO fila, columna, cadena
	mov ah, 02h
	mov bh, 0
	mov dh, fila
	mov dl, columna
	int 10h
	lea dx, cadena
	mov ah, 09h
	int 21h
ENDM

ImprimirLinea MACRO fila, columna, caracter
	mov ah, 02h
	mov bh, 0
	mov dh, fila
	mov dl, columna
	int 10h
	
	mov ah, 0Eh
	mov al, caracter
	int 10h
ENDM
;CAMBIOS
LimpiarPantalla MACRO color
	mov ah, 06h
	mov al, 0
	mov bh, color
	mov cx, 0000h
	mov dx, 184fh
	int 10h
ENDM

.MODEL Large
.STACK 100h

.DATA
linea db '|$'
separador db '----------------------BIENVENIDO--------------------$'
separador2 db '----------------------------------------------------$'
separador3 db '-------------------------MEN',00E9h,'------------------------$'
separador4 db '-------------------------DIBUJAR FIGURAS------------------------$'
actividades db 'SELECCIONE LA ACTIVIDAD QUE M',00E0h,'S LE GUSTE, DIVIERTASE!!!$'
figuras db 'a) DIBUJAR FIGURAS$'
figura1 db 'a) DIBUJAR TRIANGULO$'
figura2 db 'b) DIBUJAR CUADRADO$'
figura3 db 'c) DIBUJAR RECTANGULO$'
colorear db 'b) COLOREAR A STEVE$'
juego db 'c) JUGAR AL 3 EN RAYA$'
salir db 'X) SALIR$'
ale db 'Jos',82h,' Alejandro Sampablo Mart', 0A1h ,'nez$'
daniel db 'Sergio Daniel Chiquito Zu', 00F1h ,'iga$'
programa db 'Programa Tope de Power$'
tecla db 'Pulse cualquier tecla para continuar...$'
volver_menu db 'Z) VOLVER AL MEN',00E9h,' PRINCIPAL$'

gatitoLinea1 db '     /\_/\        ', 0Dh, 0Ah, '$'
gatitoLinea2 db '    ( o.o )      ', 0Dh, 0Ah, '$'
gatitoLinea3 db '     > ^ <       ', 0Dh, 0Ah, '$'
gatitoLinea4 db '    /     \     ', 0Dh, 0Ah, '$'
gatitoLinea5 db '   /       \    ', 0Dh, 0Ah, '$'
gatitoLinea6 db '   |       |   ', 0Dh, 0Ah, '$'
gatitoLinea7 db '    \     /    ', 0Dh, 0Ah, '$'
gatitoLinea8 db '     \_/     ', 0Dh, 0Ah, '$'

.CODE
inicio:

MENU_INICIO:
mov ax, @data
mov ds, ax

	;CAMBIAR DE COLOR
	LimpiarPantalla 57h

	;MOVER EL CURSOR
	Imprimir 8, 10, separador
	Imprimir 10, 20, ale
	Imprimir 12, 20, daniel
	Imprimir 14, 20, programa
	Imprimir 17, 20, tecla
	Imprimir 19, 10, separador2
	
	Imprimir 10,60 gatitoLinea1
	Imprimir 11,60 gatitoLinea2
	Imprimir 12,60 gatitoLinea3
	Imprimir 13,60 gatitoLinea4
	Imprimir 14,60 gatitoLinea5
	Imprimir 15,60 gatitoLinea6
	Imprimir 16,60 gatitoLinea7
	Imprimir 17,60 gatitoLinea8
	
	mov dl, 10
	mov dh, 9
	mov cx, 10
loop_inicio_linea:
	ImprimirLinea dh,dl,'|'
	inc dh
loop loop_inicio_linea

	mov dl, 62
	mov dh, 9
	mov cx, 10
loop_inicio_linea2:
	ImprimirLinea dh,dl,'|'
	inc dh
loop loop_inicio_linea2
	;TECLA SOLICITADA
	mov ah, 00h
	int 16h
	
MENU2:
	;CAMBIO DE PANTALLA
	LimpiarPantalla 97h
	Imprimir 8, 10, separador3
	Imprimir 10, 9, actividades
	Imprimir 12, 15, figuras
	Imprimir 14, 15, colorear
	Imprimir 16, 15, juego
	Imprimir 18, 15, salir 
	
esperar_tecla:
	mov ah, 00h
	int 16h
	cmp al, 'A';
	je dibujar
	cmp al, 'a'
	je dibujar
	cmp al, 'x'
	je EXIT_CONTINUE
	cmp al, 'X'
	je EXIT_CONTINUE
	jmp esperar_tecla
	
EXIT_CONTINUE:
	jmp EXIT
	
dibujar:
	LimpiarPantalla 47h
	Imprimir 8,10, separador4
	Imprimir 10,15, figura1
	Imprimir 12,15, figura2
	Imprimir 14,15, figura3
	Imprimir 16,15, volver_menu
esperar_tecla2:
	mov ah, 00h
	int 16h
	cmp al, 'A'
	je dibujarTriangulo
	cmp al, 'a'
	je dibujarTriangulo
	cmp al, 'Z';
	je MENU2_CONTINUE
	cmp al, 'z'
	je MENU2_CONTINUE
	jmp esperar_tecla2

dibujarTriangulo:
	LimpiarPantalla 87h
	mov ah, 00h
	int 16h
	JMP dibujar
	
	
linea2:
	inc dx
	int 10h
	cmp dx, 100
	jne linea2
	
	mov ax, 03h
	int 10h
	jmp dibujar

MENU2_CONTINUE:
	jmp MENU2
	
EXIT:
	mov AX, 4c00h
	INT 21h
END inicio