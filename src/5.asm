;---------------------------------------------------
; Programa:
; Autor:
; Data:
;---------------------------------------------------
ORG 500H
  
  VETOR:       DW -1,0,1,4,5,6,7,8,-8
  TAM_VETOR:   DB 0
  END_VETOR:   DS 2
  PCAdd:       DS 2
  CONT:        DB 0
  POSITIVO:    DB 0
  NEGATIVO:    DB 0
  ZERO:        DB 0
  VAR:         DB 0
  ORG 0


  INICIO:
         OUT   3
         LDA   #05H
         PUSH
         LDA   #00H
         PUSH
         LDA   #3  ;Tamanho do vetor
         JSR   SINAL



  SINAL:
             STA TAM_VETOR
             POP; retiro parte baixa do PC
             POP; retiro parte alta do PC
             POP; retiro parte baixa
             STA END_VETOR
             POP
             STA END_VETOR+1
             LDA @END_VETOR ; parte alta
	     AND #0F0h
	     JNZ NEG
             JMP ZER

  NEG:
	     LDA #1
	     ADD NEGATIVO
	     STA NEGATIVO
             JMP NEXT_ELEM

  ZER:
            LDA @END_VETOR   
            OR  #000h
            JNZ POS

            JSR ADDENDER
            LDA @END_VETOR
            STA VAR      
            JSR SUBENDER
            LDA VAR
            OR  #000h
            JNZ POS
            LDA #1
            ADD ZERO
            STA ZERO
            JMP NEXT_ELE
  ADDENDER:
           POP
           STA PCAdd
           POP
           STA PCAdd +1

           LDA END_VETOR
           ADD #1
           STA END_VETOR

           LDA PCAdd +1
           PUSH
           LDA PCAdd
           PUSH
           RET
  SUBENDER:
           POP
           STA PCAdd
           POP
           STA PCAdd +1

           LDA END_VETOR
           SUB #1
           STA END_VETOR

           LDA PCAdd +1
           PUSH
           LDA PCAdd
           PUSH
           RET
  POS:
            LDA #1
            ADD POSITIVO
            STA POSITIVO
            JMP NEXT_ELEM
  NEXT_ELEM:
            LDA END_VETOR
            ADD #2
            STA END_VETOR

            LDA CONT
            ADD #1
            STA CONT

            LDA TAM_VETOR
            SUB CONT
            JZ FIM

            LDA   END_VETOR+1
            PUSH
            LDA   END_VETOR
            PUSH
            LDA   #3       
            JSR SINAL
  FIM: HLT
