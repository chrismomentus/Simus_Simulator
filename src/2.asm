;---------------------------------------------------
; Programa:
; Autor:
; Data:
;---------------------------------------------------
ORG 65280


V1H EQU 8
V1L EQU 9
V2H EQU 8
V2L EQU 9
MV1H EQU 171
MV1L EQU 18
MV2H EQU 205
MV2L EQU 69
str11: STR "-"
str12: STR "1"
str2: STR "0"
str3: STR "1"
var1: DS 2
var2: DS 2
mvar1: DS 2
mvar2: DS 2
mret: DS 2
aux1: DS 1
aux2: DS 1
aux3: DS 1
aux4: DS 1

ORG 0

PREPARE:
    NOP
    NOP
    NOP
    LDA MV1L
    PUSH
    LDA MV1H
    PUSH
    LDA MV2L
    PUSH
    LDA MV2H
    PUSH


SWITCH:
    OUT #3
    JSR ROTINA
    SUB #1
    JZ CASE1
    SUB #1
    JZ CASE2
    JMP CASE3

CASE1:
    LDA str11
    OUT #2
    LDA str12
    OUT #2
    JMP END

CASE2:
    LDA str2
    OUT #2
    JMP END

CASE3:
    LDA str3
    OUT #2
    JMP END

ROTINA:

    POP
    STA mret+1
    POP
    STA mret
    POP
    STA mvar2+1
    POP
    STA mvar2
    POP
    STA mvar1+1
    POP
    STA mvar1
    
 
    LDA V1L
    STA @mvar1
    STA var1

    LDA mvar1
    ADD #1
    STA mvar1

    LDA V1H
    STA @mvar1
    STA var1+1

    LDA mvar1
    SUB #1
    STA mvar1
    
    LDA V2L
    STA @mvar2
    STA var2

    LDA mvar2
    ADD #1
    STA mvar2

    LDA V2H
    STA @mvar2
    STA var2+1

    LDA mvar2
    SUB #1
    STA mvar2

    LDA mret
    PUSH
    LDA mret+1
    PUSH

    LDA var1+1
    AND #8
    JZ POSA

NEGA:
    LDA var2+1
    AND #8
    JZ BMAIOR
    JMP CMP

POSA:
    LDA var2+1
    AND #8
    JZ CMP
    JMP AMAIOR

CMP:
    LDA var1+1
    SUB var2+1
    JN BMAIOR
    JZ CMP2
    JMP AMAIOR

CMP2:
    LDA var1
    SUB var2
    JN BMAIOR
    JZ IGUAIS
    JMP AMAIOR

IGUAIS:
    LDA #2
    RET

AMAIOR:
    LDA #3
    RET

BMAIOR:
    LDA #1
    RET

END: 
    HLT
