;    키보드에서 입력받은 A~Z 의 문자에 따라 (단, 대소문자를 구분하지 않음),
;    각각 숫자 1~26이 화면에 출력되는 PC 어셈블리 프로그램을 작성하시오.
;    단, 이 프로그램은 무한 반복되게 해야 함.
;    예를들어, 소문자 Z 나 대문자 Z를 입력하면 화면에 26 이 나타나면 됨.

MAIN SEGMENT
ASSUME CS:MAIN, DS:MAIN

    MOV AX,CS
    MOV DS,AX
INPUTC:
    MOV AH,1
    INT 21H

    CMP AL,20H      ; 20H는 'space bar'입력임.
    JE EXIT

    MOV INPUT,AL

    CMP INPUT,'A'
    JAE CHECKUPERZ

NOUPPER:    ; 만약 대문자 확인했는데 대문자 아니다, 그럼 소문자인지 확인
    CMP INPUT,'a'
    JAE CHECKLOWZ

    JMP INPUTC

    MOV AH,4CH
    INT 21H

CHECKLOWZ:
    CMP INPUT, 'z'
    JBE PRINTL
    JMP INPUTC

CHECKUPERZ:
    CMP INPUT, 'Z'
    JBE PRINTU
    JMP NOUPPER

PRINTL:
    MOV AL,INPUT
    MOV BL,'a'-1
    SUB AL,BL       ; 이러면 AL 에 16진수로 출력할 숫자 생김.

    MOV VAR,AL
    CALL CONVERT16TO10
    JMP INPUTC

PRINTU:
    MOV AL,INPUT
    MOV BL,'A'-1
    SUB AL,BL       ; 이러면 AL 에 16진수로 출력할 숫자 생김.

    MOV VAR,AL
    CALL CONVERT16TO10
    JMP INPUTC

CONVERT16TO10:
    MOV AH,0
    MOV AL,VAR
    MOV BL, 0AH
    DIV BL
    
    MOV LEVEL1,AL
    MOV LEVEL2,AH
    CMP LEVEL1,00H
    JE NOPRINTZERO
    MOV DL,LEVEL1
    ADD DL,'0'
    MOV AH,2
    INT 21H

NOPRINTZERO:
    MOV DL,LEVEL2
    ADD DL,'0'
    MOV AH,2
    INT 21H

    ; 개행.
    MOV AH,2
    MOV DL,0DH
    INT 21h
    MOV DL,0AH
    INT 21h
    RET


EXIT:
    MOV AH,4CH
    INT 21H

    INPUT DB ?
    VAR DB ?
    LEVEL1 DB ?
    LEVEL2 DB ?

MAIN ENDS
END