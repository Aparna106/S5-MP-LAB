data segment 
msg1 db 10,13,"enter a string : $"
arr1 db 30 dup("$")
data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax

    lea dx,msg1
    mov ah,09h
    int 21h

    mov si,offset arr1
    mov ah,01h

    read:int 21h
          cmp al,13
          je skip
          mov [si],al
          inc si
          jmp read
    
    skip:      
    lea dx, arr1
    mov ah,09h
    int 21h

    mov ah,4ch
    int 21h


code ends
end start
