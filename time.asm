
#make_bin# 
     

mov ax, 0400h
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
mov al, buffer_hour
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
mov dl, 17         ; coloana din care incepe afisarea
call WriteString
mov bp, offset tetrad2            ; salvam offsetul mesajului in bp (Hello World!)
mov cx, 1     ; incarcam in cx numarul de caractere a sirului
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 18         ; coloana din care incepe afisarea
call WriteString	    ; Call video interrupt  
mov bp, offset message            ; salvam offsetul mesajului in bp (Hello World!)
mov cx, 11     ; incarcam in cx numarul de caractere a sirului
mov dh, 9               ; rindul din care incepe afisarea
mov dl, 14         ; coloana din care incepe afisarea
call WriteString	    ; Call video interrupt   
mov ah, 01h             ;ascundem
mov cx, 2607h            ;cursorul
int 10h
ret
DisplayHour ENDP 

DisplayMinute PROC
xor ax, ax 
mov al, buffer_minute
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
mov dl, 20         ; coloana din care incepe afisarea
call WriteString
mov bp, offset tetrad2            ; salvam offsetul mesajului in bp (Hello World!)
mov cx, 1     ; incarcam in cx numarul de caractere a sirului
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 21         ; coloana din care incepe afisarea
call WriteString	    ; Call video interrupt    
mov ah, 01h             ;ascundem
mov cx, 2607h            ;cursorul
int 10h
ret
DisplayMinute ENDP



DisplaySign PROC
    mov bp, offset sign            ; salvam offsetul mesajului in bp (Hello World!)
    mov bl, 0eh             ; setam codul culorii
    mov cx, 1     ; incarcam in cx numarul de caractere a sirului
    mov dh, 11               ; rindul din care incepe afisarea
    mov dl, 19         ; coloana din care incepe afisarea
    call WriteString
    ret
DisplaySign ENDP

                           


main:
mov ah,02h 
int 1ah 
mov buffer_hour, ch
mov buffer_minute, cl
call DisplayHour
call DisplaySign 
call DisplayMinute 
p:
mov ah , 00h
int 16h 
cmp al, 1bh
jne p  
mov ax, 0600h
mov es, ax
jmp 0600h:0000h      

jmp $

buffer_hour db 0
buffer_minute db 0                                   
tetrad1 db 0
tetrad2 db 0
sign db ':',0 
message db 'System Time', 0
 
db 512 - ($ - $$) DUP(0)	;Fill the rest of sector with 0
