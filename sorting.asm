.model small
.stack 100h

data segment
  msg1 db 10,13, "Enter array elements : $"
  msg2 db 10,13, "Output is: $"
  msg3 db 10,13, " $"
  arr db 10 dup('$')
data ends

code segment
assume cs:code, ds:data
  start:
    mov ax, data
    mov ds,ax

  lea dx,msg1 ; INPUT
  mov ah,09h
  int 21h

  lea dx,arr 
  mov ah,0Ah
  int 21h

  mov ch,arr ; OUTER LOOP

  outloop:lea si,arr+1 ; INNERLOOP
  mov cl,arr+1
  
  back:
  mov bl,[si]
  inc si
  cmp bl,[si]
  jc skip1
  mov al,[si]
  mov [si],bl
  dec si
  mov [si],al
  inc si
  skip1:dec cl
  jnz back

  dec ch
  jnz outloop
  
  
  lea dx,msg2 ; OUTPUT
  mov ah,09h
  int 21h

  lea si,arr+2
  mov cl,arr+1

  up:lea dx,msg3
  mov ah,09h
  int 21h

  mov dl,[si]
  mov ah,02h
  int 21h

  inc si
  dec cl
  jnz up
  
  exit:mov ah,4ch
  int 21h

code ends

end start