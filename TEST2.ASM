.model small
.stack 100h

data segment
msg1 db 10, 13, "Enter the string: $"
str db 20 dup("$")
data ends

code segment
assume cs:code, ds:data
start: 
    mov ax, data 
    mov ds, ax 

    mov dx, offset msg1 
    mov ah, 09H
    int 21H

    call input

    call output
    jmp short exit

input proc near
    mov si, offset str 
    mov ah, 01H
skip1:int 21H
    cmp al, 13
    je skip
    mov [si], al
    inc si
    jmp skip1
skip:
    ret
input endp

output proc near
    lea dx, str
    mov ah, 09H
    int 21H
    ret
output endp
    
exit:
    mov ah, 4ch
    int 21H
code ends
end start