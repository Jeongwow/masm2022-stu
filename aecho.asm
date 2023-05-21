CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

;   에코 없는 키보드 입력을 받아서, 소문자 26글자를 입력했을 때만 화면에 출력하고,
;   그렇지 않을때는 숫자 0을 출력, 10번 반복하고 프로그램 종료.
    MOV AX,DATA
    MOV DS,AX

    MOV CX,0
NEXT:
    CMP CX,10
    JE EXIT
    INC CX

    MOV AH,1    ; 8 에코 없는 입력. AL에 저장.
    INT 21H

    MOV INPUT, AL

    CMP INPUT,'a' ; 입력받은 AL이 a~z 사이에 없을 때 zero 출력.
    JB ZERO

    CMP INPUT, 'z'
    JA ZERO

    JMP UPPER

EXIT:
    MOV AH,4CH
    INT 21H

ZERO:
    MOV AH,2
    MOV DL,'0'
    INT 21H
    JMP NEXT

UPPER:
    MOV AH, 2
    MOV DL, INPUT
    INT 21H
    JMP NEXT
CODE ENDS

DATA SEGMENT
    INPUT DB ?
DATA ENDS
END