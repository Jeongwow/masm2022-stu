CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

    MOV AX,DATA
    MOV DS,AX

AGAIN:
    MOV AH,8
    INT 21H

    MOV INPUT, AL

    CMP INPUT,'a'
    JB AGAIN

    CMP INPUT,'z'
    JA AGAIN

    JMP PRINT

PRINT:
    MOV AH,2
    MOV DL,INPUT
    SUB DL,'a'-'A'
    INT 21H
    JMP EXIT

EXIT: 
    MOV AH,4CH
    INT 21H

CODE ENDS
DATA SEGMENT
    INPUT DB ?

DATA ENDS
END

