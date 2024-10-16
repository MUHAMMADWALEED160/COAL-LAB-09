.model small
.stack 100h

.data

msg db "The sum of three digits:$"

result db ?

.code
    main proc
    
    mov ax,@data
    mov ds,ax  
    
    call addnumbers    
    
    lea dx,msg
    call display  
    
    
    mov ah,2
    mov dl,result
    int 21h
 
    mov ah,4ch
    int 21h
        
    main endp 
    
    addnumbers proc  
    
    mov bl,2
    mov dl,3
    mov cl,2
     
    add bl,dl
    add bl,cl
    
    add bl,'0' 
   
    mov result,bl
        
        
    ret
    
    addnumbers endp
    
    newline proc 
     
    mov dx,10
    mov ah,2
    int 21h
    
    mov dx,13
    mov ah,2
    int 21h    
      
    ret
    
    newline endp 
    
    display proc
        
    mov ah,9
    int 21h
    
    ret
    
    display endp 

end main