CODE SEGMENT

    ASSUME CS:CODE

NEXT:
    MOV AH,1    ; AL에 문자 키보드 입력 (echo)
    INT 21H     ; MOV AH,8 은 출력안하면서 입력받기.

    CMP AL,20H      ; 20H는 'space bar'입력임.
    JE EXIT

    CMP AL, 'A'
    JB PRINT

    CMP AL, 'Z'
    JA PRINT

    ADD AL,'a'-'A'      ;대문자는 소문자로 변환

PRINT:
    MOV AH,2
    MOV DL,AL
    INT 21H
    JMP NEXT

EXIT:
    MOV AH,4CH
    INT 21H

CODE ENDS
END