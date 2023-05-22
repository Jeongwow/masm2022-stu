main segment
assume cs:main, ds:main

    mov ax,cs
    mov ds,ax

    mov ax,A
    add ax,B
    mov SUM,ax

    mov ah,4c00h
    int 21h

    A dw ?
    B dw ?
    SUM dw ?

main ends
end