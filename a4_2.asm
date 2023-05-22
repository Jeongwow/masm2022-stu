title a4_2.asm
.model small
.stack 100h

.data
a db 2
b db 5
sum db ?

.code
main proc
    mov ax,@data
    mov ds,ax

    mov al,a
    add al,b

    mov sum,al

    add al,'0'
    mov dl,al

    mov ah,2
    int 21h

    mov ah, 4ch
    int 21h

main endp
end main