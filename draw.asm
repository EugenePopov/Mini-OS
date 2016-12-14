


#make_bin# 

mov ax,0300h
mov ds, ax 
jmp main

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PROCEDURI ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
                                                                                                            
ClearScreen:  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;         Procedura de curatare a ecranului               ;;
;;         Functia 0x06 a intreruperii BIOS 0x10           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

push ax               ; Ã Salvam continutul
push bx               ; | registrelor in starea 
push cx               ; | in care se aflau inainte de
push dx               ; L apelarea functiei

mov ah, 0x06          ; Codul functiei
mov al, 0             ; Numarul de rinduri care vor fi scroll-ate (al=0 -curata ecranul)
mov bh, 0x00          ; Setarile grafice (culoarea fundalului pentru liniile curatate)
mov ch, 7             ; Rindul din care incepe curatarea
mov cl, 12            ; Coloana din care incepe curatarea
mov dh, 24            ; Rindul in care sfirseste curatarea
mov dl, 79            ; Coloana in care sfirseste curatarea
int 0x10              ; Apelarea intreruperii BIOS

pop dx                ; Ã Restabilim 
pop cx                ; | continutul
pop bx                ; | registrelor
pop ax                ; L in starea inainte de apelare
ret
                                                                                                            
                                                                                                            

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
mov bp, offset message             ; salvam offsetul mesajului in bp 
mov cx, 3           ; incarcam in cx numarul de caractere a sirului
mov dh, 4               ; rindul din care incepe afisarea
mov dl, 9         ; coloana din care incepe afisarea
call WriteString

mov bl, 15
mov bp, offset message1             ; salvam offsetul mesajului in bp 
mov cx, 3           ; incarcam in cx numarul de caractere a sirului
mov dh, 4               ; rindul din care incepe afisarea
mov dl, 18         ; coloana din care incepe afisarea
call WriteString 

mov bl, 15
mov bp, offset message2             ; salvam offsetul mesajului in bp 
mov cx, 3           ; incarcam in cx numarul de caractere a sirului
mov dh, 4               ; rindul din care incepe afisarea
mov dl, 27         ; coloana din care incepe afisarea
call WriteString 
 


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
                   
    mov cx, 68
    mov dx, 25
    mov ah, 0dh
    int 10h
    cmp al, 4
    jne rb
    mov x, 68
    mov y, 25
    call DrawButton
    jmp end
    rb:
    mov cx, 140
    mov dx, 25
    mov ah, 0dh
    int 10h
    cmp al, 4
    jne rb1
    mov x, 140
    mov y, 25
    call DrawButton
    jmp end
    rb1:
    mov cx, 212
    mov dx, 25
    mov ah, 0dh
    int 10h
    cmp al, 4
    mov x, 212
    mov y, 25
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
cmp ah, 4dh
jne a
inc location
jmp check
a:
cmp ah, 4bh
jne o
dec location
jmp check
o: 
cmp al, 1bh
jne p  
mov ax, 0600h
mov es, ax
jmp 0600h:0000h
p:
cmp al, 13
jne b
call SelectFunction
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
    call Romb
    jmp end1
    sf:
    cmp location, 2
    jne sf1
    call Triangle
    jmp end1
    sf1:
    cmp location, 3
    jne sf2
    call Rectangle
    jmp end1
    sf2:
    cmp location, 4
    jne sf3
    
    jmp end1
    sf3:  
    
    
    
    end1:
    pop dx               ; ? Restabilim 
    pop cx               ; | continutul
    pop bx               ; | registrelor
    pop ax               ; L in starea inainte de apelare     
    ret
SelectFunction ENDP 


;------------------------------------------------------------------------------
Triangle PROC
;Deseneaza deseneaza un triunghi dreptunghic cu ajutorul functiei OCh/INT 10h;
;Primeste: coordonata X si Y
;Returneaza: Nimic
;------------------------------------------------------------------------------  
    push ax       ;salvam continutul registrelor
    push bx 
    push cx
    push dx  

    mov xw, 140              ;plasam coordonata x
    mov yw, 80              ;plasam coordonata y
    mov ah, draw_pixel           ;introducem codul functiei
    mov al, 6                    ;introducem culoarea de desenare(verde) 
         
    mov cx, 50  ;setam contorul egal cu inaltimea butonului
    w:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc yw                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop w 
    
    mov cx, 50  ;setam contorul egal cu inaltimea butonului
    w1:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc xw                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop w1 
    
    mov cx, 50  ;setam contorul egal cu inaltimea butonului
    w2:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec yw                  ;ne deplasam cu un pixel in jos
    dec xw 
    pop cx                 ;restabilim contorul
    loop w2
 
       
    pop dx              ;rstabilim continutul registrelor
    pop cx
    pop bx
    pop ax
    RET
Triangle ENDP

;------------------------------------------------------------------------------
Romb PROC                             
;Deseneaza deseneaza un triunghi dreptunghic cu ajutorul functiei OCh/INT 10h;
;Primeste: coordonata X si Y
;Returneaza: Nimic
;------------------------------------------------------------------------------  
    push ax       ;salvam continutul registrelor
    push bx 
    push cx
    push dx  

    mov xw, 63              ;plasam coordonata x
    mov yw, 105              ;plasam coordonata y
    mov ah, draw_pixel           ;introducem codul functiei
    mov al, 6                    ;introducem culoarea de desenare(verde) 
         
    mov cx, 25  ;setam contorul egal cu inaltimea butonului
    wo:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc yw                  ;ne deplasam cu un pixel in jos
    inc xw                   
    pop cx                 ;restabilim contorul
    loop wo 
    
    
    mov cx, 25  ;setam contorul egal cu inaltimea butonului
    wo1:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc xw                  ;ne deplasam cu un pixel in jos 
    dec yw
    pop cx                 ;restabilim contorul
    loop wo1 
    
    mov cx, 25  ;setam contorul egal cu inaltimea butonului
    wo2:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec xw                
    dec yw
    pop cx                 ;restabilim contorul
    loop wo2
    
    mov cx, 25  ;setam contorul egal cu inaltimea butonului
    wo3:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec xw                
    inc yw
    pop cx                 ;restabilim contorul
    loop wo3
 
       
    pop dx              ;rstabilim continutul registrelor
    pop cx
    pop bx
    pop ax
    RET
Romb ENDP

;------------------------------------------------------------------------------
Rectangle PROC                             
;Deseneaza deseneaza un triunghi dreptunghic cu ajutorul functiei OCh/INT 10h;
;Primeste: coordonata X si Y
;Returneaza: Nimic
;------------------------------------------------------------------------------  
    push ax       ;salvam continutul registrelor
    push bx 
    push cx
    push dx  

    mov xw, 212              ;plasam coordonata x
    mov yw, 80              ;plasam coordonata y
    mov ah, draw_pixel           ;introducem codul functiei
    mov al, 6                    ;introducem culoarea de desenare(verde) 
         
    mov cx, 50  ;setam contorul egal cu inaltimea butonului
    wo4:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc yw                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop wo4 
    
    
    mov cx, 25  ;setam contorul egal cu inaltimea butonului
    wo5:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc xw                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop wo5 
    
    mov cx, 50  ;setam contorul egal cu inaltimea butonului
    wo6:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere              
    dec yw
    pop cx                 ;restabilim contorul
    loop wo6
    
    mov cx, 25  ;setam contorul egal cu inaltimea butonului
    wo7:
    push cx                ;salvam contorul
    mov cx, xw              ;plasam coordonata x
    mov dx, yw              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec xw                
    pop cx                 ;restabilim contorul
    loop wo7
 
       
    pop dx              ;rstabilim continutul registrelor
    pop cx
    pop bx
    pop ax
    RET
Rectangle ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; FUNCTIA PRINCIPALA ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main:

mov x, 68
mov y, 25
call DrawButton  

mov x, 140
mov y, 25
call DrawButton

mov x, 212
mov y, 25
call DrawButton 
call WriteMessages


;------------------Verificam tasta accesata------------------------
b:
call CheckButton
 

check:
cmp location,0
jnle q
mov location, 3
q:
cmp location,3
jna m
mov location, 1
m:
cmp location,1
jne s
call RedrawButton 
mov x, 68
mov y, 25
call DrawSelectedButton
s:
cmp location,2
jne t
call RedrawButton 
mov x, 140
mov y, 25
call DrawSelectedButton 
t:
cmp location,3
jne b
call RedrawButton
mov x, 212
mov y, 25
call DrawSelectedButton
jmp b
 





jmp $              ;ciclu infinit  





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; DATE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


default_color equ 2      ;culoarea verde
select_color equ 4      ;culoarea rosie
draw_pixel equ 0ch      ;codul functiei de desenare a unui pixel 
button_width equ 30     ;latimea butonului
button_height equ 20    ;inaltimea butonului
window_width equ 210     ;latimea butonului
window_height equ 146    ;inaltimea butonului
frame_width equ 159     ;latimea butonului
frame_height equ 181        ;inaltimea butonului
button_width_int equ 26     ;latimea butonului
button_height_int equ 16    ;inaltimea butonului 
frame_color equ 15
x dw 0                      
y dw 0
xf dw 1                      
yf dw 1
xw dw 80
yw dw 18
x_int dw 0
y_int dw 0 
message db 'rmb',0   
message1 db 'trg', 0
message2 db 'drp', 0


location db 0









 db 512 - ($-$$) DUP(0) 
