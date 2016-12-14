#make_bin#
mov ax,0900h
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



Math PROC
    pusha  
    mov ax, hardware
    and ax, math_mask
    jnz m
    mov bp, offset n
    jmp display
    m:
    mov bp, offset y
    
    display:
    mov bl, color             ; setam codul culorii
    mov cx, 3  ; incarcam in cx numarul de caractere a sirului
    mov dh, 5               ; rindul din care incepe afisarea
    mov dl, 21         ; coloana din care incepe afisarea
    call WriteString
    
    mov bp , offset mess1
    mov bl, color             ; setam codul culorii
    mov cx, mess1_len  ; incarcam in cx numarul de caractere a sirului
    mov dh, 5               ; rindul din care incepe afisarea
    mov dl, 11         ; coloana din care incepe afisarea
    call WriteString
      
    popa
    ret
Math ENDP

Mouse PROC
    pusha  
    mov ax, hardware
    and ax, mouse_mask
    jnz m1
    mov bp, offset n
    jmp display1
    m1:
    mov bp, offset y
    
    display1:
    mov bl, color             ; setam codul culorii
    mov cx, 3  ; incarcam in cx numarul de caractere a sirului
    mov dh, 6               ; rindul din care incepe afisarea
    mov dl, 17         ; coloana din care incepe afisarea
    call WriteString
    
    mov bp , offset mess2
    mov bl, color             ; setam codul culorii
    mov cx, mess2_len  ; incarcam in cx numarul de caractere a sirului
    mov dh, 6               ; rindul din care incepe afisarea
    mov dl, 11         ; coloana din care incepe afisarea
    call WriteString
      
    popa
    ret
Mouse ENDP

Video PROC
    pusha  
    mov ax, hardware
    and ax, video_mask 
    mov videores,ax
    cmp videores, 00h
    jne v
    mov bp, offset video1 
    mov cx, video1_len  ; incarcam in cx numarul de caractere a sirului 
    mov dl, 11+mess3_len         ; coloana din care incepe afisarea
    jmp display3
    v:  
    cmp videores, 10h
    jne v1
    mov bp, offset video2 
    mov cx, video2_len  ; incarcam in cx numarul de caractere a sirului
    mov dl, 11+mess3_len         ; coloana din care incepe afisarea
    jmp display3
    v1:  
    cmp videores, 20h
    jne v2
    mov bp, offset video3
    mov cx, video3_len  ; incarcam in cx numarul de caractere a sirului
    mov dl, 11+mess3_len         ; coloana din care incepe afisarea
    jmp display3
    v2:  
    cmp videores, 30h
    jne v3
    mov bp, offset video4
    mov cx, video4_len  ; incarcam in cx numarul de caractere a sirului
    mov dl, 11+mess3_len         ; coloana din care incepe afisarea
    jmp display3
    v3:  
    
    
    display3:
    mov bl, color             ; setam codul culorii
   
    mov dh, 8               ; rindul din care incepe afisarea
    
    call WriteString
    
    mov bp , offset mess3
    mov bl, color             ; setam codul culorii
    mov cx, mess3_len  ; incarcam in cx numarul de caractere a sirului
    mov dh, 8               ; rindul din care incepe afisarea
    mov dl, 11         ; coloana din care incepe afisarea
    call WriteString
      
    popa        
    ret
Video ENDP

Floppy PROC
    pusha  
    mov ax, hardware
    and ax, floppy_mask 
    mov floppyres,ax
    cmp floppyres, 00h
    jne f
    mov bp, offset floppy1
    jmp display4
    f:  
    cmp floppyres, 40h
    jne f1
    mov bp, offset floppy2
    jmp display4
    f1:  
    cmp floppyres, 80h
    jne f2
    mov bp, offset floppy3
    jmp display4
    f2:  
    cmp floppyres, 0C0h
    jne f3
    mov bp, offset floppy4
    jmp display4
    f3:  
    
    
    display4:
    mov bl, color             ; setam codul culorii
    mov cx, 1  ; incarcam in cx numarul de caractere a sirului
    mov dh, 7               ; rindul din care incepe afisarea
    mov dl, 11+mess4_len         ; coloana din care incepe afisarea
    call WriteString
    
    mov bp , offset mess4
    mov bl, color             ; setam codul culorii
    mov cx, mess4_len  ; incarcam in cx numarul de caractere a sirului
    mov dh, 7               ; rindul din care incepe afisarea
    mov dl, 11         ; coloana din care incepe afisarea
    call WriteString
      
    popa
    ret
Floppy ENDP

Game PROC
    pusha  
    mov ax, hardware
    and ax, game_mask
    jnz m2
    mov bp, offset n
    jmp display2
    m2:
    mov bp, offset y
    
    display2:
    mov bl, color             ; setam codul culorii
    mov cx, 3  ; incarcam in cx numarul de caractere a sirului
    mov dh, 9               ; rindul din care incepe afisarea
    mov dl, 11+mess5_len         ; coloana din care incepe afisarea
    call WriteString
    
    mov bp , offset mess5
    mov bl, color             ; setam codul culorii
    mov cx, mess5_len  ; incarcam in cx numarul de caractere a sirului
    mov dh, 9               ; rindul din care incepe afisarea
    mov dl, 11         ; coloana din care incepe afisarea
    call WriteString
      
    popa
    ret
Game ENDP



;=================================================================================


main:
mov al, 13h
int 10h
int 11h
mov hardware, ax
call Math
call Mouse 
call Game
call Floppy 
call Video 
p:
mov ah , 00h
int 16h 
cmp al, 1bh
jne p  
mov ax, 0600h
mov es, ax
jmp 0600h:0000h
jmp $ 


;=================================================================================
hardware dw 0
math_mask dw 02h
mouse_mask dw 04h
video_mask dw 30h
floppy_mask dw 0c0h
game_mask dw 1000h 
color = 11

y db 'YES',0
n db 'NO',0  

video1 db 'EGA/VGA/PGA',0
video1_len = 11  
video2 db '40x25 CGA',0
video2_len = 9
video3 db '80x25 CGA',0
video3_len = 9
video4 db '80x25 mono text',0
video4_len = 15
videores dw 0

floppy1 db '1',0
floppy2 db '2',0
floppy3 db '3',0
floppy4 db '4',0  
floppy_len = 1
floppyres dw 0


mess1 db 'Math Copr:',0 
mess1_len = 10 
mess2 db 'Mouse:',0 
mess2_len = 6
mess3 db 'Video mode:',0 
mess3_len = 11
mess4 db 'Floppy Drives:',0 
mess4_len = 14
mess5 db 'Game Port:',0 
mess5_len = 10

