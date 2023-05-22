main segment
assume cs:main, ds:main

start:      ; ends start 를 써서 start 레이블을 지정해주면 메인 코드가 start에서 사용할 수 있음
    mov ax,cs
    mov ds,ax

    mov ax,A
    add ax,B
    mov SUM,ax

    mov ah,4ch
    int 21h


A dw 00ffh
B dw 1
SUM dw ?

main ends
end start       ; 여기에 end start를 써주면, 메인 코드 영역은 start에서 시작한다를 알려줌,
; 이렇게 쓰면 같은 영역에 code, data같이 있을 때, data 영역 변수를 위에 먼저 쓸 수 있음.