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
              AT END MOVE 'Y' TO FILE-STATUS
              NOT AT END CALL "parse-str" USING 
                      BY CONTENT MY-STR,
                      BY REFERENCE NB-NICE
                      END-CALL
              END-READ
           END-PERFORM.
           DISPLAY "Nombre de bonnes chaines : " NB-NICE.
           CLOSE FILE1.
           STOP RUN.
      
       END PROGRAM jour-cinq-prem-part.

      ******************************************************************
      
       IDENTIFICATION DIVISION.
         PROGRAM-ID. parse-str.

       DATA DIVISION.
         WORKING-STORAGE SECTION.
           77 CHAR PIC A.
               88 VOY VALUE 'a','e','i','o','u','y'.
           77 I PIC 99.
               88 END-P VALUE 17.
           77 NB-VOY PIC 99.
           77 PRED PIC A.
           77 TMP PIC AA.
               88 BAD VALUE 'ab', 'cd', 'pq', 'xy'.
           77 DOUBLE PIC X.
                   
         LINKAGE SECTION.
           77 STR PIC A(17).
           77 NB PIC 9(4).

       PROCEDURE DIVISION USING STR, NB.
       parse.
           MOVE 0 TO NB-VOY.
           MOVE 'N' TO DOUBLE.
      d    DISPLAY STR.
      d    DISPLAY "=================".
           PERFORM VARYING I FROM 1 BY 1 UNTIL END-P
               MOVE STR(I:1) TO CHAR
      d        DISPLAY "ACT. CHAR : " CHAR
      d        DISPLAY "ACT. PRED : " PRED
      d        DISPLAY "I : " I
               IF VOY
                   THEN ADD 1 TO NB-VOY
               END-IF
               IF I >= 2
                   THEN
                       STRING PRED CHAR INTO TMP
      d                DISPLAY "TMP STR : " TMP
                       IF BAD
                           THEN 
                               EXIT PERFORM
                       END-IF
                       IF PRED = CHAR
                           THEN 
                               MOVE 'Y' TO DOUBLE
                       END-IF
      d                DISPLAY "DOUBLE : " DOUBLE
               END-IF
               MOVE CHAR TO PRED
           END-PERFORM.
           IF NOT BAD AND NB-VOY >= 3 AND DOUBLE = 'Y'
               THEN
                   ADD 1 TO NB
           END-IF.

       END PROGRAM parse-str.
