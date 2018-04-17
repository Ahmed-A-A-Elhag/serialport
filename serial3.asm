bits 16
org 0x7C00

	cli
        xor ax,ax
	mov ds,ax
	mov es,ax
        mov ah, 0x02
        mov al, 10
        mov dl, 0x80
        mov ch, 0
        mov dh, 0
        mov cl, 2
        mov bx, lets_code
        int 0x13
        jmp lets_code
        
        times (510 - ($ - $$)) db 0
        db 0x55, 0xAA
        
lets_code:
        
        mov esi,0xb804E
H:
        
        mov byte[esi],177
        add esi,1
        mov byte[esi],0xf
        add esi,1
        mov byte[esi],177
        add esi,1
        mov byte[esi],0xf
        add esi,1
        add esi,156
        cmp esi,0xB8FFF
        jl H
        
        
	
	
        tablesma: dD "//1234567890-=//qwertyuiop[]//asdfghjkl;//'/zxcvbnm,.//// /"
        tablecap: dD "//1234567890-=//QWERTYUIOP[]//ASDFGHJKL;//'/ZXCVBNM,.//// /"

     
        x:dd 0
        y:dd 0
        ; Initialize Asynchronous Communication Port	
mov     ah, 0          
mov     al,11100111b   ; 9600 baud, no parity, eight bit data, and two stop bits-
mov     dx, 0           ;COM1: port.
int     14h 





        mov ebx,tablesma
        mov edi, 0xB8000
        mov esi,0xb8052

lp:

       in al,64h
       and al,1
       jz z
       in al,60h
       cmp al,0x1c ;make code for enter
       je g1
       cmp al,0x2a ;make code for shift
       je L3
L5:    
       
      
       cmp al,0xaa ;break code for shift
       je L4
L6:    
       cmp al,80h
       jb makecode
       jmp z
       
makecode:
       cmp dword[x],0
       jne L1
B1:
       mov dword[x],0
       mov dx,0x3f8
       cmp al,0x2a
       je z
       cmp al,0x3a ;;make code for capslk 
       je L10   
       cmp al,0x0e ;;make code for backspace
       je g3 
       xlat
       out dx,al
       mov [esi],al
       add esi,2
       add dword[y],2
       cmp dword[y],78
       je n2
       
z:
       mov dx,0x3fd
       in al,dx
       and al,1
       jz lp
       ;mov ah,3
       ;xor dx,dx
       ;int 0x14
       ;and ax,0000000100000000b
       cmp dword[y],0
       jne n1
m1:
       mov dword[y],0
       mov dx,0x3f8
       in al,dx
       cmp al,0x1c  ;make code for enter
       je g2
       cmp al,0x0e  ;ascii backspace
       je g6
       mov [edi],al
       add edi,1
       mov byte[edi],0x05
       add edi,1
       add dword[x],2
       cmp dword[x],78
       je L2
       jmp z
L1:
       cmp dword[x],78
       jg L2
       add edi,160
       sub edi,dword[x]
       jmp B1
L2:
       add edi,82
       sub dword[x],78
       jmp z
  
  
n1:
       cmp dword[y],78
       jg n2
       add esi,160
       sub esi,dword[y]
       jmp m1
n2:
       add esi,82
       sub dword[y],78
       jmp z
     

L3:
       cmp ebx,tablecap
       je L7
       mov ebx,tablecap
       jmp L5
L7:
       mov ebx,tablesma
       jmp L5
L4:
       cmp ebx,tablecap
       je L8
       mov ebx,tablecap
       jmp L6
L8:
       mov ebx,tablesma
       jmp L6
     
L10:
       cmp ebx,tablecap
       je L9
       mov ebx,tablecap
       jmp z
L9:
       mov ebx,tablesma
       jmp z
    
g1: 
       mov dx,0x3f8
       out dx,al   
       add esi,160
       sub esi,dword[y]
       mov dword[y],0
       jmp z  
g2:   
       add edi,160
       sub edi,dword[x]
       mov dword[x],0
       jmp z          

g3:  
       cmp esi,0xb8052
       jle lp
       cmp dword[y],0
       je g4
       sub esi,2
       mov byte[esi],0
       sub dword[y],2
       mov al,0x0e
       mov dx,0x3f8
       out dx,al   
       jmp lp
g4:
       cmp esi,0xb8052
       jle lp
       sub esi,84  
       mov byte[esi],0    
       mov dword[y],76  
       mov al,0x0e
       mov dx,0x3f8
       out dx,al  
       jmp lp            
g6:
       cmp edi,0xb8000
       jle lp
       cmp dword[x],0
       je g7
       sub edi,2
       mov byte[edi],0
       sub dword[x],2  
       jmp lp
g7:
       cmp edi,0xb8000
       jle lp
       sub edi,84  
       mov byte[edi],0    
       mov dword[x],76  
      
       jmp lp
times (0x400000 - ($ - $$)) db 0

db 	0x63, 0x6F, 0x6E, 0x65, 0x63, 0x74, 0x69, 0x78, 0x00, 0x00, 0x00, 0x02
db	0x00, 0x01, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
db	0x20, 0x72, 0x5D, 0x33, 0x76, 0x62, 0x6F, 0x78, 0x00, 0x05, 0x00, 0x00
db	0x57, 0x69, 0x32, 0x6B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x78, 0x04, 0x11
db	0x00, 0x00, 0x00, 0x02, 0xFF, 0xFF, 0xE6, 0xB9, 0x49, 0x44, 0x4E, 0x1C
db	0x50, 0xC9, 0xBD, 0x45, 0x83, 0xC5, 0xCE, 0xC1, 0xB7, 0x2A, 0xE0, 0xF2
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00