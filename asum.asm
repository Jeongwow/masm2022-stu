main segment
assume cs:main, ds:main

    mov ax,cs
    mov ds,ax

    mov ah,12h
    mov al,34h
    add ah,al

    add ax,[bx+1000h]
    add ax,dx
    mov ax,[2A45]
    mov ax,[0100]
    ; add [DI],0FFFFh


    mov ah,4ch
    int 21h

    A dw ?
    B dw ?
    SUM dw ?

main ends
end