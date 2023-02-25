data segment
	str1 db 20 dup('$')
	substr db ?
	newstr db ?
	msg1 db 10,13,"Enter First String: $"
	msg2 db 10,13,"Enter Character To Replace: $"
	msg3 db 10,13,"Enter Character To Be Replaced With: $"
	msg4 db 10,13,"The String is: $"
data ends
code segment
	assume cs:code, ds:data
	start:

	mov ax, data
	mov ds, ax

	mov ah, 09H ; 		Display Msg1
	lea dx, msg1
	int 21H
	mov si, offset str1
	call input

	mov ah, 09H ; 		Display Msg2
	lea dx, msg2
	int 21H
	mov ah, 01H
	int 21H
	mov substr, al
	
	mov ah, 09H ; 		Display Msg3
	lea dx, msg3
	int 21H
	mov ah, 01H
	int 21H
	mov newstr, al
	
	mov ah, 09H ; 		Display Msg4
	lea dx, msg4
	int 21H


				;Replace String
	mov si, offset str1+2
	mov cl, str1+1
	mov al, newstr	
	next:mov ah, [si]
	cmp ah, substr
	jne skip
	mov [si], al
	skip:inc si
	dec cl
	jnz next
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