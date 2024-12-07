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

.MODEL Large
.STACK 100h

.DATA
linea db '|$'
separador db '----------------------BIENVENIDO--------------------$'
separador2 db '----------------------------------------------------$'
ale db 'Jos',82h,' Alejandro Sampablo Mart', 0A1h ,'nez$'
daniel db 'Sergio Daniel Chiquito Zu', 00F1h ,'iga$'
programa db 'Programa Tope de Power$'
tecla db 'Pulse cualquier tecla para continuar...$'

gatitoLinea1 db '     /\_/\        ', 0Dh, 0Ah, '$'
gatitoLinea2 db '    ( o.o )      ', 0Dh, 0Ah, '$'
gatitoLinea3 db '     > ^ <       ', 0Dh, 0Ah, '$'
gatitoLinea4 db '    /     \     ', 0Dh, 0Ah, '$'
gatitoLinea5 db '   /       \    ', 0Dh, 0Ah, '$'
gatitoLinea6 db '   |       |   ', 0Dh, 0Ah, '$'
gatitoLinea7 db '    \     /    ', 0Dh, 0Ah, '$'
gatitoLinea8 db '     \___/     ', 0Dh, 0Ah, '$'

.CODE
inicio:

MENU_INICIO:
mov ax, @data
mov ds, ax

	;CAMBIAR DE COLOR
	mov ah, 06h
	mov al, 0
	mov bh, 57h
	mov cx, 0000h
	mov dx, 184fh
	int 10h
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

	
	mov ah, 00h
	int 16h
	
	;CAMBIO DE PANTALLA
	mov ah, 06h
	mov al, 0
	mov bh, 97h
	mov cx, 0000h
	mov dx, 184fh
	int 10h

	EXIT:
	mov AX, 4c00h
	INT 21h
END inicio
