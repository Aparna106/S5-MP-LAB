.model small
.stack 100h

data segment
  msg1 db 10,13, "Enter an 8 bit number : $"
  msg2 db 10,13, "The sum is : $"
  msg3 db 10,13, "The average is : $"
  msg4 db "/$"

  arr db 10 dup('$')
  num1 db ?
  num2 db ?
  num3 db ?
  sum db ?
  carry db 00h
  q db ?
  r db ?
data ends

code segment
assume cs:code, ds:data

start:
  mov ax,data
  mov ds,ax

  lea dx,msg1 ; FIRST NUM
  mov ah,09h
  int 21h
  call input
  mov num1,al

  lea dx,msg1 ; SECOND NUM
  mov ah,09h
  int 21h
  call input
  mov num2,al

  add al,num1 ; FIRST ADD
  jnc skip1
  inc carry
  skip1:mov sum,al
  
  lea dx,msg1 ; THIRD NUM
  mov ah,09h
  int 21h
  call input
  mov num3,al

  add al,sum ; SECOND ADD
  jnc skip2
  inc carry
  skip2:mov sum,al 

  lea dx,msg2 ; DISPLAY SUM
  mov ah,09h
  int 21h

  ;lea si,sum
  ;lea di,carry
  call output


  lea dx,msg3 ; AVG PART
  mov ah,09h
  int 21h

  mov ah,00h
  mov al,sum
  mov bl,03h

  div bl
  mov q,al
  mov r,ah

  lea si,q
  call output2

  
  lea dx,msg4
  mov ah,09h
  int 21h

  lea si,r
  call output2

  

  mov ah,4ch ; END
  int 21h

  input proc near ; INPUT 

  mov ah,01h
  int 21h
  sub al,30h
  cmp al,09h
  jle skip6
  sub al,07h
  skip6:mov cl,04h
  rol al,cl
  mov ch, al

  mov ah,01h
  int 21h
  sub al,30h
  cmp al,09h
  jle skip7
  sub al,07h
  skip7:add al,ch

  ret
  input endp

  output proc near ; OUTPUT
  
  mov al,carry  ; CARRY -- SUM
  add al,30h
  mov dl,al
  mov ah,02h
  int 21h

  mov al,sum  ;10'S PLACE
  and al,0f0h
  mov cl,04h
  rol al,cl

  add al,30h
  cmp al,39h
  jle skip3
  add al,07h
  skip3:mov dl,al
  mov ah,02h
  int 21h

  mov al,sum  ;1'S PLACE
  and al,0fh

  add al,30h
  cmp al,39h
  jle skip4
  add al,07h
  skip4:mov dl,al
  mov ah,02h
  int 21h

  ret
  output endp

  output2 proc near ; OUTPUT AVG
  
  mov al,[si]  ;10'S PLACE
  and al,0f0h
  mov cl,04h
  rol al,cl

  add al,30h
  cmp al,39h
  jle skip8
  add al,07h
  skip8:mov dl,al
  mov ah,02h
  int 21h

  mov al,[si]  ;1'S PLACE
  and al,0fh

  add al,30h
  cmp al,39h
  jle skip9
  add al,07h
  skip9:
  mov dl,al
  mov ah,02h
  int 21h

  ret
  output2 endp

code ends
end code