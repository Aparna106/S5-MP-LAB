data segment
	str1 db 20 dup('$')
	str2 db 20 dup('$')
	msg1 db 10,13,"Enter First String: $"
	msg2 db 10,13,"Enter Second String: $"
	msg3 db 10,13,"Concatenated String: $"
data ends
code segment
	assume cs:code,ds:data
	start:
	mov ax, data
	mov ds, ax

	mov ah, 09H ; 		Display Msg1
	lea dx, msg1
	int 21H
	lea si, str1
	call input
    
	mov ah, 09H ; 		Display Msg2
	lea dx, msg2
	int 21H
	mov si, offset str2
	call input
	
	mov ah, 09H ; 		Display Msg3
	lea dx, msg3
	int 21H

						;Concatenate String
	mov cl, str1+1		;get Length
	mov si, offset str1+2	;get index to first element
	next:inc si		;throught till the end of array
	dec cl
	jnz next
	mov di, offset str2+2	;get index to first element of second str
	mov cl, str2+1		;get length of string 2
	next2:mov al, [di]
	mov [si], al
	inc si
	inc di
	dec cl
	jnz next2
	mov si, offset str1+2
	call output

	mov ah, 4CH 		;End pgm
	int 21H
	
	input proc near
		mov ah, 0AH
		mov dx, si
		int 21H
		ret	
	input endp
	output proc near
		mov ah, 09H
		mov dx, si
		int 21H
		ret	
	output endp 
code ends
end start