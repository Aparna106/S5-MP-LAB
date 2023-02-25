.model small
.stack 100h

data segment
    msg1 db 10,13,"Enter the limit of digits required : $"
    msg2 db 10,13,"Fibonacci Series is : $"
    space db "$"
    l db ?
    len db ?
    str db 20 dup('$')
data ends

code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds,ax

    lea dx,msg1 ;  MSG1
    mov ah,09h
    int 21h

    mov ah,01h  ;  COUNT
    int 21h
    sub al,30h
    mov l,al
    mov len,al

    lea si,str+2

    mov al,00h  ; INITIALIZATION
    mov [si],al
    inc si
    mov al,01h
    mov [si],al

    lea si,str+2 ; CALCULATION
    up:mov al,[si]
    inc si
    add al,[si]
    inc si
    mov [si],al
    dec si
    dec l
    jnz up

    lea si,str+2 ; PRINT

    lea dx,msg2 ;  OP-MSG1
    mov ah,09h
    int 21h

    back:mov dl,[si]
    add dl,30h
    cmp dl,39h
    jle skip
    add dl,07h
    skip:mov ah,02h
    int 21h

    lea dx, space ;  SPACE
    mov ah,09h
    int 21h

    inc si
    dec len
    jnz back

    mov ah,4Ch
    int 21h
code ends
end start