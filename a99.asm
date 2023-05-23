; 구구단 한 단 출력하기
CODE SEGMENT
    ASSUME CS:CODE, DS:CODE

    MOV AX,CODE
    MOV DS,AX

    MOV AH,1
    INT 21H

    SUB AL,'0'
    MOV VAR,AL  ; save varible

    ; 개행.
    MOV AH,2
    MOV DL,0DH
    INT 21h
    MOV DL,0AH
    INT 21h
    
    MOV CX,1    ;1부터 9까지

PRINTLOOP:  ;
    
    CMP CL,10
    JE EXIT
    MOV DI, OFFSET LINE
    MOV AL, VAR
    ADD AL,'0'
    MOV [DI], AL

    MOV AL,CL
    ADD AL,'0'
    MOV [DI+4],AL

    INC CL
    CALL CALCULATOR
    
    MOV AL,RESLUT

    MOV DX,OFFSET LINE      ; 왜 DX지?
    MOV AH,9
    INT 21H

    JMP CONVERT16TO10 ; 사실 바로 아래로 감. 가독성을 위해. 

CONVERT16TO10:          ; 이부분이 16진수 10진수로 출력
    MOV AH,0
    MOV AL,RESLUT  ; 16진수 1A
    MOV BL, 0AH
    DIV BL
    
    MOV LEVEL1,AL
    MOV LEVEL2,AH

    CMP LEVEL1,00H  ; 9를 넘지 않으면 앞에 01,02 0을 출력하지 않아도 됨.
    JE NOPRINTZERO ; NOPRINTZERO: 나올떄 까지 넘어감  (LEVEL1출력 생략)

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
    JMP PRINTLOOP


CALCULATOR:
    MOV AL, VAR
    MOV BL, [DI+4]   ; 곱해줄 놈.
    SUB BL,'0'
    MUL BL

    MOV RESLUT,AL

    RET



EXIT: 
    MOV AH,4CH
    INT 21H

    VAR DB ?
    LEVEL1 DB ?
    LEVEL2 DB ?
    RESLUT DB ?
    LINE DB ?,' * ',?,' = ', '$'
CODE ENDS
    END