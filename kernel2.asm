
#make_bin# 

mov ax,0600h
mov ds, ax
mov xf, 1
mov yf, 1
mov xw, 54
mov yw, 18 
jmp main

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PROCEDURI ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;------------------------------------------------------------------------------
DrawButton PROC
;Deseneaza un buton la coordonata specificata cu ajutorul functiei OCh/INT 10h;
;coordonata indica coltul stinga-sus a butonului
;Primeste: coordonata X si Y
;Returneaza: Nimic
;------------------------------------------------------------------------------  
    push ax       ;salvam continutul registrelor
    push bx 
    push cx
    push dx  
    
    mov ax, x                    
    mov x_int, ax                
    add x_int, 2
    mov ax, y
    mov y_int, ax
    add y_int, 2

    mov ah, draw_pixel           ;introducem codul functiei
    mov al, default_color        ;introducem culoarea de desenare(verde)  
         
    mov cx, button_height  ;setam contorul egal cu inaltimea butonului
    l:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc y                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop l 
    
    mov cx, button_width  ;setam contorul egal cu inaltimea butonului
    l1:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc x                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop l1 
    
    mov cx, button_height  ;setam contorul egal cu inaltimea butonului
    l2:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec y                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop l2
    
    mov cx, button_width  ;setam contorul egal cu inaltimea butonului
    l3:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec x                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop l3 
 
    mov cx, button_height_int  ;setam contorul egal cu inaltimea butonului
    i:
    push cx                ;salvam contorul
    mov cx, x_int              ;plasam coordonata x
    mov dx, y_int              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc y_int                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop i 
    
    mov cx, button_width_int  ;setam contorul egal cu inaltimea butonului
    i1:
    push cx                ;salvam contorul
    mov cx, x_int              ;plasam coordonata x
    mov dx, y_int              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc x_int                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop i1 
    
    mov cx, button_height_int  ;setam contorul egal cu inaltimea butonului
    i2:
    push cx                ;salvam contorul
    mov cx, x_int              ;plasam coordonata x
    mov dx, y_int              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec y_int                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop i2
    
    mov cx, button_width_int  ;setam contorul egal cu inaltimea butonului
    i3:
    push cx                ;salvam contorul
    mov cx, x_int              ;plasam coordonata x
    mov dx, y_int              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec x_int                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop i3
       
    pop dx              ;rstabilim continutul registrelor
    pop cx
    pop bx
    pop ax
    RET
DrawButton ENDP

DrawSelectedButton PROC
;Deseneaza un buton la coordonata specificata cu ajutorul functiei OCh/INT 10h;
;coordonata indica coltul stinga-sus a butonului
;Primeste: coordonata X si Y
;Returneaza: Nimic
;------------------------------------------------------------------------------  
    push ax       ;salvam continutul registrelor
    push bx 
    push cx
    push dx  
    
    mov ax, x                    
    mov x_int, ax                
    add x_int, 2
    mov ax, y
    mov y_int, ax
    add y_int, 2

    mov ah, draw_pixel           ;introducem codul functiei
    mov al, select_color        ;introducem culoarea de desenare(verde)  
         
    mov cx, button_height  ;setam contorul egal cu inaltimea butonului
    ls:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc y                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop ls 
    
    mov cx, button_width  ;setam contorul egal cu inaltimea butonului
    ls1:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc x                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop ls1 
    
    mov cx, button_height  ;setam contorul egal cu inaltimea butonului
    ls2:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec y                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop ls2
    
    mov cx, button_width  ;setam contorul egal cu inaltimea butonului
    ls3:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec x                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop ls3 
 
    mov cx, button_height_int  ;setam contorul egal cu inaltimea butonului
    is:
    push cx                ;salvam contorul
    mov cx, x_int              ;plasam coordonata x
    mov dx, y_int              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc y_int                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop is 
    
    mov cx, button_width_int  ;setam contorul egal cu inaltimea butonului
    is1:
    push cx                ;salvam contorul
    mov cx, x_int              ;plasam coordonata x
    mov dx, y_int              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc x_int                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop is1 
    
    mov cx, button_height_int  ;setam contorul egal cu inaltimea butonului
    is2:
    push cx                ;salvam contorul
    mov cx, x_int              ;plasam coordonata x
    mov dx, y_int              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec y_int                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop is2
    
    mov cx, button_width_int  ;setam contorul egal cu inaltimea butonului
    is3:
    push cx                ;salvam contorul
    mov cx, x_int              ;plasam coordonata x
    mov dx, y_int              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec x_int                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop is3
       
    pop dx              ;rstabilim continutul registrelor
    pop cx
    pop bx
   pop ax
    RET
DrawSelectedButton ENDP

;------------------------------------------------------------------------------
DrawWindow PROC
;Deseneaza fereastra de preview cu ajutorul functiei OCh/INT 10h;
;Primeste: coordonata X si Y
;Returneaza: Nimic
;------------------------------------------------------------------------------  
    push ax       ;salvam continutul registrelor
    push bx 
    push cx
    push dx  
    

    mov ah, draw_pixel           ;introducem codul functiei
    mov al, default_color        ;introducem culoarea de desenare(verde) 
         
    mov cx, window_height  ;setam contorul egal cu inaltimea butonului
    w:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc yw                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop w 
    
    mov cx, window_width  ;setam contorul egal cu inaltimea butonului
    w1:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc xw                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop w1 
    
    mov cx, window_height  ;setam contorul egal cu inaltimea butonului
    w2:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec yw                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop w2
    
    mov cx, window_width  ;setam contorul egal cu inaltimea butonului
    w3:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec xw                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop w3 
 
       
    pop dx              ;rstabilim continutul registrelor
    pop cx
    pop bx
    pop ax
    RET
DrawWindow ENDP 


;------------------------------------------------------------------------------
DrawFrame PROC
;Deseneaza fereastra de preview cu ajutorul functiei OCh/INT 10h;
;Primeste: coordonata X si Y
;Returneaza: Nimic
;------------------------------------------------------------------------------  
    push ax       ;salvam continutul registrelor
    push bx 
    push cx
    push dx  
    

    mov ah, draw_pixel           ;introducem codul functiei
    mov al, 15        ;introducem culoarea de desenare(verde) 
         
    mov cx, frame_height  ;setam contorul egal cu inaltimea butonului
    f:
    push cx                ;salvam contorul
    mov cx, xf              ;plasam coordonata x
    mov dx, yf              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc yf                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop f 
    
    mov cx, frame_width  ;setam contorul egal cu inaltimea butonului
    f1:
    push cx                ;salvam contorul
    mov cx, xf              ;plasam coordonata x
    mov dx, yf              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc xf                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop f1 
    
    mov xf, 159
    mov yf, 1
    
    mov cx, frame_width  ;setam contorul egal cu inaltimea butonului
    f3:
    push cx                ;salvam contorul
    mov cx, xf              ;plasam coordonata x
    mov dx, yf              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec xf                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop f3


    mov xf, 159
    mov yf, 182
    mov cx, frame_width  ;setam contorul egal cu inaltimea butonului
    f4:
    push cx                ;salvam contorul
    mov cx, xf              ;plasam coordonata x
    mov dx, yf              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc xf                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop f4 
    
    
    mov cx, frame_height  ;setam contorul egal cu inaltimea butonului
    f5:
    push cx                ;salvam contorul
    mov cx, xf              ;plasam coordonata x
    mov dx, yf              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec yf                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop f5 
    
    
    mov cx, frame_width  ;setam contorul egal cu inaltimea butonului
    f6:
    push cx                ;salvam contorul
    mov cx, xf              ;plasam coordonata x
    mov dx, yf              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec xf                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop f6 
    
    mov xf, 3
    mov yf, 3
    mov cx, frame_height-4  ;setam contorul egal cu inaltimea butonului
    fi:
    push cx                ;salvam contorul
    mov cx, xf              ;plasam coordonata x
    mov dx, yf              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc yf                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop fi 
    
    mov cx, frame_width-2  ;setam contorul egal cu inaltimea butonului
    fi1:
    push cx                ;salvam contorul
    mov cx, xf              ;plasam coordonata x
    mov dx, yf              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc xf                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop fi1 
    
    mov xf, 159
    mov yf, 3
    
    mov cx, frame_width-2  ;setam contorul egal cu inaltimea butonului
    fi3:
    push cx                ;salvam contorul
    mov cx, xf              ;plasam coordonata x
    mov dx, yf              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec xf                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop fi3


    mov xf, 159
    mov yf, 180
    mov cx, frame_width-2  ;setam contorul egal cu inaltimea butonului
    fi4:
    push cx                ;salvam contorul
    mov cx, xf              ;plasam coordonata x
    mov dx, yf              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc xf                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop fi4 
    
    
    mov cx, frame_height-4  ;setam contorul egal cu inaltimea butonului
    fi5:
    push cx                ;salvam contorul
    mov cx, xf              ;plasam coordonata x
    mov dx, yf              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec yf                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop fi5 
    
    
    mov cx, frame_width-2  ;setam contorul egal cu inaltimea butonului
    fi6:
    push cx                ;salvam contorul
    mov cx, xf              ;plasam coordonata x
    mov dx, yf              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec xf                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop fi6
    
    pop dx              ;rstabilim continutul registrelor
    pop cx
    pop bx
    pop ax
    RET
DrawFrame ENDP

WriteString:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Procedura de afisare a unui sir de caractere         ;;
;;     Functia  0x13 a intreruperii BIOS 0x10              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10	    ; Call video interrupt   
ret


WriteMessages:

push ax                  ; ? Salvam continutul
push bx                  ; | registrelor in starea 
push cx                  ; | in care se aflau inainte de
push dx                  ; L apelarea functiei

mov bl, 15
mov bp, offset message2             ; salvam offsetul mesajului in bp 
mov cx, mess2_len  ; incarcam in cx numarul de caractere a sirului
mov dh, 24               ; rindul din care incepe afisarea
mov dl, 2         ; coloana din care incepe afisarea
call WriteString 

mov bl, 2
mov bp, offset button             ; salvam offsetul mesajului in bp 
mov cx, 4  ; incarcam in cx numarul de caractere a sirului
mov dh, 3               ; rindul din care incepe afisarea
mov dl, 2        ; coloana din care incepe afisarea
call WriteString

mov bl, 2
mov bp, offset button1             ; salvam offsetul mesajului in bp 
mov cx, 4  ; incarcam in cx numarul de caractere a sirului
mov dh, 7               ; rindul din care incepe afisarea
mov dl, 2        ; coloana din care incepe afisarea
call WriteString 

mov bl, 2
mov bp, offset button2             ; salvam offsetul mesajului in bp 
mov cx, 4  ; incarcam in cx numarul de caractere a sirului
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 2        ; coloana din care incepe afisarea
call WriteString

mov bl, 2
mov bp, offset button3             ; salvam offsetul mesajului in bp 
mov cx, 4  ; incarcam in cx numarul de caractere a sirului
mov dh, 15               ; rindul din care incepe afisarea
mov dl, 2        ; coloana din care incepe afisarea
call WriteString

mov bl, 2
mov bp, offset button4             ; salvam offsetul mesajului in bp 
mov cx, 4  ; incarcam in cx numarul de caractere a sirului
mov dh, 3               ; rindul din care incepe afisarea
mov dl, 74        ; coloana din care incepe afisarea
call WriteString

mov bl, 2
mov bp, offset button5             ; salvam offsetul mesajului in bp 
mov cx, 4  ; incarcam in cx numarul de caractere a sirului
mov dh, 7               ; rindul din care incepe afisarea
mov dl, 74        ; coloana din care incepe afisarea
call WriteString 

mov bl, 2
mov bp, offset button6             ; salvam offsetul mesajului in bp 
mov cx, 4  ; incarcam in cx numarul de caractere a sirului
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 74        ; coloana din care incepe afisarea
call WriteString 

mov bl, 2
mov bp, offset button7             ; salvam offsetul mesajului in bp 
mov cx, 4  ; incarcam in cx numarul de caractere a sirului
mov dh, 15               ; rindul din care incepe afisarea
mov dl, 74        ; coloana din care incepe afisarea
call WriteString 
 

mov bl, 15
mov bp, offset message1             ; salvam offsetul mesajului in bp
mov cx, 17  ; incarcam in cx numarul de caractere a sirului
mov dh, 23               ; rindul din care incepe afisarea
mov dl, 13         ; coloana din care incepe afisarea
call WriteString 



mov ah, 01h             ;ascundem
mov cx, 2607h            ;cursorul
int 10h

pop dx               ; ? Restabilim 
pop cx               ; | continutul
pop bx               ; | registrelor
pop ax               ; L in starea inainte de apelare     
ret
   
RedrawButton PROC
    push ax                  ; ? Salvam continutul
    push bx                  ; | registrelor in starea 
    push cx                  ; | in care se aflau inainte de
    push dx                  ; L apelarea functiei   
                   
    mov cx, 12
    mov dx, 18
    mov ah, 0dh
    int 10h
    cmp al, 4
    jne rb
    mov x, 12
    mov y, 18
    call DrawButton
    jmp end
    rb:
    mov cx, 12
    mov dx, 49
    mov ah, 0dh
    int 10h
    cmp al, 4
    jne rb1
    mov x, 12
    mov y, 49
    call DrawButton
    jmp end
    rb1:
    mov cx, 12
    mov dx, 80
    mov ah, 0dh
    int 10h
    cmp al, 4
    jne rb2
    mov x, 12
    mov y, 80
    call DrawButton
    jmp end
    rb2:
    mov cx, 12
    mov dx, 112
    mov ah, 0dh
    int 10h
    cmp al, 4
    jne rb3
    mov x, 12
    mov y, 112
    call DrawButton
    jmp end
;    rb3:
;    mov cx, 12
;    mov dx, 144
;    mov ah, 0dh
;    int 10h
;    cmp al, 4
;    jne rb4
;    mov x, 12
;    mov y, 144
;    call DrawButton
;    jmp end
    
    rb3:
    mov cx, 268
    mov dx, 18
    mov ah, 0dh
    int 10h
    cmp al, 4
    jne rb4
    mov x, 268
    mov y, 18
    call DrawButton 
    
    rb4:
    mov cx, 268
    mov dx, 49
    mov ah, 0dh
    int 10h
    cmp al, 4 
    jne rb5
    mov x, 268
    mov y, 49
    call DrawButton
    
    rb5:
    mov cx, 268
    mov dx, 80
    mov ah, 0dh
    int 10h
    cmp al, 4
    jne rb6
    mov x, 268
    mov y, 80
    call DrawButton 
    
    rb6:
    mov cx, 268
    mov dx, 80
    mov ah, 0dh
    int 10h
    cmp al, 4
    mov x, 268
    mov y, 112
    call DrawButton

    end:
    pop dx               ; ? Restabilim 
    pop cx               ; | continutul
    pop bx               ; | registrelor
    pop ax               ; L in starea inainte de apelare  
    
    
    ret
RedrawButton ENDP 


CheckButton PROC
mov ah , 00h
int 16h
cmp ah, 50h
jne a
inc location
jmp check
a:
cmp ah, 48h
jne o
dec location
jmp check
o:
cmp al, 13
jne df
call SelectFunction
df:
cmp ah, 3bh
jne b
call Help
ret 
CheckButton ENDP

SelectFunction PROC
    push ax                  ; ? Salvam continutul
    push bx                  ; | registrelor in starea 
    push cx                  ; | in care se aflau inainte de
    push dx                  ; L apelarea functiei 
     
     
    cmp location, 0
    je b     
    cmp location, 1
    jne sf
    call Morse
    jmp end1
    sf:
    cmp location, 2
    jne sf1
    call Calc
    jmp end1
    sf1:
    cmp location, 3
    jne sf2
    call Time
    jmp end1
    sf2:
    cmp location, 4
    jne sf3
    call Info
    jmp end1
    sf3:
    cmp location, 5
    jne sf4
    call Draw
    jmp end1
    sf4:
    cmp location, 6
    jne sf5
    call Game
    jmp end1
    sf5:
    cmp location, 7
    jne sf6
    
    jmp end1
    sf6:  
    call Help
    
    
    end1:
    pop dx               ; ? Restabilim 
    pop cx               ; | continutul
    pop bx               ; | registrelor
    pop ax               ; L in starea inainte de apelare     
    ret
SelectFunction ENDP 


Draw PROC

mov ah, 02h
mov al, 3
mov ch, 0
mov cl, 9
mov dh, 0
mov dl, 0
mov bx, 0300h
mov es, bx 
mov bx, 0   
int 13h    

jmp     0300h:0000h
ret
Draw ENDP 

Time PROC

mov ah, 02h
mov al, 1
mov ch, 0
mov cl, 12
mov dh, 0
mov dl, 0
mov bx, 0400h
mov es, bx 
mov bx, 0   
int 13h    

jmp     0400h:0000h
ret
Time ENDP  

Calc PROC

mov ah, 02h
mov al, 3
mov ch, 0
mov cl, 13
mov dh, 0
mov dl, 0
mov bx, 0500h
mov es, bx 
mov bx, 0   
int 13h    

jmp     0500h:0000h
ret
Calc ENDP

Morse PROC

mov ah, 02h
mov al, 1
mov ch, 0
mov cl, 16
mov dh, 0
mov dl, 0
mov bx, 0200h
mov es, bx 
mov bx, 0   
int 13h    

jmp     0200h:0000h
ret
Morse ENDP  

Info PROC

mov ah, 02h
mov al, 2
mov ch, 0
mov cl, 17
mov dh, 0
mov dl, 0
mov bx, 0900h
mov es, bx 
mov bx, 0   
int 13h    

jmp     0900h:0000h
ret
Info ENDP 

Game PROC

mov ah, 02h
mov al, 5
mov ch, 1
mov cl, 1
mov dh, 0
mov dl, 0
mov bx, 0450h
mov es, bx 
mov bx, 0   
int 13h    

jmp     0450h:0000h
ret
Game ENDP

Help PROC

mov ah, 02h
mov al, 1
mov ch, 1
mov cl, 6
mov dh, 0
mov dl, 0
mov bx, 0950h
mov es, bx 
mov bx, 0   
int 13h    

jmp     0950h:0000h
ret
Help ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; FUNCTIA PRINCIPALA ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main:
xor ah, ah       ;initializam
mov al, 13h      ;modul
int 10h          ;grafic  320x200 pixeli

mov x, 12
mov y, 18
call DrawButton

mov x, 12
mov y, 49 
call DrawButton 

mov x, 12
mov y, 80
call DrawButton

mov x, 12
mov y, 112
call DrawButton



mov x, 268
mov y, 18
call DrawButton

mov x, 268
mov y, 49
call DrawButton

mov x, 268
mov y, 80
call DrawButton 

mov x, 268
mov y, 112
call DrawButton

call DrawWindow
call WriteMessages
call DrawFrame

;------------------Verificam tasta accesata------------------------
b:
call CheckButton
 

check:
cmp location,0
jnle q
mov location, 8
q:
cmp location,8
jna m
mov location, 1
m:
cmp location,1
jne s
call RedrawButton 
mov x, 12
mov y, 18
call DrawSelectedButton
s:
cmp location,2
jne t
call RedrawButton 
mov x, 12
mov y, 49
call DrawSelectedButton 
t:
cmp location,3
jne u
call RedrawButton
mov x, 12
mov y, 80
call DrawSelectedButton
u:
cmp location,4
jne g
call RedrawButton
mov x, 12
mov y, 112
call DrawSelectedButton

g:
cmp location,5
jne z
call RedrawButton
mov x, 268
mov y, 18
call DrawSelectedButton
z:
cmp location,6
jne c
call RedrawButton
mov x, 268
mov y, 49
call DrawSelectedButton
c:
cmp location,7
jne v
call RedrawButton
mov x, 268
mov y, 80
call DrawSelectedButton
v:
cmp location,8
jne b
call RedrawButton
mov x, 268
mov y, 112
call DrawSelectedButton 
jmp b
 


jmp $              ;ciclu infinit  





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; DATE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


default_color equ 2      ;culoarea verde
select_color equ 4      ;culoarea rosie
draw_pixel equ 0ch      ;codul functiei de desenare a unui pixel 
button_width equ 39     ;latimea butonului
button_height equ 20    ;inaltimea butonului
window_width equ 210     ;latimea butonului
window_height equ 146    ;inaltimea butonului
frame_width equ 159     ;latimea butonului
frame_height equ 181        ;inaltimea butonului
button_width_int equ 35     ;latimea butonului
button_height_int equ 16    ;inaltimea butonului 
frame_color equ 15
x dw 0                      
y dw 0
xf dw 1                      
yf dw 1
xw dw 53
yw dw 18
x_int dw 0
y_int dw 0 
message1 db 27,18, 26,'-select button',0
message2 db '[ENTER]-acces [ESC]-return [F1]-help',0
mess2_len = $-message2
button db 'BEEP', 0   
button1 db 'CALC', 0
button2 db 'TIME', 0  
button3 db 'INFO', 0 
button4 db 'DRAW', 0 
button5 db 'GAME', 0
button6 db 'FILE', 0
button7 db 'HELP', 0
location db 0


                                                 
 db 512 - ($-$$) DUP(0) 
