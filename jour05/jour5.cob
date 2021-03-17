000001 IDENTIFICATION DIVISION.
000002  PROGRAM-ID. jour-cinq.
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
000021     77 NB-NICE-PREM PIC 9(4) VALUE 0.
000022     77 NB-NICE-DEUX PIC 9(4) VALUE 0.
000023
000024 PROCEDURE DIVISION.
000025 main.
000026     OPEN INPUT FILE1.
000027     PERFORM UNTIL EOF
000028        READ FILE1 RECORD INTO MY-FILE
000029* Lorsqu’on arrive à la fin du fichier, on met Y pour le signaler
000030        AT END MOVE 'Y' TO FILE-STATUS
000031        NOT AT END CALL "hub" USING
000032                BY CONTENT MY-STR,
000033                BY REFERENCE NB-NICE-PREM
000034                BY REFERENCE NB-NICE-DEUX
000035* On passe par référence NB-NICE pour les incrémenter
000036                END-CALL
000037        END-READ
000038     END-PERFORM.
000039     DISPLAY "Nombres de bonnes chaines :" END-DISPLAY.
000040     DISPLAY "Dans la partie 1 : " NB-NICE-PREM END-DISPLAY.
000041     DISPLAY "Dans la partie 2 : " NB-NICE-DEUX END-DISPLAY.
000042     CLOSE FILE1.
000043     STOP RUN.
000044
000045*****************************************************************
000046* hub : exécute les 2 fonctions pour les 2 parties
000047* STR : la chaine à passer en paramètre aux deux fonctions
000048* NB-PREM : (REFERENCE) nombre bonnes chaines partie 1
000049* NB-DEUX : (REFERENCE) nombre bonnes chaines partie 2
000050* Ces 2 variables seront incrémentées
000051*****************************************************************
000052
000053 IDENTIFICATION DIVISION.
000054   PROGRAM-ID. hub.
000055
000056 DATA DIVISION.
000057   LINKAGE SECTION.
000058     77 STR PIC A(17).
000059     77 NB-PREM PIC 9(4).
000060     77 NB-DEUX PIC 9(4).
000061
000062 PROCEDURE DIVISION USING STR, NB-PREM, NB-DEUX.
000063 route.
000064     CALL "parse-prem" USING
000065     BY CONTENT STR,
000066     BY REFERENCE NB-PREM
000067     END-CALL.
000068
000069     CALL "parse-deux" USING
000070     BY CONTENT STR,
000071     BY REFERENCE NB-DEUX
000072     END-CALL.
000073 EXIT PROGRAM.
000074
000075******************************************************************
000076* parse-prem : parse la chaine de caractères pour voir le nombre de
000077* bonnes chaines pour la partie 1. Prend en paramètres 2 arguments :
000078* STR : chaine de caractères de taille 17 à analyser.
000079* NB  : (REFERENCE) le nombre de bonnes chaines. Sera incrémenter.
000080*****************************************************************
000081
000082 IDENTIFICATION DIVISION.
000083 PROGRAM-ID. parse-prem.
000084
000085 DATA DIVISION.
000086   WORKING-STORAGE SECTION.
000087     77 CHAR PIC A.
000088         88 VOY VALUE 'a','e','i','o','u'.
000089     77 I PIC 99.
000090         88 END-P VALUE 17.
000091     77 NB-VOY PIC 99.
000092     77 PRED PIC A.
000093     77 TMP PIC AA.
000094         88 BAD VALUE 'ab', 'cd', 'pq', 'xy'.
000095     77 DOUBLE PIC X.
000096
000097*****************************************************************
000098* NB-VOY contient le nombre de voyelles
000099* PRED le caractère précédent
000100* TMP forme la chaine contenant le caractère précédent et courant
000101* BAD les mauvaises formes de chaines
000102* DOUBLE est mit à Y lorsque CHAR = PRED
000103*
000104* LINKAGE SECTION contient les paramètres du programme parse-str
000105*****************************************************************
000106
000107   LINKAGE SECTION.
000108     77 STR PIC A(17).
000109     77 NB PIC 9(4).
000110
000111 PROCEDURE DIVISION USING STR, NB.
000112 parse.
000113     MOVE 0 TO NB-VOY.
000114     MOVE 'N' TO DOUBLE.
000115     PERFORM VARYING I FROM 1 BY 1 UNTIL END-P
000116         MOVE STR(I:1) TO CHAR
000117         IF VOY THEN
000118             ADD 1 TO NB-VOY END-ADD
000119         END-IF
000120         IF I >= 2
000121             THEN
000122                 STRING PRED CHAR INTO TMP END-STRING
000123                 IF BAD THEN
000124                     EXIT PERFORM
000125                 END-IF
000126                 IF PRED = CHAR THEN
000127                     MOVE 'Y' TO DOUBLE
000128                 END-IF
000129         END-IF
000130         MOVE CHAR TO PRED
000131     END-PERFORM.
000132     IF NOT BAD AND NB-VOY >= 3 AND DOUBLE = 'Y' THEN
000133         ADD 1 TO NB END-ADD
000134     END-IF.
000135     EXIT PROGRAM.
000136 END PROGRAM parse-prem.
000137
000138******************************************************************
000139* parse-deux : parse la chaine de caractères pour voir le nombre de
000140* bonnes chaines pour la partie 2. Prend en paramètres 2 arguments :
000141* STR : chaine de caractères de taille 17 à analyser.
000142* NB  : (REFERENCE) le nombre de bonnes chaines. Sera incrémenter.
000143*****************************************************************
000144
000145 IDENTIFICATION DIVISION.
000146   PROGRAM-ID. parse-deux.
000147
000148 DATA DIVISION.
000149   WORKING-STORAGE SECTION.
000150     77 CHAR PIC A.
000151     77 I PIC 99.
000152         88 STR-LENGTH VALUE 17.
000153     77 J PIC 99.
000154     77 K PIC 99.
000155         88 DOUBLE-STR-LENGTH VALUE 16.
000156     77 PRED PIC A.
000157     77 MYNEW PIC A.
000158     77 DOUBLE-CHAR PIC AA.
000159     77 DOUBLE-CHAR-NEXT PIC AA.
000160     77 BETWEEN PIC X.
000161     77 DOUBLE PIC X.
000162
000163******************************************************************
000164* PRED le caractère précédent
000165* MYNEW le caractère suivant
000166* DOUBLE-CHAR la paire à vérifier
000167* DOUBLE-CHAR-NEXT les paires suivantes
000168* DOUBLE est mit à Y lorsque 2 pairs sont trouvées
000169* BETWEEN est mit à Y lorsque 2 memes lettres en encadrent une
000170******************************************************************
000171
000172   LINKAGE SECTION.
000173     77 STR PIC A(17).
000174     77 NB PIC 9(4).
000175
000176 PROCEDURE DIVISION USING STR, NB.
000177 deuxieme-part.
000178     MOVE 'N' TO BETWEEN.
000179     MOVE 'N' TO DOUBLE.
000180     PERFORM VARYING I FROM 1 BY 1 UNTIL STR-LENGTH
000181         COMPUTE J = I + 1 END-COMPUTE
000182         MOVE STR(I:1) TO CHAR
000183         IF I > 1 AND I < (LENGTH OF STR - 1) THEN
000184             MOVE STR(J:1) TO MYNEW
000185             IF PRED = MYNEW THEN
000186                 MOVE 'Y' TO BETWEEN
000187             END-IF
000188         END-IF
000189
000190         IF I < ((LENGTH OF STR) - 2) AND DOUBLE = 'N' THEN
000191             MOVE STR(I:2) TO DOUBLE-CHAR
000192             ADD 1 TO J END-ADD
000193             PERFORM VARYING K FROM J BY 1 UNTIL DOUBLE-STR-LENGTH
000194                 MOVE STR(K:2) TO DOUBLE-CHAR-NEXT
000195                 IF DOUBLE-CHAR = DOUBLE-CHAR-NEXT THEN
000196                     MOVE 'Y' TO DOUBLE
000197                 END-IF
000198             END-PERFORM
000199         END-IF
000200         MOVE CHAR TO PRED
000201     END-PERFORM.
000202
000203     IF BETWEEN  = 'Y' AND DOUBLE = 'Y'
000204         THEN
000205             ADD 1 TO NB END-ADD
000206     END-IF.
000207     EXIT PROGRAM.
000208 END PROGRAM parse-deux.
000209
000210 END PROGRAM hub.
000211 END PROGRAM jour-cinq.
