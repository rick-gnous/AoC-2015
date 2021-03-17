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
           77 NB-NICE-PREM PIC 9(4) VALUE 0.
           77 NB-NICE-DEUX PIC 9(4) VALUE 0.
      
       PROCEDURE DIVISION.
       main.
           OPEN INPUT FILE1.
           PERFORM UNTIL EOF
              READ FILE1 RECORD INTO MY-FILE
      * Lorsqu’on arrive à la fin du fichier, on met Y pour le signaler
              AT END MOVE 'Y' TO FILE-STATUS
              NOT AT END CALL "hub" USING
                      BY CONTENT MY-STR,
                      BY REFERENCE NB-NICE-PREM
                      BY REFERENCE NB-NICE-DEUX
      * On passe par référence NB-NICE pour les incrémenter
                      END-CALL
              END-READ
           END-PERFORM.
           DISPLAY "Nombres de bonnes chaines :" END-DISPLAY.
           DISPLAY "Dans la partie 1 : " NB-NICE-PREM END-DISPLAY.
           DISPLAY "Dans la partie 2 : " NB-NICE-DEUX END-DISPLAY.
           CLOSE FILE1.
           STOP RUN.
      
      *****************************************************************
      * hub : exécute les 2 fonctions pour les 2 parties
      * STR : la chaine à passer en paramètre aux deux fonctions
      * NB-PREM : (REFERENCE) nombre bonnes chaines partie 1
      * NB-DEUX : (REFERENCE) nombre bonnes chaines partie 2
      * Ces 2 variables seront incrémentées
      *****************************************************************
      
       IDENTIFICATION DIVISION.
         PROGRAM-ID. hub.
         
       DATA DIVISION.
         LINKAGE SECTION.
           77 STR PIC A(17).
           77 NB-PREM PIC 9(4).
           77 NB-DEUX PIC 9(4).

       PROCEDURE DIVISION USING STR, NB-PREM, NB-DEUX.
       route.
           CALL "parse-prem" USING
           BY CONTENT STR,
           BY REFERENCE NB-PREM
           END-CALL.

           CALL "parse-deux" USING
           BY CONTENT STR,
           BY REFERENCE NB-DEUX
           END-CALL.
       EXIT PROGRAM.

      ******************************************************************
      * parse-prem : parse la chaine de caractères pour voir le nombre de
      * bonnes chaines pour la partie 1. Prend en paramètres 2 arguments :
      * STR : chaine de caractères de taille 17 à analyser.
      * NB  : (REFERENCE) le nombre de bonnes chaines. Sera incrémenter.
      *****************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. parse-prem.
    
       DATA DIVISION.
         WORKING-STORAGE SECTION.
           77 CHAR PIC A.
               88 VOY VALUE 'a','e','i','o','u'.
           77 I PIC 99.
               88 END-P VALUE 17.
           77 NB-VOY PIC 99.
           77 PRED PIC A.
           77 TMP PIC AA.
               88 BAD VALUE 'ab', 'cd', 'pq', 'xy'.
           77 DOUBLE PIC X.

      *****************************************************************
      * NB-VOY contient le nombre de voyelles
      * PRED le caractère précédent
      * TMP forme la chaine contenant le caractère précédent et courant
      * BAD les mauvaises formes de chaines
      * DOUBLE est mit à Y lorsque CHAR = PRED
      *
      * LINKAGE SECTION contient les paramètres du programme parse-str
      *****************************************************************
      
         LINKAGE SECTION.
           77 STR PIC A(17).
           77 NB PIC 9(4).
      
       PROCEDURE DIVISION USING STR, NB.
       parse.
           MOVE 0 TO NB-VOY.
           MOVE 'N' TO DOUBLE.
           PERFORM VARYING I FROM 1 BY 1 UNTIL END-P
               MOVE STR(I:1) TO CHAR
               IF VOY THEN
                   ADD 1 TO NB-VOY END-ADD
               END-IF
               IF I >= 2
                   THEN
                       STRING PRED CHAR INTO TMP END-STRING
                       IF BAD THEN
                           EXIT PERFORM
                       END-IF
                       IF PRED = CHAR THEN
                           MOVE 'Y' TO DOUBLE
                       END-IF
               END-IF
               MOVE CHAR TO PRED
           END-PERFORM.
           IF NOT BAD AND NB-VOY >= 3 AND DOUBLE = 'Y' THEN
               ADD 1 TO NB END-ADD
           END-IF.
           EXIT PROGRAM.
       END PROGRAM parse-prem.

      ******************************************************************
      * parse-deux : parse la chaine de caractères pour voir le nombre de
      * bonnes chaines pour la partie 2. Prend en paramètres 2 arguments :
      * STR : chaine de caractères de taille 17 à analyser.
      * NB  : (REFERENCE) le nombre de bonnes chaines. Sera incrémenter.
      *****************************************************************

       IDENTIFICATION DIVISION.
         PROGRAM-ID. parse-deux.
      
       DATA DIVISION.
         WORKING-STORAGE SECTION.
           77 CHAR PIC A.
           77 I PIC 99.
               88 STR-LENGTH VALUE 17.
           77 J PIC 99.
           77 K PIC 99.
               88 DOUBLE-STR-LENGTH VALUE 16.
           77 PRED PIC A.
           77 MYNEW PIC A.
           77 DOUBLE-CHAR PIC AA.
           77 DOUBLE-CHAR-NEXT PIC AA.
           77 BETWEEN PIC X.
           77 DOUBLE PIC X.
      
      ******************************************************************
      * PRED le caractère précédent
      * MYNEW le caractère suivant
      * DOUBLE-CHAR la paire à vérifier
      * DOUBLE-CHAR-NEXT les paires suivantes
      * DOUBLE est mit à Y lorsque 2 pairs sont trouvées
      * BETWEEN est mit à Y lorsque 2 memes lettres en encadrent une
      ******************************************************************
      
         LINKAGE SECTION.
           77 STR PIC A(17).
           77 NB PIC 9(4).
      
       PROCEDURE DIVISION USING STR, NB.
       deuxieme-part.
           MOVE 'N' TO BETWEEN.
           MOVE 'N' TO DOUBLE.
           PERFORM VARYING I FROM 1 BY 1 UNTIL STR-LENGTH
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
                   PERFORM VARYING K FROM J BY 1 UNTIL DOUBLE-STR-LENGTH
                       MOVE STR(K:2) TO DOUBLE-CHAR-NEXT
                       IF DOUBLE-CHAR = DOUBLE-CHAR-NEXT THEN
                           MOVE 'Y' TO DOUBLE
                       END-IF
                   END-PERFORM
               END-IF
               MOVE CHAR TO PRED
           END-PERFORM.

           IF BETWEEN  = 'Y' AND DOUBLE = 'Y'
               THEN
                   ADD 1 TO NB END-ADD
           END-IF.
           EXIT PROGRAM.
       END PROGRAM parse-deux.

       END PROGRAM hub.
       END PROGRAM jour-cinq-prem-part.
