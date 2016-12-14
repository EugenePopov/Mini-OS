#make_bin#

mov ax,0450h
mov ds, ax 
jmp main 

WriteString PROC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Procedura de afisare a unui sir de caractere         ;;
;;     Functia  0x13 a intreruperii BIOS 0x10              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10	    ; Call video interrupt   
ret
WriteString ENDP

DisplayHour PROC 
xor ax, ax
mov al, buffer_hour1
ror ax, 4
xor bx, bx
mov bl, ah
rol bx, 4 
xor al, 30h
xor bh, 30h
mov tetrad1, al
mov tetrad2, bh 
mov bp, offset tetrad1            ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 0eh              ; setam codul culorii
mov cx, 1     ; incarcam in cx numarul de caractere a sirului 
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 21         ; coloana din care incepe afisarea
call WriteString
mov bp, offset tetrad2            ; salvam offsetul mesajului in bp (Hello World!)
mov cx, 1     ; incarcam in cx numarul de caractere a sirului
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 22         ; coloana din care incepe afisarea
call WriteString	    ; Call video interrupt  
mov bp, offset message            ; salvam offsetul mesajului in bp (Hello World!)
mov cx, 9     ; incarcam in cx numarul de caractere a sirului
mov dh, 9               ; rindul din care incepe afisarea
mov dl, 20         ; coloana din care incepe afisarea
call WriteString
ret
DisplayHour ENDP 

DisplayMinute PROC
xor ax, ax 
mov al, buffer_minute1
ror ax, 4
xor bx, bx
mov bl, ah
rol bx, 4 
xor al, 30h
xor bh, 30h
mov tetrad1, al
mov tetrad2, bh 
mov bp, offset tetrad1            ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 0eh              ; setam codul culorii
mov cx, 1     ; incarcam in cx numarul de caractere a sirului 
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 24         ; coloana din care incepe afisarea
call WriteString
mov bp, offset tetrad2            ; salvam offsetul mesajului in bp (Hello World!)
mov cx, 1     ; incarcam in cx numarul de caractere a sirului
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 25         ; coloana din care incepe afisarea 
call WriteString
ret
DisplayMinute ENDP  

DisplaySecond PROC
xor ax, ax 
mov al, buffer_second1
ror ax, 4
xor bx, bx
mov bl, ah
rol bx, 4 
xor al, 30h
xor bh, 30h
mov tetrad1, al
mov tetrad2, bh 
mov bp, offset tetrad1            ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 0eh              ; setam codul culorii
mov cx, 1     ; incarcam in cx numarul de caractere a sirului 
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 27         ; coloana din care incepe afisarea
call WriteString
mov bp, offset tetrad2            ; salvam offsetul mesajului in bp (Hello World!)
mov cx, 1     ; incarcam in cx numarul de caractere a sirului
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 28         ; coloana din care incepe afisarea
call WriteString	    ; Call video interrupt    
mov ah, 01h             ;ascundem
mov cx, 2607h            ;cursorul
int 10h
ret
DisplaySecond ENDP 



DisplaySign PROC
    mov bp, offset points            ; salvam offsetul mesajului in bp (Hello World!)
    mov bl, 0eh             ; setam codul culorii
    mov cx, 1     ; incarcam in cx numarul de caractere a sirului
    mov dh, 11               ; rindul din care incepe afisarea
    mov dl, 23         ; coloana din care incepe afisarea
    call WriteString
    ret
DisplaySign ENDP

DisplaySign1 PROC
    mov bp, offset points            ; salvam offsetul mesajului in bp (Hello World!)
    mov bl, 0eh             ; setam codul culorii
    mov cx, 1     ; incarcam in cx numarul de caractere a sirului
    mov dh, 11               ; rindul din care incepe afisarea
    mov dl, 26        ; coloana din care incepe afisarea
    call WriteString
    ret
DisplaySign1 ENDP

CalcSecond PROC 
    
    push ax
    push bx
    push cx
    push dx
    
    mov al, buffer_second1
    rol ax, 4
    rol al, 4
    
    
    mov bl, buffer_second
    rol bx, 4
    rol bl, 4 
    
    sub al, bl
    cmp al, 0
    jnl c
    neg al
    c:
    sub ah, bh
    cmp ah, 0
    jnl d
    neg ah
    mov sign, 1
    d:
    
    cmp sign, 1
    jne e
    mov bh, 06h
    mov bl, 00h
    sub bl, al
    cmp bl, 0
    jnl g
    neg bl
    sub bl, 10
    neg bl
    dec bh
    g:
    sub bh, ah
    ror bl, 4
    ror bx, 4
    mov buffer_second1, bl 
    jmp f
    e:
    ror al, 4
    ror ax, 4
    mov buffer_second1, al 
    f:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
CalcSecond ENDP     

CalcMinute PROC 
    
    push ax
    push bx
    push cx
    push dx
    
    mov al, buffer_minute1
    rol ax, 4
    rol al, 4
    
    
    mov bl, buffer_minute
    rol bx, 4
    rol bl, 4 
    
    sub al, bl
    cmp al, 0
    jnl c1
    neg al
    c1:
    sub ah, bh
    cmp ah, 0
    jnl d1
    neg ah
    mov sign, 1
    d1:
    
    cmp sign, 1
    jne e1
    mov bh, 06h
    mov bl, 00h
    sub bl, al
    cmp bl, 0
    jnl g1
    neg bl
    sub bl, 10
    neg bl
    dec bh
    g1:
    sub bh, ah
    ror bl, 4
    ror bx, 4 
    mov buffer_minute1, bl    
    jmp f1
    e1:
    ror al, 4
    ror ax, 4
    mov buffer_minute1, al 
    f1:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
CalcMinute ENDP  

CalcHour PROC 
    
    push ax
    push bx
    push cx
    push dx
    
    mov al, buffer_hour1
    rol ax, 4
    rol al, 4
    
    
    mov bl, buffer_hour
    rol bx, 4
    rol bl, 4 
    
    sub al, bl
    cmp al, 0
    jnl c2
    neg al
    c2:
    sub ah, bh
    cmp ah, 0
    jnl d2
    neg ah
    mov sign, 1
    d2:
    
    cmp sign, 1
    jne e2
    mov bh, 06h
    mov bl, 00h
    sub bl, al
    cmp bl, 0
    jnl g2
    neg bl
    sub bl, 10
    neg bl
    dec bh
    g2:
    sub bh, ah
    ror bl, 4
    ror bx, 4 
    mov buffer_hour1, bl 
    jmp f2
    e2:
    ror al, 4
    ror ax, 4
    mov buffer_hour1, al 
    f2:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
CalcHour ENDP

;------------------------------------------------------------------------------
DrawField PROC
;Deseneaza fereastra de preview cu ajutorul functiei OCh/INT 10h;
;Primeste: coordonata X si Y
;Returneaza: Nimic
;------------------------------------------------------------------------------  
    push ax       ;salvam continutul registrelor
    push bx 
    push cx
    push dx  
    
    mov x, 60
    mov y, 38
    mov xv, 70
    mov yv, 38
    mov xh, 60
    mov yh, 48
    
    mov ah, 0ch           ;introducem codul functiei
    mov al, 15        ;introducem culoarea de desenare(verde) 
         
    mov cx, dimension  ;setam contorul egal cu inaltimea butonului
    w:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc y                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop w 
    
    mov cx, dimension  ;setam contorul egal cu inaltimea butonului
    w1:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc x                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop w1 
    
    mov cx, dimension  ;setam contorul egal cu inaltimea butonului
    w2:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec y                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop w2
    
    mov cx, dimension  ;setam contorul egal cu inaltimea butonului
    w3:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec x                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop w3 
    
    mov cx, 7 
    a:
    call DrawVertical
    add xv, 10
    mov yv, 38
    loop a    

    mov cx, 7 
    b1:
    call DrawHorizontal
    add yh, 10
    mov xh, 60
    loop b1
       
    pop dx              ;rstabilim continutul registrelor
    pop cx
    pop bx
    pop ax
    RET
DrawField ENDP 

;------------------------------------------------------------------------------
DrawVertical PROC
;Deseneaza fereastra de preview cu ajutorul functiei OCh/INT 10h;
;Primeste: coordonata X si Y
;Returneaza: Nimic
;------------------------------------------------------------------------------  
    push ax       ;salvam continutul registrelor
    push bx 
    push cx
    push dx  

    

    mov ah, 0ch           ;introducem codul functiei
    mov al, 15        ;introducem culoarea de desenare(verde) 

    mov cx, dimension  ;setam contorul egal cu inaltimea butonului
    v:
    push cx                ;salvam contorul
    mov cx, xv              ;plasam coordonata x
    mov dx, yv              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc yv                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop v                 ;restabilim contorul

       
    pop dx              ;rstabilim continutul registrelor
    pop cx
    pop bx
    pop ax
    RET
DrawVertical ENDP 

;------------------------------------------------------------------------------
DrawHorizontal PROC
;Deseneaza fereastra de preview cu ajutorul functiei OCh/INT 10h;
;Primeste: coordonata X si Y
;Returneaza: Nimic
;------------------------------------------------------------------------------  
    push ax       ;salvam continutul registrelor
    push bx 
    push cx
    push dx  
    
    
    mov ah, 0ch           ;introducem codul functiei
    mov al, 15        ;introducem culoarea de desenare(verde) 

    mov cx, dimension  ;setam contorul egal cu inaltimea butonului
    h:
    push cx                ;salvam contorul
    mov cx, xh              ;plasam coordonata x
    mov dx, yh              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc xh                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop h                 ;restabilim contorul

       
    pop dx              ;rstabilim continutul registrelor
    pop cx
    pop bx
    pop ax
    RET
DrawHorizontal ENDP

;------------------------------------------------------------------------------
Fill PROC
;Deseneaza fereastra de preview cu ajutorul functiei OCh/INT 10h;
;Primeste: coordonata X si Y
;Returneaza: Nimic
;------------------------------------------------------------------------------  
    push ax       ;salvam continutul registrelor
    push bx 
    push cx
    push dx  
    
    mov bx, xsel
    inc bx
    mov xf, bx
    mov bx, ysel
    inc bx
    mov yf, bx
    mov ah, 0ch           ;introducem codul functiei
    mov al, 4        ;introducem culoarea de desenare(verde) 
    
    mov cx, 9
    fl:
    push cx

    mov cx, 9  ;setam contorul egal cu inaltimea butonului
    fl1:
    push cx                ;salvam contorul
    mov cx, xf              ;plasam coordonata x
    mov dx, yf              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc xf                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop fl1                 ;restabilim contorul
    
    mov bx, xsel
    inc bx
    mov xf, bx
    inc yf
    pop cx
    loop fl
    

    call CheckField
  
    pop dx              ;rstabilim continutul registrelor
    pop cx
    pop bx
    pop ax
    RET
Fill ENDP   

CheckButton PROC
mov ah , 00h
int 16h
cmp ah, 4dh
jne a1
inc locationh
inc xg
add xsel, 10
;mov ysel, 38
jmp check
a1:
cmp ah, 4bh
jne ov
dec locationh
dec xg 
sub xsel, 10
;mov ysel, 38
jmp check 
ov:
cmp ah, 50h
jne as
inc locationv 
inc yg
add ysel, 10
jmp check1
as:
cmp ah, 48h
jne o
dec locationv
dec yg
sub ysel, 10
jmp check1
o: 
cmp al, 1bh
jne p  
mov ax, 0600h
mov es, ax
jmp 0600h:0000h
p:
cmp al, 13
jne b
cmp count, 0
jne jk
call Fill
call InitialTime
call CheckCoordonate
inc count
jmp ui
jk:
;call CheckCoordonate
mov ax, x1
mov bx, y1
cmp xsel, ax
jne we
cmp ysel, bx
jne we
call Fill 
call CheckCoordonate 
jmp ui

we: 
;call CheckCoordonate
mov ax, x2
mov bx, y2
cmp xsel, ax
jne we1
cmp ysel, bx
jne we1
call Fill 
call CheckCoordonate
jmp ui

we1: 
;call CheckCoordonate
mov ax, x3
mov bx, y3
cmp xsel, ax
jne we2
cmp ysel, bx
jne we2
call Fill
call CheckCoordonate
jmp ui

we2:
;call CheckCoordonate
mov ax, x4
mov bx, y4
cmp xsel, ax
jne we3
cmp ysel, bx
jne we3
call Fill
call CheckCoordonate
jmp ui

we3:
;call CheckCoordonate
mov ax, x5
mov bx, y5
cmp xsel, ax
jne we4
cmp ysel, bx
jne we4
call Fill
call CheckCoordonate
jmp ui

we4:
;call CheckCoordonate
mov ax, x6
mov bx, y6
cmp xsel, ax
jne we5
cmp ysel, bx
jne we5
call Fill
call CheckCoordonate 
jmp ui

we5: 
;call CheckCoordonate
mov ax, x7
mov bx, y7
cmp xsel, ax
jne we6
cmp ysel, bx
jne we6
call Fill
call CheckCoordonate 
jmp ui

we6:
;call CheckCoordonate
mov ax, x8
mov bx, y8
cmp xsel, ax
jne ui
cmp ysel, bx
jne ui
call Fill
call CheckCoordonate 
jmp ui

ui:
ret 
CheckButton ENDP  

CheckCoordonate PROC 
    push ax                  ; ? Salvam continutul
    push bx                  ; | registrelor in starea 
    push cx                  ; | in care se aflau inainte de
    push dx                  ; L apelarea functiei   
    
    sub yf, 10
    dec xf 
    mov ax, xf
    mov bx, yf 
    
    add ax, 10
    sub bx, 20
    mov x1, ax
    mov y1, bx 
    
    mov ax, xf
    mov bx, yf 
    
    add ax, 20
    sub bx, 10
    mov x2, ax
    mov y2, bx

    mov ax, xf
    mov bx, yf 
    
    add ax, 20
    add bx, 10
    mov x3, ax
    mov y3, bx
    
    mov ax, xf
    mov bx, yf 
    
    add ax, 10
    add bx, 20
    mov x4, ax
    mov y4, bx
    
    mov ax, xf
    mov bx, yf 
    
    sub ax, 10
    add bx, 20
    mov x5, ax
    mov y5, bx
    
    mov ax, xf
    mov bx, yf 
    
    sub ax, 20
    add bx, 10
    mov x6, ax
    mov y6, bx
    
    mov ax, xf
    mov bx, yf 
    
    sub ax, 20
    sub bx, 10
    mov x7, ax
    mov y7, bx
    
    mov ax, xf
    mov bx, yf 
    
    sub ax, 10
    sub bx, 20
    mov x8, ax
    mov y8, bx


    pop dx               ; ? Restabilim 
    pop cx               ; | continutul
    pop bx               ; | registrelor
    pop ax               ; L in starea inainte de apelare   
    
    ret
CheckCoordonate ENDP     

RedrawCell PROC
    push ax                  ; ? Salvam continutul
    push bx                  ; | registrelor in starea 
    push cx                  ; | in care se aflau inainte de
    push dx                  ; L apelarea functiei   
                   
    mov cx, 60
    mov dx, 38
    mov ah, 0dh
    int 10h
    cmp al, 3
    jne rb
    mov x, 60
    mov y, 38
    call DrawCell
    jmp end
    rb:
    mov cx, 70
    mov dx, 38
    mov ah, 0dh
    int 10h
    cmp al, 3
    jne rb1
    mov x, 70
    mov y, 38
    call DrawCell
    jmp end
    rb1:
    mov cx, 80
    mov dx, 38
    mov ah, 0dh
    int 10h
    cmp al, 3
    mov x, 80
    mov y, 38
    call DrawCell
   
    end:
    pop dx               ; ? Restabilim 
    pop cx               ; | continutul
    pop bx               ; | registrelor
    pop ax               ; L in starea inainte de apelare   
    
    ret
RedrawCell ENDP 

DrawSelectedCell PROC
;Deseneaza un buton la coordonata specificata cu ajutorul functiei OCh/INT 10h;
;coordonata indica coltul stinga-sus a butonului
;Primeste: coordonata X si Y
;Returneaza: Nimic
;------------------------------------------------------------------------------  
    push ax       ;salvam continutul registrelor
    push bx 
    push cx
    push dx  
    

    mov ah, 0ch           ;introducem codul functiei
    mov al, 1        ;introducem culoarea de desenare(verde)  
         
    mov cx, 10  ;setam contorul egal cu inaltimea butonului
    dsc:
    push cx                ;salvam contorul
    mov cx, xsel              ;plasam coordonata x
    mov dx, ysel              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc ysel                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop dsc 
    
    mov cx, 10  ;setam contorul egal cu inaltimea butonului
    dsc1:
    push cx                ;salvam contorul
    mov cx, xsel              ;plasam coordonata x
    mov dx, ysel              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc xsel                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop dsc1 
    
    mov cx, 10  ;setam contorul egal cu inaltimea butonului
    dsc2:
    push cx                ;salvam contorul
    mov cx, xsel              ;plasam coordonata x
    mov dx, ysel              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec ysel                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop dsc2
    
    mov cx, 10  ;setam contorul egal cu inaltimea butonului
    dsc3:
    push cx                ;salvam contorul
    mov cx, xsel              ;plasam coordonata x
    mov dx, ysel              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec xsel                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop dsc3 

    pop dx              ;rstabilim continutul registrelor
    pop cx
    pop bx
   pop ax
    RET
DrawSelectedCell ENDP 

DrawCell PROC
;Deseneaza un buton la coordonata specificata cu ajutorul functiei OCh/INT 10h;
;coordonata indica coltul stinga-sus a butonului
;Primeste: coordonata X si Y
;Returneaza: Nimic
;------------------------------------------------------------------------------  
    push ax       ;salvam continutul registrelor
    push bx 
    push cx
    push dx  
    

    mov ah, 0ch           ;introducem codul functiei
    mov al, 15        ;introducem culoarea de desenare(verde)  
         
    mov cx, 10  ;setam contorul egal cu inaltimea butonului
    dc:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc y                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop dc 
    
    mov cx, 10  ;setam contorul egal cu inaltimea butonului
    dc1:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    inc x                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop dc1 
    
    mov cx, 10  ;setam contorul egal cu inaltimea butonului
    dc2:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec y                  ;ne deplasam cu un pixel in jos 
    pop cx                 ;restabilim contorul
    loop dc2
    
    mov cx, 10  ;setam contorul egal cu inaltimea butonului
    dc3:
    push cx                ;salvam contorul
    mov cx, x              ;plasam coordonata x
    mov dx, y              ;plasam coordonata y
    int 10h                ;apela de intrerupere
    dec x                  ;ne deplasam cu un pixel in jos
    pop cx                 ;restabilim contorul
    loop dc3 

    pop dx              ;rstabilim continutul registrelor
    pop cx
    pop bx
   pop ax
    RET
DrawCell ENDP    


InitialTime PROC
    push ax
    push bx
    push cx
    push dx
    
    mov ah,02h 
    int 1ah 
    mov buffer_hour, ch
    mov buffer_minute, cl
    mov buffer_second, dh
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
InitialTime ENDP 

FinalTime PROC              
    push ax
    push bx
    push cx
    push dx
    
    mov ah,02h 
    int 1ah 
    mov buffer_hour1, ch
    mov buffer_minute1, cl
    mov buffer_second1, dh 
    
    call CalcHour
    call CalcMinute
    call CalcSecond
    
    call DisplayHour
    call DisplaySign 
    call DisplayMinute 
    call DisplaySign1
    call DisplaySecond
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
FinalTime ENDP
 
CheckField PROC
    push ax
    push bx
    push cx
    push dx
    
    mov count_fill, 0
    mov xcf, 65
    mov ycf, 45  
    
    mov cx, 8
    cf:
    push cx
    
    mov cx, 8
    cf2:
    push cx
    mov ah, 0Dh
    mov cx, xcf
    mov dx, ycf
    int 10h
    cmp al, 4
    jne cf1
    inc count_fill
    cmp count_fill, 64
    jne cf1
    call FinalTime
    cf1: 
    add xcf, 10
    pop cx
    loop cf2 
    
    mov xcf, 65    
    add ycf, 10
    pop cx
    loop cf
       
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
CheckField ENDP        

;-------------------------------------------------------MAIN----------------------------------------------------------------------- 
;----------------------------------------------------------------------------------------------------------------------------------
main:

call DrawField
  

b:
call CheckButton
 

check:
cmp locationh,0
jnle q
mov locationh, 1
q:
cmp locationh,8
jna m
mov locationh, 8
m:
cmp locationh,1
jne s
call DrawField 
mov xsel, 60
call DrawSelectedCell
jmp b
s:
cmp locationh,2
jne t
call DrawField 
call DrawSelectedCell
jmp b 
t:
cmp locationh,3
jne tv
call DrawField
call DrawSelectedCell
jmp b
tv:
cmp locationh,4
jne tv1
call DrawField

call DrawSelectedCell
jmp b
tv1:
cmp locationh,5
jne tv2
call DrawField
call DrawSelectedCell
jmp b
tv2:
cmp locationh,6
jne tv3
call DrawField
call DrawSelectedCell
jmp b
tv3:
cmp locationh,7
jne tv4
call DrawField
call DrawSelectedCell
jmp b
tv4:
cmp locationh,8
jne qw
call DrawField
mov xsel, 130
call DrawSelectedCell
jmp b 



check1:
qw:
cmp locationv,0
jnle qv
mov locationv, 1
qv:
cmp locationv,8
jna mv
mov locationv, 8
mv:
cmp locationv,1
jne sv
call DrawField 
mov ysel, 38
call DrawSelectedCell
jmp b
sv:
cmp locationv,2
jne ta
call DrawField 
call DrawSelectedCell
jmp b 
ta:
cmp locationv,3
jne tva
call DrawField
call DrawSelectedCell
jmp b
tva:
cmp locationv,4
jne tva1
call DrawField

call DrawSelectedCell
jmp b
tva1:
cmp locationv,5
jne tva2
call DrawField
call DrawSelectedCell
jmp b
tva2:
cmp locationv,6
jne tva3
call DrawField
call DrawSelectedCell
jmp b
tva3:
cmp locationv,7
jne tva4
call DrawField
call DrawSelectedCell
jmp b
tva4:
cmp locationv,8
jne b
call DrawField
mov ysel, 108
call DrawSelectedCell
jmp b

jmp $
;-------------------------------------------------------DATA----------------------------------------------------------------------- 
;----------------------------------------------------------------------------------------------------------------------------------
x dw 60
y dw 38  
xv dw 70
yv dw 38 
xh dw 60
yh dw 48
xf dw 61
yf dw 39
xsel dw 60
ysel dw 38
dimension dw 80
locationh db 0
locationv db 0 
count db 0     
xg db 0
yg db 0
 
x1 dw 0
y1 dw 0 
x2 dw 0
y2 dw 0
x3 dw 0
y3 dw 0
x4 dw 0
y4 dw 0
x5 dw 0
y5 dw 0
x6 dw 0
y6 dw 0
x7 dw 0
y7 dw 0
x8 dw 0
y8 dw 0 
xcf dw 0
ycf dw 0
count_fill db 0

buffer_hour db 0
buffer_minute db 0
buffer_second db 0  
buffer_hour1 db 0
buffer_minute1 db 0
buffer_second1 db 0                                  
tetrad1 db 0
tetrad2 db 0
points db ':',0 
message db 'Your Time', 0
resultd db 0
sign db 0
db 512 - ($ - $$) DUP(0)	;Fill the rest of sector with 0


