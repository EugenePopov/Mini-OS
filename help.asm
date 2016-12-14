
#make_bin#

mov ax,0950h
mov ds, ax

jmp main

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

mov bp, offset str1             ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 1             ; setam codul culorii
mov cx, str1_len  ; incarcam in cx numarul de caractere a sirului
mov dh, 7               ; rindul din care incepe afisarea
mov dl, 17         ; coloana din care incepe afisarea
call WriteString

mov bp,offset str2             ; salvam offsetul mesajului in bp (This is )
mov bl, 0fh             ; setam codul culorii
mov cx, str2_len   ; incarcam in cx numarul de caractere a sirului
mov dh, 8               ; rindul din care incepe afisarea
mov dl, 8        ; coloana din care incepe afisarea
call WriteString 

mov bp,offset str3             ; salvam offsetul mesajului in bp (This is )
mov bl, 0fh             ; setam codul culorii
mov cx, str3_len   ; incarcam in cx numarul de caractere a sirului
mov dh, 9               ; rindul din care incepe afisarea
mov dl, 8         ; coloana din care incepe afisarea
call WriteString  

mov bp,offset str4             ; salvam offsetul mesajului in bp (This is )
mov bl, 0fh             ; setam codul culorii
mov cx, str4_len   ; incarcam in cx numarul de caractere a sirului
mov dh, 10               ; rindul din care incepe afisarea
mov dl, 8         ; coloana din care incepe afisarea
call WriteString

mov ah, 01h             ;ascundem
mov cx, 2607h            ;cursorul
int 10h

j:
mov ah, 00h
int 16h
cmp al, 1bh
jne j
mov ax, 0600h
mov es, ax
jmp 0600h:0000h


pop dx               ; ? Restabilim 
pop cx               ; | continutul
pop bx               ; | registrelor
pop ax               ; L in starea inainte de apelare     
ret    

main:
call WriteMessages

jmp $

str1 db "Mini OS",0
str1_len = $-str1  
str2 db "Kernel Version 3.0",0
str2_len = $-str2
str3 db "Release date 29.11.2015",0
str3_len = $-str3     
str4 db "Author : Popov Eugen",0
str4_len = $-str4  


db 512 - ($ - $$) DUP(0)	;Fill the rest of sector with 0
