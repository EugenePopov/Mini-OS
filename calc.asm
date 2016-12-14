#make_bin# 
mov ax, 0500h
mov ds, ax 
mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0
jmp main 

Validate PROC 
    cmp al, 30h
    jnl v
    cmp al, 2dh
    je endv 
    cmp al, 0dh
    je endv
    mov bp, offset error 
    mov bl, 0ch             ; setam codul culorii
    mov cx, err_len  ; incarcam in cx numarul de caractere a sirului
    mov dh, 8               ; rindul din care incepe afisarea
    mov dl, 12         ; coloana din care incepe afisarea
    call WriteString
    mov ah, 0
    int 16h 
    call ClearScreen
    jmp main
    
    v:
    cmp al, 39h
    jna endv
    mov bp, offset error  
    mov bl, 0ch             ; setam codul culorii 
    mov cx, err_len  ; incarcam in cx numarul de caractere a sirului
    mov dh, 8               ; rindul din care incepe afisarea
    mov dl, 12         ; coloana din care incepe afisarea
    call WriteString
    mov ah, 0
    int 16h
    call ClearScreen
    jmp main  
    
    endv:    
    ret
Validate ENDP

ClearScreen PROC
    push ax                  ; ? Salvam continutul
    push bx                  ; | registrelor in starea 
    push cx                  ; | in care se aflau inainte de
    push dx                  ; L apelarea functiei

    mov bp, offset clear
    mov bl, 00h             ; setam codul culorii
    mov cx, 17  ; incarcam in cx numarul de caractere a sirului
    mov dh, 8               ; rindul din care incepe afisarea
    mov dl, 12         ; coloana din care incepe afisarea
    call WriteString   
    
    mov cx, 17  ; incarcam in cx numarul de caractere a sirului
    mov dh, 9               ; rindul din care incepe afisarea
    mov dl, 12         ; coloana din care incepe afisarea
    call WriteString
    
    mov cx,17  ; incarcam in cx numarul de caractere a sirului
    mov dh, 10               ; rindul din care incepe afisarea
    mov dl, 12         ; coloana din care incepe afisarea
    call WriteString
    
    mov cx, 18  ; incarcam in cx numarul de caractere a sirului
    mov dh, 11               ; rindul din care incepe afisarea
    mov dl, 12         ; coloana din care incepe afisarea
    call WriteString 
    
        
    mov cx, 18  ; incarcam in cx numarul de caractere a sirului
    mov dh, 12               ; rindul din care incepe afisarea
    mov dl, 12         ; coloana din care incepe afisarea
    call WriteString
    
    pop dx               ; ? Restabilim 
    pop cx               ; | continutul
    pop bx               ; | registrelor
    pop ax               ; L in starea inainte de apelare     
    ret 

ClearScreen ENDP    

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

WriteMessages PROC

push ax                  ; ? Salvam continutul
push bx                  ; | registrelor in starea 
push cx                  ; | in care se aflau inainte de
push dx                  ; L apelarea functiei


mov bl, 0ch             ; setam codul culorii
mov cx, msg1_len  ; incarcam in cx numarul de caractere a sirului
mov dh, 10               ; rindul din care incepe afisarea
mov dl, 12         ; coloana din care incepe afisarea
call WriteString




pop dx               ; ? Restabilim 
pop cx               ; | continutul
pop bx               ; | registrelor
pop ax               ; L in starea inainte de apelare     
ret
WriteMessages ENDP 

WriteMessageB PROC

push ax                  ; ? Salvam continutul
push bx                  ; | registrelor in starea 
push cx                  ; | in care se aflau inainte de
push dx                  ; L apelarea functiei


mov bl, 0ch             ; setam codul culorii
mov cx, msg3_len  ; incarcam in cx numarul de caractere a sirului
mov dh, 11               ; rindul din care incepe afisarea
mov dl, 12         ; coloana din care incepe afisarea
call WriteString




pop dx               ; ? Restabilim 
pop cx               ; | continutul
pop bx               ; | registrelor
pop ax               ; L in starea inainte de apelare     
ret
WriteMessageB ENDP

ReadA PROC 
    
mov bp, offset msg1             ; salvam offsetul mesajului in bp (Hello World!)
call WriteMessages 
mov cx, 4 

l: 
push cx
mov ah , 00h                          
int 16h
call Validate
cmp al, 0dh
je l2 
cmp al, 2dh
je l6 
cmp cx,4
jne l7
pop cx
dec cx
push cx
l7:                       
mov digit, al
xor digit, 30h
cmp cx, 3
jne l1
mov bl, 100
mov al, digit
mul bl
mov a, ax      
l1:
cmp cx, 2
jne l3 
mov bl, 10
mov al, digit
mul bl
xor ah, ah
add a, ax
l3:
cmp cx, 1
jne l4
xor ah, ah 
mov al, digit
xor ah, ah
add a, ax
l4:

mov al, digit
or al, 30h
l6:
cmp cx, 4
jne l8
mov signa, al
l8:
mov ah, 09h
mov bh, 0
mov bl, 2
mov cx, 1 
int 10h
mov ah, 2                   
mov bh, 0
mov dh, 10
mov dl, cursor_pos
int 10h
inc cursor_pos

pop cx
loop l
jmp end1  

l2:
cmp cx, 2
jne l5
mov ax, a
mov bl, 100
div bl
mov a, ax
pop cx
l5:
cmp cx, 1
jne end1
mov ax, a
mov bl, 10
div bl
mov a, ax 
pop cx
end1:
ret
ReadA ENDP  

ReadB PROC 
mov cursor_pos, 22    
mov bp, offset msg3             ; salvam offsetul mesajului in bp (Hello World!)
call WriteMessageB 
mov cx, 4 

lb: 
push cx
mov ah , 00h                          
int 16h 
call Validate
cmp al, 0dh
je lb2 
cmp al, 2dh
je lb6 
cmp cx,4
jne lb7
pop cx
dec cx
push cx
lb7:                       
mov digit, al
xor digit, 30h
cmp cx, 3
jne lb1
mov bl, 100
mov al, digit
mul bl
mov b, ax      
lb1:
cmp cx, 2
jne lb3 
mov bl, 10
mov al, digit
mul bl
xor ah, ah
add b, ax
lb3:
cmp cx, 1
jne lb4
xor ah, ah 
mov al, digit
xor ah, ah
add b, ax
lb4:

mov al, digit
or al, 30h
lb6:
cmp cx, 4
jne lb8
mov signb, al
lb8:
mov ah, 09h
mov bh, 0
mov bl, 2
mov cx, 1 
int 10h
mov ah, 2                   
mov bh, 0
mov dh, 11
mov dl, cursor_pos
int 10h
inc cursor_pos

pop cx
loop lb
jmp end1b  

lb2:
cmp cx, 2
jne lb5
mov ax, b
mov bl, 100
div bl
mov b, ax
pop cx
lb5:
cmp cx, 1
jne end1
mov ax, b
mov bl, 10
div bl
mov b, ax
pop cx
end1b:
ret
ReadB ENDP

CheckSignA PROC
    cmp signa, 2dh
    jne c
    mov ax, 0
    sub ax, a
    mov a, ax
    
    c:
    ret
CheckSignA ENDP  

CheckSignB PROC
    cmp signb, 2dh
    jne d
    mov ax, 0
    sub ax, b
    mov b, ax
    
    d:
    ret
CheckSignB ENDP   


Operation PROC
     s: 
     mov bp, offset msg2
     mov bl, 0ch             ; setam codul culorii
     mov cx, msg2_len  ; incarcam in cx numarul de caractere a sirului
     mov dh, 12               ; rindul din care incepe afisarea
     mov dl, 12         ; coloana din care incepe afisarea
     call WriteString
     mov ah , 00h                          
     int 16h 
     mov operation_s, al
     
           
     cmp al, 2bh  ;+
     jne o
     mov ah, 09h           ;afisam 
     mov bh, 0             ;simbolul
     mov bl, 2
     mov cx, 1             ;la ecran
     int 10h
     mov ax,a
     add ax, b
     pushf
     pop dx
     xor dl, 80h
     cmp dl, 80h
     ja o4
     mov signr, 1 
     o4:
     mov result, ax 
     call DisplayResult  
     jmp endo
          
     
     o:
     cmp al, 2dh    ;-
     jne o1
     mov ah, 09h
     mov bh, 0 
     mov bl, 2
     mov cx, 1 
     int 10h
     mov ax, a
     sub ax, b
     pushf
     pop dx
     xor dl, 80h
     cmp dl, 80h
     ja o3
     mov signr, 1
     o3:
     mov result, ax 
     call DisplayResult  
     jmp endo
     
     
     
     o1:
     call ResultSign 
     cmp al, 2ah     ;*
     jne o2
     mov ah, 09h
     mov bh, 0
     mov bl, 2
     mov cx, 1 
     int 10h
     cmp a, 99
     jng op1
     inc nmul
     op1:
     cmp b, 99
     jng op2
     inc nmul
     op2:
     cmp nmul , 2
     jne op3
    mov bp, offset error1
    mov bl, 0ch             ; setam codul culorii
    mov cx, err1_len  ; incarcam in cx numarul de caractere a sirului
    mov dh, 8               ; rindul din care incepe afisarea
    mov dl, 12         ; coloana din care incepe afisarea
    call WriteString
    mov ah, 0
    int 16h 
    call ClearScreen
    jmp main
     op3:
     mov ax, a
     imul b 
    ; pushf
    ; pop dx
    ; xor dl, 80h
     ;cmp dl, 80h
    ; ja o5
    ; mov signr, 1
    ; o5:
     mov result, ax
     call DisplayResult  
     jmp endo  
    
     
     
     o2: 
     call ResultSign 
     cmp al, 2fh     ;/   
     jne s
     mov ah, 09h
     mov bh, 0
     mov bl, 2
     mov cx, 1 
     int 10h
     

     mov ax, a  
     cwd
     mov bx, b
     idiv bx    
     mov integer, ax
     mov remainder, dx
     call DisplayDivisionResult
     
      endo: 
    ret 
Operation ENDP  

DisplayResult PROC
push ax
push bx
push cx
push dx  


cmp signr, 1
jne dr
neg result

dr:
mov ax, result
xor dx, dx  
mov bx,10 
idiv bx  
or dl, 30h
mov di,offset resultd
mov  byte ptr[di+3],dl
xor dx, dx
div bx 
or dl, 30h
mov di,offset resultd 
mov  byte ptr[di+2],dl
xor dx, dx 
div bx 
or dl, 30h
mov  byte ptr[di+1],dl
xor dx, dx
div bx 
or dl, 30h
mov  byte ptr[di],dl

cmp signr, 1                ;daca rezultatul e negativ afisam semnul
jne dr4
mov bp, offset sign_mess           ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 2             ; setam codul culorii
mov cx, 1     ; incarcam in cx numarul de caractere a sirului
mov dh, 13               ; rindul din care incepe afisarea
mov dl, 12         ; coloana din care incepe afisarea
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10
dr4:


mov bp, offset resultd            ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 2             ; setam codul culorii
mov cx, result_length     ; incarcam in cx numarul de caractere a sirului
mov dh, 13               ; rindul din care incepe afisarea
mov dl, 13         ; coloana din care incepe afisarea
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
DisplayResult ENDP   
    
               
               
               


DisplayDivisionResult PROC
push ax
push bx
push cx
push dx  

cmp signr, 1  

jne ddr9
neg integer

cmp signa, 2dh
jne ddr9
neg remainder 
ddr9:

cmp signsum, 5ah
jne ddr10
neg remainder
ddr10:
mov ax, integer  
mov cx, 2  
ddr:
ddr1:
push cx
xor dx, dx  
mov bx,10 
idiv bx  
or dl, 30h
mov di,offset resultd
mov  byte ptr[di+3],dl
xor dx, dx
div bx 
or dl, 30h
mov di,offset resultd 
mov  byte ptr[di+2],dl
xor dx, dx 
div bx 
or dl, 30h
mov  byte ptr[di+1],dl
xor dx, dx
div bx 
or dl, 30h
mov  byte ptr[di],dl

cmp signr, 1                ;daca rezultatul e negativ afisam semnul
jne ddr4
mov bp, offset sign_mess           ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 2             ; setam codul culorii
mov cx, 1     ; incarcam in cx numarul de caractere a sirului
mov dh, 13               ; rindul din care incepe afisarea
mov dl, 12         ; coloana din care incepe afisarea
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10
ddr4:


mov bp, offset resultd            ; salvam offsetul mesajului in bp (Hello World!)
mov bl, 2             ; setam codul culorii
mov cx, 4     ; incarcam in cx numarul de caractere a sirului
mov dh, 13               ; rindul din care incepe afisarea
mov dl, x         ; coloana din care incepe afisarea
mov ah, 13h	; Codul functiei de afisare a unui sir 
mov al, 1       ; Modul de afisare
mov bh, 0x00	; Numarul paginii
int 0x10	    ; Call video interrupt 
mov ax, remainder
mov x, 18
pop cx
loop ddr    
mov ah, 01h             ;ascundem
mov cx, 2607h            ;cursorul
int 10h 
pop dx
pop cx
pop bx
pop ax
ret
DisplayDivisionResult ENDP 



ResultSign PROC
     pusha
     mov al, signa
    add al, signb
    mov signsum, al
    cmp al, 2dh
    jne rs
    mov signr, 1
    jmp exit
    rs:
    mov signr, 0   
    
     exit: 
     
    popa
    ret
ResultSign ENDP
               
               
               
                                     
;===================================== MAIN FUNCTION===========================================================

main: 
mov cursor_pos, 22 
mov nmul, 0
mov signsum, 0
mov x, 13
mov signa, 0 
mov signb, 0
mov signr, 0 
mov signsum, 0 
mov operation_s, 0
call ReadA 
call CheckSignA 
call ReadB
call CheckSignB 
call Operation
mov ah, 0
int 16h
mov ax, 0600h
mov es, ax
jmp 0600h:0000h
       

;=========================================== DATA =============================================================

end:
jmp $  


digit db 0
a dw 0 
b dw 0
result dw 0
cursor_pos db 0
msg1 db 'Input a: ',0
msg1_len = 9
msg2 db 'Input operation: ',0 
msg2_len = 17
msg3 db 'Input b: ',0
msg3_len = 9 
signa db 0 
signb db 0
signr db 0 
error db 'Not an integer!',0
error1 db 'Overflow!',0 
err_len = 15
err1_len = 9
resultd db 0,0,0,0,0
result_length dw 4
nmul db 0
sign_mess db '-',0 
operation_s db 0
x db 13   ; coloana de unde se afiseaza rezultatul impartirii
integer dw 0
remainder dw 0
signsum db 0
clear db '000000000000000000',0