#make_bin# 
mov ax, 0200h
mov ds, ax 

jmp main


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

main:
mov cx, 3

a:
push cx
mov cx, 3
l:    
mov ah, 02h
mov dl, 07h
int 21h
loop l 
call Delay 
mov cx, 3
m:
  
mov ah, 02h
mov dl, 07h
int 21h
call Delay 
loop m

mov cx, 3
n:    
mov ah, 02h
mov dl, 07h
int 21h
loop n

pop cx 
call Delay
loop a

p:
mov ah , 00h
int 16h 
cmp al, 1bh
jne p  
mov ax, 0600h
mov es, ax
jmp 0600h:0000h

jmp $
