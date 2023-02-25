.model small
.stack 100h

data segment
msg1 db 10,13,"Enter the Number:$"
msg2 db 10,13,"The number is Odd$"
msg3 db 10,13,"The number is Even$"
data ends
code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax

lea dx,msg1   ;display msg1
mov ah,09h
int 21h
call input

skip1:sub al,02h
jc odd
jz even1
jmp skip1

odd:lea dx,msg2
mov ah,09h
int 21h
call exit

even1:lea dx,msg3
mov ah,09h
int 21h
call exit

input proc near   
    mov ah,01h   ;input higher byte char
    int 21h
    sub al,30h   ;ascii conversion
    cmp al,09h
    jle skip2   ;if less than or equal to 9
    sub al,07h
skip2:mov cl,04h
    rol al,cl   ;shift 4 times to left
    mov ch,al   ;move to ch, the higher bytes
    mov ah,01h   ;input lower byte char
    int 21h
    sub al,30h   ;ascii conversion
    cmp al,09h
    jle skip3
    sub al,07h
skip3:add al,ch
    ret
input endp

exit proc near
    mov ah,4ch
    int 21h
    ret
exit endp

code ends
end start