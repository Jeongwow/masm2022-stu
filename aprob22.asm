; 키보드에서 대 소문자 문자들을 계속 입력받으며 '소문자 x' 가 입력될때까지 그 갯수를 카운팅 하여 출력하는 PC 어셈블리 프로그램을 작성하시오.
; 예를들어    nocreditx 이라고 입력하면, 8 을 출력하면 됨. (x는 카운트 하지 않음)
; 입력은 아주 협조적이어서, 대소문자 이외에는 아무것도 입력하지 않는다고 가정하면 됨. (대소문자가 아닌 것에 대한 어떤 예외 처리도 필요없다는 것)
; x 가 입력 종료 문자가 되는 것임.

CODE SEGMENT
ASSUME CS:CODE,DS:CODE

    MOV AX,CS
    MOV DS,AX

    MOV CL,0
INPUTCHAR:
    MOV AH,1
    INT 21H

    MOV INPUT,AL

    JMP CHECKGATHER
ENDCHECKCOME:

    CMP INPUT,'x'
    JNE INPUTCHAR

    ; 개행.
    MOV AH,2
    MOV DL,0DH
    INT 21h
    MOV DL,0AH
    INT 21h

    ; 숫자 출력
    MOV VAR,CL
    CALL CONVERT16TO10

    MOV AH,4CH
    INT 21H


CHECKGATHER:
    CMP INPUT,'a'
    JE INCREASEANDRETURN

    CMP INPUT,'e'
    JE INCREASEANDRETURN

    CMP INPUT,'i'
    JE INCREASEANDRETURN

    CMP INPUT,'o'
    JE INCREASEANDRETURN

    CMP INPUT,'u'
    JE INCREASEANDRETURN
    JMP ENDCHECKCOME


INCREASEANDRETURN:
    INC CL
    JMP ENDCHECKCOME



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
    RET


    MOV AH,4CH
    INT 21H

    VAR DB ?
    INPUT DB ?
    LEVEL1 DB ?
    LEVEL2 DB ?

CODE ENDS
END