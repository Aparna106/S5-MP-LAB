data segment
     str1 db 20 dup("$")
     msg1 db 10,13,"Enter the string:$"
     msg2 db 10,13,"character:$"
     msg3 db 10,13,"occurence:$"
     occ db ?
data ends
code segment
     assume cs:code,ds:data
     start:
         mov ax,data
         mov ds,ax

         lea dx,msg1
         mov ah,09h
         int 21h

         lea si,str1
         mov cl,00h
         loop1:mov ah,01h
               int 21h
               cmp al,13
               je skip
               mov [si],al
               inc si
               inc cl
               jmp loop1

           skip:lea dx,msg2
                mov ah,09h
                int 21h

                mov ah,01h
                int 21h
                mov occ,al
                
                mov bl,00h
                lea si,str1
          loop2:mov al,[si]
                cmp al,occ
                jne skip1
                inc bl
          skip1:inc si
                dec cl
                jnz loop2

                lea dx,msg3
                mov ah,09h
                int 21h
                
                add bl,30h
                mov dl,bl
                mov ah,02h
                int 21h

                mov ah,4ch
                int 21h

  code ends
  end start