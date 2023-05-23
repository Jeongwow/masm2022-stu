CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

    MOV AX,DATA
    MOV DS,AX

NEXT:
    MOV AH,1    ; AL에 문자 키보드 입력 (echo)
    INT 21H     ; MOV AH,8 은 출력안하면서 입력받기.

    MOV INPUT,AL

    CMP INPUT,20H      ; 20H는 'space bar'입력임.
    JE EXIT

    CMP INPUT, 'A'
    JAE CHECKU
    

NOUPER:
    CMP INPUT, 'a'
    JAE CHECKL

    JMP NEXT


CHECKU:
    CMP INPUT, 'Z'
    JBE PRINTU

    JMP NOUPER

CHECKL:
    CMP INPUT, 'z'
    JBE PRINTL
    
    JMP NEXT

PRINTU:
    MOV DL,INPUT
    ADD DL,'a'-'A'

    MOV AH,2
    INT 21H
    JMP NEXT

PRINTL:
    MOV DL,INPUT
    SUB DL,'a'-'A'
    MOV AH,2
    INT 21H
    JMP NEXT

EXIT:
    MOV AH,4CH
    INT 21H

CODE ENDS
DATA SEGMENT
    INPUT DB ?
DATA ENDS
END