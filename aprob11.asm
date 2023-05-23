;    키보드에서 입력받은 A~Z 의 문자에 따라 (단, 대소문자를 구분하지 않음),
;    각각 숫자 1~26이 화면에 출력되는 PC 어셈블리 프로그램을 작성하시오.
;    단, 이 프로그램은 무한 반복되게 해야 함.
;    예를들어, 소문자 Z 나 대문자 Z를 입력하면 화면에 26 이 나타나면 됨.

CODE SEGMENT
ASSUME CS:CODE,DS:CODE

    mov ax,cs
    mov ds,ax

INPUTCHAR:
    MOV AH,1
    INT 21H

    CMP AL,20H      ; 20H는 'space bar'입력임.
    JE EXIT

    MOV INPUT,AL

    CMP INPUT,'a'
    JAE UNDERZ
    JMP INPUTCHAR



UNDERZ:
    CMP INPUT,'z'
    JBE PRINTNUM
    JMP INPUTCHAR



PRINTNUM:
    MOV AL,INPUT
    SUB AL,'a'

    ;10진수 변환
    MOV BL,0AH

    MOV AH,0    ; AX를 BL로 나눌꺼라. AH는 0으로 채워줌. 간섭받지 않으려고
    DIV BL

    MOV LEVEL1,AL
    MOV LEVEL2,AH

    MOV DL,LEVEL1
    ADD DL,'0'
    MOV AH,2
    INT 21H

    MOV DL,LEVEL2
    ADD DL,'0'
    MOV AH,2
    INT 21H
    JMP INPUTCHAR


EXIT:
    MOV AH,4CH
    INT 21H




    MOV AH,4CH
    INT 21H

    INPUT DB ?
    LEVEL1 DB ?
    LEVEL2 DB ?

CODE ENDS
END