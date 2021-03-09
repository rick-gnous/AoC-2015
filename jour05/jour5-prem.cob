000001 IDENTIFICATION DIVISION.
000002  PROGRAM-ID. jour-cinq-prem-part.
000003
000004 ENVIRONMENT DIVISION.
000005    INPUT-OUTPUT SECTION.
000006    FILE-CONTROL.
000007         SELECT FILE1 ASSIGN TO "input"
000008         ORGANIZATION LINE SEQUENTIAL.
000009
000010 DATA DIVISION.
000011   FILE SECTION.
000012   FD FILE1.
000013     01 INPUT-FILE.
000014       02 STR PIC A(17).
000015
000016   WORKING-STORAGE SECTION.
000017     01 MY-FILE.
000018       02 MY-STR PIC A(17).
000019     01 FILE-STATUS PIC X VALUE 'N'.
000020       88 EOF VALUE 'Y'.
000021     77 NB-NICE PIC 9(4) VALUE 0.
000022
000023 PROCEDURE DIVISION.
000024 main.
000025     OPEN INPUT FILE1.
000026     PERFORM UNTIL EOF
000027        READ FILE1 RECORD INTO MY-FILE
000028* Lorsqu’on arrive à la fin du fichier, on met Y pour le signaler
000029        AT END MOVE 'Y' TO FILE-STATUS
000030        NOT AT END CALL "parse-str" USING
000031                BY CONTENT MY-STR,
000032                BY REFERENCE NB-NICE
000033* On passe par référence NB-NICE pour l’incrémenter
000034                END-CALL
000035        END-READ
000036     END-PERFORM.
000037     DISPLAY "Nombre de bonnes chaines : " NB-NICE END-DISPLAY.
000038     CLOSE FILE1.
000039     STOP RUN.
000039
000040******************************************************************
000041* parse-str : parse la chaine de caractères pour voir le nombre de
000042* bonnes chaines. Prend en paramètres 2 arguments :
000043* STR : chaine de caractères de taille 16. Sera parser.
000044* NB  : (REFERENCE) le nombre de bonnes chaines. Sera incrémenter.
000045
000046 IDENTIFICATION DIVISION.
000047   PROGRAM-ID. parse-str.
000047
000048 DATA DIVISION.
000049   WORKING-STORAGE SECTION.
000050     77 CHAR PIC A.
000051         88 VOY VALUE 'a','e','i','o','u'.
000052     77 I PIC 99.
000053         88 END-P VALUE 17.
000054     77 NB-VOY PIC 99.
000055     77 PRED PIC A.
000056     77 TMP PIC AA.
000057         88 BAD VALUE 'ab', 'cd', 'pq', 'xy'.
000058     77 DOUBLE PIC X.
000058
000059* NB-VOY contient le nombre de voyelles
000060* PRED le caractère précédent
000061* TMP forme la chaine contenant le caractère précédent et courant
000062* BAD les mauvaises formes de chaines
000063* DOUBLE est mit à Y lorsque CHAR = PRED
000064*
000065* LINKAGE SECTION contient les paramètres du programme parse-str
000066
000067   LINKAGE SECTION.
000068     77 STR PIC A(17).
000069     77 NB PIC 9(4).
000069
000070 PROCEDURE DIVISION USING STR, NB.
000071 parse.
000072     MOVE 0 TO NB-VOY.
000073     MOVE 'N' TO DOUBLE.
000074d    DISPLAY STR.
000075d    DISPLAY "=================".
000076     PERFORM VARYING I FROM 1 BY 1 UNTIL END-P
000077         MOVE STR(I:1) TO CHAR
000078d        DISPLAY "ACT. CHAR : " CHAR
000079d        DISPLAY "ACT. PRED : " PRED
000080d        DISPLAY "I : " I
000081         IF VOY
000082             THEN ADD 1 TO NB-VOY END-ADD
000083         END-IF
000084         IF I >= 2
000085             THEN
000086                 STRING PRED CHAR INTO TMP END-STRING
000087d                DISPLAY "TMP STR : " TMP
000088                 IF BAD
000089                     THEN
000090                         EXIT PERFORM
000091                 END-IF
000092                 IF PRED = CHAR
000093                     THEN
000094                         MOVE 'Y' TO DOUBLE
000095                 END-IF
000096d                DISPLAY "DOUBLE : " DOUBLE
000097         END-IF
000098         MOVE CHAR TO PRED
000099     END-PERFORM.
000100     IF NOT BAD AND NB-VOY >= 3 AND DOUBLE = 'Y'
000101         THEN
000102             ADD 1 TO NB END-ADD
000103     END-IF.
000104     EXIT PROGRAM.
000105 END PROGRAM parse-str.
000105
000106*************************************************************************
000107
000108 END PROGRAM jour-cinq-prem-part.
