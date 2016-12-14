	org 100h 
	

	
	mov ah, 3ch
	mov cx, 0
	mov dx, offset filename
	mov ah, 3ch
	int 21h  ; create file... 
	mov handle, ax

	mov bx, handle
	mov dx, offset data
	mov cx, data_size
	mov ah, 40h
	int 21h ; write to file... 

	mov bx, handle
	mov ah, 3eh
	int 21h ; close file... 
	ret

	filename db "myfile.dat", 0 
	handle dw ?
	data db " some data "
	data_size=$-offset data
