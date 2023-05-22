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
    MOV BL,'a'-'0'
    SUB AL,BL

    MOV VAR,AL       ; 일단 VAR에 AL 넣어두기
    CMP AL,'9'        ;
    JBE JUSTPRINTVAR
    
    ; 여기까지 어차피 16진수로 ~ 저장될듯.
    MOV AH,0        ; ah 를 비워줌.
    MOV BL,10H
    MUL BL         ; 왼쪽 쉬프트. (AX에 저장.)

    ;그럼 지금까지 하면 AX에 쉬프트 되어있음. 원래 : 00FFH , 결과 0FF0H
    MOV LEVEL1,AH           ; 상위 보존
    MOV AH,0        ; ah 를 비워줌. 그래야 오른쪽으로 shift 했을 때 00FFh가 아니라 000FH가 됨.
    DIV BL          ; 하위 움직이기. AL에 몫 저장.

    MOV LEVEL2,AL      ; VAR -> 프린트할 변수
    JMP JUSTPRINTLOW       ; VAR 프린트, 

PRINTU:
    MOV AL,INPUT
    MOV BL,'A'-'0'
    SUB AL,BL

    MOV VAR,AL       ; 일단 VAR에 AL 넣어두기
    CMP AL,'9'      ;
    
    JBE JUSTPRINTVAR

    ; 여기까지 어차피 16진수로 ~ 저장될듯.
    MOV AH,0        ; ah 를 비워줌.
    MOV BL,10H
    MUL BL         ; 왼쪽 쉬프트. (AX에 저장.)

    ;그럼 지금까지 하면 AX에 쉬프트 되어있음. 원래 : 00FFH , 결과 0FF0H
    MOV LEVEL1,AH           ; 상위 보존
    MOV AH,0        ; ah 를 비워줌. 그래야 오른쪽으로 shift 했을 때 00FFh가 아니라 000FH가 됨.
    DIV BL          ; 하위 움직이기. AL에 몫 저장.

    MOV LEVEL2,AL      ; VAR -> 프린트할 변수
    JMP JUSTPRINTLOW       ; VAR 프린트, 

JUSTPRINTLOW:
    MOV DL,LEVEL1
    MOV AH,2
    INT 21H
    JMP JUSTPRINTUP

JUSTPRINTUP:
    MOV DL,LEVEL2
    MOV AH,2
    INT 21H
    JMP INPUTC

JUSTPRINTVAR:
    MOV DL,VAR
    MOV AH,2
    INT 21H
    JMP INPUTC

    INPUT DB ?
    VAR DB ?
    LEVEL1 DB ?
    LEVEL2 DB ?

MAIN ENDS
END