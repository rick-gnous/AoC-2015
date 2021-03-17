       IDENTIFICATION DIVISION.
        PROGRAM-ID. jour-cinq-prem-part.
      
       ENVIRONMENT DIVISION.
          INPUT-OUTPUT SECTION.
          FILE-CONTROL.
               SELECT FILE1 ASSIGN TO "input"
               ORGANIZATION LINE SEQUENTIAL.
      
       DATA DIVISION.
         FILE SECTION.
         FD FILE1.
           01 INPUT-FILE.
             02 STR PIC A(17).
      
         WORKING-STORAGE SECTION.
           01 MY-FILE.
             02 MY-STR PIC A(17).
           01 FILE-STATUS PIC X VALUE 'N'.
             88 EOF VALUE 'Y'.
           77 NB-NICE PIC 9(4) VALUE 0.
      
       PROCEDURE DIVISION.
       main.
           OPEN INPUT FILE1.
           PERFORM UNTIL EOF
              READ FILE1 RECORD INTO MY-FILE
      * Lorsqu’on arrive à la fin du fichier, on met Y pour le signaler
              AT END MOVE 'Y' TO FILE-STATUS
              NOT AT END CALL "parse-str" USING
                      BY CONTENT MY-STR,
                      BY REFERENCE NB-NICE
      * On passe par référence NB-NICE pour l’incrémenter
                      END-CALL
              END-READ
           END-PERFORM.
           DISPLAY "Nombre de bonnes chaines : " NB-NICE END-DISPLAY.
           CLOSE FILE1.
           STOP RUN.
      
      ******************************************************************
      * parse-str : parse la chaine de caractères pour voir le nombre de
      * bonnes chaines. Prend en paramètres 2 arguments :
      * STR : chaine de caractères de taille 16. Sera parser.
      * NB  : (REFERENCE) le nombre de bonnes chaines. Sera incrémenter.
      *****************************************************************
      
       IDENTIFICATION DIVISION.
         PROGRAM-ID. parse-str.
      
       DATA DIVISION.
         WORKING-STORAGE SECTION.
           77 CHAR PIC A.
               88 VOY VALUE 'a','e','i','o','u'.
           77 I PIC 99.
               88 END-P VALUE 17.
           77 J PIC 99.
           77 K PIC 99.
               88 END-I VALUE 17.
           77 PRED PIC A.
           77 MYNEW PIC A.
           77 TMP PIC AA.
           77 TMP-NEXT PIC AA.
           77 BETWEEN PIC X.
           77 DOUBLE PIC X.
           77 DOUBLE-CHAR PIC AA.
           77 DOUBLE-CHAR-NEXT PIC AA.
      
      ******************************************************************
      * NB-VOY contient le nombre de voyelles
      * PRED le caractère précédent
      * TMP forme la chaine contenant le caractère précédent et courant
      * BAD les mauvaises formes de chaines
      * DOUBLE est mit à Y lorsque CHAR = PRED
      *
      * LINKAGE SECTION contient les paramètres du programme parse-str
      ******************************************************************
      
         LINKAGE SECTION.
           77 STR PIC A(17).
           77 NB PIC 9(4).
      
       PROCEDURE DIVISION USING STR, NB.
       premiere-part.
           MOVE 'N' TO BETWEEN.
           MOVE 'N' TO DOUBLE.
      d    DISPLAY STR.
      d    DISPLAY "=================".
           PERFORM VARYING I FROM 1 BY 1 UNTIL END-P
               COMPUTE J = I + 1 END-COMPUTE
               MOVE STR(I:1) TO CHAR
               IF I > 1 AND I < (LENGTH OF STR - 1) THEN
                   MOVE STR(J:1) TO MYNEW
                   IF PRED = MYNEW THEN
                       MOVE 'Y' TO BETWEEN
                   END-IF
               END-IF

               IF I < ((LENGTH OF STR) - 2) AND DOUBLE = 'N' THEN
                   MOVE STR(I:2) TO DOUBLE-CHAR
                   ADD 1 TO J END-ADD
                   PERFORM VARYING K FROM J BY 1 UNTIL END-I
                       MOVE STR(K:2) TO DOUBLE-CHAR-NEXT
                       IF DOUBLE-CHAR = DOUBLE-CHAR-NEXT THEN
                           MOVE 'Y' TO DOUBLE
                       END-IF
                   END-PERFORM
               END-IF

      d        DISPLAY "ACT. CHAR : " CHAR
      d        DISPLAY "ACT. PRED : " PRED
      d        DISPLAY "I : " I
               MOVE CHAR TO PRED
           END-PERFORM.

           IF BETWEEN  = 'Y' AND DOUBLE = 'Y'
               THEN
                   ADD 1 TO NB END-ADD
           END-IF.
           EXIT PROGRAM.

        END PROGRAM parse-str.
      
      *************************************************************************
      
       END PROGRAM jour-cinq-prem-part.
