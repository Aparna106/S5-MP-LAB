.model small
.stack 100h

data segment
msg1 db 10, 13, "Enter the number: $"
msg2 db 10, 13, "The number is odd$"
msg3 db 10, 13, "The number is even"
data ends

code segment
assume cs:code, ds:data
start:

    mov ax, data
    mov ds, ax

    lea dx, msg1
    mov ah, 09H
    int 21H

    call input

skip1:
    sub al, 02H
    jc odd
    jz even1
    jmp skip1
    call exit

odd:
    lea dx, msg2
    mov ah, 09H
    int 21H
    call exit

even1:
    lea dx,msg3
    mov ah,09h
    int 21h
    call exit

    input proc near
        mov ah, 01H
        int 21H
        sub al, 30h
        cmp al, 09H
        jle skip2
        sub al, 07H
    skip2:mov cl, 04h
        rol al, cl
        mov ch, al
        mov ah, 01H
        int 21H
        sub al, 30h
        cmp al, 09H
        jle skip3
        sub al, 07H
    skip3:add al, ch
        ret
    input endp

    exit proc near
        mov ah, 4ch
        int 21H
        ret
    exit endp

code ends
end start