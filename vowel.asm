.model small
.stack 100h

data segment
    n db ?
    msg1 db 10, 13, "Enter the string: $"
    msg2 db 10, 13, "No. of vowels occurance: $"
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

    lea si, str
    mov ch, 00H
skip7:mov al, [si]
    cmp al, 13
    je count
    cmp al, 'a'
    jne skip2
    inc ch 
skip2:cmp al,'e'
    jne skip3
    inc ch
skip3:cmp al,'i'
    jne skip4
    inc ch
skip4:cmp al,'o'
    jne skip5
    inc ch
skip5:cmp al,'u'
    jne skip6
    inc ch
skip6:inc si
    jmp skip7
    

count: 
    call output
    jmp exit

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
    lea dx, msg2
    mov ah, 09H
    int 21H
    mov n, ch
    mov al,n
    add al,30h
    mov dl,al
    mov ah, 02H
    int 21h
    ret
output endp

    
exit:
    mov ah, 4ch
    int 21H
code ends
end start