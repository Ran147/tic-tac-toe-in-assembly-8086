 
.model large

org 100h                                           
                                                 
;------Variables usadas, asi como pantallas       
.data                                              

    pressenter db 'Press Enter','$'               ; variable para indicar cuando presionar enter
    msg1 db 10,13,'Digite su nombre: $'           ; variables para indicar la escritura del nombre
    msg2 db 10,13,'Digite su nombre: $'
    player1 db 'Jugador 1:$'                      ; variable para indicar el numero de jugador
    player2 db 'Jugador 2:$'
    usu1 db '0$'                                  ; variables que almacenan el nombre del jugador
    usu2 db '0$'
    nivel1T db 'Nivel 1$'                         ; Variables que almacenan el str del nivel    
    nivel2T db 'Nivel 2$' 
    msgp1 db 10,13,"Escribir signo signo: " ,"$"    ; variable para indicar cuando escribir el signo
    msgp2 db 10,13,"Escribir signo: " ,"$" 
    sig1 db 'Su signo es:$'                       ; indica que signo tiene el jugador
    sig2 db 'Su signo es:$'
    signo1 db '0$'                                ; almacena el signo del jugador
    signo2 db '0$'
    puntaje1 db 30h                               ; variable con los puntos de los jugadores
    puntaje2 db 30h
    puntos1 db 'Puntos:','$'                      ; indica los puntos via str
    puntos2 db 'Puntos:','$'
    PActivo db '<-','$'                           ; indica que jugador esta en turno
    Reglas db "Reglas del juego$"                                                    ; reglas del juego
    regla1 db "1. Cada jugador tiene un turno el cual se debe de respetar$"
    regla2 db "2. Cada jugador hara uso de su marca propia$"
    regla3 db "3. Para colocar la marca se debe usar el click izquierdo$"
    regla4 db "4. Hacer click en los numeros de las casillas para colocar la marca$"
    regla5 db "5. Si se clickea afuera de la matriz o con otro boton, se resta 1 punto$"
    regla6 db "6. Si se clickea la marca de otro jugador se resta 1 punto$"
    regla7 db "7. Completar lineas diagonales,verticales o horizontales para sumar 3 puntos$"
    
    rendirse db "d$"              ; variables que indican los botones para salirse, rendirse o reiniciar
    salirse db "s$"
    reiniciar db "r$"       
    m1   db ' _______________________________','$'      ; variables usadas para crear la matriz
    m2   db '          |        |','$'
    limpiar    db '           ' ,'$'                    ; variables usadas para limpiar elementos del juego
    limpiar2 db ' ','$'
    limpiar3 db '                             ','$'
    linea db 10,13 ,"$"
    mouseX dw 0             ; variables para almacenar las coordenadas x y del mouse
    mouseY dw 0   
    tiempo db 0             ; variable para almacenar el tiempo de juego de cada nivel
    
                                             
                                      
                                              ;pantalla principal del juego
    pantallaprincipal dw '  ' ,0ah,0dh
    
    dw ' ',0ah,0dh
    dw ' ',0ah,0dh
    dw ' ',0ah,0dh 
    dw '         ================================================================',0ah,0dh
    dw '        ||                                                               ||',0ah,0dh
    dw '        ||                                                               ||',0ah,0dh
    dw '        ||                                                               ||',0ah,0dh
    dw '        ||   ____    ______ _   _   _      _____ _   _ ______            ||',0ah,0dh
    dw '        ||   |___ \  |  ____| \ | | | |    |_   _| \ | |  ____|   /\     ||',0ah,0dh
    dw '        ||     __) | | |__  |  \| | | |      | | |  \| | |__     /  \    ||',0ah,0dh
    dw '        ||    |__ <  |  __| | . ` | | |      | | | . ` |  __|   / /\ \   ||',0ah,0dh
    dw '        ||    ___) | | |____| |\  | | |____ _| |_| |\  | |____ / ____ \  ||',0ah,0dh
    dw '        ||   |____/  |______|_| \_| |______|_____|_| \_|______/_/    \_\ ||',0ah,0dh
    dw '        ||                                                               ||',0ah,0dh
    dw '        ||                                                               ||',0ah,0dh
    dw '        ||                                                               ||',0ah,0dh
    dw '        ||                                                               ||',0ah,0dh
    dw '        ||                                                               ||',0ah,0dh
    dw '        ||---------------------------------------------------------------||',0ah,0dh
    dw '        ||                                                               ||',0ah,0dh
    dw '        ||                           -Enter-                             ||',0ah,0dh
    dw '         ================================================================ ',0ah,0dh
    dw '$',0ah,0dh
    ;Pantalla en caso que el jugador 1 gane
    pantallafinalp1 dw '  ',0ah,0dh
        
    dw ' ',0ah,0dh
    dw ' ',0ah,0dh
    dw ' ',0ah,0dh                                    
    dw '         ==================================================',0ah,0dh
    dw '        ||                   Jugador 1 gana                ||',0ah,0dh
    dw '        ||-------------------------------------------------||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh  
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh
    dw '         ================================================== ',0ah,0dh
    dw '$',0ah,0dh
    ;Pantalla en caso que el jugador 2 gane
    pantallafinalp2 dw '  ',0ah,0dh
       
    dw ' ',0ah,0dh
    dw ' ',0ah,0dh
    dw ' ',0ah,0dh
    dw '         ==================================================',0ah,0dh
    dw '        ||                   Jugador 2 gana                ||',0ah,0dh
    dw '        ||-------------------------------------------------||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh  
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh
    dw '         ==================================================',0ah,0dh
    dw '$',0ah,0dh
                    ; Pantalla en caso que exista empate
    pantallafinalemp dw '  ',0ah,0dh
       
    dw ' ',0ah,0dh
    dw ' ',0ah,0dh
    dw ' ',0ah,0dh
    dw '         ==================================================',0ah,0dh
    dw '        ||                      EMPATE                     ||',0ah,0dh
    dw '        ||-------------------------------------------------||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh  
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh
    dw '         ================================================== ',0ah,0dh
    dw '$',0ah,0dh
                ; pantalla en caso que algun jugador se salga del juego  
   pantallasalirse dw '  ',0ah,0dh
       
    dw ' ',0ah,0dh
    dw ' ',0ah,0dh
    dw ' ',0ah,0dh
    dw '         ==================================================',0ah,0dh
    dw '        ||                   Fin del juego                 ||',0ah,0dh
    dw '        ||-------------------------------------------------||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh  
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh 
    dw '        ||                                                 ||',0ah,0dh
    dw '        ||                                                 ||',0ah,0dh
    dw '         ==================================================',0ah,0dh
    dw '$',0ah,0dh
;------variables con las coordenadas de los numeros de la matriz-------    
cor1x dw 5
cor1y dw 5
cor2x dw 10h
cor2y dw 5
cor3x dw 26
cor3y dw 5
cor4x dw 5
cor4y dw 13
cor5x dw 10h
cor5y dw 13
cor6x dw 26
cor6y dw 13
cor7x dw 5
cor7y dw 19
cor8x dw 10h
cor8y dw 19
cor9x dw 26
cor9y dw 19
;-------variables con las coordenadas de los botones para salirse, rendirse o reiniciar--- 
corsalirsex dw 65
corsalirsey dw 10
correiniciarx dw 60
correiniciary dw 10
correndirsex dw 55
correndirsey dw 10
;---- variables utilizadas para indicar si un espacio de la matriz esta vacio o no---
espacio1 db 0
espacio2 db 0
espacio3 db 0
espacio4 db 0
espacio5 db 0
espacio6 db 0
espacio7 db 0
espacio8 db 0
espacio9 db 0
;------ variables con el str de los numeros de los espacios de la matriz 
espacio1s db "1$"
espacio2s db "2$"
espacio3s db "3$"
espacio4s db "4$"
espacio5s db "5$"
espacio6s db "6$"
espacio7s db "7$"
espacio8s db "8$"
espacio9s db "9$"
.code
;----------------------Datos------------------------------
mov ax,@data
mov ds,ax   
;------macros------------ 
clearScreen macro              ;Macro para limpiar pantallas
        mov ah, 0fh
        int 10h
        mov ah, 0
        int 10h
    endm
    
    imprimirtexto macro variable, x, y            ; macro para imprimir un texto dado en una coordenada especifica de pixeles
        mov ah, 02h
        mov bh, 00d
        mov dh, x
        mov dl, y
        int 10h
        mov ah, 9
        lea dx, variable
        int 21h
    endm
    
    imprimirPantallas macro pantalla              ; macro para imprimir pantallas, mas que todo por orden
        mov ah,09h
        lea dx, pantalla             
        int 21h
    endm   
    
    imprimirInput macro texto, variable           ; macro que imprime un texto y al mismo tiempo
        mov ah, 09                                ; recibe un dato para almacenarlo en una variable dada
        lea dx, texto
        int 21h
        
        mov ah, 1
        int 21h
        mov variable, al
    endm    
    
    imprimirDatos macro variable, y, x            ; macro que imprime los datos del usuario en coordenadas dadas
        mov ah, 02h                                     
        mov bh, 00d
        mov dh, y                                       
        mov dl, x                                       
        int 10h
        
        mov ah, 9h
        mov al, variable                                
        mov bh, 0
        mov bl, 2                                       
        mov cx, 1  
        int 10h  
    endm                   
    
      
   
       
         
    mouse macro       ; macro para uso del mouse, que activa el curso, ense a el cursor
        mov ax, 00h   ; y detecta las coordenadas asi como los clicks
        int 33h
        mov ax, 01h
        int 33h  
        mov ax,03h
        int 33h
    endm
     
    
 
    Soundfailure macro  ;macro la cual crea un sonido
    mov ah, 2h
    mov dl, 07h
    int 21h
    endm
    
    
 
        
    colores macro simb, color       ;macro que recibe una variable y le da un color
        mov ah, 9h
        mov al, simb
        mov bh, 0
        mov bl, color
        mov cx, 1
        int 10h
    endm 

;-----------------Procedimientos pre-juego---------------------
    
    main:                              
      mov puntaje1, 48               ; se le mueve a la puntiacion de los jugadores un 48
      mov puntaje2, 48               ; que seria un 0 al pasarlo al ascii
      mov tiempo, 00h                ; al tiempo se le mueve un 0  
                         
                      
      clearScreen                    ;se limpia la pantalla
      imprimirPantallas  pantallaPrincipal ; se imprime la pantalla principal
      imprimirTexto limpiar2,23,79         
      
        noEnter:                     ;espera el enter
            mov ah,08h
            int 21h
            cmp al,0dh
            je  personas
            jne noEnter
        
        
    personas:
        clearScreen                       ; se limpia pantalla y se pide el nombre asi como
        imprimirInput msg1, usu1          ; el signo de los jugadores
        imprimirInput msgp1, signo1
        imprimirInput msg2, usu2  
        imprimirInput msgp2, signo2 
        jmp reglitas
         
         
         reglitas:                    ; se limpia la pantalla y se pasa a imprimir las reglas
         clearScreen
         imprimirTexto Reglas, 2, 3
         imprimirTexto regla1, 4, 3
         imprimirTexto regla2, 6, 3
         imprimirTexto regla3, 8, 3
         imprimirTexto regla4, 10, 3
         imprimirTexto regla5, 12, 3
         imprimirTexto regla6, 14, 3
         imprimirTexto regla7, 16, 3
         jmp espera
         
        
            espera:                     ;se espera un enter
                mov ah,08h
                int 21h
                cmp al,0dh
                je  primerNivel
                jne espera


       
         
        
         
         
;-----------Parte del inicio del juego-----------      
;----------------------------------------------------
    primerNivel:                                   ; se le mueven a los espacios un cero
        mov espacio1, 0                            ; esto en caso de un posible reinicio
        mov espacio2, 0
        mov espacio3, 0
        mov espacio4, 0
        mov espacio5, 0
        mov espacio6, 0
        mov espacio7, 0
        mov espacio8, 0
        mov espacio9, 0
        mov tiempo, 00h                         ; se reinicia el tiempo
            
       matrizJuego:
            clearScreen                      ; se limpia la pantalla y se imprime la matriz
             imprimirTexto m2, 21, 1        
            imprimirTexto m2, 20, 1                   
            imprimirTexto m2, 19, 1
            imprimirTexto m2, 18, 1
            imprimirTexto m2, 17, 1
            imprimirTexto m2, 16, 1
            imprimirTexto m2, 15, 1
            imprimirTexto m2, 14, 1
            imprimirTexto m2, 13, 1
            imprimirTexto m2, 12, 1
            imprimirTexto m2, 11, 1
            imprimirTexto m2, 10, 1
            imprimirTexto m2, 9, 1
            imprimirTexto m2, 8, 1
            imprimirTexto m2, 7, 1
            imprimirTexto m2, 6, 1
            imprimirTexto m2, 5, 1
            imprimirTexto m2, 4, 1
            imprimirTexto m2, 3, 1 
            imprimirTexto m1, 16, 1
            imprimirTexto m1, 9, 1
            imprimirTexto player1, 3, 35  ; imprime datos del jugador
            imprimirDatos usu1, 3, 45
            imprimirTexto sig1, 3, 47
            imprimirDatos signo1, 3, 59
            imprimirTexto puntos1, 3, 62 
            imprimirDatos puntaje1, 3, 69
            imprimirTexto player2, 5, 35    ; se imprimen datos del jugador 2
            imprimirDatos usu2, 5, 45
            imprimirTexto sig2, 5 ,47
            imprimirDatos signo2, 5, 59
            imprimirTexto puntos2, 5, 62
            imprimirDatos puntaje2, 5, 69
            imprimirTexto nivel1T,0,14               ; indicacion del nivel 1
            imprimirTexto pressenter,10, 40
            imprimirTexto rendirse 10, 55
            imprimirTexto reiniciar 10,60            ; se imprime los botones de salir, reiniciar y rendirse
            imprimirTexto salirse 10, 65             
            imprimirTexto limpiar2,23,79
                       
            
            continuar:
                    mov ah, 08h
                    int 21h
                    cmp al, 0dh
                    je limpiarTexto          ;espera un enter
                    jmp continuar
                    
            limpiarTexto:
                imprimirTexto limpiar, 10,40    ; limpia el enter
            ponernumeros:
                imprimirTexto espacio1s, 5, 5     ; procede a imprimir los numeros de los espacios de la matriz
                imprimirTexto espacio2s, 5, 16
                imprimirTexto espacio3s, 5, 26
                imprimirTexto espacio4s, 13, 5
                imprimirTexto espacio5s, 13, 16
                imprimirTexto espacio6s, 13, 26
                imprimirTexto espacio7s, 19, 5
                imprimirTexto espacio8s, 19, 16
                imprimirTexto espacio9s, 19, 26 
            
;------------------Nivel1---------
      
        jugador1n1:                            ; se limpia el indicador de turno del jugador2
            imprimirTexto limpiar2, 5, 70      ; se imprime el del jugador1
            imprimirTexto PActivo, 3, 70         
            escribirsignos1:
                inc tiempo                     ; se incrementa el tiempo
                cmp tiempo, 200                ; se compara si el tiempo llega a 200
                    je SegundoNivel            ; pasa al segundo nivel
                xor bx, bx
                mouse                          ; en esta parte solamente se estan recibiendo las
                cmp bx, 1                      ; coordenadas del mouse y se verifica si hay click izquierdo o derecho
                je verificarcordenadas1
                cmp bx, 2
                je quitarpuntos1
                jmp escribirsignos1
                    quitarpuntos1:
                        mov al, puntaje1          ; se le remueven puntos al jugador1, se limpia
                        sub al, 1                 ; el puntaje y se imprime el nuevo puntaje
                        mov puntaje1, al          ; ademas de pasar al jugador2
                        imprimirTexto limpiar2, 3, 69
                        imprimirDatos puntaje1, 3, 69
                        jmp jugador2n1  
                        
                verificarcordenadas1:      ; en caso de haber click izquierdo se divide entre 8 las coordenadas
                    shr cx, 3              ; del mouse, haciendo uso del shift right 3 veces cada coordenada
                    shr dx, 3
                    mov mouseX, cx         ; la coordenada pasa a las variables respectivas
                    mov mouseY, dx
 ;----verificacion de coordenada x-----                   
                verxsalirse1:                ; en esta seccion lo que sucede es que se compara las
                    mov bx, mouseX           ; coordenadas x recibidas en el mouse con las coordenadas
                    cmp bx, corsalirsex      ; preestablecidas de las variables.
                        je verysalirse1      ; si la coordenada x coincide con la coordenada x de la variable
                        jne verxreiniciar1   ; entonces pasa a la siguiente seccion para verificar 
                                             ; si la coordenada y del mouse coincide con la coordenada y preestablecida
                verxreiniciar1:              ;De no coincidir la coordenada x con la prestablecida
                    mov bx, mouseX           ; Se pasa a la siguiente coordenada prestablecida y se hace la comparacion
                    cmp bx, correiniciarx
                        je veryreiniciar1
                        jne verxrendirse1    ;Eventualmente si no coincide con ninguna coordenada x, suena el beep y se bajan puntos
                        
                verxrendirse1:
                    mov bx, mouseX
                    cmp bx, correndirsex
                        je veryrendirse1
                        jne verx1
                        
                verx1: 
                    mov bx, mouseX
                    cmp bx, cor1x
                        je very1
                        jne verx2
                        
                verx2: 
                    mov bx, mouseX   
                    cmp bx, cor2x
                        je very2
                        jne verx3
                verx3:
                    mov bx, mouseX
                    cmp bx, cor3x
                        je very3
                        jne verx4
                verx4:
                    mov bx, mouseX
                    cmp bx, cor4x
                        je very4
                        jne verx5
                verx5:
                    mov bx, mouseX
                    cmp bx, cor5x
                        je very5
                        jne verx6
                verx6: 
                    mov bx, mouseX
                    cmp bx, cor6x
                        je very6
                        jne verx7 
                verx7: 
                    mov bx, mouseX
                    cmp bx, cor7x
                        je very7
                        jne verx8
                verx8: 
                    mov bx, mouseX
                    cmp bx, cor8x
                        je very8
                        jne verx9 
                verx9:
                    mov bx, mouseX
                    cmp bx, cor9x
                        je very9
                        jne reducirpsonido
                        
                        
                        
                reducirpsonido:               ; resta puntos al jugador, suena el beep, actualiza el puntaje
                    mov al, puntaje1          ; y pasa al jugador 2
                        sub al, 1
                        mov puntaje1, al 
                        SoundFailure
                        imprimirTexto limpiar2, 3, 69
                        imprimirDatos puntaje1, 3, 69
                        jmp jugador2n1
                    
         ;------Verificacion de coordenada y-------           
                verysalirse1:                         ; en esta seccion se compara la coordenada y del mouse
                    xor bx, bx                        ; con las coordenadas y prestablecidas
                    mov bx, mouseY                    ; si coinciden, se pasa a otra seccion dedicada a
                    cmp bx, corsalirsey               ; salirse, reiniciar el juego o rendirse en caso de ser botones
                        je botonsalirse1              ; en caso de ser los numeros de los espacios, entonces pasa a
                        jne verxreiniciar1            ; a verificar que ese espacio este vacio
                                                      ; de lo contrario, se devuelve a la seccion de verificacion de coordenadas x 
                veryreiniciar1:                       ; para verificar otra coordenada x para pasar a su respectiva coordenada y
                    xor bx, bx
                    mov bx, mouseY
                    cmp bx, correiniciary
                        je  main                 ; reinicia el juego
                        jne verxrendirse1
                        
                veryrendirse1:
                    xor bx, bx
                    mov bx, mouseY
                    cmp bx, correndirsey
                        je botonrendirsej1n1
                        jne verx1
                            
             
                very1: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor1y
                    je verificarvacio1j1
                    jne verx2
            
                     
                very2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor2y
                    je verificarvacio2j1
                    jne verx3
                very3: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor3y
                    je verificarvacio3j1
                    jne verx4  
                    
                very4: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor4y
                    je verificarvacio4j1
                    jne verx5 
                very5: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor5y
                    je verificarvacio5j1
                    jne verx6
                very6: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor6y
                    je verificarvacio6j1
                    jne verx7
                very7: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor7y
                    je verificarvacio7j1
                    jne verx8
                very8: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor8y
                    je verificarvacio8j1
                    jne verx9
                very9: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor9y
                    je verificarvacio9j1
                    jne reducirpsonido          ; si la coordenada y no coincide, baja puntos
;------botones-------------------------                    
                botonrendirsej1n1:                   ; boton de rendirse, limpia pantalla y imprime pantalla del jugador ganador
                    clearScreen
                    imprimirPantallas pantallafinalp2
                    jmp fin
                    
                botonsalirse1:
                    clearScreen                         ; boton de salirse, limpia pantalla e imprime las estadisticas
                    imprimirPantallas pantallasalirse   ;para terminar el juego
                    imprimirTexto player1, 8, 12  
                    imprimirDatos usu1, 8, 22
                    imprimirTexto sig1, 8, 24
                    imprimirDatos signo1, 8, 36
                    imprimirTexto puntos1, 8, 38 
                    imprimirDatos puntaje1, 8, 45
                    imprimirTexto player2, 12, 12 
                    imprimirDatos usu2, 12, 22
                    imprimirTexto sig2, 12 ,24
                    imprimirDatos signo2, 12, 36
                    imprimirTexto puntos2, 12, 38
                    imprimirDatos puntaje2, 12, 45
                    jmp fin 
                    
          ;----------verificacion de vacios-----------         
                                                             ; En esta parte se verifica si el espacio clickeado esta vacio
                verificarvacio1j1:                           ; se compara el espacio con cero, si es cero, se le mueve un 1
                    cmp espacio1, 0                          ; indicando que es del jugador1 ahora, y se procede a limpiar el numero
                        je llenar1j1                         ; para colocar la marca del jugador con el color, posteriormente pasa a verificar la victoria del jugador               
                        jne reducirpsonido                   ;En caso que el espacio no sea cero, significa que le pertenece a otro jugador                
                            llenar1j1:                       ; Entonces se bajan puntos y suena el beep              
                                mov espacio1, 1                               
                                jmp marquita1j1                              
                                    marquita1j1:
                                        imprimirTexto limpiar2, 5, 5
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n1
                                         
                verificarvacio2j1:
                    cmp espacio2, 0
                        je llenar2j1
                        jne reducirpsonido
                            llenar2j1:
                                mov espacio2, 1
                                jmp marquita2j1
                                    marquita2j1:
                                        imprimirTexto limpiar2, 5, 16
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n1
                                 
                verificarvacio3j1:   
                    cmp espacio3, 0
                        je llenar3j1
                        jne reducirpsonido 
                            llenar3j1:
                                mov espacio3, 1
                                jmp marquita3j1
                                    marquita3j1:
                                        imprimirTexto limpiar2, 5, 26
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n1 
                verificarvacio4j1:
                    cmp espacio4, 0
                        je llenar4j1
                        jne reducirpsonido
                            llenar4j1:
                                mov espacio4, 1 
                                jmp marquita4j1
                                    marquita4j1:
                                        imprimirTexto limpiar2, 13, 5
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n1
                verificarvacio5j1:
                    cmp espacio5, 0
                        je llenar5j1
                        jne reducirpsonido
                            llenar5j1:
                                mov espacio5, 1
                                jmp marquita5j1
                                    marquita5j1:
                                        imprimirTexto limpiar2, 13, 16
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n1 
                verificarvacio6j1:
                    cmp espacio6, 0
                        je llenar6j1
                        jne reducirpsonido
                            llenar6j1:
                                mov espacio6, 1
                                jmp marquita6j1
                                    marquita6j1:
                                        imprimirTexto limpiar2, 13, 26
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n1 
                verificarvacio7j1:
                    cmp espacio7, 0
                        je llenar7j1
                        jne reducirpsonido
                            llenar7j1:
                                mov espacio7, 1
                                jmp marquita7j1
                                    marquita7j1:
                                        imprimirTexto limpiar2, 19, 5
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n1
                verificarvacio8j1:
                    cmp espacio8, 0
                        je llenar8j1
                        jne reducirpsonido 
                            llenar8j1:
                                mov espacio8, 1 
                                jmp marquita8j1
                                    marquita8j1:
                                        imprimirTexto limpiar2, 19, 16
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n1
                verificarvacio9j1:
                    cmp espacio9, 0
                        je llenar9j1
                        jne reducirpsonido 
                            llenar9j1:
                                mov espacio9, 1
                                jmp marquita9j1
                                    marquita9j1:
                                        imprimirTexto limpiar2, 19, 26
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n1   
                                        
    ;-------Verificacion de la victoria del jugador1---------                                    
                verificarvictoriaj1n1:
                    jmp horizontalj1n1l1                         ; En esta parte se recorre toda la matriz cada vez que hay un click
                    horizontalj1n1l1:                            ; Se recorren las 3 lineas horizontales, 3 verticales y 2 diagonales
                        cmp espacio1, 1                          ; lo que se busca es verificar si los espacios de cada linea tienen el 1
                            je horizontalj1n1p2                  ; del jugador 1, si es asi, se pasa a a adir puntos, si no es asi, se pasa al jugador2
                            jne horizontalj1n1l2
                                horizontalj1n1p2:
                                    cmp espacio2 , 1
                                        je horizontalj1n1p3
                                        jne horizontalj1n1l2
                                            horizontalj1n1p3:
                                                cmp espacio3, 1
                                                    je anadirpuntosnivel1
                                                    jne horizontalj1n1l2
                    horizontalj1n1l2: 
                        cmp espacio4, 1
                            je horizontalj1n1l2p2 
                            jne horizontalj1n1l3
                                horizontalj1n1l2p2:
                                    cmp espacio5 , 1
                                        je horizontalj1n1l2p3
                                        jne horizontalj1n1l3
                                            horizontalj1n1l2p3:
                                                cmp espacio6, 1
                                                    je anadirpuntosnivel1
                                                    jne horizontalj1n1l3
                    horizontalj1n1l3: 
                        cmp espacio7, 1
                            je horizontalj1n1l3p2
                            jne verticalj1n1l1
                                horizontalj1n1l3p2:
                                    cmp espacio8 , 1
                                        je horizontalj1n1l3p3
                                        jne verticalj1n1l1
                                            horizontalj1n1l3p3:
                                                cmp espacio9, 1
                                                    je anadirpuntosnivel1
                                                    jne verticalj1n1l1
                    verticalj1n1l1:
                        cmp espacio7, 1
                            je verticalj1n1l1p2
                            jne verticalj1n1l2
                                verticalj1n1l1p2:
                                    cmp espacio4 , 1
                                        je verticalj1n1l1p3
                                        jne verticalj1n1l2
                                            verticalj1n1l1p3:
                                                cmp espacio1, 1
                                                    je anadirpuntosnivel1
                                                    jne verticalj1n1l2
                    verticalj1n1l2:
                        cmp espacio8, 1
                            je verticalj1n1l2p2
                            jne verticalj1n1l3
                                verticalj1n1l2p2:
                                    cmp espacio5 , 1
                                        je verticalj1n1l2p3
                                        jne verticalj1n1l3
                                            verticalj1n1l2p3:
                                                cmp espacio2, 1
                                                    je anadirpuntosnivel1
                                                    jne verticalj1n1l3
                    verticalj1n1l3:
                        cmp espacio9, 1
                            je verticalj1n1l3p2
                            jne diagonalj1n1l1
                                verticalj1n1l3p2:
                                    cmp espacio6 , 1
                                        je verticalj1n1l3p3
                                        jne diagonalj1n1l1
                                            verticalj1n1l3p3:
                                                cmp espacio3, 1
                                                    je anadirpuntosnivel1
                                                    jne diagonalj1n1l1
                    diagonalj1n1l1: 
                        cmp espacio7, 1
                            je diagonalj1n1l1p2
                            jne diagonalj1n1l2
                                diagonalj1n1l1p2:
                                    cmp espacio5 , 1
                                        je diagonalj1n1l1p3
                                        jne diagonalj1n1l2
                                            diagonalj1n1l1p3:
                                                cmp espacio3, 1
                                                    je anadirpuntosnivel1 
                                                    jne diagonalj1n1l2
                    diagonalj1n1l2:
                        cmp espacio9, 1
                            je diagonalj1n1l2p2
                            jne jugador2n1
                                diagonalj1n1l2p2:
                                    cmp espacio5 , 1
                                        je diagonalj1n1l2p3
                                        jne jugador2n1
                                            diagonalj1n1l2p3:
                                                cmp espacio1, 1
                                                    je anadirpuntosnivel1 
                                                    jne jugador2n1
 ;---------adicion de puntos jugador1-----------                                                   
                anadirpuntosnivel1:                 ; En esta parte, se le a aden 3 puntos al jugador 1
                    xor ax, ax                      ; se actualiza el puntaje en pantalla y se pasa al segundo nivel
                    mov al, puntaje1
                    add al, 3
                    mov puntaje1, al
                    imprimirTexto limpiar2, 3, 69
                    imprimirDatos puntaje1, 3, 69
                    jmp SegundoNivel
                    
                
;----------Jugador2----------------------------                
             jugador2n1:
                imprimirTexto limpiar2, 3, 70              ; se limpia el indicador el jugador1
                imprimirTexto PActivo, 5, 70               ; se a ade el del jugador2
                escribirsignos2:
                inc tiempo                                ;En esta seccion todo es exactamente igual a la del jugador 1
                cmp tiempo, 200                           ; a diferencia que ahora la reduccion del puntaje o la adicion del mismo
                    je SegundoNivel                       ; afectara al jugador2
                xor bx, bx
                mouse    
                cmp bx, 1   
                            
                je verificarcordenadas2
                cmp bx, 2
                je quitarpuntos2
                jmp escribirsignos2
                    quitarpuntos2:
                        mov al, puntaje2
                        sub al, 1
                        mov puntaje2, al
                        imprimirTexto limpiar2, 5, 69
                        imprimirDatos puntaje2, 5, 69
                        jmp jugador1n1                  ; se pasa al jugador 1
                        
                verificarcordenadas2:
                    shr cx, 3
                    shr dx, 3
                    mov mouseX, cx
                    mov mouseY, dx
                    
;-----------Verificacion de coordenadas x jugador 2---------                  
                 verxsalirse2:                             ; En esta seccion es lo mismo que la vista en la del jugador 1
                    mov bx, mouseX
                    cmp bx, corsalirsex
                        je verysalirse2
                        jne verxreiniciar2  
                        
                verxreiniciar2:
                    mov bx, mouseX
                    cmp bx, correiniciarx
                        je veryreiniciar2
                        jne verxrendirse2 
                        
                verxrendirse2:
                    mov bx, mouseX
                    cmp bx, correndirsex
                        je veryrendirse2
                        jne verx1j2
                verx1j2: 
                    mov bx, mouseX
                    cmp bx, cor1x
                        je very1j2
                        jne verx2j2
                        
                verx2j2: 
                    mov bx, mouseX   
                    cmp bx, cor2x
                        je very2j2
                        jne verx3j2
                verx3j2:
                    mov bx, mouseX
                    cmp bx, cor3x
                        je very3j2
                        jne verx4j2
                verx4j2:
                    mov bx, mouseX
                    cmp bx, cor4x
                        je very4j2
                        jne verx5j2
                verx5j2:
                    mov bx, mouseX
                    cmp bx, cor5x
                        je very5j2
                        jne verx6j2
                verx6j2: 
                    mov bx, mouseX
                    cmp bx, cor6x
                        je very6j2
                        jne verx7j2 
                verx7j2: 
                    mov bx, mouseX
                    cmp bx, cor7x
                        je very7j2
                        jne verx8j2
                verx8j2: 
                    mov bx, mouseX
                    cmp bx, cor8x
                        je very8j2
                        jne verx9j2 
                verx9j2:
                    mov bx, mouseX
                    cmp bx, cor9x
                        je very9j2
                        jne reducirpsonido2
                        ;anadir lo de rendirse y etc
                        
                        
                reducirpsonido2:
                    mov al, puntaje2
                        sub al, 1
                        mov puntaje2, al 
                        SoundFailure
                        imprimirTexto limpiar2, 5, 69
                        imprimirDatos puntaje2, 5, 69
                        jmp jugador1n1             ; se pasa al jugador 1
                    
;--------verificacion de coordenadas y jugador 2-----------                    
                verysalirse2:                           ; En esta seccion es lo mismo de la seccion del jugador 1
                    xor bx, bx
                    mov bx, mouseY
                    cmp bx, corsalirsey
                        je botonsalirse2
                        jne verxreiniciar2
                        
                veryreiniciar2:
                    xor bx, bx
                    mov bx, mouseY
                    cmp bx, correiniciary
                        je  main
                        jne verxrendirse2
                        
                veryrendirse2:
                    xor bx, bx
                    mov bx, mouseY
                    cmp bx, correndirsey
                        je botonrendirsej2n1
                        jne verx1j2        
             
                very1j2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor1y
                    je verificarvacio1j2
                    jne verx2j2 
                very2j2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor2y
                    je verificarvacio2j2
                    jne verx3j2
                very3j2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor3y
                    je verificarvacio3j2
                    jne verx4j2  
                    
                very4j2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor4y
                    je verificarvacio4j2
                    jne verx5j2 
                very5j2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor5y
                    je verificarvacio5j2
                    jne verx6j2
                very6j2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor6y
                    je verificarvacio6j2
                    jne verx7j2
                very7j2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor7y
                    je verificarvacio7j2
                    jne verx8j2
                very8j2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor8y
                    je verificarvacio8j2
                    jne verx9j2
                very9j2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor9y
                    je verificarvacio9j2
                    jne reducirpsonido2
    ;----------botones del jugador 2----------             ; En esta seccion es lo mismo que la del jugador 1  
                botonrendirsej2n1:                         ; a diferencia que si se rinde, esta vez gana el jugador 1
                    clearScreen
                    imprimirPantallas pantallafinalp1
                    jmp fin
                    
                botonsalirse2:
                    clearScreen
                    imprimirPantallas pantallasalirse
                    imprimirTexto player1, 8, 12  ;DATOS JUG 1
                    imprimirDatos usu1, 8, 22
                    imprimirTexto sig1, 8, 24
                    imprimirDatos signo1, 8, 36
                    imprimirTexto puntos1, 8, 38 
                    imprimirDatos puntaje1, 8, 45
                    imprimirTexto player2, 12, 12 ;DATOS JUG 2
                    imprimirDatos usu2, 12, 22
                    imprimirTexto sig2, 12 ,24
                    imprimirDatos signo2, 12, 36
                    imprimirTexto puntos2, 12, 38
                    imprimirDatos puntaje2, 12, 45
                    jmp fin     
    ;---------verificacion de vacios jugador 2--------              
                verificarvacio1j2:
                    cmp espacio1, 0                           ; Es exactamente la misma funcionalidad que lo visto en jugador 1
                        je llenar1j2                          ; Pero ahora en vez de a adirle un 1 al espacio, se le a ade un 2       
                        jne reducirpsonido2                                  
                            llenar1j2:                                     
                                mov espacio1, 2                              
                                jmp marquita1j2                              
                                    marquita1j2:
                                        imprimirTexto limpiar2, 5, 5
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n1
                                         
                verificarvacio2j2:
                    cmp espacio2, 0
                        je llenar2j2
                        jne reducirpsonido2
                            llenar2j2:
                                mov espacio2, 2
                                jmp marquita2j2
                                    marquita2j2:
                                        imprimirTexto limpiar2, 5, 16
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n1
                                 
                verificarvacio3j2:   
                    cmp espacio3, 0
                        je llenar3j2
                        jne reducirpsonido2 
                            llenar3j2:
                                mov espacio3, 2
                                jmp marquita3j2
                                    marquita3j2:
                                        imprimirTexto limpiar2, 5, 26
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n1 
                verificarvacio4j2:
                    cmp espacio4, 0
                        je llenar4j2
                        jne reducirpsonido2
                            llenar4j2:
                                mov espacio4, 2 
                                jmp marquita4j2
                                    marquita4j2:
                                        imprimirTexto limpiar2, 13, 5
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n1
                verificarvacio5j2:
                    cmp espacio5, 0
                        je llenar5j2
                        jne reducirpsonido2
                            llenar5j2:
                                mov espacio5, 2
                                jmp marquita5j2
                                    marquita5j2:
                                        imprimirTexto limpiar2, 13, 16
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n1 
                verificarvacio6j2:
                    cmp espacio6, 0
                        je llenar6j2
                        jne reducirpsonido2
                            llenar6j2:
                                mov espacio6, 2
                                jmp marquita6j2
                                    marquita6j2:
                                        imprimirTexto limpiar2, 13, 26
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n1 
                verificarvacio7j2:
                    cmp espacio7, 0
                        je llenar7j2
                        jne reducirpsonido2
                            llenar7j2:
                                mov espacio7, 2
                                jmp marquita7j2
                                    marquita7j2:
                                        imprimirTexto limpiar2, 19, 5
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n1
                verificarvacio8j2:
                    cmp espacio8, 0
                        je llenar8j2
                        jne reducirpsonido2 
                            llenar8j2:
                                mov espacio8, 2 
                                jmp marquita8j2
                                    marquita8j2:
                                        imprimirTexto limpiar2, 19, 16
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n1
                verificarvacio9j2:
                    cmp espacio9, 0
                        je llenar9j2
                        jne reducirpsonido2 
                            llenar9j2:
                                mov espacio9, 2
                                jmp marquita9j2
                                    marquita9j2:
                                        imprimirTexto limpiar2, 19, 26
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n1   
                                        
;-----------verificar victoria del jugador 2-------                                        
                verificarvictoriaj2n1:                    ;Misma funcionalidad que antes solo que comprueba si en el espacio hay un 2
                    jmp horizontalj2n1l1   
                    horizontalj2n1l1:
                        cmp espacio1, 2
                            je horizontalj2n1p2
                            jne horizontalj2n1l2
                                horizontalj2n1p2:
                                    cmp espacio2 , 2
                                        je horizontalj2n1p3
                                        jne horizontalj2n1l2
                                            horizontalj2n1p3:
                                                cmp espacio3, 2
                                                    je anadirpuntosnivel1j2
                                                    jne horizontalj2n1l2
                    horizontalj2n1l2: 
                        cmp espacio4, 2
                            je horizontalj2n1l2p2 
                            jne horizontalj2n1l3
                                horizontalj2n1l2p2:
                                    cmp espacio5 , 2
                                        je horizontalj2n1l2p3
                                        jne horizontalj2n1l3
                                            horizontalj2n1l2p3:
                                                cmp espacio6, 2
                                                    je anadirpuntosnivel1j2
                                                    jne horizontalj2n1l3
                    horizontalj2n1l3: 
                        cmp espacio7, 2
                            je horizontalj2n1l3p2
                            jne verticalj2n1l1
                                horizontalj2n1l3p2:
                                    cmp espacio8 , 2
                                        je horizontalj2n1l3p3
                                        jne verticalj2n1l1
                                            horizontalj2n1l3p3:
                                                cmp espacio9, 2
                                                    je anadirpuntosnivel1j2
                                                    jne verticalj2n1l1
                    verticalj2n1l1:
                        cmp espacio7, 2
                            je verticalj2n1l1p2
                            jne verticalj2n1l2
                                verticalj2n1l1p2:
                                    cmp espacio4 , 2
                                        je verticalj2n1l1p3
                                        jne verticalj2n1l2
                                            verticalj2n1l1p3:
                                                cmp espacio1, 2
                                                    je anadirpuntosnivel1j2
                                                    jne verticalj2n1l2
                    verticalj2n1l2:
                        cmp espacio8, 2
                            je verticalj2n1l2p2
                            jne verticalj2n1l3
                                verticalj2n1l2p2:
                                    cmp espacio5 , 2
                                        je verticalj2n1l2p3
                                        jne verticalj2n1l3
                                            verticalj2n1l2p3:
                                                cmp espacio2, 2
                                                    je anadirpuntosnivel1j2
                                                    jne verticalj2n1l3
                    verticalj2n1l3:
                        cmp espacio9, 2
                            je verticalj2n1l3p2
                            jne diagonalj2n1l1
                                verticalj2n1l3p2:
                                    cmp espacio6 , 2
                                        je verticalj2n1l3p3
                                        jne diagonalj2n1l1
                                            verticalj2n1l3p3:
                                                cmp espacio3, 2
                                                    je anadirpuntosnivel1j2
                                                    jne diagonalj2n1l1
                    diagonalj2n1l1: 
                        cmp espacio7, 2
                            je diagonalj2n1l1p2
                            jne diagonalj2n1l2
                                diagonalj2n1l1p2:
                                    cmp espacio5 , 2
                                        je diagonalj2n1l1p3
                                        jne diagonalj2n1l2
                                            diagonalj2n1l1p3:
                                                cmp espacio3, 2
                                                    je anadirpuntosnivel1 
                                                    jne diagonalj2n1l2
                    diagonalj2n1l2:
                        cmp espacio9, 2
                            je diagonalj2n1l2p2
                            jne jugador1n1
                                diagonalj2n1l2p2:
                                    cmp espacio5 , 2
                                        je diagonalj2n1l2p3
                                        jne jugador1n1
                                            diagonalj2n1l2p3:
                                                cmp espacio1, 2
                                                    je anadirpuntosnivel1j2 
                                                    jne jugador1n1            ; si no hay conecte entre espacios pasa al jugador 1
     ;--------anadir puntos del jugador 2----------                                               
                anadirpuntosnivel1j2:
                    xor ax, ax                          ; Lo mismo que el jugador 1 , solo que en este caso afecta al jugador2
                    mov al, puntaje2                    ; pasa al siguiente nivel
                    add al, 3
                    mov puntaje2, al
                    imprimirTexto limpiar2, 5, 69
                    imprimirDatos puntaje2, 5, 69
                    jmp SegundoNivel
                    
                    
;------------segundo nivel-----------
                                                      
    SegundoNivel:                             ;Todo lo visto en el primer nivel, es igual aca
        mov espacio1, 0                       ; La unica diferencia es que ahora el tiempo a alcanzar es menor
        mov espacio2, 0
        mov espacio3, 0
        mov espacio4, 0
        mov espacio5, 0
        mov espacio6, 0
        mov espacio7, 0
        mov espacio8, 0
        mov espacio9, 0 
        mov tiempo, 00h                                  
        matrizdejuegon2:
             clearScreen
             imprimirTexto m2, 21, 1      
            imprimirTexto m2, 20, 1                  
            imprimirTexto m2, 19, 1
            imprimirTexto m2, 18, 1
            imprimirTexto m2, 17, 1
            imprimirTexto m2, 16, 1
            imprimirTexto m2, 15, 1
            imprimirTexto m2, 14, 1
            imprimirTexto m2, 13, 1
            imprimirTexto m2, 12, 1
            imprimirTexto m2, 11, 1
            imprimirTexto m2, 10, 1
            imprimirTexto m2, 9, 1
            imprimirTexto m2, 8, 1
            imprimirTexto m2, 7, 1
            imprimirTexto m2, 6, 1
            imprimirTexto m2, 5, 1
            imprimirTexto m2, 4, 1
            imprimirTexto m2, 3, 1 
             
            imprimirTexto m1, 16, 1
           
            imprimirTexto m1, 9, 1
            imprimirTexto player1, 3, 35  
            imprimirDatos usu1, 3, 45
            imprimirTexto sig1, 3, 47
            imprimirDatos signo1, 3, 59
            imprimirTexto puntos1, 3, 62 
            imprimirDatos puntaje1, 3, 69
            imprimirTexto player2, 5, 35 
            imprimirDatos usu2, 5, 45
            imprimirTexto sig2, 5 ,47
            imprimirDatos signo2, 5, 59
            imprimirTexto puntos2, 5, 62
            imprimirDatos puntaje2, 5, 69
            imprimirTexto nivel2T,0,14                ; str que indica que es el segundo nivel
            imprimirTexto pressenter,10, 40
            imprimirTexto rendirse 10, 55
            imprimirTexto reiniciar 10,60 
            imprimirTexto salirse 10, 65             
            imprimirTexto limpiar2,23,79
                         
            
            continuarn2:
                    mov ah, 08h
                    int 21h
                    cmp al, 0dh
                    je limpiarTexton2             
                    jmp continuarn2
                    
            limpiarTexton2:
                imprimirTexto limpiar, 10,40
            ponernumerosn2:
                imprimirTexto espacio1s, 5, 5
                imprimirTexto espacio2s, 5, 16
                imprimirTexto espacio3s, 5, 26
                imprimirTexto espacio4s, 13, 5
                imprimirTexto espacio5s, 13, 16
                imprimirTexto espacio6s, 13, 26
                imprimirTexto espacio7s, 19, 5
                imprimirTexto espacio8s, 19, 16
                imprimirTexto espacio9s, 19, 26
                 
 
;----------Comienza la parte del primer jugador en segundo nivel
        jugador1n2:
            imprimirTexto limpiar2, 5, 70             ; Todo es igual que lo visto en el anterior nivel
            imprimirTexto PActivo, 3, 70          
            escribirsignos1n2:
                inc tiempo
                cmp tiempo, 110                      ; El tiempo ahora es mejor
                    je resultadosfinales
                xor bx, bx
                mouse    
                cmp bx, 1   
                            
                je verificarcordenadas1n2
                cmp bx, 2
                je quitarpuntos1n2
                jmp escribirsignos1n2
                    quitarpuntos1n2:
                        mov al, puntaje1
                        sub al, 1
                        mov puntaje1, al
                        imprimirTexto limpiar2, 3, 69
                        imprimirDatos puntaje1, 3, 69
                        jmp jugador2n2  
                        
                verificarcordenadas1n2:
                    shr cx, 3
                    shr dx, 3
                    mov mouseX, cx
                    mov mouseY, dx
         ;-------verificar coordenadas x jugador1 nivel 2------           
                 verxsalirse1n2:                              ; Misma logica que antes
                    mov bx, mouseX
                    cmp bx, corsalirsex
                        je verysalirse1n2
                        jne verxreiniciar1n2  
                        
                verxreiniciar1n2:
                    mov bx, mouseX
                    cmp bx, correiniciarx
                        je veryreiniciar1n2
                        jne verxrendirse1n2 
                        
                verxrendirse1n2:
                    mov bx, mouseX
                    cmp bx, correndirsex
                        je veryrendirse1n2
                        jne verx1n2
                verx1n2: 
                    mov bx, mouseX
                    cmp bx, cor1x
                        je very1n2
                        jne verx2n2
                        
                verx2n2: 
                    mov bx, mouseX   
                    cmp bx, cor2x
                        je very2n2
                        jne verx3n2
                verx3n2:
                    mov bx, mouseX
                    cmp bx, cor3x
                        je very3n2
                        jne verx4n2
                verx4n2:
                    mov bx, mouseX
                    cmp bx, cor4x
                        je very4n2
                        jne verx5n2
                verx5n2:
                    mov bx, mouseX
                    cmp bx, cor5x
                        je very5n2
                        jne verx6n2
                verx6n2: 
                    mov bx, mouseX
                    cmp bx, cor6x
                        je very6n2
                        jne verx7n2 
                verx7n2: 
                    mov bx, mouseX
                    cmp bx, cor7x
                        je very7n2
                        jne verx8n2
                verx8n2: 
                    mov bx, mouseX
                    cmp bx, cor8x
                        je very8n2
                        jne verx9n2 
                verx9n2:
                    mov bx, mouseX
                    cmp bx, cor9x
                        je very9n2
                        jne reducirpsonidon2
                        
                        
                        
                reducirpsonidon2:
                    mov al, puntaje1
                        sub al, 1
                        mov puntaje1, al 
                        SoundFailure
                        imprimirTexto limpiar2, 3, 69
                        imprimirDatos puntaje1, 3, 69
                        jmp jugador2n2
                    
         ;------verificar coordenada y jugador 1 nivel 2-------           
                verysalirse1n2:
                    xor bx, bx                                  ; Misma logica que antes en jugador 1
                    mov bx, mouseY
                    cmp bx, corsalirsey
                        je botonsalirse1n2
                        jne verxreiniciar1n2
                        
                veryreiniciar1n2:
                    xor bx, bx
                    mov bx, mouseY
                    cmp bx, correiniciary
                        je  main
                        jne verxrendirse1n2
                        
                veryrendirse1n2:
                    xor bx, bx
                    mov bx, mouseY
                    cmp bx, correndirsey
                        je botonrendirsej1n2
                        jne verx1n2        
             
                very1n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor1y
                    je verificarvacio1j1n2
                    jne verx2n2 
                very2n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor2y
                    je verificarvacio2j1n2
                    jne verx3n2
                very3n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor3y
                    je verificarvacio3j1n2
                    jne verx4n2  
                    
                very4n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor4y
                    je verificarvacio4j1n2
                    jne verx5n2 
                very5n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor5y
                    je verificarvacio5j1n2
                    jne verx6n2
                very6n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor6y
                    je verificarvacio6j1n2
                    jne verx7n2
                very7n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor7y
                    je verificarvacio7j1n2
                    jne verx8n2
                very8n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor8y
                    je verificarvacio8j1n2
                    jne verx9n2
                very9n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor9y
                    je verificarvacio9j1n2
                    jne reducirpsonidon2
         ;----------- botones del jugador 1-----------           
                botonrendirsej1n2:                                    ; Misma logica que antes en jugador 1
                    clearScreen
                    imprimirPantallas pantallafinalp2
                    jmp fin
                    
                botonsalirse1n2:
                    clearScreen
                    imprimirPantallas pantallasalirse
                    imprimirTexto player1, 8, 12  
                    imprimirDatos usu1, 8, 22
                    imprimirTexto sig1, 8, 24
                    imprimirDatos signo1, 8, 36
                    imprimirTexto puntos1, 8, 38 
                    imprimirDatos puntaje1, 8, 45
                    imprimirTexto player2, 12, 12 
                    imprimirDatos usu2, 12, 22
                    imprimirTexto sig2, 12 ,24
                    imprimirDatos signo2, 12, 36
                    imprimirTexto puntos2, 12, 38
                    imprimirDatos puntaje2, 12, 45
                    jmp fin     
  ;-----------verificacion de vacios jugador 1 nivel 2--------                  
                verificarvacio1j1n2:                              ; Misma logica que antes en jugador 1
                    cmp espacio1, 0
                        je llenar1j1n2                                         
                        jne reducirpsonidon2                                   
                            llenar1j1n2:                                     
                                mov espacio1, 1                               
                                jmp marquita1j1n2                             
                                    marquita1j1n2:
                                        imprimirTexto limpiar2, 5, 5
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n2
                                         
                verificarvacio2j1n2:
                    cmp espacio2, 0
                        je llenar2j1n2
                        jne reducirpsonidon2
                            llenar2j1n2:
                                mov espacio2, 1
                                jmp marquita2j1n2
                                    marquita2j1n2:
                                        imprimirTexto limpiar2, 5, 16
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n2
                                 
                verificarvacio3j1n2:   
                    cmp espacio3, 0
                        je llenar3j1n2
                        jne reducirpsonidon2 
                            llenar3j1n2:
                                mov espacio3, 1
                                jmp marquita3j1n2
                                    marquita3j1n2:
                                        imprimirTexto limpiar2, 5, 26
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n2 
                verificarvacio4j1n2:
                    cmp espacio4, 0
                        je llenar4j1n2
                        jne reducirpsonidon2
                            llenar4j1n2:
                                mov espacio4, 1 
                                jmp marquita4j1n2
                                    marquita4j1n2:
                                        imprimirTexto limpiar2, 13, 5
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n2
                verificarvacio5j1n2:
                    cmp espacio5, 0
                        je llenar5j1n2
                        jne reducirpsonidon2
                            llenar5j1n2:
                                mov espacio5, 1
                                jmp marquita5j1n2
                                    marquita5j1n2:
                                        imprimirTexto limpiar2, 13, 16
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n2 
                verificarvacio6j1n2:
                    cmp espacio6, 0
                        je llenar6j1n2
                        jne reducirpsonidon2
                            llenar6j1n2:
                                mov espacio6, 1
                                jmp marquita6j1n2
                                    marquita6j1n2:
                                        imprimirTexto limpiar2, 13, 26
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n2 
                verificarvacio7j1n2:
                    cmp espacio7, 0
                        je llenar7j1n2
                        jne reducirpsonidon2
                            llenar7j1n2:
                                mov espacio7, 1
                                jmp marquita7j1n2
                                    marquita7j1n2:
                                        imprimirTexto limpiar2, 19, 5
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n2
                verificarvacio8j1n2:
                    cmp espacio8, 0
                        je llenar8j1n2
                        jne reducirpsonidon2 
                            llenar8j1n2:
                                mov espacio8, 1 
                                jmp marquita8j1n2
                                    marquita8j1n2:
                                        imprimirTexto limpiar2, 19, 16
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n2
                verificarvacio9j1n2:
                    cmp espacio9, 0
                        je llenar9j1n2
                        jne reducirpsonidon2 
                            llenar9j1n2:
                                mov espacio9, 1
                                jmp marquita9j1n2
                                    marquita9j1n2:
                                        imprimirTexto limpiar2, 19, 26
                                        colores signo1, 13
                                        jmp verificarvictoriaj1n2   
                                        
        ;-------verificacion de victoria del jugador 1 nivel 2--------                                
                verificarvictoriaj1n2:
                    jmp horizontalj1n2l1                             ; Misma logica que antes en jugador 1
                    horizontalj1n2l1:
                        cmp espacio1, 1
                            je horizontalj1n2p2
                            jne horizontalj1n2l2
                                horizontalj1n2p2:
                                    cmp espacio2 , 1
                                        je horizontalj1n2p3
                                        jne horizontalj1n2l2
                                            horizontalj1n2p3:
                                                cmp espacio3, 1
                                                    je anadirpuntosnivel2
                                                    jne horizontalj1n2l2
                    horizontalj1n2l2: 
                        cmp espacio4, 1
                            je horizontalj1n2l2p2 
                            jne horizontalj1n2l3
                                horizontalj1n2l2p2:
                                    cmp espacio5 , 1
                                        je horizontalj1n2l2p3
                                        jne horizontalj1n2l3
                                            horizontalj1n2l2p3:
                                                cmp espacio6, 1
                                                    je anadirpuntosnivel2
                                                    jne horizontalj1n2l3
                    horizontalj1n2l3: 
                        cmp espacio7, 1
                            je horizontalj1n2l3p2
                            jne verticalj1n2l1
                                horizontalj1n2l3p2:
                                    cmp espacio8 , 1
                                        je horizontalj1n2l3p3
                                        jne verticalj1n2l1
                                            horizontalj1n2l3p3:
                                                cmp espacio9, 1
                                                    je anadirpuntosnivel2
                                                    jne verticalj1n2l1
                    verticalj1n2l1:
                        cmp espacio7, 1
                            je verticalj1n2l1p2
                            jne verticalj1n2l2
                                verticalj1n2l1p2:
                                    cmp espacio4 , 1
                                        je verticalj1n2l1p3
                                        jne verticalj1n2l2
                                            verticalj1n2l1p3:
                                                cmp espacio1, 1
                                                    je anadirpuntosnivel2
                                                    jne verticalj1n2l2
                    verticalj1n2l2:
                        cmp espacio8, 1
                            je verticalj1n2l2p2
                            jne verticalj1n2l3
                                verticalj1n2l2p2:
                                    cmp espacio5 , 1
                                        je verticalj1n2l2p3
                                        jne verticalj1n2l3
                                            verticalj1n2l2p3:
                                                cmp espacio2, 1
                                                    je anadirpuntosnivel2
                                                    jne verticalj1n2l3
                    verticalj1n2l3:
                        cmp espacio9, 1
                            je verticalj1n2l3p2
                            jne diagonalj1n2l1
                                verticalj1n2l3p2:
                                    cmp espacio6 , 1
                                        je verticalj1n2l3p3
                                        jne diagonalj1n2l1
                                            verticalj1n2l3p3:
                                                cmp espacio3, 1
                                                    je anadirpuntosnivel2
                                                    jne diagonalj1n2l1
                    diagonalj1n2l1: 
                        cmp espacio7, 1
                            je diagonalj1n2l1p2
                            jne diagonalj1n2l2
                                diagonalj1n2l1p2:
                                    cmp espacio5 , 1
                                        je diagonalj1n2l1p3
                                        jne diagonalj1n2l2
                                            diagonalj1n2l1p3:
                                                cmp espacio3, 1
                                                    je anadirpuntosnivel2 
                                                    jne diagonalj1n2l2
                    diagonalj1n2l2:
                        cmp espacio9, 1
                            je diagonalj1n2l2p2
                            jne jugador2n2
                                diagonalj1n2l2p2:
                                    cmp espacio5 , 1
                                        je diagonalj1n2l2p3
                                        jne jugador2n2
                                            diagonalj1n2l2p3:
                                                cmp espacio1, 1
                                                    je anadirpuntosnivel2 
                                                    jne jugador2n2
;---------anadir puntos al jugador 1 nivel 2--------                                                    
                anadirpuntosnivel2:            ; Misma logica que antes en jugador 1
                    xor ax, ax                 ; pero ahora en vez de pasar al siguiente nivel
                    mov al, puntaje1           ; se pasa a verificar los resultados finales
                    add al, 3
                    mov puntaje1, al
                    imprimirTexto limpiar2, 3, 69
                    imprimirDatos puntaje1, 3, 69
                    jmp resultadosfinales
                    
                
;-------jugador 2 nivel 2-------------------                
             jugador2n2:                               ; La logica es igual a lo visto anteriormente
                imprimirTexto limpiar2, 3, 70          ; el tiempo se mantiene a lo que se establecio en el segundo nivel
                imprimirTexto PActivo, 5, 70 
                escribirsignos2n2:
                inc tiempo
                cmp tiempo, 110
                    je resultadosfinales
                xor bx, bx
                mouse    
                cmp bx, 1   
                je verificarcordenadas2n2
                cmp bx, 2
                je quitarpuntos2n2
                jmp escribirsignos2n2
                    quitarpuntos2n2:
                        mov al, puntaje2
                        sub al, 1
                        mov puntaje2, al
                        imprimirTexto limpiar2, 5, 69
                        imprimirDatos puntaje2, 5, 69
                        jmp jugador1n2  
                        
                verificarcordenadas2n2:
                    shr cx, 3
                    shr dx, 3
                    mov mouseX, cx
                    mov mouseY, dx 
    ;----------verificar coordenada x jugador 2 nivel 2-----------                
                 verxsalirse2n2:                                ; Misma logica que antes en jugador 2
                    mov bx, mouseX
                    cmp bx, corsalirsex
                        je verysalirse2n2
                        jne verxreiniciar2n2  
                        
                verxreiniciar2n2:
                    mov bx, mouseX
                    cmp bx, correiniciarx
                        je veryreiniciar2n2
                        jne verxrendirse2n2 
                        
                verxrendirse2n2:
                    mov bx, mouseX
                    cmp bx, correndirsex
                        je veryrendirse2n2
                        jne verx1j2n2
                        
                verx1j2n2: 
                    mov bx, mouseX
                    cmp bx, cor1x
                        je very1j2n2
                        jne verx2j2n2
                        
                verx2j2n2: 
                    mov bx, mouseX   
                    cmp bx, cor2x
                        je very2j2n2
                        jne verx3j2n2
                verx3j2n2:
                    mov bx, mouseX
                    cmp bx, cor3x
                        je very3j2n2
                        jne verx4j2n2
                verx4j2n2:
                    mov bx, mouseX
                    cmp bx, cor4x
                        je very4j2n2
                        jne verx5j2n2
                verx5j2n2:
                    mov bx, mouseX
                    cmp bx, cor5x
                        je very5j2n2
                        jne verx6j2n2
                verx6j2n2: 
                    mov bx, mouseX
                    cmp bx, cor6x
                        je very6j2n2
                        jne verx7j2n2 
                verx7j2n2: 
                    mov bx, mouseX
                    cmp bx, cor7x
                        je very7j2n2
                        jne verx8j2n2
                verx8j2n2: 
                    mov bx, mouseX
                    cmp bx, cor8x
                        je very8j2n2
                        jne verx9j2n2 
                verx9j2n2:
                    mov bx, mouseX
                    cmp bx, cor9x
                        je very9j2n2
                        jne reducirpsonido2n2
                        
                        
                        
                reducirpsonido2n2:
                    mov al, puntaje2
                        sub al, 1
                        mov puntaje2, al 
                        SoundFailure
                        imprimirTexto limpiar2, 5, 69
                        imprimirDatos puntaje2, 5, 69
                        jmp jugador1n2
                    
;----- verificar coordenada y jugador 2 nivel 2--------                    
                verysalirse2n2:
                    xor bx, bx                          ; Misma logica que antes en jugador 2
                    mov bx, mouseY
                    cmp bx, corsalirsey
                        je botonsalirse2n2
                        jne verxreiniciar2n2
                        
                veryreiniciar2n2:
                    xor bx, bx
                    mov bx, mouseY
                    cmp bx, correiniciary
                        je  main
                        jne verxrendirse2n2
                        
                veryrendirse2n2:
                    xor bx, bx
                    mov bx, mouseY
                    cmp bx, correndirsey
                        je botonrendirsej2n2
                        jne verx1j2n2        
             
                very1j2n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor1y
                    je verificarvacio1j2n2
                    jne verx2j2n2 
                very2j2n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor2y
                    je verificarvacio2j2n2
                    jne verx3j2n2
                very3j2n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor3y
                    je verificarvacio3j2n2
                    jne verx4j2n2  
                    
                very4j2n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor4y
                    je verificarvacio4j2n2
                    jne verx5j2n2 
                very5j2n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor5y
                    je verificarvacio5j2n2
                    jne verx6j2n2
                very6j2n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor6y
                    je verificarvacio6j2n2
                    jne verx7j2n2
                very7j2n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor7y
                    je verificarvacio7j2n2
                    jne verx8j2n2
                very8j2n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor8y
                    je verificarvacio8j2n2
                    jne verx9j2n2
                very9j2n2: 
                xor bx, bx
                mov bx, mouseY
                cmp bx, cor9y
                    je verificarvacio9j2n2
                    jne reducirpsonido2n2
 ;------------ botones del jugador 2 nivel 2---------------                   
                botonrendirsej2n2:                    ; Misma logica que antes en jugador 2
                    clearScreen
                    imprimirPantallas pantallafinalp1
                    jmp fin
                    
                botonsalirse2n2:
                    clearScreen
                    imprimirPantallas pantallasalirse
                    imprimirTexto player1, 8, 12  
                    imprimirDatos usu1, 8, 22
                    imprimirTexto sig1, 8, 24
                    imprimirDatos signo1, 8, 36
                    imprimirTexto puntos1, 8, 38 
                    imprimirDatos puntaje1, 8, 45
                    imprimirTexto player2, 12, 12 
                    imprimirDatos usu2, 12, 22
                    imprimirTexto sig2, 12 ,24
                    imprimirDatos signo2, 12, 36
                    imprimirTexto puntos2, 12, 38
                    imprimirDatos puntaje2, 12, 45
                    jmp fin     
;-------verificacion de vacios jugador 2 nivel 2---------                    
                verificarvacio1j2n2:                          ; Misma logica que antes en jugador 2
                    cmp espacio1, 0
                        je llenar1j2n2                                    
                        jne reducirpsonido2n2                          
                            llenar1j2n2:                                  
                                mov espacio1, 2                             
                                jmp marquita1j2n2                            
                                    marquita1j2n2:
                                        imprimirTexto limpiar2, 5, 5
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n2
                                         
                verificarvacio2j2n2:
                    cmp espacio2, 0
                        je llenar2j2n2
                        jne reducirpsonido2n2
                            llenar2j2n2:
                                mov espacio2, 2
                                jmp marquita2j2n2
                                    marquita2j2n2:
                                        imprimirTexto limpiar2, 5, 16
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n2
                                 
                verificarvacio3j2n2:   
                    cmp espacio3, 0
                        je llenar3j2n2
                        jne reducirpsonido2n2 
                            llenar3j2n2:
                                mov espacio3, 2
                                jmp marquita3j2n2
                                    marquita3j2n2:
                                        imprimirTexto limpiar2, 5, 26
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n2 
                verificarvacio4j2n2:
                    cmp espacio4, 0
                        je llenar4j2n2
                        jne reducirpsonido2n2
                            llenar4j2n2:
                                mov espacio4, 2 
                                jmp marquita4j2n2
                                    marquita4j2n2:
                                        imprimirTexto limpiar2, 13, 5
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n2
                verificarvacio5j2n2:
                    cmp espacio5, 0
                        je llenar5j2n2
                        jne reducirpsonido2n2
                            llenar5j2n2:
                                mov espacio5, 2
                                jmp marquita5j2n2
                                    marquita5j2n2:
                                        imprimirTexto limpiar2, 13, 16
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n2 
                verificarvacio6j2n2:
                    cmp espacio6, 0
                        je llenar6j2n2
                        jne reducirpsonido2n2
                            llenar6j2n2:
                                mov espacio6, 2
                                jmp marquita6j2n2
                                    marquita6j2n2:
                                        imprimirTexto limpiar2, 13, 26
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n2 
                verificarvacio7j2n2:
                    cmp espacio7, 0
                        je llenar7j2n2
                        jne reducirpsonido2n2
                            llenar7j2n2:
                                mov espacio7, 2
                                jmp marquita7j2n2
                                    marquita7j2n2:
                                        imprimirTexto limpiar2, 19, 5
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n2
                verificarvacio8j2n2:
                    cmp espacio8, 0
                        je llenar8j2n2
                        jne reducirpsonido2n2 
                            llenar8j2n2:
                                mov espacio8, 2 
                                jmp marquita8j2n2
                                    marquita8j2n2:
                                        imprimirTexto limpiar2, 19, 16
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n2
                verificarvacio9j2n2:
                    cmp espacio9, 0
                        je llenar9j2n2
                        jne reducirpsonido2n2 
                            llenar9j2n2:
                                mov espacio9, 2
                                jmp marquita9j2n2
                                    marquita9j2n2:
                                        imprimirTexto limpiar2, 19, 26
                                        colores signo2, 14
                                        jmp verificarvictoriaj2n2   
                                        
  ;----------verificacion de victoria del jugador 2 nivel 2--------                                      
                verificarvictoriaj2n2:
                    jmp horizontalj2n2l1                   ; Misma logica que antes en jugador 2
                    horizontalj2n2l1:
                        cmp espacio1, 2
                            je horizontalj2n2p2
                            jne horizontalj2n2l2
                                horizontalj2n2p2:
                                    cmp espacio2 , 2
                                        je horizontalj2n2p3
                                        jne horizontalj2n2l2
                                            horizontalj2n2p3:
                                                cmp espacio3, 2
                                                    je anadirpuntosnivel2j2
                                                    jne horizontalj2n2l2
                    horizontalj2n2l2: 
                        cmp espacio4, 2
                            je horizontalj2n2l2p2 
                            jne horizontalj2n2l3
                                horizontalj2n2l2p2:
                                    cmp espacio5 , 2
                                        je horizontalj2n2l2p3
                                        jne horizontalj2n2l3
                                            horizontalj2n2l2p3:
                                                cmp espacio6, 2
                                                    je anadirpuntosnivel2j2
                                                    jne horizontalj2n2l3
                    horizontalj2n2l3: 
                        cmp espacio7, 2
                            je horizontalj2n2l3p2
                            jne verticalj2n2l1
                                horizontalj2n2l3p2:
                                    cmp espacio8 , 2
                                        je horizontalj2n2l3p3
                                        jne verticalj2n2l1
                                            horizontalj2n2l3p3:
                                                cmp espacio9, 2
                                                    je anadirpuntosnivel2j2
                                                    jne verticalj2n2l1
                    verticalj2n2l1:
                        cmp espacio7, 2
                            je verticalj2n2l1p2
                            jne verticalj2n2l2
                                verticalj2n2l1p2:
                                    cmp espacio4 , 2
                                        je verticalj2n2l1p3
                                        jne verticalj2n2l2
                                            verticalj2n2l1p3:
                                                cmp espacio1, 2
                                                    je anadirpuntosnivel2j2
                                                    jne verticalj2n2l2
                    verticalj2n2l2:
                        cmp espacio8, 2
                            je verticalj2n2l2p2
                            jne verticalj2n2l3
                                verticalj2n2l2p2:
                                    cmp espacio5 , 2
                                        je verticalj2n2l2p3
                                        jne verticalj2n2l3
                                            verticalj2n2l2p3:
                                                cmp espacio2, 2
                                                    je anadirpuntosnivel2j2
                                                    jne verticalj2n2l3
                    verticalj2n2l3:
                        cmp espacio9, 2
                            je verticalj2n2l3p2
                            jne diagonalj2n2l1
                                verticalj2n2l3p2:
                                    cmp espacio6 , 2
                                        je verticalj2n2l3p3
                                        jne diagonalj2n2l1
                                            verticalj2n2l3p3:
                                                cmp espacio3, 2
                                                    je anadirpuntosnivel2j2
                                                    jne diagonalj2n2l1
                    diagonalj2n2l1: 
                        cmp espacio7, 2
                            je diagonalj2n2l1p2
                            jne diagonalj2n2l2
                                diagonalj2n2l1p2:
                                    cmp espacio5 , 2
                                        je diagonalj2n2l1p3
                                        jne diagonalj2n2l2
                                            diagonalj2n2l1p3:
                                                cmp espacio3, 2
                                                    je anadirpuntosnivel2j2 
                                                    jne diagonalj2n2l2
                    diagonalj2n2l2:
                        cmp espacio9, 2
                            je diagonalj2n2l2p2
                            jne jugador1n2
                                diagonalj2n2l2p2:
                                    cmp espacio5 , 2
                                        je diagonalj2n2l2p3
                                        jne jugador1n2
                                            diagonalj2n2l2p3:
                                                cmp espacio1, 2
                                                    je anadirpuntosnivel2j2 
                                                    jne jugador1n2
 ;----------- anadir puntos al jugador 2 nivel 2---------                                                   
                anadirpuntosnivel2j2:               ; Misma logica que antes en jugador 2
                    xor ax, ax                      ; pero ahora se pasa a resultados finales
                    mov al, puntaje2
                    add al, 3
                    mov puntaje2, al
                    imprimirTexto limpiar2, 5, 69
                    imprimirDatos puntaje2, 5, 69
                    jmp resultadosfinales
                    
;-------Calculos para obtener el ganador----------
resultadosfinales:
    xor ax, ax                   ; En esta seccion se mueve el puntaje del jugador 1 a un registo
    mov al, puntaje1             ; Esto para compararlo con el puntaje del jugador 2
    cmp al, puntaje2             ; Si son iguales va a empate, si es mayor, va a victoriaj1
        je empate                ; si es menor va a victoriaj2
        jg victoriaj1
        jl victoriaj2
        
empate:
    clearScreen
    imprimirPantallas pantallafinalemp           ;se limpia la pantalla y se imprime la pantalla
    imprimirTexto player1, 8, 12                 ; de empate, se procede a ense ar las estadisticas
    imprimirDatos usu1, 8, 22                    ; y se termina el juego
    imprimirTexto sig1, 8, 24
    imprimirDatos signo1, 8, 36
    imprimirTexto puntos1, 8, 38 
    imprimirDatos puntaje1, 8, 45
    imprimirTexto player2, 12, 12 
    imprimirDatos usu2, 12, 22
    imprimirTexto sig2, 12 ,24
    imprimirDatos signo2, 12, 36
    imprimirTexto puntos2, 12, 38
    imprimirDatos puntaje2, 12, 45
    jmp fin

victoriaj1:
    clearScreen
    imprimirPantallas pantallafinalp1        ; se limpia la pantalla y se imprime la pantalla
    imprimirTexto player1, 8, 12             ; de victoria del jugador 1, se ense an las estadisticas
    imprimirDatos usu1, 8, 22                ; primero ense ando la informacion del jugador 1
    imprimirTexto sig1, 8, 24
    imprimirDatos signo1, 8, 36
    imprimirTexto puntos1, 8, 38 
    imprimirDatos puntaje1, 8, 45
    imprimirTexto player2, 12, 12 
    imprimirDatos usu2, 12, 22
    imprimirTexto sig2, 12 ,24
    imprimirDatos signo2, 12, 36
    imprimirTexto puntos2, 12, 38
    imprimirDatos puntaje2, 12, 45  
    jmp fin

victoriaj2:
    clearScreen
    imprimirPantallas pantallafinalp2       ; se limpia la pantalla y se imprime la pantalla
    imprimirTexto player1, 12, 12           ; de victoria del jugador 2, se ense an las estadisticas
    imprimirDatos usu1, 12, 22              ; primero ense ando la informacion del jugador 2
    imprimirTexto sig1, 12, 24
    imprimirDatos signo1, 12, 36
    imprimirTexto puntos1, 12, 38 
    imprimirDatos puntaje1, 12, 45
    imprimirTexto player2, 8, 12 
    imprimirDatos usu2, 8, 22
    imprimirTexto sig2, 8 ,24
    imprimirDatos signo2, 8, 36
    imprimirTexto puntos2, 8, 38
    imprimirDatos puntaje2, 8, 45
    jmp fin            
                    
                
fin:                         ; se termina el juego
    .exit 
    
