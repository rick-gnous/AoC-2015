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
             02 STR PIC A(17).
           01 WS-STATUS PIC X VALUE 'N'.
             88 EOF VALUE 'Y'.
      
       PROCEDURE DIVISION.
         main.
           OPEN INPUT FILE1.
           PERFORM UNTIL EOF
              READ FILE1 RECORD INTO MY-FILE
              AT END MOVE 'Y' TO WS-STATUS
              NOT AT END DISPLAY MY-FILE
              END-READ
           END-PERFORM.
           CLOSE FILE1.
           STOP RUN.
      
       END PROGRAM jour-cinq-prem-part.
       
      *deuxième étape, lire car par car
      *troisième étape, check si voyelle
      *retenir lettre act et pred pour check mot interdit
      *retenir lettre jusqu’à double
