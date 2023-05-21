CODE SEGMENT
    ASSUME CS:CODE,  DS:DATA
    ; VAR (16진수짜리 8BIT 출력)
    MOV AX,DATA
    MOV DS,AX
    
    MOV AL,VAR
    MOV BL, 10H

    ; MUL BL =>  MOV CL,4     SHL AL,CL
    MUL BL    ; AX = 0120H, AL을 왼쪽으로 1칸 쉬프트.
    MOV LEVEL1, AH      ; 상위 보존. LEVEL1 = 01H
    MOV AH,0            ; AX = 0120H 에서 0020H로 변환. 그래야 아래에서 오른쪽으로 쉬프트할 때 1이 끼어들지 않음.
    DIV BL              ; 하위 비트 10으로 나누기, 20H ->02H  로 변환
    MOV LEVEL2, AL      ; 하위 보존. LEVEL2 = 02H. 애라모르겠다. 일단 보존.
    
    MOV DL,LEVEL1
    ADD DL,'0'          ; 원래 AL은 02H였음. 이걸 아스키코드화 시켜줌.(숫자로)
    CALL PRINT

    MOV DL,LEVEL2
    ADD DL,'0'
    CALL PRINT

    MOV AH,4CH
    INT 21H

PRINT: 
    MOV AH,2   ; 여기서 AH 건드리니까 위에서 변수 잘 봐야함.
    INT 21H
    RET

CODE ENDS

DATA SEGMENT
    VAR DB 92H
    LEVEL1 DB ?
    LEVEL2 DB ?
DATA ENDS
END