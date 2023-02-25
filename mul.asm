data segment
        num1 DB ?
        num2 DB ?
        product DW ?
        msg1 DB 10,13,"Enter number 1: $"
        msg2 DB 10,13,"Enter number 2: $"
	msg3 DB 10,13,"The result is $"
data ends
code segment
        assume cs:code,ds:data
        start:
        mov ax,data
        mov ds,ax
        lea dx,msg1
        mov ah,09H
        int 21H
        call input
        mov num1,al
	mov ah,09H
        lea dx,msg2
	int 21H
        call input
        mov num2,al
	
	mov ax,0000H;multiplying two numbers - repeated addition
	mov bl,num2
	repeat:add al,num1
	daa
	jnc next
	mov cl,al
	mov al,ah
	add al,01H
	daa
	mov ah,al
	mov al,cl
	next:dec bl
	jnz repeat

	mov product,ax
	mov ah,09H
        lea dx,msg3
        int 21H

	lea si,product;load address of product
	call output
	mov ah,4CH
	int 21H

input proc near
	mov ah,01H
	int 21H
	sub al,30H
	cmp al,09H
	jle skip
	sub al,07H
 	skip:mov cl,04H
	rol al,cl
	mov ch,al;store al value

	mov ah,01H
	int 21H
	sub al,30H
	cmp al,09H
	jle skip2
	sub al,07H
	skip2:add al,ch
	ret
input endp
output proc near
	mov ax,[si];move to al register
	and ah,0f0H;mask lower bits
	mov cl,04H
	rol ah,cl;perform rotation to right
	add ah,30H;hex to ascii
	cmp ah,39H
	jle skip4
	add ah,07H
	skip4:mov dl,ah
	mov ah,02H
	int 21H

	mov ax,[si]
	and ah,0fH
	add ah,30H;hex to ascii
	cmp ah,39H
	jle skip5
	add ah,07H
	skip5: mov dl,ah
	mov ah,02H
	int 21H

	mov ax,[si];move to al register
	and al,0f0H;mask lower bits
	mov cl,04H
	rol al,cl;perform rotation to right
	add al,30H;hex to ascii
	cmp al,39H
	jle skip6
	add al,07H
	skip6: mov dl,al
	mov ah,02H
	int 21H

	mov ax,[si]
	and al,0fH
	add al,30H;hex to ascii
	cmp al,39H
	jle skip7
	add al,07H
	skip7:mov dl,al
	mov ah,02H
	int 21H
	ret
output endp
code ends
end start