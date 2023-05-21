.model small
.stack 100h
.data
    prompt db 'enter a lower case letter : $'
    msg db 0Dh,0Ah,'in upper case it is: '
    char db ?,'$'

.code
main proc
    
    mov ax,@data  ; get data segment
    mov ds,ax
    
    mov dx,offset prompt
    mov ah,9
    int 21h

    mov ah,1
    int 21h

    sub al,20h
    mov char,al

    mov dx,offset msg
    mov ah,9
    int 21h

    mov ah,4ch
    int 21h

main endp
end main