;---------------------------------------------------
; Programa:
; Autor:
; Data:
;---------------------------------------------------
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
