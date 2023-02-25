.model small
.stack 100h

data segment
    str db 20 dup("$")
    msg1 db 10,13,"Enter the string:$"
    msg2 db 10,13,"character:$"
    msg3 db 10,13,"occurence:$"
    occ db ?
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    lea dx, msg1
    mov ah, 09H
    int 21

    call input

    lea dx, msg2
    mov ah, 09H
    int 21

    mov occ, cl
    call exit

input proc near
    mov si, offset str 
    mov cl, 00H
    mov ah, 01H
skip1:int 21H
    cmp al, 13
    je skip
    mov [si], al
    inc si
    inc cl
    jmp skip1
skip:
    ret
input endp

exit proc near
    mov ah, 4ch
    int 21H
    ret
exit endp

code Ends
end start