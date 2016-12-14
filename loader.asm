    
#make_bin#

#AX=0000h#
#BX=0000h#
#CX=0000h#
#DX=0000h#
#SI=0000h#
#DI=0000h#
#BP=0000h#  


mov ax,0800h
mov ds, ax 
jmp main    


Delay1:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;         Procedura de efectuare a unei retineri          ;;
;;         Functia 0x86 a intreruperii BIOS 0x15           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push ax             ;Salvam  
push bx
push cx             ;continutul
push dx             ;registrelor

mov ah, 0x86        ; Codul functiei
mov cx, 0x08         ; Durata pauzei in microsecunde (in cx bitul superior)
mov dx, 0x88        ; in dx bitul inferior   (800 milisecunde)
int 0x15            ; Apelarea intreruperii BIOS

pop dx              ; Restabilim
pop cx              ; continutul     
pop bx
pop ax              ; registrelor
ret  

DrawBar:
push ax
push bx
push cx
push dx
mov bp, offset bar            ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 15             ; setam codul culorii
mov cx, 1  ; incarcam in cx numarul de caractere a sirului
mov dh, 10               ; rindul din care incepe afisarea
mov dl, 33         ; coloana din care incepe afisarea
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10	    ; Call video interrupt  
mov cx, 1  ; incarcam in cx numarul de caractere a sirului
mov dh, 10               ; rindul din care incepe afisarea
mov dl, 49         ; coloana din care incepe afisarea
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10	    ; Call video interrupt             
pop dx
pop cx
pop bx
pop ax
ret

DrawBox:
push ax
push bx
push cx
push dx
mov bp, offset symbol            ; salvam offsetul mesajului in bp (Hello World!)
mov bl, ds:[color]             ; setam codul culorii
mov cx, 1  ; incarcam in cx numarul de caractere a sirului
mov dh, 10               ; rindul din care incepe afisarea
mov dl, [x]         ; coloana din care incepe afisarea
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10	    ; Call video interrupt 
mov ah, 01h             ;ascundem
mov cx, 2607h            ;cursorul
int 10h 
pop dx
pop cx
pop bx
pop ax
ret
 
DrawPercent:
push ax
push bx
push cx
push dx
mov bp, offset percent            ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 15             ; setam codul culorii
mov cx, 1  ; incarcam in cx numarul de caractere a sirului
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 47         ; coloana din care incepe afisarea
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10	    ; Call video interrupt  
pop dx
pop cx
pop bx
pop ax
ret 

ReadSector:

mov ah, 02h
mov al, 5
mov ch, 0
mov cl, 4
mov dh, 0
mov dl, 0
mov bx, 0600h
mov es, bx 
mov bx, 0   
int 13h
; pass control to kernel: 
jmp     0600h:0000h
ret 

CheckSector:
push ax
push bx
push cx
push dx
mov ah, 02h
mov al, 1
mov ch, 0
mov cl, 9
mov dh, 0
mov dl, 0
mov bx, 0400h
mov es, bx 
mov bx, 0   
int 13h
mov bx, 0800h                
mov es, bx  
cmp al, 0      
jne c
call Error 
b:
mov ah , 00h
int 16h 
cmp al, 1bh
jne b
int 19h
c:
pop dx
pop cx
pop bx
pop ax
ret 

Error:
push ax
push bx
push cx
push dx
mov bp, offset err_msg            ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 4             ; setam codul culorii
mov cx, 29  ; incarcam in cx numarul de caractere a sirului
mov dh, 8               ; rindul din care incepe afisarea
mov dl, 28         ; coloana din care incepe afisarea
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10	    ; Call video interrupt
mov bp, offset reb            ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 4             ; setam codul culorii
mov cx, 36  ; incarcam in cx numarul de caractere a sirului
mov dh, 13               ; rindul din care incepe afisarea
mov dl, 24         ; coloana din care incepe afisarea
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10	    ; Call video interrupt  
pop dx
pop cx
pop bx
pop ax
ret 

Message:
push ax
push bx
push cx
push dx
mov bp, offset msg            ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 15             ; setam codul culorii
mov cx, 9  ; incarcam in cx numarul de caractere a sirului
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 36         ; coloana din care incepe afisarea
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10	    ; Call video interrupt  
pop dx
pop cx
pop bx
pop ax
ret

LoadMess:
push ax
push bx
push cx
push dx
;mov bp, offset load25+si            ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 15             ; setam codul culorii
mov cx,2  ; incarcam in cx numarul de caractere a sirului
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 44         ; coloana din care incepe afisarea
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10	    ; Call video interrupt  
pop dx
pop cx
pop bx
pop ax
ret   

LoadComplete:
push ax
push bx
push cx
push dx
mov bp, offset load100            ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 15             ; setam codul culorii
mov cx, 3  ; incarcam in cx numarul de caractere a sirului
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 44         ; coloana din care incepe afisarea
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10	    ; Call video interrupt    
mov ah, 01h             ;ascundem
mov cx, 2607h            ;cursorul
int 10h
pop dx
pop cx
pop bx
pop ax
ret    

PrintRAM:
push ax
push bx
push cx
push dx     

mov bp,  offset ram_mess           ; salvam offsetul mesajului in bp 
mov bl, 2                          ; setam codul culorii
mov cx, 17                         ; incarcam in cx numarul de caractere a sirului
mov dh, 0                          ; rindul din care incepe afisarea
mov dl, 0                          ; coloana din care incepe afisarea
mov ah, 13h	                       ; Codul functiei de afisare a unui sir 
mov al, 1                          ; Modul de afisare
mov bh, 0x00	                   ; Numarul paginii
int 0x10	                       ; Call video interrupt    
mov ah, 01h                        ;ascundem
mov cx, 2607h                      ;cursorul
int 10h

pop dx
pop cx
pop bx
pop ax
ret  

DisplayRAM: 
push ax
push bx
push cx
push dx  

int 12h
cmp ax, 0258h
jg d
int 19h
d:  
mov bl,10 
div bl  
or ah, 30h
mov di,offset result 
mov  byte ptr[di+2],ah
xor ah, ah
div bl 
or ah, 30h
mov di,offset result 
mov  byte ptr[di+1],ah
xor ah, ah 
div bl 
or ah, 30h
mov  byte ptr[di],ah
xor ah, ah

mov bp, offset result            ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 2             ; setam codul culorii
mov cx, 3     ; incarcam in cx numarul de caractere a sirului
mov dh, 0               ; rindul din care incepe afisarea
mov dl, 12         ; coloana din care incepe afisarea
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10	    ; Call video interrupt    
mov ah, 01h             ;ascundem
mov cx, 2607h            ;cursorul
int 10h 
pop dx
pop cx
pop bx
pop ax
ret   
                             

               

main:    
call PrintRAM
call DisplayRAM   
call DrawBar           ;desanam cite o bara la inceput si sfirsit 
call Message            ;afisam mesajul "Loading"
call DrawPercent         ;afisam mesajul "%"
mov bp, offset load25     ;incarcam in bp adresa ce contine valoarea 25 
mov cx, 15              ; setam contorul ciclului(desenam 15 elemente)
l: 
call CheckSector
push bp                        ;salvam continutul bp pentru a incrementa valoarea acestuia ulterior(incrementam offsetul 25, 50, 75)
call DrawBox                 ;desenam un element  
call Delay1
pop bp                        ;restabilim continutul bp
mov ax, cx                   ;incarcam contorul in ax pentru impartirea ulterioara
mov bl, 4                    
div bl                       ;impartim la 4
cmp ah, 0                    ;verificam daca restul inmpartirii este 0
jnz et2                      ;daca da incrementam culoarea si offsetul pentru valoarea procentelor, daca nu- salt la et2
inc color 
call LoadMess 
add bp, 3
et2:
inc x                        ;incrementam coordonata x pentru box  
loop l 
call LoadComplete               ;afisam mesajul "Loading 100%" 
call Delay1
call ReadSector

jmp $  


bar db 124 
x db 34
y db 10
symbol db 222, 0 
msg db 'Loading ',48,0 
percent db 37, 0
load25 db  50,53,0 
load50 db  53,48,0
load75 db  55,53,0
load100 db  49,48,48,0   
ram_mess db 'Memory size:   KB',0    
color db 1  
result db 0,0,0,0,0 
err_msg db 'ERROR: Floppy disk not found!',0
reb db 'Enter disk and press [ESC] to reboot',0


db 512 - ($ - $$) DUP(0)	;Fill the rest of sector with 0
;DW 0xAA55			;Add boot signature at the end of bootloader





