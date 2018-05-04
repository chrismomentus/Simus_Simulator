ORG 700H
X: DB 243,195

ORG 800H
Y: DB 243,195,243,195

ORG 0
PCAdd: DS 2;salvar retorno do AddEnder
HPC: DS 1 ; parte alta para o retorno do PC
LPC: DS 1 ; Parte baixa para o retorno do PC
VAL: DS 2 ; endereço da variavel
VAR: DS 1 ; valor da variavel de 1byte
idx: DS 1
MAIN:
     LDA #08H
     PUSH
     LDA #00H
     PUSH
     LDA #4
     OUT 3
     JSR ROTINA
HLT


ROTINA:

       SUB #1
       STA idx
       POP ; Retira a parte baixa do PC
       POP ; Retira a parte alta do PC

       POP ; parte baixa da memoria
       STA VAL

       POP ; pate alta da memoria
       STA VAL+1

       LDA @VAL
       PUSH
       JSR   IMPRIME
       JSR   AddEnder
       LDA   idx

       JNZ   ROTINA
       JZ    FIM
FIM:
    HLT
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
