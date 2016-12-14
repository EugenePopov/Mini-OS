; BIOS reads 512 bytes from cylinder: 0, head: 0, sector: 1
; of bootable floppy drive, then it loads this data into
; memory at 0000:7c00h and starts the execution from the first byte.


#make_boot#

ORG 0x7C00	    ;Origin, tell the assembler that where the code will be in memory after it is been loaded
				
jmp main        ; Salt la punctul de intrare in program

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
                                      
ClearScreen:  
; Ecranul are dimensiunea de 24x79 pixeli
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
mov ch, 0             ; Rindul din care incepe curatarea
mov cl, 0             ; Coloana din care incepe curatarea
mov dh, 24            ; Rindul in care sfirseste curatarea
mov dl, 79            ; Coloana in care sfirseste curatarea
int 0x10              ; Apelarea intreruperii BIOS

pop dx                ; Ã Restabilim 
pop cx                ; | continutul
pop bx                ; | registrelor
pop ax                ; L in starea inainte de apelare
ret                                      
                                      

WriteMessages:

push ax                  ; ? Salvam continutul
push bx                  ; | registrelor in starea 
push cx                  ; | in care se aflau inainte de
push dx                  ; L apelarea functiei

mov bp, offset str1             ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 0ch             ; setam codul culorii
mov cx, str1_len  ; incarcam in cx numarul de caractere a sirului
mov dh, 10               ; rindul din care incepe afisarea
mov dl, str1_x         ; coloana din care incepe afisarea
call WriteString

mov bp,offset str2             ; salvam offsetul mesajului in bp (This is )
mov bl, 0ch             ; setam codul culorii
mov cx, str2_len   ; incarcam in cx numarul de caractere a sirului
mov dh, 11               ; rindul din care incepe afisarea
mov dl, str2_x         ; coloana din care incepe afisarea
call WriteString 

mov ah, 01h             ;ascundem
mov cx, 2607h            ;cursorul
int 10h

pop dx               ; ? Restabilim 
pop cx               ; | continutul
pop bx               ; | registrelor
pop ax               ; L in starea inainte de apelare     
ret    

Delay:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;         Procedura de efectuare a unei retineri          ;;
;;         Functia 0x86 a intreruperii BIOS 0x15           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push ax             ;Salvam
push cx             ;continutul
push dx             ;registrelor

mov ah, 0x86        ; Codul functiei
mov cx, 0x3         ; Durata pauzei in microsecunde (in cx bitul superior)
mov dx, 0x20        ; in dx bitul inferior   (800 milisecunde)
int 0x15            ; Apelarea intreruperii BIOS

pop dx              ; Restabilim
pop cx              ; continutul
pop ax              ; registrelor 
ret   

beep:    
mov ah, 02h
mov dl, 07h
int 21h
ret      

ReadSector:
push ax
push bx
push cx
push dx  
call beep
call Delay 
pop dx
pop cx
pop bx
pop ax
mov ah, 02h
mov al, 2 
;mov al, 4
mov ch, 0
mov cl, 2 
;mov cl, 4
mov dh, 0
mov dl, 0
mov bx, 0800h 
;mov bx, 0600h
mov es, bx 
mov bx, 0   
int 13h    

; pass control to kernel: 
call ClearScreen
jmp     0800h:0000h 
;jmp     0600h:0000h
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FUNCTIA PRINCIPALA;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main:

call WriteMessages 
mov ah , 00h
int 16h 
cmp al, 1bh
jnz here  
 int 19h 
here:
cmp al,13 
je ReadSector     

;Data                
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           Definima: 4 mesaje in 8 offset-uri            ;;
;;                Lungimea fiecarui string                 ;;
;;           Coordonata pe x a fiecarui string             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

str1 db 'Restart-ESC', 0	
str1_len dw 11
str1_x db 34
str2 db 'Load kernel-ENTER' ,0 
str2_len dw 17     
str2_x db 34  

db 510 - ($ - $$) DUP(0)	;Fill the rest of sector with 0
DW 0xAA55			;Add boot signature at the end of bootloader



