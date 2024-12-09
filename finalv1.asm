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

Barra MACRO Color, EsqIni, EsqFin
        mov ah, 06h
        mov al, 00h
        mov bh, Color
        mov cx, EsqIni
        mov dx, EsqFin
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
bienvenidoColorear db '----------------BIENVENIDO A DIBUJAR A STEVE--------------------$'
opcionesCabello db '¿Que color de pelo deseas?$'
azulCabello db 'a) Azul$'
moradoCabello db 'b) Morado$'
negroCabello db 'c) Negro$'

opcionesPlayera db '¿Que color de playera deseas?$'
opcPlayera1 db 'a) Negro$'
opcPlayera2 db 'b) Cyan$'
opcPlayera3 db 'c) Rojo$'

volverDibujar db 'Quieres volver a dibujar? (S/N)$'

opcionesPantalon db '¿Que color de pantalon deseas?$'
opcPantalon1 db 'a) Morado$'
opcPantalon2 db 'b) Azul$'
opcPantalon3 db 'c) Blanco$'

gatitoLinea1 db '     /\_/\        ', 0Dh, 0Ah, '$'
gatitoLinea2 db '    ( o.o )      ', 0Dh, 0Ah, '$'
gatitoLinea3 db '     > ^ <       ', 0Dh, 0Ah, '$'
gatitoLinea4 db '    /     \     ', 0Dh, 0Ah, '$'
gatitoLinea5 db '   /       \    ', 0Dh, 0Ah, '$'
gatitoLinea6 db '   |       |   ', 0Dh, 0Ah, '$'
gatitoLinea7 db '    \     /    ', 0Dh, 0Ah, '$'
gatitoLinea8 db '     \_/     ', 0Dh, 0Ah, '$'

colorCabello db 0
colorPlayera db 0
colorPantalon db 0

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
	cmp al, 'B';
	je steve2
	cmp al, 'b'
	je steve2
	cmp al, 'x'
	je EXIT_CONTINUE
	cmp al, 'X'
	je EXIT_CONTINUE
	jmp esperar_tecla

steve2:
	jmp STEVE_DIBUJO

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

STEVE_DIBUJO:
	LimpiarPantalla 47h
	Imprimir 8,10, bienvenidoColorear
	Imprimir 10,10, opcionesCabello
	Imprimir 12,10, azulCabello
	Imprimir 14,10, moradoCabello
	Imprimir 16,10, negroCabello
volver1:
	mov ah, 00h
	int 16h
	cmp al, 'a'
	je cabello_azul
	cmp al, 'b'
	je cabello_morado
	cmp al, 'c'
	je cabello_negro
	jmp volver1
	cabello_azul:
	mov colorCabello, 10h
	jmp siguiente
	cabello_morado:
	mov colorCabello, 50h
	jmp siguiente
	cabello_negro:
	mov colorCabello, 00h
	jmp siguiente
siguiente:
	LimpiarPantalla 57h
	Imprimir 8,10, bienvenidoColorear
	Imprimir 10,10, opcionesPlayera
	Imprimir 12,10, opcPlayera1
	Imprimir 14,10, opcPlayera2
	Imprimir 16,10, opcPlayera3
volver2:
	mov ah, 00h
	int 16h
	cmp al, 'a'
	je playera_negro
	cmp al, 'b'
	je playera_cyan
	cmp al, 'c'
	je playera_rojo
	jmp volver2

	playera_negro:
	mov colorPlayera, 00h
	jmp siguiente2

	playera_cyan:
	mov colorPlayera, 30h
	jmp siguiente2

	playera_rojo:
	mov colorPlayera, 40h
	jmp siguiente2
siguiente2:
	LimpiarPantalla 17h
	Imprimir 8,10, bienvenidoColorear
	Imprimir 10,10, opcionesPantalon
	Imprimir 12,10, opcPantalon1
	Imprimir 14,10, opcPantalon2
	Imprimir 16,10, opcPantalon3
volver3:
	mov ah, 00h
	int 16h
	cmp al, 'a'
	je pantalon_morado
	cmp al, 'b'
	je pantalon_azul
	cmp al, 'c'
	je pantalon_blanco
	jmp volver3

	pantalon_morado:
	mov colorPantalon, 50h
	jmp fin

	pantalon_azul:
	mov colorPantalon, 10h
	jmp fin

	pantalon_blanco:
	mov colorPantalon, 70h
	jmp fin

fin:
	LimpiarPantalla 77h
	Barra 20H, 1200h, 18AFh
	Barra 60h, 0B43h, 1346h
	Barra 20h, 093Dh, 0A4Bh
	Barra 20h, 073Fh, 0849h
	Barra 20h, 0541h, 0647h
	Barra colorPantalon, 111Eh, 1525h
	Barra 60h, 161Eh, 1625h
	Barra colorPlayera, 0A1Eh, 1025h
	Barra colorPlayera, 0A1Ah, 0B29h
	Barra 60h, 0C1Ah, 101Dh
	Barra 60h, 0C26h, 1029h
	Barra 60h, 051Eh, 0925h
	Barra colorCabello, 051Eh, 0525h
	Barra colorCabello, 051Eh, 061Eh
	Barra colorCabello, 0525h, 0625h
	Barra 70h, 0720h, 0723h
	Barra 00h, 0721h, 0721h
	Barra 00h, 0723h, 0723h
	Barra 00h, 0921h, 0922h
	Imprimir 23,10, volverDibujar
	mov ah, 00h
	int 16h
	cmp al, 's'
	je dibujarVolver
	jmp MENU2_CONTINUE;
dibujarVolver:
	jmp STEVE_DIBUJO
	
EXIT:
	mov AX, 4c00h
	INT 21h
END inicio