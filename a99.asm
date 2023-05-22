; 구구단 한 단 출력하기
CODE SEGMENT
    ASSUME CS:CODE, DS:CODE
    
    MOV AX,CODE
    MOV DS,AX

    MOV AH,1
    INT 21H

    MOV VAR,AL  ; save varible
    MOV CX,1
    CALL PRINTGOGO

    JMP EXIT


PRINTGOGO:
    
    CMP CL,10
    JE EXIT
    MOV BX, OFFSET LINE
    MOV LINE[BX], VAR

    MOV LINE[BX+4],VAR + CL

    INC CL
    CALL CALCULATOR

    MOV LINE[BX+8],RESLUT

    ; 재정비
    ADD LINE[BX],'0'
    ADD LINE[BX+4],'0'

    MOV DL,OFFSET LINE
    MOV AH,9
    INT 21H

    CALL CONVERT16TO10
    RET


CONVERT16TO10:
    MOV AH,0
    MOV AL,RESLUT  ; 16진수 1A
    MOV BL, 0AH
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

    ; 개행.
    MOV AH,2
    MOV DL,0DH
    INT 21h
    MOV DL,0AH
    INT 21h
    RET


CALCULATOR:
    MOV AL, VAR
    MUL LINE[BX+4] ; 곱해줄 놈.

    MOV RESLUT,AL

    RET



EXIT: 
    MOV AH,4CH
    INT 21H

    VAR DB ?
    RESLUT DB ?
    LINE DB ?,' * ',?,' = ', '$'
CODE ENDS
    END