val: DS 1
ROTINA:
    
    LDA #0F3h
    STA val
    OUT 3
    AND #0F0h
    SHR
    SHR
    SHR
    SHR
    JSR PRINT
    LDA val
    AND #00Fh
    JSR PRINT
    LDA val
    OUT 0
    RET

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


AddEnder:
         POP
         STA PCAdd

         POP
         STA PCAdd+1
         ; Codigo, somo 1
         LDA VAL
         ADD #1
         STA VAL

         LDA VAL +1
         PUSH

         LDA VAL
         PUSH

         ;preparo o retorno
         LDA PCAdd +1
         PUSH
         LDA PCAdd
         PUSH

         LDA PCAdd +1
         PUSH
         LDA PCAdd
         PUSH
         RET
IMPRIME:
        POP
        STA LPC
        POP
        STA HPC
        POP

        STA VAR
        AND #0F0h
        SHR
        SHR
        SHR
        SHR
        JSR PRINT
        LDA VAR
        AND #00Fh
        JSR PRINT

        LDA VAR
        OUT 0

        LDA HPC
        PUSH       ; salvando retorno da funcao

        LDA LPC
        PUSH       ; salvando retorno da funcao
        RET

; printa um caractere ascii na console
aux: DS 1
PRINT:
    STA aux
    SUB #10
    JN ZTON
ATOF:
    LDA aux
    ADD #55
    JMP PRINTEND
ZTON:
    LDA aux
    ADD #48
PRINTEND:
    OUT 2
    RET
