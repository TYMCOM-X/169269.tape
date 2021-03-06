0001�	TITLE ERRCHK - PRINT ERROR INFORMATION GATHERED BY CHKPNT
0002�	T1=1
   0003�	T2=2
   0004�	T3=3
   0005�	T4=4
   0006�	T5=5
   0007�	T6=6
   0008�	T7=7
   0009�	
  0010�	P=17
   0011�	PTR=16
 0012�	C=15
   0013�	TYP=14          ;TYPE OF DEVICE FOR ERROR PRINTING IN LONG MODE
    0014�	FL=0
   0015�	
  0016�	FIL==1
 0017�	LPT==2
 0018�	TMP==3
 0019�	
  0020�	OPDEF RET [POPJ P,]
   0021�	
  0022�	OPDEF OCHI [3B8]
 0023�	OPDEF OCHR [1B8]
 0024�	OPDEF OSTR [2B8]
 0025�	
  0026�	        LOC 41
   0027�	        JSR UUO0
 0028�	        RELOC
    0029�	
  0030�	JOBVER==137
                               0031�	        INTERNAL JOBVER
    0032�	        LOC JOBVER
    0033�	        9
   0034�	        RELOC
    0035�	        
    0036�	ARRAY BUF[200],PDL[40],DCNV,OBUF[3]
  0037�	
  0038�	COM:    IOWD 200,BUF
  0039�	        0
   0040�	
  0041�	EXTERNAL JOBFF,JOBREL
 0042�	
  0043�	JBTLIC==-20
 0044�	LICSYS==(1B3)
    0045�	RECDAT==0       ;RELATIVE LOCATION OF DATE (LH) AND TIME (RH) IN RECORD
 0046�	RECDEF==1       ;TYPE IN RH IF -1 IN LH OTHERWISE NOT ERROR TYPE
   0047�	
  0048�	FLGDSK==400000  ;THE OUTPUT IS TO A DSK FILE
   0049�	FLGOPN==200000  ;THE OUTPUT FILE IS OPEN
                                          0050�	FLGDAT==100000  ;DATE HAS BEEN OUTPUT
0051�	
  0052�	DEB==0  ;DEBUG FLAG
       �  0001�	STPT:   RESET
    0002�	        MOVEI FL,0
    0003�	        MOVE P,[IOWD 40,PDL]
    0004�	IFE DEB,<       HRROI T1,JBTLIC
 0005�	        GETTAB T1,
    0006�	         MOVEI T1,0
   0007�	        TRNE T1,LICSYS  ;DOES HE HAVE SYSTAT LIC?
   0008�	        JRST LICOK      ;YES
    0009�	        HRLS T1
  0010�	        SETLIC T1,      ;NO, SET JOB LIC AS  PROCESS LIC>
0011�	LICOK:  INIT FIL,16
   0012�	IFE DEB,<       SIXBIT /SYS/>
   0013�	IFN DEB,<       SIXBIT /DSK/>
   0014�	        0
                                 0015�	        JRST NODSK
    0016�	        MOVEI T1,^D10
 0017�	        MOVEM T1,RADIX# ;SET READ RADIX
   0018�	        SETZM STRTIM#
 0019�	        MOVEI T1,^D<24*60*60>   ;MIDNIGHT
 0020�	        MOVEM T1,STPTIM#
   0021�		SETZM NOADV#	;NO CHKPNT RECORD ALREADY READ.
  0022�	        SETZM ELMERR#   ;NO ERRORS TO SUPRESS
  0023�	        SETZM CNTERR#   ;CONTINUOUS ERROR MODE
 0024�	        SETZM SHTFRM#   ;NOT IN SHORT FORM (EXPANDED)
    0025�	        SETZM ELMLST#   ;NO UNITS TO SUPRESS
   0026�	        SETZM HRDFLG#   ;HARD AND SOFT ERRORS
  0027�	        SETOM ONLERR#   ;NO ERROR SELECTION
                        0028�	        SETZM ONLNAM#   ;NO SPECIAL UNIT SELECTION
  0029�	        SETZM FRECOR#
 0030�	        SETZM UNILST#
 0031�	        SETZM SKPERR#   ;SKIP ALL ERRORS (ENVIRON ONLY)
  0032�	        SETZM USESNS#   ;INCLUDE SENSE BYTES
   0033�	        SETZM USEENV#   ;INCLUDE ENVIRONMENTAL DATA
 0034�	CMDLP:  OUTSTR [ASCIZ /
    0035�	*/]
    0036�	        SETZM SAVCHR#
 0037�	        PUSHJ P,SCAN
  0038�	        TRNN FL,IDENT
 0039�	        JRST TRMLOK
   0040�	        MOVE T4,[-CMDLEN,,CMDTAB]
    0041�	        PUSHJ P,CMDSRC
0042�	         JRST TYPHLP
  0043�	        XCT CMDDSP(T3)  ;FOUND COMMAND
                   0044�	CMDDON: PUSHJ P,WTLF
  0045�	        JRST CMDLP
    0046�	
  0047�	WTLF:   CAIN C,12
0048�	        POPJ P,
  0049�	        INCHWL C
 0050�	        JRST WTLF
0051�	
  0052�	TRMLOK: TRNE FL,TERMF
 0053�	        JRST CMDDON
   0054�	TYPHLP: PUSHJ P,WTLF
  0055�	        OUTSTR [ASCIZ /TYPE HELP FOR HELP/]
    0056�	        JRST CMDLP
    0057�	
  0058�	NODSK:  OUTSTR [ASCIZ /
    0059�	CAN NOT INIT SYS/]
    0060�	        EXIT
    �  0001�	NUMF==1
0002�	TERMF==2
    0003�	IDENT==4
    0004�	
  0005�	SCAN:   TRZ FL,NUMF!TERMF!IDENT
 0006�	        SKIPN C,SAVCHR
0007�	SKPSP:  INCHWL C
                     0008�	        CAIN C," "
    0009�	        JRST SKPSP
    0010�	        CAIG C,"9"
    0011�	        CAIGE C,"0"
   0012�	        JRST IDNCHK
   0013�	        MOVEI T1,0
    0014�	NUMIN:  IMUL T1,RADIX
 0015�	        ADDI T1,-"0"(C)
    0016�	        INCHWL C
 0017�	        CAIG C,"9"
    0018�	        CAIGE C,"0"
   0019�	        SKIPA
    0020�	        JRST NUMIN
    0021�	        MOVEM C,SAVCHR
0022�	        TRO FL,NUMF
   0023�	        POPJ P,
  0024�	
  0025�	IDNCHK: CAIL C,140
    0026�	        SUBI C,40
0027�	        CAIG C,"Z"
    0028�	        CAIGE C,"A"
   0029�	        JRST TRMCHK
                  0030�	        MOVE T1,[POINT 6,ACCUM]
 0031�	        SETZM ACCUM#
  0032�	LETIN:  SUBI C,40
0033�	        TLNE T1,770000
0034�	        IDPB C,T1
0035�	        INCHWL C
 0036�	        CAIG C,"Z"
    0037�	        CAIGE C,"A"
   0038�	        SKIPA
    0039�	        JRST LETIN
    0040�	        CAIG C,"9"
    0041�	        CAIGE C,"0"
   0042�	        SKIPA
    0043�	        JRST LETIN
    0044�	        MOVEM C,SAVCHR
0045�	        TRO FL,IDENT
  0046�	        POPJ P,
  0047�	
  0048�	TRMCHK: CAIN C,15
0049�	        TRO FL,TERMF
  0050�	        SETZM SAVCHR
  0051�	        POPJ P,
      �                      0001�	CMDSRC: MOVE T1,ACCUM
 0002�	        PUSHJ P,MAKMSK
0003�	MSKDON: HLLZ T3,T4
    0004�	        HRLI T4,T3
    0005�	        MOVEM T4,SRCPTR#
   0006�	        MOVEI T4,0
    0007�	CMDSR0: CAMN T1,@SRCPTR
    0008�	        JRST CPOPJ1
   0009�	        MOVE T5,@SRCPTR
    0010�	        AND T5,T2
0011�	                CAME T1,T5
 0012�	        JRST CMDSR1
   0013�	        JUMPN T4,CPOPJ
0014�	        MOVE T4,T3
    0015�	CMDSR1: AOBJN T3,CMDSR0
    0016�	        JUMPE T4,CPOPJ
0017�	        MOVE T3,T4
    0018�	CPOPJ1: AOS (P)
  0019�	CPOPJ:  POPJ P,
      �  0001�	        DEFINE CMDS
                       0002�	<       X QUIT,<JRST DOEXIT>
    0003�	        X DATE,<PUSHJ P,SRTTST>
 0004�	        X HELP,<PUSHJ P,DOHLP>
  0005�	        X ERROR,<PUSHJ P,SETERR>
0006�	        X START,<PUSHJ P,SETSTR>
0007�	        X STOP,<PUSHJ P,SETSTP>
 0008�	        X CONTIG,<SETOM CNTERR>
 0009�	        X ONEDAY,<SETZM CNTERR>
 0010�	        X SORT,<SETOM SRTFLG>
   0011�	        X UNSORT,<SETZM SRTFLG>
 0012�	>
 0013�	
  0014�	        DEFINE X (A,B)
0015�	<       <SIXBIT /A/>>
 0016�	
  0017�	CMDTAB: CMDS
0018�	CMDLEN==.-CMDTAB
 0019�	
  0020�	        DEFINE X(A,B)
 0021�	<       B>
  0022�	
  0023�	CMDDSP: CMDS
0024�	
       0025�	DOEXIT: PUSHJ P,WTLF
  0026�	        EXIT
0027�	
  0028�	DOHLP:  PUSHJ P,WTLF
  0029�	        OUTSTR HLPMS
  0030�	        POPJ P,
  0031�	
  0032�	HLPMS:  ASCIZ /
  0033�	COMMANDS ARE:
    0034�	
  0035�	QUIT    QUIT
0036�	ERROR   SET ERROR CONDITIONS DESIRED
 0037�	   ERROR        ALL
   0038�	   ERROR DPA3   ONLY DPA3
  0039�	   ERROR -DPA3  EXCLUDE DPA3
    0040�	   ERROR DP     ONLY DISK PACKS
 0041�	   ERROR DPA    ONLY PACKS ON CONTROLLER A
0042�	   ERROR 4000   ONLY ERRORS WITH CONI BIT 4000
 0043�	   ERROR -4000  EXCLUDE ERRORS WITH CONI BIT 4000
   0044�	   ERROR HARD   ONLY HARD ERRORS
          0045�	   ERROR -HARD  INCLUDE BOTH HARD AND SOFT ERRORS
   0046�	   ERROR SHORT  ERRORS IN SHORT FORM (ACTUAL BITS)
  0047�	   ERROR -SHORT ERRORS IN LONG FORM (NAMES OF BITS)
 0048�	   ERROR SENSE  INCLUDE SENSE DATA IN ERROR PRINTOUT
0049�	   ERROR -SENSE EXCLUDE SENSE DATA
   0050�	   ERROR ENVIRO INCLUDE ENVIRONMENTAL DATA IN PRINTOUT
   0051�	   ERROR -ENVIRO EXCLUDE ENVIRONMENTAL DATA
    0052�	   ERROR ALL    SAME AS JUST ERROR
   0053�	   ERROR -ALL   SUPPRESS ALL ERRORS (JUST SENSE AND ENVIRO IF ON)
  0054�	
  0055�	   MORE THAN ONE ERROR COMMAND MAY BE INCLUDED ON A SINGLE LINE
                                  0056�	   AS ERROR SENSE ENVIRO -FT -FH
0057�	DATE    SET DATE AND PRINT DATA
 0058�	START   SET STARTING TIME
  0059�	STOP    SET ENDING TIME
    0060�	CONTIG  START AND THE DATE AND TIME SPECIFIED AND REPEAT ERROR
0061�	        REPORTING FOR EACH DATE THROUGH TODAY
  0062�	ONEDAY  TURN OFF CONTIG MODE
    0063�	SORT    SORT ERRORS BY DEVICE
   0064�	UNSORT  SORT ERRORS BY TIME
0065�	/
     �  0001�	SETSTR: PUSHJ P,SCAN
  0002�	        TRNE FL,TERMF
 0003�	        JRST    [SETZM STRTIM
   0004�	                POPJ P,]
   0005�	        TRNN FL,NUMF
  0006�	        JRST ILLCMD
   0007�	        IDIVI T1,^D100
     0008�	        IMULI T1,^D60
 0009�	        ADD T1,T2
0010�	        IMULI T1,^D60
 0011�	        MOVEM T1,STRTIM
    0012�	        POPJ P,
  0013�	
  0014�	ILLCMD: PUSHJ P,WTLF
  0015�	        OUTSTR [ASCIZ /ILLEGAL COMMAND/]
  0016�	        POPJ P,
  0017�	
  0018�	SETSTP: PUSHJ P,SCAN
  0019�	        TRNE FL,TERMF
 0020�	        JRST    [MOVEI T1,^D<24*60*60>
    0021�	                MOVEM T1,STPTIM
 0022�	                POPJ P,]
   0023�	        TRNN FL,NUMF
  0024�	        JRST ILLCMD
   0025�	        IDIVI T1,^D100
0026�	        IMULI T1,^D60
 0027�	        ADD T1,T2
0028�	        IMULI T1,^D60
           0029�	        MOVEM T1,STPTIM
    0030�	        POPJ P,
      �  0001�	
  0002�	SRTTST: MOVE    T1,SRTFLG       ;GET SRTFLG
    0003�	        CAMN    T1,[-1]         ;IS OUTPUT TO BE SORTED?
 0004�	        JRST    START           ;IF SO, GO TO START
 0005�	        MOVE    T1,[SIXBRRCHK/] ;INIT OUTPUT FILE
   0006�	        MOVEM   T1,LPTNAM+2
0007�	        MOVE    T1,[SIXBIT /TTY/] ;OUTPUT ERRORS TO TTY
  0008�	        MOVEM   T1,TTYCHN+1
0009�	        TRZ     FL,FLGOPN       ;MAKE SURE TTY IS INITIALIZED
 0010�	        PUSHJ   P,GETDAT        ;CALL GETDAT
                                                          0011�	        CLOSE   LPT,            ;COMPLETE TTY OUTPUT
0012�	        JRST    FINISH          ;GO TO FINISH
  0013�	START:  MOVE    T1,[SIXBIT /DSK/] ;CHANGE ERROR OUTPUT TO DSK
 0014�	        MOVEM   T1,TTYCHN+1
0015�	        PJOB    T1,             ;GET JOB NUMBER
0016�	        MOVE    T2,[POINT 3,T1,17] ;INIT BYTE PTR TO JOB #
    0017�	        MOVE    T3,[POINT 6,LPTNAM+2] ;INIT BYTE PTR TO FILE NAME
  0018�	        MOVEI   T4,6            ;INIT CNTR TO LENGTH OF NAME
  0019�	TMPNAM: ILDB    T5,T2           ;GET BYTE FROM JOB #
0020�	        ADDI    T5,20           ;CONVERT TO SIXBIT
                                0021�	        IDPB    T5,T3           ;PUT BYTE IN FILE NAME
   0022�	        SOJG    T4,TMPNAM       ;CONTINUE UNTIL NAME WRITTEN
  0023�	        OPEN    LPT,TTYCHN      ;OPEN DSK CHANNEL
   0024�	        JRST    DSKBSY          ;IF ERROR, GO TO DSKBSY
  0025�	        LOOKUP  LPT,LPTNAM      ;IS THERE AN OLD TMP FILE?
    0026�	        JFCL                    ;IGNORE ERROR
  0027�	        RENAME  LPT,DELBLK      ;IF SO, DELETE IT
   0028�	        JFCL                    ;IGNORE ERROR
  0029�	        TRZ     FL,FLGOPN       ;MAKE SURE FILE IS OPENED
0030�	        PUSHJ   P,GETDAT        ;CALL GETDAT
                       0031�	        CLOSE   LPT,            ;CLOSE TMP FILE
0032�	        MOVE    T1,[SIXBIT /TTY/] ;RESUME ERROR OUTPUT TO TTY
 0033�	        MOVEM   T1,TTYCHN+1
0034�	        MOVE    T1,ERRFLG       ;GET ERRFLG
    0035�	        CAMN    T1,[-1]         ;NO ERRORS FOUND?
   0036�	        JRST    FINISH          ;IF SO, GO TO FINISH
0037�	        OPEN    TMP,DSKCHN      ;OPEN DSK CHANNEL
   0038�	        JRST    DSKBSY          ;IF ERROR, GO TO DSKBSY
  0039�	        LOOKUP  TMP,LPTNAM      ;LOOKUP TMP FILE
    0040�	        JRST    NOFILE          ;IF ERROR, GO TO NOFILE
                                                         0041�	        INPUT   TMP,CMDLST      ;READ FILE INTO SRTBUF
   0042�	        STATZ   TMP,740000      ;ERROR WHILE READING FILE?
    0043�	        JRST    RDERR           ;IF SO, GO TO RDERR
 0044�	        STATZ   TMP,20000       ;END OF FILE DETECTED?
   0045�	        SKIPA
    0046�	        JRST    BUFOVR          ;IF SO, GO TO BUFOVR
0047�	        MOVE    T1,[POINT 7,SRTBUF] ;INIT BYTE PTR TO SRTBUF
  0048�	        MOVEI   T2,LIST         ;INIT PTR TO LIST
   0049�	        MOVEI   T3,3(T2)        ;CREATE LIST HDR
    0050�	        HRLZM   T3,2(T2)
   0051�	        MOVEI   T3,0            ;INIT ENTRY LENGTH CNTR
       0052�	        MOVEI   T7,DATTBL       ;INIT DATTBL PTR
    0053�	LOAD:   ILDB    T4,T1           ;GET BYTE FROM SRTBUF
    0054�	        CAIN    T4,0            ;BUFFER EMPTY?
 0055�	        JRST    EOF             ;IF SO, GO TO EOF
   0056�	        ADDI    T3,1            ;INCREMENT ENTRY LENGTH
  0057�	        CAIE    T4,12           ;BEGINNING OF RECORD?
    0058�	        JRST    TIMTST          ;IF NOT, GO TO TIMTST
    0059�	        MOVEM   T1,PTRSAV       ;ELSE, SAVE SRTBUF PTR
   0060�	        MOVEM   T3,CTRSAV       ;AND ENTRY LENGTH
   0061�	        JRST    LOAD            ;GO TO LOAD
                             0062�	BUFOVR: OUTSTR  [ASCIZ /BUFFER CAPACITY EXCEEDED - ABORTING
   0063�	/]
0064�	        JRST    FINISH          ;GO TO FINISH
  0065�	EOF:    MOVE    T4,CTRSAV       ;GET LENGTH OF LAST ENTRY
0066�	        ADDI    T4,2            ;ADD 2 FOR EXTRA CR/LF
   0067�	        MOVEM   T4,2(T2)        ;WRITE IT TO LIST
   0068�	        MOVE    T1,PTRSAV       ;ADD EXTRA CR/LF TO LAST ENTRY
0069�	        MOVEI   T4,15
 0070�	        IDPB    T4,T1
 0071�	        MOVEI   T4,12
 0072�	        IDPB    T4,T1
 0073�	        JRST    SORT            ;GO TO SORT
    0074�	DATTST: CAIE    T4,"-"          ;DATE RECORD FOUND?
           0075�	        JRST    LOAD            ;IF NOT, GO TO LOAD
 0076�	        ILDB    T4,T1           ;LOAD NEXT BYTE
0077�	        ADDI    T3,1            ;INCREMENT ENTRY LENGTH
  0078�	        CAIG    T4,"Z"          ;IS THIS CHAR ALPHA?
0079�	        CAIGE   T4,"A"
0080�	        JRST    LOAD            ;IF NOT, GO TO LOAD
 0081�	        MOVE    T4,PTRSAV       ;GET BYTE PTR TO RECORD
  0082�	        MOVEM   T4,0(T7)        ;WRITE IT TO DATTBL
 0083�	        MOVE    T4,CTRSAV       ;GET ENTRY LENGTH
   0084�	        MOVEM   T4,DATCTR       ;WRITE IT TO DATCTR
 0085�	        SETOM   DATFLG          ;SET DATFLG
              0086�	        JRST    LOAD            ;GO TO LOAD
    0087�	TIMTST: CAIE    T4,":"          ;TIME RECORD FOUND?
 0088�	        JRST    DATTST          ;IF NOT, GO TO DATTST
    0089�	        MOVE    T4,DATFLG       ;GET DATFLG
    0090�	        CAME    T4,[-1]         ;IS FLAG SET?
  0091�	        JRST    LENGTH          ;IF NOT, GO TO LENGTH
    0092�	        SETZM   DATFLG          ;RESET DATFLG
  0093�	        MOVE    T4,CTRSAV       ;GET LENGTH OF DATE RECORD
    0094�	        SUB     T4,DATCTR
  0095�	        MOVEM   T4,1(T7)        ;WRITE IT TO DATTBL
                                                                  0096�	        MOVE    T4,CTRSAV       ;GET LENGTH OF LAST ENTRY
0097�	        SUB     T4,1(T7)
   0098�	        MOVEM   T4,2(T2)        ;WRITE IT TO LIST
   0099�	        ADDI    T7,2            ;INCREMENT DATTBL PTR
    0100�	        JRST    LENGTH+2        ;GO TO LENGTH+2
0101�	LENGTH: MOVE    T4,CTRSAV       ;GET LENGTH OF LAST ENTRY
0102�	        MOVEM   T4,2(T2)        ;WRITE IT TO LIST
   0103�	        SUB     T3,CTRSAV       ;INIT LENGTH OF NEXT ENTRY
    0104�	        MOVEI   T4,3(T2)        ;GET ADR OF NEXT ENTRY IN LIST
0105�	        CAIN    T4,ENDLST       ;IS LIST AREA FULL?
                                    0106�	        JRST    LSTOVR          ;IF SO, GO TO LSTOVR
0107�	        HRLM    T4,2(T2)        ;LINK THIS ENTRY TO IT
   0108�	        MOVEM   T4,T2           ;INCREMENT LIST PTR
 0109�	        IBP     T1              ;SKIP TO UNIT NAME
  0110�	        IBP     T1
    0111�	        IBP     T1
    0112�	        ADDI    T3,3            ;INCREMENT ENTRY LENGTH
  0113�	        MOVEI   T5,4            ;INIT CNTR TO UNIT NAME LENGTH
0114�	        MOVE    T6,[POINT 7,UNISAV] ;INIT BYTE PTR TO UNISAV
  0115�	UNIT:   ILDB    T4,T1           ;GET BYTE FROM SRTBUF
    0116�	        IDPB    T4,T6           ;PUT BYTE IN UNISAV
      0117�	        ADDI    T3,1            ;INCREMENT ENTRY LENGTH
  0118�	        SOJG    T5,UNIT         ;CONTINUE UNTIL NAME IS SAVED
 0119�	        MOVE    T4,UNISAV       ;GET UNIT NAME
 0120�	        MOVEM   T4,0(T2)        ;WRITE IT TO LIST
   0121�	        MOVE    T4,PTRSAV       ;GET BYTE PTR
  0122�	        MOVEM   T4,1(T2)        ;WRITE IT TO LIST
   0123�	        JRST    LOAD            ;GO TO LOAD
    0124�	LSTOVR: OUTSTR  [ASCIZ /LIST AREA FULL - ABORTING
   0125�	/]
0126�	        JRST    FINISH          ;GO TO FINISH
  0127�	SORT:   SUBI    T2,LIST         ;GET # OF ENTRIES IN LIST
                              0128�	        IDIVI   T2,3
  0129�	        MOVEM   T2,ENTCTR       ;AND SAVE # IN ENTCTR
    0130�	SETUP:  MOVEI   T7,0            ;SET FLAG TO 0
 0131�	        MOVEI   T1,LIST         ;INIT LAST TO LIST HDR
   0132�	        HLRZ    T2,2(T1)        ;INIT CURRENT TO LINK(LAST)
   0133�	        HLRZ    T3,2(T2)        ;INIT NEXT TO LINK(CURRENT)
   0134�	        MOVE    T4,ENTCTR       ;INIT CNTR TO LIST LENGTH
0135�	        SUBI    T4,1            ;NUMBER OF PASSES IS 1 LESS
   0136�	COMPAR: MOVE    T5,0(T2)        ;GET CURRENT DEVNAM
 0137�	        CAMG    T5,0(T3)        ;IS IT LESS THAN THE NEXT?
                        0138�	        JRST    SHIFT           ;IF SO, GO TO SHIFT
 0139�	        MOVEI   T7,1            ;ELSE, SET FLAG TO 1
0140�	        HLRZ    T5,2(T1)        ;SAVE LINK(LAST)
    0141�	        HLRZ    T6,2(T2)        ;SET LINK(LAST) TO LINK(CURRENT)
   0142�	        HRLM    T6,2(T1)
   0143�	        HLRZ    T6,2(T3)        ;SET LINK(CURRENT) TO LINK(NEXT)
   0144�	        HRLM    T6,2(T2)
   0145�	        HRLM    T5,2(T3)        ;SET LINK(NEXT) TO LINK SAVED
 0146�	        EXCH    T2,T3           ;SWAP NEXT AND CURRENT
   0147�	SHIFT:  HLRZ    T1,2(T1)        ;SET LAST TO LINK(LAST)
                                          0148�	        HLRZ    T2,2(T2)        ;SET CURRENT TO LINK(CURRENT)
 0149�	        HLRZ    T3,2(T3)        ;SET NEXT TO LINK(NEXT)
  0150�	        SOJG    T4,COMPAR       ;IF NOT END OF LIST, GO TO COMPAR
  0151�	        CAIN    T7,0            ;IS FLAG = 0?
  0152�	        JRST    TYPOUT          ;IF SO, GO TO TYPOUT
0153�	        JRST    SETUP           ;ELSE, GO TO SETUP
  0154�	TYPOUT: OPEN    LPT,TTYCHN      ;OPEN TTY CHANNEL
   0155�	        JRST    TTYBSY          ;IF ERROR, GO TO TTYBSY
  0156�	        ENTER   LPT,LPTNAM      ;OPEN OUTPUT FILE
   0157�	        JRST    TTYBSY          ;IF ERROR, GO TO TTYBSY
       0158�	        MOVE    T1,ENTCTR       ;INIT CNTR TO # OF ENTRIES
    0159�	        MOVEI   T2,LIST         ;INIT PTR TO LIST HDR
    0160�	NEXT:   HLRZ    T2,2(T2)        ;GET NEXT ERROR ENTRY ON LIST
 0161�	        HRRZ    T3,1(T2)        ;GET PTR TO ENTRY
   0162�	        MOVEI   T5,DATTBL       ;GET PTR TO DATTBL
  0163�	DATSRH: HRRZ    T6,0(T5)        ;GET PTR TO NEXT DATE
    0164�	        CAIN    T6,0            ;NO DATES LEFT?
0165�	        JRST    DATOUT          ;IF SO, GO TO DATOUT
0166�	        CAMG    T3,T6           ;DOES ENTRY FOLLOW DATE?
 0167�	        JRST    DATOUT          ;IF NOT, GO TO DATOUT
         0168�	        ADDI    T5,2            ;INCREMENT DATTBL PTR
    0169�	        JRST    DATSRH          ;GO TO DATSRH
  0170�	DATOUT: SUBI    T5,2            ;BACKUP 1 DATTBL ENTRY
   0171�	        MOVE    T3,0(T5)        ;GET BYTE PTR TO DATE RECORD
  0172�	        MOVE    T4,1(T5)        ;GET BYTE COUNT FOR DATE RECORD
    0173�	        CAMN    T3,DATSAV       ;HAS DATE ALREADY BEEN TYPED?
 0174�	        JRST    ERROUT          ;IF SO, GO TO ERROUT
0175�	        MOVEM   T3,DATSAV       ;SAVE NEW DATE PTR
  0176�	        PUSHJ   P,PUT           ;CALL PUT
                                                                       0177�	ERROUT: MOVE    T3,1(T2)        ;GET BYTE PTR TO ERROR ENTRY
  0178�	        HRRZ    T4,2(T2)        ;GET BYTE COUNT FOR ERROR ENTRY
    0179�	        PUSHJ   P,PUT           ;CALL PUT
 0180�	        SOJG    T1,NEXT         ;CONTINUE UNTIL NO ENTRIES LEFT
    0181�	        JRST    FINISH          ;GO TO FINISH
  0182�	PUT:    SOSG    OBUF+2          ;DECREMENT BYTE COUNT
    0183�	        JRST    PUTBUF          ;IF BUFFER FULL, GIVE TO MONITOR
   0184�	NXTCHR: ILDB    T5,T3           ;LOAD BYTE FROM ENTRY
    0185�	        IDPB    T5,OBUF+1       ;PUT BYTE IN BUFFER
                                                   0186�	        SOJG    T4,PUT          ;CONTINUE UNTIL NO BYTES LEFT
 0187�	        POPJ    P,              ;RETURN TO CALLING POINT
 0188�	FINISH: CLOSE   LPT,            ;COMPLETE TTY OUTPUT
0189�	        MOVEI   T1,SRTBUF       ;GET PTR TO SRTBUF
  0190�	BUFCLR: SETZM   0(T1)           ;CLEAR SRTBUF
  0191�	        CAIE    T1,ENDBUF-1
0192�	        AOJA    T1,BUFCLR
  0193�	        MOVEI   T1,LIST         ;GET PTR TO LIST
    0194�	LSTCLR: SETZM   0(T1)           ;CLEAR LIST AREA
    0195�	        CAIE    T1,ENDLST-1
0196�	        AOJA    T1,LSTCLR
  0197�	        MOVEI   T1,DATTBL       ;GET PTR TO DATTBL
            0198�	TABCLR: SETZM   0(T1)           ;CLEAR DATTBL
  0199�	        CAIE    T1,ENDTBL-1
0200�	        AOJA    T1,TABCLR
  0201�	        SETZM   ERRFLG          ;RESET ERRFLG
  0202�	        SETZM   DATSAV          ;CLEAR DATSAV
  0203�	        POPJ    P,              ;RETURN TO CALLING POINT
 0204�	PUTBUF: OUTPUT  LPT,0           ;GIVE BUFFER TO MONITOR
  0205�	        STATZ   LPT,740000      ;ERROR DURING OUTPUT?
    0206�	        JRST    WTERR           ;IF SO, GO TO WTERR
 0207�	        JRST    NXTCHR          ;ELSE, GO TO NXTCHR
 0208�	DSKBSY: OUTSTR  [ASCIZ /UNABLE TO INIT DSK/]
   0209�	        JRST    FINISH
     0210�	TTYBSY: OUTSTR  [ASCIZ /UNABLE TO INIT TTY/]
   0211�	        JRST    FINISH
0212�	NOFILE: OUTSTR  [ASCIZ /UNABLE TO LOCATE TMP FILE/]
 0213�	        JRST    FINISH
0214�	RDERR:  OUTSTR  [ASCIZ /ERROR WHILE READING TMP FILE/]
   0215�	        JRST    FINISH
0216�	WTERR:  OUTSTR  [ASCIZ /ERROR DURING TTY OUTPUT/]
   0217�	        JRST    FINISH
0218�	TTYCHN: 0
   0219�	        0
   0220�	        OBUF,,0
  0221�	DSKCHN: 17
  0222�	        SIXBIT  /DSK/
 0223�	        0
   0224�	CMDLST: IOWD    6000,SRTBUF
0225�	        0
   0226�	SRTBUF: BLOCK   6000
  0227�	ENDBUF==.
   0228�	LIST:   BLOCK   600
             0229�	ENDLST==.
   0230�	DATTBL: BLOCK   60
    0231�	ENDTBL==.
   0232�	DELBLK: BLOCK   4
0233�	ERRFLG: BLOCK   1
0234�	SRTFLG: BLOCK   1
0235�	DATFLG: BLOCK   1
0236�	UNISAV: BLOCK   1
0237�	DATSAV: BLOCK   1
0238�	PTRSAV: BLOCK   1
0239�	CTRSAV: BLOCK   1
0240�	DATCTR: BLOCK   1
0241�	ENTCTR: BLOCK   1
    �  0001�	GETDAT: PUSHJ P,SCAN
  0002�	        TRNE FL,TERMF
 0003�	        JRST TODAY
    0004�	        TRNE FL,IDENT
 0005�	        JRST MONNAM
   0006�	        TRNN FL,NUMF
  0007�	        JRST ILLCMD
   0008�	        MOVE T6,T1
    0009�	GOTMON: PUSHJ P,SCAN
  0010�	        TRNE FL,TERMF
           0011�	        JRST ILLCMD
   0012�	        TRNN FL,NUMF
  0013�	        JRST GOTMON
   0014�	        MOVE T5,T1
    0015�	GOTDAY: PUSHJ P,SCAN
  0016�	        TRNE FL,TERMF
 0017�	        JRST ILLCMD
   0018�	        TRNN FL,NUMF
  0019�	        JRST GOTDAY
   0020�	        CAILE T1,^D1900
    0021�	        SUBI T1,^D1900
0022�	        SUBI T1,^D64
  0023�	        JUMPL T1,ILLCMD
    0024�	        IMULI T1,^D12
 0025�	        ADDI T1,-1(T6)
0026�	        IMULI T1,^D31
 0027�	        ADDI T1,-1(T5)
0028�	        MOVEM T1,DESDAT#
   0029�	        JRST SRCFIL
   0030�	
  0031�	TODAY:  DATE T1,
                     0032�	        MOVEM T1,DESDAT
    0033�	        JRST SRCFIL
   0034�	
  0035�	MONNAM: MOVE T4,[-MONLEN,,MONTAB]
    0036�	        PUSHJ P,CMDSRC
0037�	         JRST ILLCMD
  0038�	        MOVEI T6,1(T3)
0039�	        JRST GOTMON
   0040�	
  0041�	MONTAB: <SIXBIT /JANUARY/>
 0042�	        <SIXBIT /FEBRUARY/>
0043�	        <SIXBIT /MARCH/>
   0044�	        <SIXBIT /APRIL/>
   0045�	        <SIXBIT /MAY/>
0046�	        <SIXBIT /JUNE/>
    0047�	        <SIXBIT /JULY/>
    0048�	        <SIXBIT /AUGUST/>
  0049�	        <SIXBIT /SEPTEMBER/>
    0050�	        <SIXBIT /OCTOBER/>
 0051�	        <SIXBIT /NOVEMBER/>
     0052�	        <SIXBIT /DECEMBER/>
0053�	MONLEN==.-MONTAB
 0054�	
      �  0001�	SRCFIL: MOVEI PTR,0
   0002�	        MOVE T1,DESDAT
0003�	        MOVEM T1,DCNV   ;IN CASE CONVERSION NEEDED
  0004�	        PUSHJ P,CNVNAM
0005�	        LOOKUP FIL,NAME
    0006�	         SKIPA
   0007�	        JRST RDFIL              ;GOT IT
   0008�	        SETZM DCNV+1
  0009�	        MOVEI T1,400000
    0010�	        MOVEM T1,DCNV+2
    0011�	        MOVEI T1,DCNV
 0012�	        DATUUO T1,
    0013�	         JFCL
    0014�	        MOVE T1,DCNV    ;THIS IS FOR OLD STYLE DATES. ONE REC/WEEK
 0015�	        SUBI T1,3
               0016�	        IDIVI T1,7
    0017�	        IMULI T1,7
    0018�	        ADDI T1,3
0019�	        MOVEM T1,DCNV
 0020�	        MOVSS DCNV+2    ;REVERSE CONVERSION
    0021�	        MOVEI T1,DCNV
 0022�	        DATUUO T1,
    0023�	         JFCL
    0024�	        MOVE T1,DCNV
  0025�	        PUSHJ P,CNVNAM
0026�	        LOOKUP FIL,NAME
    0027�	         JRST NOFIL
   0028�	        JRST RDFIL
    0029�	
  0030�	NAME:   3
   0031�	        0
   0032�	        0
   0033�	        SIXBIT /DAT/
      �  0001�	CNVNAM: IDIVI T1,^D31   ;CONVERT DATE IN T1 TO MMDDYY IN SIXBIT
    0002�	        ADDI T2,1       ;DAYS
        0003�	        PUSH P,T2
0004�	        IDIVI T1,^D12
 0005�	        ADDI T1,^D64
  0006�	        CAIL T1,^D100
 0007�	        SUBI T1,^D100   ;SO 200X COMES OUT 0X
  0008�	        EXCH T1,(P)     ;NOW YEAR ON STACK
0009�	        PUSH P,T1       ;NOW DAY THEN YEAR
0010�	        AOS T1,T2       ;MONTH
  0011�	        MOVE T3,[POINT 6,NAME+2]
0012�	        PUSHJ P,SXDCV   ;CONVERT
0013�	        POP P,T1        ;DD
0014�	        PUSHJ P,SXDCV
 0015�	        POP P,T1        ;YY
0016�	SXDCV:  IDIVI T1,^D10
 0017�	        ADDI T1,'0'
   0018�	        IDPB T1,T3
    0019�	        ADDI T2,'0'
                                 0020�	        IDPB T2,T3
    0021�	        POPJ P,
      �  0001�	NOFIL:  PUSHJ P,WTLF
  0002�	        HRRZ T1,NAME+3
0003�	        JUMPN T1,NOLIC
0004�	        OUTSTR [ASCIZ /CAN NOT FIND DATA FILE/]
0005�	        POPJ P,
  0006�	
  0007�	NOLIC:  OUTSTR [ASCIZ /NOT ENOUGH LICENSE/]
    0008�	        POPJ P,
  0009�	
  0010�	GETREC:	SKIPE NOADV
   0011�		 JRST [	SETZM NOADV
  0012�			RET]
 0013�		AOBJN PTR,CONBUF
0014�	        INPUT FIL,COM
 0015�	        STATZ FIL,20000
    0016�	        POPJ P,
  0017�	        MOVSI PTR,-8
  0018�	        HRRI PTR,BUF
  0019�	        JRST BUFRET
   0020�	
                 0021�	CONBUF: ADDI PTR,17
   0022�	BUFRET: SKIPN (PTR)
   0023�	        JRST GETREC
   0024�	        AOS (P)
  0025�	        POPJ P,
      �  0001�	ELMMSK==2       ;MASK IN ELIMINATE LIST
   0002�	ELMNAM==1       ;NAME IN ELIMINATE LIST
   0003�	
  0004�	SETERR: PUSH P,RADIX
  0005�	        MOVEI T1,^D8
  0006�	        MOVEM T1,RADIX  ;RADIX MUST BE SET TO 8 FOR ERROR READIN
   0007�	        PUSHJ P,SCAN
  0008�	        TRNE FL,TERMF
 0009�	        JRST RSTERR     ;NOTHING, RESET ALL ERROR FLAGS
  0010�	NXTSER: TRNE FL,NUMF
  0011�	        JRST    [SETZM ELMERR
                                                     0012�	                MOVEM T1,ONLERR ;SELECT SINGLE ERROR TYPE
0013�	                JRST LEVERR]
    0014�	        TRNE FL,IDENT
 0015�	        JRST ERRIDN     ;HARD OR A UNIT NAME
   0016�	        CAIN C,"-"      ;SPECIAL, MIGHT BE -
   0017�	        JRST ERRMIN     ;YES, DESELECTING SOME ERROR
0018�	ERRCER: POP P,RADIX
   0019�	        JRST ILLCMD     ;ERROR
  0020�	
  0021�	RSTERR: SETZM HRDFLG
  0022�	        SETZM ONLNAM
  0023�	        SETOM ONLERR
  0024�	        SETZM ELMERR
  0025�	        SETZM USESNS
  0026�	        SETZM USEENV
  0027�	        SETZM SKPERR
  0028�	        SETZM SHTFRM
                 0029�	LEVER1: MOVEI T1,ELMLST
    0030�	        PUSHJ P,SETFRE
0031�	LEVERR: TRNN FL,TERMF   ;IF NOT END OF LINE (FROM ERR<RET>)
   0032�	        PUSHJ P,SCAN    ;SCAN FOR SOMETHING ELSE
    0033�	        TRNN FL,TERMF   ;IF END OF LINE, DONE NOW
   0034�	        JRST NXTSER     ;ELSE TRY FOR SOMETHING ELSE
0035�	        POP P,RADIX
   0036�	        POPJ P,
  0037�	
  0038�	ERRIDN: MOVE T4,[-ECMLEN,,ECMTAB]
    0039�	        PUSHJ P,CMDSRC
0040�	         JRST ERRUNM    ;NOT FOUND, A UNIT NAME
0041�	        XCT ECMDSP(T3)
0042�	        JRST LEVERR
   0043�	
  0044�	ERRUNM: MOVE T1,ACCUM
                               0045�	        MOVEM T1,ONLNAM ;SET NAME
    0046�	        PUSHJ P,MAKMSK  ;MAKE A MASK
 0047�	        MOVEM T2,ONLMSK#
   0048�	        JRST LEVER1     ;AND RESET ELIMINATED UNITS
     �  0001�	ERRMIN: PUSHJ P,SCAN
  0002�	        TRNE FL,NUMF
  0003�	        JRST    [SETOM ONLERR
   0004�	                MOVEM T1,ELMERR ;ELIMINATE ERROR TYPE
    0005�	                JRST LEVERR]
    0006�	        TRNN FL,IDENT
 0007�	        JRST ERRCER     ;MUST BE ERROR
    0008�	        MOVE T4,[-ECMLEN,,ECMTAB]
    0009�	        PUSHJ P,CMDSRC
0010�	         JRST ERRMUN    ;ASSUME - UNIT NAME
                                  0011�	        XCT ECMMDS(T3)
0012�	        JRST LEVERR
   0013�	
  0014�	ERRMUN: SETZM ONLNAM    ;REMOVE POSITIVE SELECTION
  0015�	        MOVEI T4,ELMLST
    0016�	ELMSRC: HRRZ T2,(T4)
  0017�	        JUMPE T2,ELMNEW ;LOOK FOR END OF LIST
  0018�	        MOVE T4,T2
    0019�	        JRST ELMSRC
   0020�	
  0021�	ELMNEW: PUSHJ P,GETCOR
0022�	        SETZM (T2)
    0023�	        HRLM T2,ELMLST
0024�	        HRRM T2,(T4)    ;LINK IN NEW BLOCK
0025�	        MOVE T4,T2      ;SAVE LINK POINTER
0026�	                MOVE T1,ACCUM
   0027�	        MOVEM T1,ELMNAM(T4)     ;SAVE NAME
0028�	        PUSHJ P,MAKMSK
          0029�	        MOVEM T2,ELMMSK(T4)     ;AND MASK
 0030�	        JRST LEVERR
   0031�	
  0032�	MAKMSK: MOVEI T2,0
    0033�	        MOVSI T3,770000
    0034�	MAKMS1: TDNN T1,T3
    0035�	        POPJ P, ;DONE
 0036�	        IOR T2,T3
0037�	        LSH T3,-6
0038�	        JUMPN T3,MAKMS1
    0039�	        POPJ P,
  0040�	
  0041�	        DEFINE ECMDS
  0042�	<       X HARD,<SETOM HRDFLG>,<SETZM HRDFLG>
   0043�	        X SHORT,<SETOM SHTFRM>,<SETZM SHTFRM>
  0044�	        X ALL,<JRST RSTERR>,<SETOM SKPERR>
0045�	        X ENVIRONMENTAL,<SETOM USEENV>,<SETZM USEENV>
                                                      0046�	        X SENSE,<SETOM USESNS>,<SETZM USESNS>
  0047�	>
 0048�	
  0049�	        DEFINE X (A,B,C)
   0050�	<       <SIXBIT /A/>>
 0051�	
  0052�	ECMTAB: ECMDS
    0053�	ECMLEN==.-ECMTAB
 0054�	        DEFINE X (A,B,C)
   0055�	<       B>
  0056�	ECMDSP: ECMDS           ;POSITIVE ACTION
  0057�	        DEFINE X (A,B,C)
   0058�	<       C>
  0059�	ECMMDS: ECMDS           ;NEGATIVE ACTION
      �  0001�	RDFIL:  SETZM SNREC#
  0002�	        TRZ FL,FLGDAT   ;NO DATE OUTPUT YET
    0003�	LOOP:   PUSHJ P,GETREC
0004�	         JRST FILDON
  0005�	        SKIPL RECDEF(PTR)
                                          0006�	        JRST LOOP       ;NOT FOR US
  0007�	        HLRZ T1,RECDAT(PTR)
0008�	        CAME T1,DESDAT
0009�	        JRST LOOP
0010�	        SETOM SNREC     ;WE HAVE A RECORD FOR THAT DATE
  0011�	        HRRZ T1,RECDAT(PTR)
0012�	        CAML T1,STPTIM
0013�	        JRST FILDON     ;RECORDS ARE IN SEQ, THIS IS TOO LATE
 0014�	        HRRZ T1,RECDEF(PTR)
0014�		CAIN T1,101	;2020 TAPE ERROR RECORD?
0014�		 JRST [	PUSHJ P,M20ERR
    0014�			JRST LOOP]
0015�	        CAIL T1,ERRTYP
0016�	        JRST LOOP       ;UNKNOWN TYPE
0017�	        SETOM SNREC
   0018�	        XCT ERRTAB(T1)
0019�	        JRST LOOP
          0020�	
  0021�	ERRTAB: PUSHJ P,UNIERR
0022�	        PUSHJ P,MTAERR
0023�	        PUSHJ P,SETRST  ;RESTART MESSAGE
  0024�	        PUSHJ P,FTAERR  ;IBM TAPE ERROR (FT'S)
 0025�	        PUSHJ P,UNISNS  ;SENSE DATE (BP)
  0026�	        PUSHJ P,FTASNS  ;SENSE DATA (FT)
  0027�	        PUSHJ P,PARERR  ;PARITY ERROR
0028�	        JFCL
0029�	        JFCL
0030�	
  0031�	ERRTYP==.-ERRTAB
 0032�	
  0033�	FILDON: TRNE FL,FLGDSK
0034�	        JRST FILDN1     ;DO NOT RELEASE DISK
   0035�	        RELEASE LPT,
  0036�	        TRZ FL,FLGOPN
 0037�	FILDN1: SKIPE CNTERR
  0038�	        JRST CHKDAT     ;POSSIBLY CONTINUE
          0039�	        SKIPN SNREC
   0040�	        JRST NORCD      ;NO RECORDS FOR DATE
   0041�	        TRNE FL,FLGDAT  ;IF DATE PRINTED, THEN AT LEAST ONE RECORD
 0042�	        POPJ P,
  0043�	        PUSHJ P,WTLF
  0044�	        OUTSTR [ASCIZ /NONE/]
   0045�	        SETOM   ERRFLG          ;TELL SRTTST NO ERRORS FOUND
  0046�	        POPJ P,
  0047�	
  0048�	NORCD:  PUSHJ P,WTLF
  0049�	        OUTSTR [ASCIZ /NO RECORDS SEEN FOR DATE/]
   0050�	        POPJ P,
  0051�	
  0052�	CHKDAT: DATE T1,
 0053�	        CAMG T1,DESDAT  ;FINISHED?
   0054�	        POPJ P,         ;YES
                                                 0055�	        AOS DESDAT      ;TRY NEXT DAY
0056�	        TRZ FL,FLGDAT   ;SO NEXT DATE WILL PRINT
    0057�	        JRST SRCFIL
       �  0001�	UUO0:   0
   0002�	        PUSH P,T1
0003�	        LDB T1,[POINT 9,40,8]
   0004�	        CAILE T1,3
    0005�	        JRST UUOERR
   0006�	        JRST @UUOTAB(T1)
   0007�	
  0008�	UUOERR: OUTSTR [ASCIZ /UUO ERROR/]
   0009�	        EXIT
0010�	
  0011�	UUOTAB: JRST UUOERR
   0012�	        JRST UUOCHR
   0013�	        JRST UUOSTR
   0014�	        JRST UUOCHI
   0015�	
  0016�	UUOCHR: MOVE T1,@40
   0017�	UUOCH1: PUSHJ P,OCHR
  0018�	UUOXIT: POP P,T1
                0019�	        JRST @UUO0
    0020�	
  0021�	UUOCHI: HRRZ T1,40
    0022�	        JRST UUOCH1
   0023�	
  0024�	OCHR:	SOSG OBUF+2
0025�		OUTPUT LPT,0
    0026�		IDPB T1,OBUF+1
  0027�		POPJ P,
    0028�	
  0029�	UUOSTR: PUSH P,T2
0030�	        HRRZ T2,40
    0031�	        HRLI T2,(POINT 7,0)
0032�	UUOST1: ILDB T1,T2
    0033�	        JUMPE T1,UUOST2
    0034�	        PUSHJ P,OCHR
  0035�	        JRST UUOST1
   0036�	UUOST2: POP P,T2
 0037�	        JRST UUOXIT
   0038�	
  0039�	OUTDEC: IDIV T2,RADIX
 0040�	        HRLM T3,(P)
   0041�	        SKIPE T2
 0042�	        PUSHJ P,OUTDEC
                              0043�	        HLRZ T2,(P)
   0044�	        OCHI "0"(T2)
  0045�	        POPJ P,
  0046�	
  0047�	OUTOCT: PUSH P,RADIX
  0048�	        PUSH P,[10]
   0049�	        POP P,RADIX
   0050�	        PUSHJ P,OUTDEC
0051�	        POP P,RADIX
   0052�	        POPJ P,
  0053�	
  0054�	DEC4:   CAIL T2,^D1000
0055�	        JRST OUTDEC
   0056�	        OCHI " "
 0057�	DEC3:   CAIL T2,^D100
 0058�	        JRST OUTDEC
   0059�	        OCHI " "
 0060�	DEC2:   CAIGE T2,^D10
 0061�	        OCHI " "
 0062�	        JRST OUTDEC
       �  0001�	OUTSIX: MOVEI T2,0
    0002�	        LSHC T2,6
0003�	        OCHI " "(T2)
            0004�	        JUMPN T3,OUTSIX
    0005�	        POPJ P,
  0006�	
  0007�	OUTHLF:	PUSH P,RADIX
  0008�		MOVEI T2,^D8
    0009�		MOVEM T2,RADIX
  0010�		HLRZ T2,T4
 0011�		JUMPE T2,NOLEFT
 0012�		PUSHJ P,OUTDEC
  0013�		OCHI ","
   0014�	NOLEFT:	HRRZ T2,T4
    0015�		PUSHJ P,OUTDEC
  0016�		POP P,RADIX
0017�		OCHI " "
   0018�		POPJ P,
    0019�	
  0020�	TIMOUT: MOVE T2,T4
    0021�	        IDIVI T2,^D60
 0022�	        IDIVI T2,^D60
 0023�	        MOVE T4,T3      ;SAVE MIN
    0024�	        PUSHJ P,OUTDEC
0025�	        OCHI ":"
 0026�	        MOVE T2,T4
    0027�	        CAIGE T2,^D10
                          0028�	        OCHI "0"
 0029�	        JRST OUTDEC
   0030�	
  0031�	OPNFIL: TROE FL,FLGOPN
0032�	        POPJ P,
  0033�	        OPEN LPT,TTYCHN
    0034�	        JRST LPTWAT
   0035�	LPTGOT: ENTER LPT,LPTNAM
   0036�	        JRST NOENT
    0037�	        MOVEI T2,LPT
  0038�	        DEVNAM T2,
    0039�	         MOVEI T2,0
   0040�	        HLRZS T2
 0041�	        CAIN T2,'DSK'
 0042�	        TRO FL,FLGDSK
 0043�	        POPJ P,
  0044�	
      �  0001�	LPTWAT: PUSHJ P,WTLF
  0002�	        OUTSTR [ASCIZ /LPT BUSY - WAITING
 0003�	/]
0004�	LPTWT1: MOVEI T2,^D10
 0005�	        SLEEP T2,
                         0006�	        OPEN LPT,TTYCHN
    0007�	        JRST LPTWT1
   0008�	        JRST LPTGOT
   0009�	
  0010�	NOENT:  PUSHJ P,WTLF
  0011�	        OUTSTR [ASCIZ /CAN NOT ENTER OUTPUT FILE/]
  0012�	        EXIT
0013�	
  0014�	LPTNAM: 3
   0015�	        0
   0016�	        0
   0017�	        SIXBIT /TMP/
  0018�	
  0019�	OUTDAT: TLZ FL,FERRST   ;TURN OFF RESTART WHEN PRINTING DATE
  0020�	        PUSH P,T1
0021�	        OSTR [ASCIZ /
 0022�	/]
0023�	        MOVE T1,DESDAT
0024�	        IDIVI T1,^D31
 0025�	        ADDI T2,1
0026�	        PUSHJ P,OUTDEC
0027�	        IDIVI T1,^D12
                                    0028�	        OSTR @MONASC(T2)
   0029�	        MOVEI T2,^D64(T1)
  0030�	        PUSHJ P,OUTDEC
0031�	        OSTR [ASCIZ /
 0032�	/]
0033�	        POP P,T1
 0034�	        POPJ P,
  0035�	
  0036�	        DEFINE XMON (A)
    0037�	<IRP A,<[ASCIZ /-A-/]>>
    0038�	
  0039�	MONASC: XMON <JAN,FEB,MAR,APR,MAY,JUNE,JULY,AUG,SEPT,OCT,NOV,DEC>
      �  0001�	;FLAG BITS
  0002�	
  0003�	FERRST==1       ;IN LEFT HALF, RESTART DETECTED
0004�	FERHRD==2       ;HARD ERROR
0005�	FERDSK==4       ;ERROR IS IN DISK
    0006�	
  0007�	;INFORMATION IN A RECORD
   0008�	
                                                         0009�	RECRUN==2       ;RUNTIME FOR RECORDER (IN TRU)
 0010�	RECNAM==3       ;UNIT NAME
 0011�	RECID==4        ;UNIT ID
   0012�	RECHRD==5       ;NUMBER OF HARD ERRORS
    0013�	RECSOF==6       ;NUMBER OF SSOFT ERRORS
   0014�	RECHCI==7       ;HARD CONI
 0015�	RECSCI==10      ;SOFT CONI
 0016�	RECHBN==11      ;LOGICAL BLOCK NUMBER
0017�	RECSDI==12      ;SOFT DATAI
0018�	RECHDI==13      ;HARD DATAI
0019�	RECRET==14      ;RETRY COUNT
    0020�	
  0021�	;INFORMATION IN CORE LIST
  0022�	
  0023�	CORNAM==1       ;NAME
 0024�	RECSBN==15      ;SOFT LOGICAL BLOCK NUMBER
0025�	CORID==2        ;ID
                            0026�	CORSOF==3       ;SOFT DATA COUNT
0027�	CORHRD==4       ;HARDATA COUNT
  0028�	
  0029�	;ALSO USED FOR MAGTAPE
0030�	
  0031�	CORCNT==2       ;NUMBER OF ERRORS
    0032�	CORHNG==2       ;HUNG COUNT FOR FTA
  0033�	CORWRT==3       ;NUMBER OF REWRITES
  0034�	CORWOK==4       ;NUMBER OF RECORDS CORRECTLY REWRITTEN
   0035�	CORWFL==5       ;NUMBER OF RECORDS ON WHICH REWRITE FAILED
    0036�	CORROK==6       ;NUMBER OF RECORDS ON WHICH REREAD WORKED
0037�	CORRFL==7       ;NUMBER OF RECORDS ON WHICH REREAD FAILED
0038�	
  0039�	CORSIZ==10      ;SIZE OF CORE BLOCK
  0040�	
  0041�	;MTA RECORDS
0042�	
                 0043�	REMCNI==5       ;CONI
 0044�	REMCNT==4       ;ERROR COUNT
    0045�	REMWRT==6       ;NUMBER OF REWRITES TRIED
 0046�	        REMWOK==10      ;NUMBER OF REWRITES SUCCESSFUL
   0047�	REMWFL==7       ;NUMBER OF REWRITES WHICH FAILED
    0048�	REMROK==11      ;NUMBER OF REREADS SUCCEDING
   0049�	REMRFL==12      ;NUMBER OF REREADS FAILING
0050�	
  0051�	;FTA RECORDS
0052�	
  0053�	REFROK==4       ;READ RECOVERED
 0054�	REFRFL==5       ;READ UNRECOVERED
    0055�	REFWOK==6       ;WRITE RECOVERED
0056�	REFWFL==7       ;WRITE UNRECOVERED
   0057�	REFSCI==10      ;SOFT CONI
 0058�	REFHCI==11      ;HARD CONI
           0059�	REFHNG==12      ;HUNG COUNT
0060�	REFHFC==13      ;HUNG FUNCTION
  0061�	REFCIH==14      ;HUNG CONI
     �  0001�	SETRST: TLOA FL,FERRST  ;FLAG A RESTART
   0002�	SETRS1: TLZ FL,FERRST   ;RESTART OFF (FIRST TIME
    0003�	        HRRZ T1,JOBFF
 0004�	        MOVEI T1,UNILST
    0005�	        JRST SETFRE     ;PUT ON FREE CORE LIST
 0006�	
  0007�	FNDLNK: MOVEI T1,UNILST ;FIND UNIT IN UNIT LIST
0008�	FNDLN1: HRRZ T2,(T1)
  0009�	        JUMPE T2,NEWLNK		;REACHED END, NEED A NEW ONE
    0010�	        MOVE T1,T2
    0011�	        MOVE T2,CORNAM(T1)
 0012�	        CAMN T2,RECNAM(PTR)
                              0013�	        POPJ P,			;FOUND IT
0014�	        JRST FNDLN1		;TRY AGAIN
 0015�	
  0016�	NEWLNK: PUSHJ P,GETCOR		;GET SOME CORE SPACE
   0017�	        SETZM (T2)		;ZERO LINK
  0018�	        HRRM T2,(T1)		;LINK IN
  0019�	        HRLM T2,UNILST		;RECORD END
  0020�	        MOVE T1,T2
    0021�	        MOVE T2,RECNAM(PTR)
0022�	        MOVEM T2,CORNAM(T1)
0023�	XXZ==CORNAM+1
    0024�	        REPEAT CORSIZ-CORNAM-1,<SETZM XXZ(T1)
  0025�	XXZ==XXZ+1>             ;CLEAR EXTRA WORDS
0026�	        POPJ P,
  0027�	
  0028�	GETCOR: HRRZ T2,FRECOR
0029�	        JUMPN T2,[HRRZ T2,(T2)  ;FREE CORE, GET LINK
                    0030�	                EXCH T2,FRECOR  ;AND REMOVE FIRST EL
0031�	                POPJ P,]
   0032�	        MOVE T2,JOBFF
 0033�	        ADDI T2,CORSIZ
0034�	        CAMG T2,JOBREL
0035�	        JRST COROK
    0036�	        IORI T2,1777
  0037�	        CORE T2,
 0038�	         JRST NOCOR
   0039�	COROK:  MOVEI T2,CORSIZ
    0040�	        EXCH T2,JOBFF
 0041�	        ADDM T2,JOBFF
 0042�	        POPJ P,
  0043�	
  0044�	NOCOR:  PUSHJ P,WTLF
  0045�	        OUTSTR [ASCIZ /NOT ENOUGH CORE AVAILABLE/]
  0046�	        EXIT
0047�	
  0048�	SETFRE: SKIPN T2,(T1)   ;ANY CORE IN USE?
 0049�	        POPJ P,         ;NO
     0050�	        MOVSS T2        ;GET POINTER TO END IN R.H. FOR INDEX
 0051�	        HRRZ T3,FRECOR
0052�	        HRRM T3,(T2)    ;LINK CURRENT FREE ON END
   0053�	        HLRZM T2,FRECOR ;SET START OF LIST
0054�	        SETZM (T1)      ;ZERO ORIGINAL LIST
    0055�	        POPJ P,
      �  0001�	;COMMON UNIT CODE. FIRST FIND OUT IF UNIT TO BE IGNORED
  0002�	
  0003�	COMUNI: SKIPN ONLNAM		;ONLY ONE UNIT OR TYPE?
  0004�		 JRST NOTONL		;NO
    0005�	        MOVE T2,RECNAM(PTR)
0006�	        AND T2,ONLMSK
 0007�	        CAMN T2,ONLNAM
0008�		 JRST ONLOK		;ONLY UNIT OK
0009�	        TLNN FL,FERDSK
                    0010�		 POPJ P,		;ONLY DISKS HAVE ID'S
0011�	        MOVE T2,RECID(PTR)
 0012�	        AND T2,ONLMSK
 0013�	        CAMN T2,ONLNAM
0014�		 JRST ONLOK
0015�	        POPJ P,			;NOT THE ONE WE WANT
    0016�	
  0017�	NOTONL: MOVEI T2,ELMLST		;SEE IF UNIT TO BE IGNORED
 0018�	ELMCHK: HRRZ T2,(T2)
  0019�	        JUMPE T2,ONLOK		;OUT OF UNITS TO IGNORE
0020�	        MOVE T3,RECNAM(PTR)
0021�	        AND T3,ELMMSK(T2)
  0022�	        CAMN T3,ELMNAM(T2)
 0023�	        POPJ P,			;SKIP IT
 0024�	        TLNN FL,FERDSK
0025�	        JRST ELMCHK		;CHECK NEXT
0026�	        MOVE T3,RECID(PTR)      ;FOR DISK CHECK ID ALSO
       0027�	        AND T3,ELMMSK(T2)
  0028�	        CAMN T3,ELMNAM(T2)
 0029�	        POPJ P,
  0030�	        JRST ELMCHK
   0031�	
  0032�	ONLOK:  AOS (P)			;AT LEAST ONE SKIP RETURN
    0033�	        TLZ FL,FERHRD		;RESET HARD ERROR FLAG
  0034�	        PUSHJ P,FNDLNK		;GET A CORE BLOCK FOR UNIT
  0035�	        HRRZ T2,RECDAT(PTR)
0036�	        CAML T2,STRTIM
0037�	        AOS (P)			;A GOOD RECORD
0038�	        POPJ P,         ;SKIP TO HERE IF TOO EARLY
  0039�	
  0040�	COMOP1: PUSHJ P,OPNFIL  ;OPEN OUTPUT FILE IF NEEDED
 0041�	        TRON FL,FLGDAT
0042�	        PUSHJ P,OUTDAT  ;OUTPUT DATE IF NEEDED
                0043�	        OSTR [ASCIZ /
 0044�	/]
0045�	        TLZE FL,FERRST
0046�	        OSTR [ASCIZ /
 0047�	
  0048�	RESTART
0049�	
  0050�	/]
0051�	        HRRZ T4,RECDAT(PTR)
0052�	        PUSHJ P,TIMOUT
0053�	        OCHI 11         ;TAB
    0054�	        POPJ P,
  0055�	
  0056�	COMOPN: PUSHJ P,COMOP1
0057�	        MOVE T3,RECNAM(PTR)
0058�	        JRST OUTSIX
       �  0001�	CORPRM==2       ;STORE PARITY COUNT HERE IN CORE BLOCK
   0002�	CORFND==3       ;COUNT OF NUMBER FOUND HERE
    0003�	
  0004�	PRMCNT==2       ;NUMBER OF INTERUPTS
 0005�	PRMFND==3       ;NUMBER FOUND
                                      0006�	PRMADR==4       ;ADDRESS
   0007�	PRMWRD==5       ;WORD
 0008�	PRMPC==6        ;PC
   0009�	
  0010�	PARERR: MOVSI T1,'APR'
0011�	        EXCH T1,RECNAM(PTR)
0012�	        MOVEM T1,PARIDS#        ;FAKE NAME IN RECNAM FOR COMMON RTNS
    0013�	        TLZ FL,FERDSK
 0014�	        SKIPN SKPERR
  0015�	        PUSHJ P,COMUNI
0016�	         POPJ P,
 0017�	         JRST PARUPD    ;JUST UPDATE
 0018�	        MOVE T2,PARIDS
0019�	        MOVEM T2,RECNAM(PTR)
    0020�	        MOVE T2,PRMCNT(PTR)
0021�	        SUB T2,CORPRM(T1)
  0022�	        JUMPE T2,PARUP1 ;JUST UPDATE IF UNCHANGED
                                 0023�	        JUMPG T2,PARER1 ;GO PRINT
    0024�	PARRST: PUSHJ P,SETRST
0025�	        MOVSI T2,'APR'
0026�	        MOVEM T2,RECNAM(PTR)    ;AGAIN
    0027�	        PUSHJ P,FNDLNK
0028�	        MOVE T2,PARIDS
0029�	        MOVEM T2,RECNAM(PTR)
    0030�	PARER1: PUSHJ P,COMOP1
0031�	        MOVE T2,PRMCNT(PTR)
0032�	        SUB T2,CORPRM(T1)
  0033�	        SKIPE SHTFRM
  0034�	        JRST PARSHT
   0035�	        OSTR [ASCIZ /PARITY ERRORS /]
0036�	        PUSHJ P,OUTDEC
0037�	        MOVE T2,PRMFND(PTR)
0038�	        SUB T2,CORFND(T1)
  0039�	        JUMPLE T2,NOPRF ;SAY NONE FOUND
                                 0040�	        OSTR [ASCIZ /
 0041�	        FOUND /]
 0042�	        PUSHJ P,OUTDEC
0043�	        OSTR [ASCIZ /
 0044�	        LAST ADDRESS /]
    0045�	        MOVE T2,PRMADR(PTR)
0046�	        PUSHJ P,OUTOCT
0047�	        OSTR [ASCIZ /
 0048�	        CONTENTS /]
   0049�	        MOVE T4,PRMWRD(PTR)
0050�	        PUSHJ P,OUTHLF
0051�	        MOVE T4,PRMPC(PTR)
 0052�	        OSTR [ASCIZ /
 0053�	        PC /]
    0054�	        PUSHJ P,OUTHLF
0055�	        OSTR [ASCIZ /
 0056�	/]
0057�	        JRST PARUP1
   0058�	
  0059�	NOPRF:  OSTR [ASCIZ /
 0060�	        NONE FOUND
    0061�	/]
                              0062�	        JRST PARUP1
   0063�	
  0064�	PARUPD: MOVE T1,PARIDS
0065�	        MOVEM T2,RECNAM(PTR)
    0066�	PARUP1: MOVE T2,PRMCNT(PTR)
0067�	        MOVEM T2,CORPRM(T1)
0068�	        MOVE T2,PRMFND(PTR)
0069�	        MOVEM T2,CORFND(T1)
0070�	        POPJ P,
  0071�	
  0072�	PARSHT: OSTR [ASCIZ /PAR. ERR. /]
    0073�	        PUSHJ P,OUTDEC
0074�	        MOVE T2,PRMFND(PTR)
0075�	        SUB T2,CORFND(T1)
  0076�	        OSTR [ASCIZ / FND /]
    0077�	        PUSHJ P,OUTDEC
0078�	        MOVE T2,PRMADR(PTR)
0079�	        OSTR [ASCIZ / LOC /]
    0080�	        PUSHJ P,OUTOCT
                                   0081�	        MOVE T4,PRMWRD(PTR)
0082�	        OSTR [ASCIZ / /]
   0083�	        PUSHJ P,OUTHLF
0084�	        OSTR [ASCIZ /
 0085�	/]
0086�	        JRST PARUP1
       �  0001�	UNIERR: TLO FL,FERDSK
 0002�	        SETZM PRVERR#		;NO SENSE DATA NEEDED IF PRINTING
 0003�	        SKIPN SKPERR
  0004�	        PUSHJ P,COMUNI
0005�	         POPJ P,		;DO NOT KEEP UNIT
  0006�	         JRST UPDUNI		;TOO EARLY
0007�	        MOVE T2,CORID(T1)
  0008�	        JUMPE T2,CHKERR		;MUST BE A NEW ENTRY
  0009�	        CAME T2,RECID(PTR)
 0010�	FRCRST: JRST    [PUSHJ P,SETRST ;SYSTEM RESTARTED JUST BEFORE THIS ENTRY.
              0011�	                PUSHJ P,FNDLNK  ;REFIND UNIT
   0012�	                JRST CHKERR]    ;UNIT CORE BLOCK IS NOW NEW
   0013�	CHKERR: HRRZ T2,RECHRD(PTR)
0014�	        HRRZ T3,CORHRD(T1)
 0015�	        SUB T2,T3
0016�	        JUMPL T2,FRCRST		;CHECK FOR DECREASED ERROR COUNT (RESTART)
0017�	        HLRZ T3,RECHRD(PTR)
0018�	        HLRZ T4,CORHRD(T1)
 0019�	        SUB T3,T4
0020�	        JUMPL T3,FRCRST
    0021�	        ADD T2,T3		;KEEP A TOTAL OF ERRORS
0022�	        SKIPE T2
 0023�		 TLO FL,FERHRD		;HARD ERROR
    0024�	        HRRZ T3,RECSOF(PTR)
0025�	        HRRZ T4,CORSOF(T1)
 0026�	        SUB T3,T4
     0027�	        JUMPL T3,FRCRST
    0028�	        ADD T2,T3
0029�	        HLRZ T3,RECSOF(PTR)
0030�	        HLRZ T4,CORSOF(T1)
 0031�	        SUB T3,T4
0032�	        JUMPL T3,FRCRST
    0033�	        ADD T2,T3
0034�	        JUMPE T2,UPDUNI		;NO ERRORS, JUST PASS OVER IT
   0035�	        SKIPE HRDFLG
  0036�		 TLNE FL,FERHRD
 0037�		  SKIPA
    0038�		   JRST UPDUNI		;IF ONLY WANT HARD ERRORS AND NOT HARD IGNORE
0039�	        SETOM PRVERR		;THERE WAS AN ERROR PRINTED
   0040�	        PUSHJ P,COMOPN		;OPEN OUTPUT
 0041�	        OCHI "("		;UNIT NAME ALREADY PRINTED, PRINT ID
   0042�	        MOVE T3,RECID(PTR)
           0043�	        PUSHJ P,OUTSIX
0044�	        OSTR [ASCIZ /)  /]
     �  0001�	        MOVE T4,RECHRD(PTR)
0002�	        SUB T4,CORHRD(T1)
  0003�	        HLRZ T2,T4
    0004�	        JUMPE T2,NOHDV
0005�	        OSTR [ASCIZ /HDEV /]
    0006�	        PUSHJ P,OUTDEC
0007�	        OCHI " "
 0008�	NOHDV:  HRRZ T2,T4
    0009�	        JUMPE T2,NOHDAT
    0010�	        OSTR [ASCIZ /HDAT /]
    0011�	        PUSHJ P,OUTDEC
0012�	        OCHI " "
 0013�	NOHDAT: MOVE T4,RECSOF(PTR)
0014�	        SUB T4,CORSOF(T1)
  0015�	        HLRZ T2,T4
    0016�	        JUMPE T2,NOSDV
0017�	        OSTR [ASCIZ /SDEV /]
              0018�	        PUSHJ P,OUTDEC
0019�	        OCHI " "
 0020�	NOSDV:  HRRZ T2,T4
    0021�	        JUMPE T2,NOSDAT
    0022�	        OSTR [ASCIZ /SDAT /]
    0023�	        PUSHJ P,OUTDEC
0024�	NOSDAT: OSTR [ASCIZ /
 0025�	        /]
  0026�		MOVE T1,RECNAM(PTR)
  0027�		XOR T1,[SIXBIT/RM/]
  0028�		TLNN T1,777700		;RM03 UNIT?
    0029�		 JRST RMERRS		;YES, DIFFERENT FORMAT.
    0030�	        SKIPN SHTFRM
  0031�		 JRST UNILNG		;PRINT LONG FORM
 0032�	        TLNN FL,FERHRD
0033�		 JRST NOUHER		;NOT HARD ERROR
  0034�	        OSTR [ASCIZ /HCNI /]
    0035�	        MOVE T4,RECHCI(PTR)
0036�	        PUSHJ P,OUTHLF
     0037�	        OSTR [ASCIZ /HDATAI /]
  0038�		MOVE T4,RECHDI(PTR)
  0039�	        PUSHJ P,OUTHLF
0040�	        OSTR [ASCIZ /LBN /]
0041�	        MOVE T2,RECHBN(PTR)
0042�	        PUSHJ P,OUTDEC
0043�	        OSTR [ASCIZ /
 0044�	        /]
      �  0001�	NOUHER: OSTR [ASCIZ /SCNI /]
    0002�	        MOVE T4,RECSCI(PTR)
0003�	        PUSHJ P,OUTHLF
0004�	        OSTR [ASCIZ /SDATAI /]
  0005�	        MOVE T4,RECSDI(PTR)
0006�	        PUSHJ P,OUTHLF
0007�	        OSTR [ASCIZ /RET /]
0008�	        HRRZ T2,RECRET(PTR)
0009�	        PUSHJ P,OUTDEC
0010�	        OSTR [ASCIZ / SLBN /]
                                 0011�	        MOVE T2,RECSBN(PTR)
0012�	        PUSHJ P,OUTDEC
0013�	        OSTR [ASCIZ /
 0014�	/]
0015�	UPDUNI: MOVE T2,RECHRD(PTR)
0016�		MOVEM T2,CORHRD(T1)
  0017�	        MOVE T2,RECSOF(PTR)
0018�	        MOVEM T2,CORSOF(T1)
0019�	        MOVE T2,RECID(PTR)
 0020�	        MOVEM T2,CORID(T1)      ;IN CASE THIS IS THE FIRST TIME
    0021�	        POPJ P,
      �  0001�	UNILNG: MOVSI TYP,-TYPLEN       ;FIND THE UNIT TYPE
 0002�	        HLRZ T2,RECNAM(PTR)
0003�	        TRZ T2,77               ;KEEP FIRST TWO WORDS OF UNIT NAME
 0004�	        CAME T2,TYPTAB(TYP)
0005�	        AOBJN TYP,.-1
                     0006�	        JUMPGE TYP,BANUNT
  0007�	        TLNN FL,FERHRD          ;IS THERE A HARD ERROR?
  0008�	        JRST NOUHLN             ;NO, JUST SOFT
 0009�	        OSTR [ASCIZ /HARD ERROR DATA
 0010�	/]
0011�	        MOVE T4,TYPCNI(TYP)     ;A POINTER TO THE NAMES OF CONI BITS
    0012�	        MOVE T2,RECHCI(PTR)
0013�	        PUSHJ P,OUTBTS
0014�	        MOVE T2,RECHDI(PTR)
0015�	        PUSHJ P,@TYPDTI(TYP)
    0016�	        OSTR [ASCIZ /
 0017�	/]
0018�	        MOVE T2,RECHBN(PTR)
0019�	        PUSHJ P,@TYPBLK(TYP)
    0020�	        OCHI 11
  0021�	NOUHLN: OSTR [ASCIZ /SOFT ERROR DATA
 0022�	/]
               0023�	        MOVE T4,TYPCNI(TYP)
0024�	        MOVE T2,RECSCI(PTR)
0025�	        PUSHJ P,OUTBTS
0026�	        MOVE T2,RECSDI(PTR)
0027�	        PUSHJ P,@TYPDTI(TYP)
    0028�	        MOVE T2,RECSBN(PTR)
0029�	        PUSHJ P,@TYPBLK(TYP)
    0030�	        OSTR [ASCIZ /   NUMBER OF RETRIES /]
   0031�	        HRRZ T2,RECRET(PTR)
0032�	        PUSHJ P,OUTDEC
0033�	        OSTR [ASCIZ /
 0034�	/]
0035�	        JRST UPDUNI
       �  0001�	;RM03 ERROR REPORTING.  SEE CHKPNT&ERRRM FOR DESCRIPTION OF THE TWO
0002�	; RECORDS CONTAINING UDB DATA WRITTEN BY CHKPNT.
                                                           0003�	RMERRS:	SETZM RP06FL#		;FLAG RP06 IF APPROPRIATE.
   0004�		SKIPGE 7(PTR)
   0005�		 SETOM RP06FL
   0005�		MOVSI T2,400000
 0005�		ANDCAM T2,7(PTR)
0006�		TLNN FL,FERHRD		;HARD ERROR?
   0007�		 JRST RMER2
0008�		OSTR [ASCIZ/HARD ERROR DATA.
   0009�	/]
0010�		MOVE T7,[POINT 18,7(PTR)]
 0011�		PUSHJ P,RMREGS		;PRINT REGISTERS.
   0012�		PUSHJ P,RMENXT		;GET SECOND RECORD (CONTAINS LBN)
  0013�		 JRST RMER4		;NONE.
  0014�		SKIPE SHTFRM		;PRINT DISK ADDRESS.
  0015�		 JRST RMER9
0016�		OSTR [ASCIZ/   HARD ERROR DISK ADDRESS= /]
    0017�		MOVE T2,3(PTR)
  0018�		PUSHJ P,RMBLK
   0019�		JRST RMER2A
          0020�	RMER9:	OSTR [ASCIZ/    HLBN = /]
0021�		MOVE T2,3(PTR)
  0022�		PUSHJ P,OUTDEC
  0023�		JRST RMER2A
0024�	RMER2:	PUSHJ P,RMENXT		;HERE TO REPORT SOFT ERROR.
  0025�		 JRST RMER4		;CAN'T GET SECOND RECORD.
   0026�	RMER2A:	OSTR [ASCIZ/SOFT ERROR DATA.
 0027�	/]
0028�		MOVE T7,[POINT 18,6(PTR)]
 0029�		PUSHJ P,RMREGS		;PRINT REGISTERS
    0030�		SKIPE SHTFRM
    0031�		 JRST RMER5
0032�		OSTR [ASCIZ/   SOFT ERROR DISK ADDRESS= /]
    0033�		MOVE T2,4(PTR)
  0034�		PUSHJ P,RMBLK
   0035�		OSTR [ASCIZ/   SOFT ERROR RETRIES= /]
    0036�		HRRZ T2,5(PTR)
  0037�		PUSHJ P,OUTDEC
  0038�		OSTR [BYTE (7) 15,12]
     0039�		JRST UPDUNI
0040�	RMER5:	OSTR [ASCIZ/    SLBN = /]
0041�		MOVE T2,4(PTR)
  0042�		PUSHJ P,OUTDEC
  0043�		OSTR [ASCIZ/    RET = /]
  0044�		HRRZ T2,5(PTR)
  0045�		PUSHJ P,OUTDEC
  0046�		JRST UPDUNI
0047�	
  0048�	;READ IN THE SECOND ERROR RECORD, SKIP IF GOT IT, SINGLE RETURN IF
 0049�	; NOT.
 0050�	RMENXT:	PUSHJ P,GETREC		;GET SECOND ERROR RECORD.
   0051�		 RET			;EOF--OOPS.
   0052�		SKIPL T1,RECDEF(PTR)
 0053�		 JRST RMENXT
    0054�		HRRZS T1
   0055�		CAIN T1,100
0056�		 AOS (P)
   0057�		RET
   0058�	RMER4:	OSTR [ASCIZ/
   0059�	THE SECOND ERROR RECORD IS MISSING.  CONSEQUENTLY, INFORMATION
     0060�	ABOUT SOFT ERRORS AND THE DISK ADDRESS OF HARD ERRORS (IF ANY)
0061�	IS MISSING.
 0062�	/]
0063�		SETOM NOADV		;TELL GETREC HAVE ALREADY READ NEXT RECORD.
0064�		RET
   0065�	
  0066�	;TYPE LBM IN T2 AS RM03/RP06 DISK ADR.
    0067�	RMBLK:	OSTR [ASCIZ/CYLINDER /]
  0068�		MOVE T3,RP06FL
  0069�		IDIV T2,[EXP ^D380,^D148]+1(T3)
0070�		PUSH P,T3
  0071�		PUSHJ P,DEC3
    0072�		OSTR [ASCIZ/, HEAD /]
0073�		POP P,T2
   0074�		MOVE T3,RP06FL
  0075�		IDIV T2,[EXP ^D20,^D30]+1(T3)
  0076�		PUSH P,T3
  0077�		PUSHJ P,DEC2
    0078�		OSTR [ASCIZ/, SECTOR /]
   0079�		POP P,T2
   0080�		PUSHJ P,DEC2
              0081�		RET
   0082�	
  0083�	RMREGS:	SKIPN RP06FL
  0084�		 SKIPA T5,[-3,,RMREGT]
    0085�		  MOVE T5,[-3,,RPREGT]
    0086�	RMREG1:	SKIPN (T5)		;LAST REGISTER?
  0087�		 RET
  0088�		ILDB T6,T7
 0089�		PUSHJ P,RMTR		;TYPE REGISTER CONTENTS.
   0090�		JRST RMREG1
0091�	;TYPE CONTENTS (T6) OF REGISTER WHOSE TABLE INDEX IS IN T5.
   0092�	;IF SHTFRM IS OFF, PRINT OUT THE BITS IN LONG FORM (I.E. NAME THEM).
    0092�	RMTR:	PUSH P,T5
  0092�		MOVE T3,(T5)
    0092�		TLNN T3,-1		;INDIRECT ENTRY?
   0092�		 MOVE T5,T3
0093�		HRRZ T3,(T5)
    0094�		OSTR (T3)
  0095�		OSTR [ASCIZ/ (1,,/]	;PRINT REGISTER ADDRESS
        0096�		HLRZ T2,(T5)
    0097�		PUSHJ P,OUTOCT
  0098�		OSTR [ASCIZ/), /]
    0099�		MOVE T2,T6
 0100�		PUSHJ P,OUTOCT		;CONTENTS OF REGISTER IN OCTAL
0101�		SKIPE SHTFRM
    0102�		 JRST RMTR1
0103�		PUSHJ P,RMBITS		;IN LONG FORM, NAME THE BITS.
 0104�		AOBJN T5,.+1
    0105�	RMTR2:	OSTR [BYTE (7) 15,12]
    0106�		HRLI T5,-3
 0106�	RMTR3:	POP P,T3
  0106�		HRRI T5,1(T3)
   0107�		RET
   0108�	RMTR1:	AOBJP T5,RMTR2
 0109�		OSTR [ASCIZ/, /]
0110�		JRST RMTR3
 0111�	;TYPE CONTENTS OF T6 AS BIT NAMES FOR REGISTER WHOSE TABLE INDEX IS IN T5.
   0112�	RMBITS:	MOVE T2,(T5)
  0113�		AOJ T2,
                             0114�		MOVE T3,(T2)
    0114�		TRNE T6,177777
  0115�		CAMN T3,[-1]
    0116�		 RET
  0117�		OSTR [ASCIZ/ = /]
    0118�		PUSH P,[20]
0119�		PUSH P,[-1]
0120�		MOVE T3,[POINT 1,T6,19]
   0121�	RMB1:	ILDB T1,T3
 0122�		JUMPE T1,RMB2
   0123�		AOSE (P)
   0124�		 OCHI "+"
  0125�		OSTR (T2)
  0126�	RMB2:	SOSLE -1(P)
0127�		 AOJA T2,RMB1
   0128�		SUB P,[2,,2]
    0129�		RET
   0130�	;PROCEEDING SEQUENTAILLY THROUGH EITHER REGISTER TABLE,
  0131�	; THE DEVICE DRIVER SAVES HALFWORDS IN THE UDB, WHICH ARE
0132�	; COPIED BY CHKPNT INTO THE ACCOUNTING FILE.
   0133�	DEFINE IOREG(NAME,ADR,SAME,BITS)<
                   0133�	IF1 <BLOCK 1>
    0133�	IF2, <
 0134�	IFDEF NAME'DEF,<ZZ==1>
0135�	IFNDEF NAME'DEF,<ZZ==0>
    0136�	IFN ZZ&SAME,<0,,NAME'DEF>
  0137�	IFE ZZ&SAME,<
    0137�	NAME'DEF==.
 0138�		ADR,,<[<ASCIZ\NAME\>
 0139�	       IFB <BITS>,<-1>
0140�	       IFNB <BITS>,<IRP BITS,<<ASCIZ\BITS\>>>
  0141�	      ]>>
   0142�	>>
0143�	RMREGT:
0144�	IOREG (CS1,776700,1,<SC,TRE,MCPE,12,DVA,PSEL,A17,A16,RDY,IE,F4,F3,F2,F1,F0,GO>)
   0145�	IOREG (CS2,776710,1,<DLT,WCE,UPE,NED,NEM,PGE,MXF,MDPE,OR,IR,CLR,PAT,BAI,U2,U1,U0>)
0146�	IOREG (ER1,776714,1,<DCK,UNS,OPI,DTE,WLE,IAE,AOE,HCRC,HCE,ECH,WCF,FER,PAR,RMR,ILR,ILF>)
                    0147�	IOREG (ER2,776742,0,<BSE,SKI,OPE,IVC,LSC,LBC,9,8,DVC,6,5,4,DPE,2,1,0>)
  0148�	IOREG (WC,776702,1)
   0149�	IOREG (DS,776712,0,<ATA,ERR,PIP,MOL,WRL,LBT,PGM,DPR,DRY,VV,5,4,3,2,1,OM>)
    0150�	IOREG (BA,776704,1)
   0151�	IOREG (AS,776716,1)
   0152�	IOREG (LA,776720,1)
   0153�	IOREG (EC2,776746,1)
  0154�	IOREG (MR1,776724,0,<OCC,RG,EBL,REX,ESRC,PLFS,ECRC,PDA,PHA,CONT,WC,EECC,WD,LS,LST,DMD>)
0155�	IOREG (DT,776726,0,<15,14,MOH,12,DRQ,10,9,DT8,DT7,DT6,DT5,DT4,DT3,DT2,DT1,DT0>)
   0156�	IOREG (SN,776730,1)
   0157�	IOREG (OF,776732,0,<15,14,13,FMT,ECI,HCI,9,8,OD,6,5,4,3,2,1,0>)
    0158�	IOREG (DC,776734,1)
        0159�	IOREG (MR2,776740,0,<RQA,RQB,TAG,TES,CIC,CIH,BB9,BB8,BB7,BB6,BB5,BB4,BB3,BB2,BB1,BB0>)
 0160�	IOREG (DA,776706,1)
   0161�	IOREG (EC1,776744,1)
  0162�		0
0163�	
  0164�	RPREGT:
0165�	IOREG (CS1,776700,1)
  0166�	IOREG (CS2,776710,1)
  0167�	IOREG (ER1,776714,1)
  0168�	IOREG (ER3,776742,0,<OCYL,SKI,OPE,12,11,10,9,8,7,ACL,DCL,35V,3,2,WAO,DCU>)
   0169�	IOREG (WC,776702,1)
   0170�	IOREG (DS,776712,0,<ATA,ERR,PIP,MOL,WRL,LST,PGM,DPR,DRY,VV,5,4,3,2,1,0>)
0171�	IOREG (BA,776704,1)
   0172�	IOREG (DA,776706,1)
   0173�	IOREG (AS,776716,1)
   0174�	IOREG (LA,776720,1)
                                                0175�	IOREG(MR,776724,0,<15,14,13,12,11,10,SBD,8,DEN,ECCE,MWR,MRD,MSCLK,MIND,MCLK,DMD>)
 0176�	IOREG (OF,776732,0,<SGCH,14,13,FMT,ECCI,HCI,9,8,OF7,OF6,OF5,OF4,OF3,OF2,OF1,OF0>)
 0177�	IOREG (SN,776730,1)
   0178�	IOREG (DC,776734,1)
   0179�	IOREG (CC,776736,0)
   0179�	IOREG (ER2,776740,0,<15,14,PLU,12,IXE,NHS,MHS,WRU,ABS,TUF,TDF,RAW,CSU,WSU,CSF,WCU>)
    0179�	IOREG (EC1,776744,1)
  0180�	IOREG (EC2,776746,1)
  0183�		0
0193�	
  0203�	;2020 TU45 REGISTERS.
 0213�	M20RT:
 0223�	IOREG(CS1,772440,0,<SC,TRE,MCPE,12,DVA,PSEL,A17,A16,RDY,IE,F4,F3,F2,F1,F0,GO>)
    0233�	IOREG(WC,772442,0)
                                  0243�	IOREG(BA,772444,0)
    0253�	IOREG(FC,772446,0)
    0263�	IOREG(CS2,772450,0,<DLT,WCE,UPE,NED,NEM,PGE,MXF,MDPE,OR,IR,CLR,PAT,BAI,U2,U1,U0>)
 0273�	IOREG(DS,772452,0,<ATA,ERR,PIP,MOL,WRL,EOT,9,DPR,DRY,SSC,PES,SDWN,IOB,TM,BOT,SLA>)
0283�	IOREG(ER,772454,0,<COR,UNS,OPI,DTE,NEF,CS,FCE,NSG,PEF,INC,DPAR,FMT,CPAR,RMR,ILR,ILF>)
  0293�	IOREG(AS,772456,0)
    0303�	IOREG(CK,772460,0)
    0313�	IOREG(DB,772462,0)
    0323�	IOREG(M2,772464,0,<MD8,MD7,MD6,MD5,MD4,MD3,MD2,MD1,MD0,2BC,MC,MO3,MO2,MO1,MO0,MM>)
0333�	IOREG(DT,772466,0,<NSA,TAP,MOH,7CH,DRQ,SPR,9,DT8,DT7,DT6,DT5,DT4,DT3,DT2,DT1,DT0>)
0343�	IOREG(SN,772470,0)
         0353�	IOREG(TC,772472,0,<ACC,TCW,FCS,EOA,11,DE2,DE1,DE0,FS3,FS2,FS1,FS0,EP,SS2,SS1,SS0>)
0363�		0
    �  0001�	;HERE IS THE DISPATCH INFORMATION FOR THE UNITS
0002�	
  0003�	TYPTAB: 'FH '
    0004�	        'DP '
    0005�	        'BP '
    0006�	TYPLEN==.-TYPTAB
 0007�	
  0008�	BANUNT: OSTR [ASCIZ /
 0009�	CAN NOT FIND UNIT TYPE
0010�	/]
0011�	        JRST UPDUNI
   0012�	
  0013�	TYPCNI: EXP FHCNI,DPCNI,BPCNI
   0014�	TYPDTI: EXP FHDTI,DPDTI,BPDTI
   0015�	TYPBLK: EXP FHBLK,DPBLK,BPBLK
   0016�	
  0017�	        DEFINE AQ (A)
 0018�	<[ASCIZ ^A^]>
    0019�	
  0020�	FHCNI:  REPEAT ^D18,<0>
                   0021�	        AQ <CHANNEL TERMINATE ERROR>
 0022�	        AQ <SEARCH ERROR>
  0023�	        AQ <UNIT ERROR>
    0024�	        AQ <TRACK ERROR>
   0025�	        AQ <NOT READY>
0026�	        AQ <POWER FAILURE>
 0027�	        AQ <DEVICE PAIRTY ERROR>
0028�	        AQ <DATA PARITY ERROR>
  0029�	        AQ <CONTROL WORD PARITY ERROR>
    0030�	        AQ <NO SUCH MEMORY>
0031�	        AQ <ILLEGAL WRITE>
 0032�	        AQ <DATA LATE>
0033�	        REPEAT 6,<0>
  0034�	
  0035�	DPCNI:  REPEAT ^D14,<0>
    0036�	        AQ <CONTROL WORD PARITY ERROR>
    0037�	        AQ <SECTOR PARITY ERROR>
                              0038�	        AQ <CHANNEL DATA PARITY ERROR>
    0039�	        AQ <DISK WORD PARITY ERROR>
  0040�	        AQ <CHANNEL TERMINATE ERROR>
 0041�	        AQ <END OF CYLINDER>
    0042�	        AQ <POWER FAILURE>
 0043�	        AQ <SEARCH ERROR>
  0044�	        AQ <DATA LATE>
0045�	        AQ <NO SUCH MEMORY>
0046�	        0
   0047�	        AQ <NOT READY>
0048�	        AQ <ILLEGAL WRITE>
 0049�	        AQ <ILLEGAL DATAO>
 0050�	        AQ <SECTOR ADDRESS ERROR>
    0051�	        AQ <SURFACE ADDRESS ERROR>
   0052�	        REPEAT 6,<0>
      �  0001�	BPCNI:  REPEAT ^D9,<0>
0002�	        AQ <WRITE PROTECT ERROR>
     0003�	        AQ <SELECT ERROR>
  0004�	        AQ <CONTROL ERROR>
 0005�	        AQ <LENGTH ERROR>
  0006�	        AQ <EQUIPMENT CHECK>
    0007�	        AQ <PERMANENT EQUIPMENT CHECK>
    0008�	        AQ <UNIT EXCEPTION>
0009�	        AQ <ATTENTION FLAG>
0010�	        AQ <BUSY>
0011�	        AQ <COUNT ERROR>
   0012�	        AQ <UNRECOVERABLE DATA CHECK>
0013�	        AQ <RECOVERABLE DATA CHECK>
  0014�	        AQ <INVALID TRACK FORMAT>
    0015�	        AQ <SEARCH ERROR>
  0016�	        AQ <CORE PARITY ERROR>
  0017�	        AQ <NO SUCH MEMORY>
0018�	        AQ <DATA LATE>
0019�	        AQ <UNKNOWN ERROR>
      0020�	        AQ <PROTECTION FAILURE>
 0021�	        AQ <BUS IN PARITY ERROR>
0022�	        AQ <BUS OUT PARITY ERROR>
    0023�	        AQ <COMMAND REJECT>
0024�	        REPEAT 5,<0>
  0025�	
  0026�	OUTBTS: JFFO T2,.+2		;LOOK FOR A BIT
 0027�	        POPJ P,			;DONE
    0028�	        LSH T2,1(T3)		;SHIFT OFF END
 0029�	        ADD T4,T3		;INCREMENT POINTER
0030�	        SKIPN (T4)
    0031�	        AOJA T4,OUTBTS		;IGNORE IF 0
 0032�	        OSTR [ASCIZ /     /]
    0033�	        OSTR @(T4)		;TELL WHAT BIT MEANS
  0034�	        OSTR [ASCIZ /
 0035�	/]
0036�	        AOJA T4,OUTBTS
0037�	
                           0038�	DPBLK:  IDIVI T2,^D200		;GET CYLINDER IN T2
    0039�	        PUSH P,T3
0040�	        OSTR [ASCIZ /     CYLINDER /]
0041�	        PUSHJ P,DEC4
  0042�	        OSTR [ASCIZ / HEAD /]
   0043�	        POP P,T2
 0044�	        IDIVI T2,^D10
 0045�	        PUSH P,T3
0046�	        PUSHJ P,DEC2
  0047�	        OSTR [ASCIZ / RECORD /]
 0048�	        POP P,T3
 0049�	        PUSHJ P,DEC2
  0050�	        OSTR [ASCIZ /
 0051�	/]
0052�	        POPJ P,
      �  0001�	DPDTI:  PUSH P,T2
0002�	        OSTR [ASCIZ /     DRIVE /]
   0003�	        LDB T2,[POINT 3,(P),2]
  0004�	        PUSHJ P,OUTDEC
                         0005�	        OSTR [ASCIZ / CYLINER /]
0006�	        LDB T2,[POINT 8,(P),10]
 0007�	        MOVEI T3,1B23
 0008�	        TDNE T3,(P)
   0009�	        TRO T2,400
    0010�	        PUSHJ P,OUTDEC
0011�	        OSTR [ASCIZ / SECTOR COUNTER /]
   0012�	        LDB T2,[POINT 5,(P),22]
 0013�	        PUSHJ P,OUTDEC
0014�	        OSTR [ASCIZ /
 0015�	/]
0016�	        MOVEI T4,DPDTTB
    0017�	        POP P,T2
 0018�	        JRST OUTBTS
   0019�	
  0020�	DPDTTB: REPEAT ^D11,<0>
    0021�	        AQ <POSITION FAILURE>
   0022�	        AQ <HEADS IN POSITION>
  0023�	        AQ <DISK ON LINE>
                                0024�	        AQ <FILE UNSAFE>
   0025�	        AQ <NO SUCH DRIVE>
 0026�	        AQ <READ ONLY>
0027�	        AQ <WRITE HEADER LOCKOUT>
    0028�	        REPEAT ^D9,<0>
0029�	        AQ <ATTN 0>
   0030�	        AQ <ATTN 1>
   0031�	        AQ <ATTN 2>
   0032�	        AQ <ATTN 3>
   0033�	        AQ <ATTN 4>
   0034�	        AQ <ATTN 5>
   0035�	        AQ <ATTN 6>
   0036�	        AQ <ATTN 7>
   0037�	        0
   0038�	
  0039�	FHBLK:  IDIVI T2,^D40
 0040�	        PUSH P,T3
0041�	        OSTR [ASCIZ /     TRACK /]
   0042�	        PUSHJ P,DEC4
  0043�	        POP P,T2
 0044�	        LSH T2,1
                0045�	        OSTR [ASCIZ / SECTOR /]
 0046�	        PUSHJ P,DEC2
  0047�	        OSTR [ASCIZ /
 0048�	/]
0049�	        POPJ P,
      �  0001�	FHDTI:  PUSH P,T2
0002�	        LDB T2,[POINT 6,(P),23]
 0003�	        OSTR [ASCIZ /     PARITY REGISTER /]
   0004�	                PUSHJ P,OUTOCT
  0005�	        OSTR [ASCIZ / UNIT /]
   0006�	        LDB T2,[POINT 2,(P),27]
 0007�	        PUSHJ P,OUTDEC
0008�	        OSTR [ASCIZ / SECTOR /]
 0009�	        LDB T2,[POINT 4,(P),31]
 0010�	        SKIPE T2
 0011�	        PUSHJ P,OUTDEC
0012�	        POP P,T2
 0013�	        ANDI T2,17
    0014�	        PUSHJ P,OUTDEC
     0015�	        OSTR [ASCIZ /
 0016�	/]
0017�	        POPJ P,
  0018�	
  0019�	BPBPT==^D<18*19-2>      ;BLOCKS PER TRACK ON 230
    0020�	
  0021�	BPBLK:  IDIVI T2,BPBPT
0022�	        PUSH P,T3
0023�	        OSTR [ASCIZ /     CYLINDER /]
0024�	        PUSHJ P,DEC4
  0025�	        POP P,T2
 0026�	        IDIVI T2,^D18
 0027�	        PUSH P,T3
0028�	        OSTR [ASCIZ / HEAD /]
   0029�	        PUSHJ P,DEC2
  0030�	        OSTR [ASCIZ / RECORD /]
 0031�	        POP P,T2
 0032�	        ADDI T2,1
0033�	        PUSHJ P,DEC2
  0034�	        MOVE T2,BPDTSV
0035�	        TRNE T2,1
0036�	        JRST BPBLK1
             0037�	        PUSH P,T2
0038�	        OSTR [ASCIZ / CONTROL /]
0039�	        LDB T2,[POINT 2,(P),1]
  0040�	        PUSHJ P,OUTDEC
0041�	        OSTR [ASCIZ / DRIVE /]
  0042�	        LDB T2,[POINT 6,(P),7]
  0043�	        MOVSI T3,-10
  0044�	DRVLPF: CAMN T2,[EXP 70,61,52,43,34,25,16,7](T3)
    0045�	        JRST DRVLP1
   0046�	        AOBJN T3,DRVLPF
    0047�	        OSTR [ASCIZ /UNKNOWN/]
  0048�	        SKIPA
    0049�	DRVLP1: OCHI "A"(T3)
  0050�	        POP P,T2
 0051�	BPBLK1: OSTR [ASCIZ /
 0052�	/]
0053�	        POPJ P,
      �  0001�	BPDTI:  MOVEM T2,BPDTSV#        ;SAVE DATAI
                        0002�	        CAMN T2,[-1]
  0003�	        JRST    [OSTR [ASCIZ /  NO SENSE DATA
  0004�	/]
0005�	                POPJ P,]
   0006�	        TRNE T2,1
0007�	        JRST MEMSNS     ;MEMORY SENSE DATA
0008�	        PUSH P,T2
0009�	        LDB T2,[POINT 4,(P),27]
 0010�	        JRST @[EXP FMT0,FMT1,FMT2,FMT3,FMT4,FMT5,FMT6
    0011�	                REPEAT 11,<FMTU>](T2)
0012�	
  0013�	FMTU:   OSTR [ASCIZ /     UNKNOWN MESSAGE/]
    0014�	FMTC:   OSTR [ASCIZ /
 0015�	/]
0016�	        POP P,T2
 0017�	        POPJ P,
  0018�	
  0019�	FMT0:   OSTR [ASCIZ /     PROGRAM ERROR OR SYSTEM CHECK
  0020�	          /]
          0021�	        LDB T2,[POINT 4,(P),31]
 0022�	        OSTR @FMT0T(T2)
    0023�	        JRST FMTC
0024�	
  0025�	FMT0T:  AQ <NO MESSAGE>
    0026�	        AQ <INVALID COMMAND>
    0027�	        AQ <INVALID SEQUENCE>
   0028�	        AQ <CCW COUNT LESS THAN REQUIRED>
 0029�	        AQ <DATA VALUE NOT AS REQUIRED>
   0030�	        AQ <DIAGNOSTIC WRITE NOT PERMITTED>
    0031�	        AQ <CHANNEL DISCONTINUED RETRY>
   0032�	        AQ <CHANNEL RETURNED WITH INCORRECT RETRY CCW>
   0033�	        AQ <23FD - NOT READY>
   0034�	        AQ <23FD - HARD SEEK CHECK>
  0035�	        AQ <23FD HARD READ CHECK>
                   0036�	        AQ <IMPROPER DEFFECTIVE TRACK POINTER>
 0037�	        AQ <SERDES MALFUNCTION - NO ST 4'S>
    0038�	        AQ <DIAGNOSTIC WRITE CONTROL CODE MISMATCH>
 0039�	        AQ <CONTROL STORAGE BUSY WITH MICRODIAGNOSTIC>
   0040�	        AQ <RETRY BYTE COUNT/SECTOR VALUE INCORRECT>
    �  0001�	FMT1:   OSTR [ASCIZ /     DISK DRIVE EQUIPMENT CHECK
0002�	          /]
0003�	        LDB T2,[POINT 4,(P),31]
 0004�	        OSTR @FMT1T(T2)
    0005�	        JRST FMTC
0006�	
  0007�	FMT1T:  AQ <NO MESSAGE>
    0008�	        AQ <SET TARGET ERROR>
   0009�	        AQ <NOT USED>
                                         0010�	        AQ <NO WRITE GATE AT DRIVE>
  0011�	        AQ <NO WRITE CURRENT SENSE>
  0012�	        AQ <NOT USED>
 0013�	        AQ <TRANSMIT CYLINDER ERROR>
 0014�	        AQ <TRANSMIT HEAD ERROR>
0015�	        AQ <TRANSMIT DIFFERENCE ERROR>
    0016�	        AQ <FILE STATUS NOT AS EXPECTED>
  0017�	        AQ <SEEK ERROR>
    0018�	        AQ <SEEK INCOMPLETE ON RETRY>
0019�	        AQ <NO INTERRUPT FROM DRIVE>
 0020�	        REPEAT 3,<AQ <NOT USED>>
0021�	
  0022�	FMT2:   OSTR [ASCIZ /     STORAGE CONTROL EQUIPMENT CHECK
0023�	          /]
0024�	        LDB T2,[POINT 4,(P),31]
                                    0025�	        OSTR @FMT2T(T2)
    0026�	        JRST FMTC
0027�	
  0028�	FMT2T:  AQ <NO MESSAGE>
    0029�	        AQ <ECC P1 OR P3 COMPARE FAILURE>
 0030�	        AQ <ECC P2 COMPARE FAILURE>
  0031�	        REPEAT 15,<AQ <NOT USED>>
        �  0001�	FMT3:   OSTR [ASCIZ /     STORAGE CONTROL - CONTROL CHECK
0002�	          /]
0003�	        LDB T2,[POINT 4,(P),31]
 0004�	        OSTR @FMT3T(T2)
    0005�	        JRST FMTC
0006�	
  0007�	FMT3T:  AQ <NO MESSAGE>
    0008�	        REPEAT 17,<AQ <NOT USED>>
    0009�	
  0010�	FMT4:   OSTR [ASCIZ /     DATA CHECK WITHOUT DISPLACEMENT
0011�	          /]
               0012�	        LDB T2,[POINT 4,(P),31]
 0013�	        OSTR @FMT4T(T2)
    0014�	        JRST FMTC
0015�	
  0016�	FMT4T:  AQ <HA FIELD ECC UNCORRECTABLE>
   0017�	        AQ <COUNT FIELD ECC UNCORRECTABLE>
0018�	        AQ <KEY FIELD ECC UNCORRECTABLE>
  0019�	        AQ <DATA FIELD ECC UNCORRECTABLE>
 0020�	        AQ <HA FIELD NO SYNC BYTE FOUND>
  0021�	        AQ <COUNT FIELD NO SYNC BYTE FOUND>
    0022�	        AQ <KEY FIELD NO SYNC BYTE FOUND>
 0023�	        AQ <DATA FIELD NO SYNC BYTE FOUND>
0024�	        AQ <NOT USED>
 0025�	        AQ <AM DETECTION FAILURE ON RETRY>
0026�	        REPEAT 6,<AQ <NOT USED>>
     0027�	
  0028�	FMT5:   OSTR [ASCIZ /     DATA CHECK WITH DISPLACEMENT
   0029�	          /]
0030�	        LDB T2,[POINT 4,(P),31]
 0031�	        OSTR @FMT5T(T2)
    0032�	        JRST FMTC
    �  0001�	FMT5T:  AQ <HA FIELD CORRECTABLE>
    0002�	        AQ <COUNT FIELD CORRECTABLE>
 0003�	        AQ <KEY FIELD CORRECTABLE>
   0004�	        AQ <DATA FIELD CORRECTABLE>
  0005�	        REPEAT 14,<AQ <NOT USED>>
    0006�	
  0007�	FMT6:   OSTR [ASCIZ %     USAGE/ERROR STATISTICS%]
  0008�	        JRST FMTC
0009�	
  0010�	MEMSNS: OSTR [ASCIZ /     MEMORY ERROR LOCATION /]
  0011�	        PUSH P,T2
                    0012�	        LDB T2,[POINT 22,(P),24]
0013�	        PUSHJ P,OUTOCT
0014�	        OSTR [ASCIZ / BIT /]
    0015�	        LDB T2,[POINT 6,(P),30]
 0016�	        PUSHJ P,OUTDEC
0017�	        JRST FMTC
    �  0010�	;2020 TAPE ERROR REPORTING.
0030�	M20ERR:	TLZ FL,FERDSK
 0040�		SKIPN SKPERR
    0050�		PUSHJ P,COMUNI
  0060�		 POPJ P,	;NOT INTERESTED IN THIS UNIT
    0070�		 JRST M20UPD    ;JUST UPDATE INFORMATION
 0080�		MOVE T2,5(PTR)     ;COUNT FROM POINTER
   0090�		SUB T2,CORCNT(T1)
    0100�		JUMPN T2,M20OK0
 0110�		MOVE T3,4(PTR)
  0120�		SUB T3,CORHNG(T1)
                                                      0130�		JUMPE T3,CPOPJ		;NO CHANGE IN HUNG OR ERROR COUNT.
 0140�	M20OK0:	JUMPLE T2,M20RST	 ;<0 => RESTART BETWEEN RECORDS.
0150�		JUMPG T3,M20OK1
 0160�	M20RST: JRST    [PUSHJ P,SETRST
 0170�			PUSHJ P,FNDLNK
 0180�			JRST M20OK1]
   0190�	M20OK1:	MOVE T2,5(PTR)
0200�		SUB T2,CORCNT(PTR)
   0210�		SKIPE T2
   0220�		 TLO FL,FERHRD
  0230�		SKIPE HRDFLG
    0240�		 TLNE FL,FERHRD
 0250�		  SKIPA
    0260�		   JRST M20UPD     ;WANT ONLY HARD ERRORS
0270�		PUSHJ P,COMOPN		;SETUP OUTPUT FILE.
 0290�		MOVE T2,4(PTR)
  0291�		SUB T2,CORHNG(T1)
    0300�		OSTR [ASCIZ/
    0310�	HUNG COUNT = /]
                           0310�		PUSHJ P,OUTDEC
  0311�		OSTR [ASCIZ/; DEVICE ERRORS = /]
    0311�		MOVE T2,5(PTR)
  0312�		SUB T2,CORCNT(T1)
    0312�		PUSHJ P,OUTDEC
  0313�		OSTR [BYTE (7) 15,12]
0313�		SKIPE SHTFRM
    0314�		 JRST M20UPD
    0314�		OSTR [ASCIZ/
    0315�	DEVICE REGISTERS ON MOST RECENT ERROR.
    0315�	/]
0316�		MOVE T5,[-3,,M20RT]
  0316�		MOVE T7,[POINT 18,6(PTR)]
 0316�		PUSHJ P,RMREG1
  0320�		POPJ P,
    0330�	M20UPD:	DMOVE T2,4(PTR)
    0340�		MOVEM T2,CORHNG(T1)
  0350�		MOVEM T3,CORCNT(T1)
  0360�		POPJ P,
        �  0001�	MTAERR: TLZ FL,FERDSK
 0002�	        SKIPN SKPERR
                                0003�	        PUSHJ P,COMUNI
0004�	         POPJ P,        ;NOT INTERESTED IN THIS UNIT
0005�	         JRST MTAUPD    ;JUST UPDATE INFORMATION
    0006�	        MOVE T2,REMCNT(PTR)     ;COUNT FROM POINTER
 0007�	        SUB T2,CORCNT(T1)
  0008�	        JUMPE T2,CPOPJ  ;NO INFORMATION
   0009�	        JUMPG T2,MTAOK1         ;OK
  0010�	MTARST: JRST    [PUSHJ P,SETRST
 0011�	                PUSHJ P,FNDLNK
  0012�	                JRST MTAOK1]
    0013�	MTAOK1: MOVE T2,REMWFL(PTR)
0014�	        SUB T2,CORWFL(T1)
  0015�	        JUMPL T2,MTARST
    0016�	        MOVE T3,REMRFL(PTR)
0017�	        SUB T3,CORRFL(T1)
       0018�	        JUMPL T3,MTARST
    0019�	        ADD T2,T3
0020�	        SKIPE T2
 0021�	        TLO FL,FERHRD   ;CALL IT A HARD ERROR
  0022�	        MOVE T3,REMWRT(PTR)
0023�	        SUB T3,CORWRT(T1)
  0024�	        JUMPL T3,MTARST
    0025�	        MOVE T3,REMWOK(PTR)
0026�	        SUB T3,CORWOK(T1)
  0027�	        JUMPL T3,MTARST
    0028�	        MOVE T3,REMROK(PTR)
0029�	        SUB T3,CORROK(T1)
  0030�	        JUMPL T3,MTARST
    0031�	        SKIPE HRDFLG
  0032�	        TLNE FL,FERHRD
0033�	        SKIPA
    0034�	        JRST MTAUPD     ;WANT ONLY HARD ERRORS
                                              0035�	        PUSHJ P,COMOPN  ;OPEN OUTPUT AND GENERATE NAME
       �  0001�	        MOVE T2,REMCNT(PTR)
0002�	        SUB T2,CORCNT(T1)
  0003�	        SKIPN SHTFRM
  0004�	        JRST MTALNG
   0005�	        OSTR [ASCIZ / ERRS /]
   0006�	        PUSHJ P,OUTDEC
0007�	        MOVE T2,REMWRT(PTR)
0008�	        SUB T2,CORWRT(T1)
  0009�	        JUMPE T2,MTR1
 0010�	        OSTR [ASCIZ / WRT /]
    0011�	        PUSHJ P,OUTDEC
0012�	MTR1:   MOVE T2,REMWOK(PTR)
0013�	        SUB T2,CORWOK(T1)
  0014�	        JUMPE T2,MTR2
 0015�	        OSTR [ASCIZ / WRT OK /]
 0016�	        PUSHJ P,OUTDEC
                         0017�	MTR2:   MOVE T2,REMWFL(PTR)
0018�	        SUB T2,CORWFL(T1)
  0019�	        JUMPE T2,MTR3
 0020�	        OSTR [ASCIZ / WRT FL /]
 0021�	        PUSHJ P,OUTDEC
0022�	MTR3:   MOVE T2,REMROK(PTR)
0023�	        SUB T2,CORROK(T1)
  0024�	        JUMPE T2,MTR4
 0025�	        OSTR [ASCIZ / RD OK /]
  0026�	        PUSHJ P,OUTDEC
0027�	MTR4:   MOVE T2,REMRFL(PTR)
0028�	        SUB T2,CORRFL(T1)
  0029�	        JUMPE T2,MTR5
 0030�	        OSTR [ASCIZ / RD FL /]
  0031�	        PUSHJ P,OUTDEC
0032�	MTR5:   OSTR [ASCIZ /
 0033�	        CONI /]
  0034�	        MOVE T4,REMCNI(PTR)
0035�	        PUSHJ P,OUTHLF
          0036�	        OSTR [ASCIZ /
 0037�	/]
0038�	MTAUPD: MOVE T2,REMCNT(PTR)
0039�	        MOVEM T2,CORCNT(T1)
0040�	        MOVE T2,REMWRT(PTR)
0041�	        MOVEM T2,CORWRT(T1)
0042�	        MOVE T2,REMWFL(PTR)
0043�	        MOVEM T2,CORWFL(T1)
0044�	        MOVE T2,REMWOK(PTR)
0045�	        MOVEM T2,CORWOK(T1)
0046�	        MOVE T2,REMROK(PTR)
0047�	        MOVEM T2,CORROK(T1)
0048�	        MOVE T2,REMRFL(PTR)
0049�	        MOVEM T2,CORRFL(T1)
0050�	        POPJ P,
      �  0001�	MTALNG: OSTR [ASCIZ / NUMBER OF ERRORS /]
 0002�	        PUSHJ P,OUTDEC
0003�	        MOVE T2,REMWRT(PTR)
                              0004�	        SUB T2,CORWRT(T1)
  0005�	        JUMPE T2,MTAL1  ;NO REWRITES
 0006�	        OSTR [ASCIZ /
 0007�	        WRITE RETRYS, NUMBER /]
 0008�	        PUSHJ P,OUTDEC
0009�	        MOVE T2,REMWOK(PTR)
0010�	        SUB T2,CORWOK(T1)
  0011�	        JUMPE T2,MTAL2
0012�	        OSTR [ASCIZ / SUCCESSFUL /]
  0013�	        PUSHJ P,OUTDEC
0014�	MTAL2:  MOVE T2,REMWFL(PTR)
0015�	        SUB T2,CORWFL(T1)
  0016�	        JUMPE T2,MTAL1
0017�	        OSTR [ASCIZ / FAILED /]
 0018�	        PUSHJ P,OUTDEC
0019�	MTAL1:  MOVE T2,REMROK(PTR)
0020�	        ADD T2,REMRFL(PTR)
 0021�	        SUB T2,CORROK(T1)
            0022�	        SUB T2,CORRFL(T1)
  0023�	        JUMPE T2,MTAL3
0024�	        OSTR [ASCIZ /
 0025�	        READ RETRYS, NUMBER /]
  0026�	        PUSHJ P,OUTDEC
0027�	        MOVE T2,REMROK(PTR)
0028�	        SUB T2,CORROK(T1)
  0029�	        JUMPE T2,MTAL4
0030�	        OSTR [ASCIZ / SUCCESSFUL /]
  0031�	        PUSHJ P,OUTDEC
0032�	MTAL4:  MOVE T2,REMRFL(PTR)
0033�	        SUB T2,CORRFL(T1)
  0034�	        JUMPE T2,MTAL3
0035�	        OSTR [ASCIZ / FAILED /]
 0036�	        PUSHJ P,OUTDEC
0037�	MTAL3:  OSTR [ASCIZ /
 0038�	        CONI
0039�	/]
0040�	        MOVEI T4,MTACNI
                                       0041�	        MOVE T2,REMCNI(PTR)
0042�	        PUSHJ P,OUTBTS
0043�	        OSTR [ASCIZ /
 0044�	/]
0045�	        JRST MTAUPD
       �  0001�	MTACNI: REPEAT ^D11,<0>
    0002�	        AQ <CONTROL WORD PARITY ERROR>
    0003�	        AQ <NO SUCH MEMORY>
0004�	        AQ <DATA PARITY ERROR>
  0005�	        REPEAT 4,<0>
  0006�	        AQ <UNIT HUNG>
0007�	        0
   0008�	        0
   0009�	                AQ <ILLEGAL>
    0010�	        AQ <TAPE PARITY ERROR>
  0011�	        AQ <END OF FILE>
   0012�	        0
   0013�	        AQ <READ COMPARE ERROR>
 0014�	        AQ <RECORD LENGTHS DIFFER>
                  0015�	        AQ <DATA LATE>
0016�	        AQ <BAD TAPE>
 0017�	        REPEAT 7,<0>
      �  0001�	FTAERR: TLZ FL,FERDSK
 0002�	        SETZM PRVERR    ;NO SENSE DATA NEEDED
  0003�	        SKIPN SKPERR
  0004�	        PUSHJ P,COMUNI
0005�	         POPJ P,        ;NOT INTERESTED
   0006�	         JRST FTAUPD    ;JUST UPDATE
 0007�	        MOVE T3,REFHNG(PTR)     ;HUNG COUNT
    0008�	        SUB T3,CORHNG(T1)
  0009�	        JUMPL T3,FTARST ;NEEDS RESTART IF NEG
  0010�	        MOVE T2,REFWOK(PTR)
0011�	        SUB T2,CORWOK(T1)
  0012�	        JUMPL T2,FTARST ;WRITE RECOVERYS
  0013�	        ADD T3,T2
          0014�	        MOVE T2,REFWFL(PTR)
0015�	        SUB T2,CORWFL(T1)
  0016�	        JUMPL T2,FTARST
    0017�	        ADD T3,T2
0018�	        MOVE T2,REFROK(PTR)
0019�	        SUB T2,CORROK(T1)
  0020�	        JUMPL T2,FTARST
    0021�	        ADD T3,T2
0022�	        MOVE T2,REFRFL(PTR)
0023�	        SUB T2,CORRFL(T1)
  0024�	        JUMPL T2,FTARST
    0025�	        ADD T3,T2
0026�	        JUMPE T3,CPOPJ  ;NOTHING TO UPDATE, IGNORE RECORD
0027�	FTAOK1: MOVE T2,REFRFL(PTR)
0028�	        ADD T2,REFWFL(PTR)
 0029�	        ADD T2,REFHNG(PTR)
 0030�	        SUB T2,CORHNG(T1)
  0031�	        SUB T2,CORWFL(T1)
            0032�	        SUB T2,CORRFL(T1)       ;IF T2 IS POS, THIS IS HARD ERR
    0033�	        JUMPG T2,FTAHRD
    0034�	        SKIPE HRDFLG
  0035�	        JRST FTAUPD     ;ONLY WANT HARD ERRORS, UPDATE ONLY
   0036�	FTAHRD: PUSHJ P,COMOPN
0037�	        SETOM PRVERR
  0038�	        SKIPN SHTFRM
  0039�	        JRST FTALNG     ;LONG ERROR MESSAGE
    0040�	        MOVE T2,REFWOK(PTR)
0041�	        SUB T2,CORWOK(T1)
  0042�	        JUMPLE T2,FTAR1
    0043�	        OSTR [ASCIZ / WRT RT /]
 0044�	        PUSHJ P,OUTDEC
0045�	FTAR1:  MOVE T2,REFWFL(PTR)
0046�	        SUB T2,CORWFL(T1)
  0047�	        JUMPLE T2,FTAR2
         0048�	        OSTR [ASCIZ / WRT FL /]
 0049�	        PUSHJ P,OUTDEC
0050�	        FTAR2:  MOVE T2,REFROK(PTR)
  0051�	        SUB T2,CORROK(T1)
  0052�	        JUMPLE T2,FTAR3
    0053�	        OSTR [ASCIZ / RD RT /]
  0054�	        PUSHJ P,OUTDEC
    �  0001�	FTAR3:  MOVE T2,REFRFL(PTR)
0002�	        SUB T2,CORRFL(T1)
  0003�	        JUMPLE T2,FTAR4
    0004�	        OSTR [ASCIZ /RD FL /]
   0005�	        PUSHJ P,OUTDEC
0006�	FTAR4:  MOVE T2,REFHNG(PTR)
0007�	        SUB T2,CORHNG(T1)
  0008�	        JUMPLE T2,FTAR5
    0009�	        OSTR [ASCIZ / HUNG /]
   0010�	        PUSHJ P,OUTDEC
                         0011�	FTAR5:  MOVE T2,REFWFL(PTR)
0012�	        ADD T2,REFRFL(PTR)
 0013�	        SUB T2,CORWFL(T1)
  0014�	        SUB T2,CORRFL(T1)
  0015�	        JUMPLE T2,FTAR6
    0016�	        OSTR [ASCIZ /
 0017�	        HCNI CONI /]
  0018�	        MOVE T4,REFHCI(PTR)
0019�	        PUSHJ P,OUTHLF
0020�	        JRST FTAR7
    0021�	FTAR6:  MOVE T2,REFWOK(PTR)
0022�	        ADD T2,REFROK(PTR)
 0023�	        SUB T2,CORWOK(T1)
  0024�	        SUB T2,CORROK(T1)
  0025�	        JUMPLE T2,FTAR8
    0026�	FTAR7:  OSTR [ASCIZ /
 0027�	        SCNI CONI /]
  0028�	        MOVE T4,REFSCI(PTR)
0029�	        PUSHJ P,OUTHLF
          0030�	FTAR8:  MOVE T2,REFHNG(PTR)
0031�	        SUB T2,CORHNG(T1)
  0032�	        JUMPLE T2,FTAR9
    0033�	        OSTR [ASCIZ /
 0034�	        HUNG CONI /]
  0035�	        MOVE T4,REFCIH(PTR)
0036�	        PUSHJ P,OUTHLF
0037�	        OSTR [ASCIZ / FUNCT /]
  0038�	        MOVE T2,REFHFC(PTR)
0039�	        PUSHJ P,OUTDEC
0040�	FTAR9:  OSTR [ASCIZ /
 0041�	/]
0042�	FTAUPD: MOVE T2,REFWOK(PTR)
0043�	        MOVEM T2,CORWOK(T1)
0044�	        MOVE T2,REFWFL(PTR)
0045�	        MOVEM T2,CORWFL(T1)
0046�	        MOVE T2,REFROK(PTR)
0047�	        MOVEM T2,CORROK(T1)
0048�	        MOVE T2,REFRFL(PTR)
                    0049�	        MOVEM T2,CORRFL(T1)
0050�	        MOVE T2,REFHNG(PTR)
0051�	        MOVEM T2,CORHNG(T1)
0052�	        POPJ P,
      �  0001�	FTARST: PUSHJ P,SETRST
0002�	        PUSHJ P,FNDLNK
0003�	        JRST FTAOK1
   0004�	
  0005�	FTALNG: MOVE T2,REFWOK(PTR)
0006�	        SUB T2,CORWOK(T1)
  0007�	        JUMPLE T2,FTAL1
    0008�	        OSTR [ASCIZ /
 0009�	        WRITE RETRYS, NUMBER /]
 0010�	        PUSHJ P,OUTDEC
0011�	        MOVE T2,REFWFL(PTR)
0012�	        SUB T2,CORWFL(T1)
  0013�	        OSTR [ASCIZ / FAILED /]
 0014�	        PUSHJ P,OUTDEC
0015�	FTAL1:  MOVE T2,REFROK(PTR)
                    0016�	        SUB T2,CORROK(T1)
  0017�	        JUMPLE T2,FTAL2
    0018�	        OSTR [ASCIZ /
 0019�	        READ RETRYS, NUMBER /]
  0020�	        PUSHJ P,OUTDEC
0021�	        MOVE T2,REFRFL(PTR)
0022�	        SUB T2,CORRFL(T1)
  0023�	        OSTR [ASCIZ / FAILED /]
 0024�	        PUSHJ P,OUTDEC
0025�	FTAL2:  MOVE T2,REFWFL(PTR)
0026�	        ADD T2,REFRFL(PTR)
 0027�	        SUB T2,CORWFL(T1)
  0028�	        SUB T2,CORRFL(T1)
  0029�	        JUMPE T2,FTAL3
0030�	        OSTR [ASCIZ /
 0031�	        HARD CONI
0032�	/]
0033�	        MOVEI T4,FTACNI
    0034�	        MOVE T2,REFHCI(PTR)
                         0035�	        PUSHJ P,OUTBTS
0036�	FTAL3:  MOVE T2,REFWOK(PTR)
0037�	        ADD T2,REFROK(PTR)
 0038�	        SUB T2,CORWOK(T1)
  0039�	        SUB T2,CORROK(T1)
  0040�	        JUMPLE T2,FTAL4
    0041�	        OSTR [ASCIZ /
 0042�	        SOFT CONI
0043�	/]
0044�	        MOVEI T4,FTACNI
    0045�	        MOVE T2,REFSCI(PTR)
0046�	        PUSHJ P,OUTBTS
    �  0001�	FTAL4:  MOVE T2,REFHNG(PTR)
0002�	        SUB T2,CORHNG(T1)
  0003�	        JUMPLE T2,FTAL5
    0004�	        OSTR [ASCIZ /
 0005�	        TIME HUNG /]
  0006�	        PUSHJ P,OUTDEC
0007�	        OSTR [ASCIZ / FUNCTION /]
                        0008�	        MOVE T2,REFHFC(PTR)
0009�	        CAIL T2,HFCCNT  ;SEE IF TOO LARGE
 0010�	        MOVEI T2,HFCCNT ;POINT TO UNKNOWN
 0011�	        OSTR @HFCNAM(T2)
   0012�	        OSTR [ASCIZ /
 0013�	        SA-10 CONI
    0014�	/]
0015�	        MOVEI T4,SAXCNI
    0016�	        MOVE T2,REFCIH(PTR)
0017�	        PUSHJ P,OUTBTS
0018�	FTAL5:  OSTR [ASCIZ /
 0019�	/]
0020�	        JRST FTAUPD
   0021�	
  0022�	HFCNAM: AQ <UNKNOWN>
  0023�	        AQ <REWIND>
   0024�	        AQ <WRITE TAPE MARK>
    0025�	        AQ <SKIP RECORD>
   0026�	        AQ <BACKSPACE RECORD>
   0027�	        AQ <REWIND AND UNLOAD>
       0028�	        AQ <ERASE GAP>
0029�	        AQ <SKIP FILE>
0030�	        AQ <BACKSPACE FILE>
0031�	        AQ <UGETF SENSE>
   0032�	        AQ <READ>
0033�	        AQ <WRITE>
    0034�	HFCCNT==.-HFCNAM
 0035�	        AQ <UNKNOWN>
  0036�	
  0037�	FTACNI: 0
   0038�	        AQ <SELECT ERROR>
  0039�	        AQ <BUS IN PARITY ERROR>
0040�	        AQ <CONTROL ERROR>
 0041�	        AQ <EQUIPMENT CHECK>
    0042�	        AQ <INTERVENTION REQUIRED>
   0043�	        AQ <COMMAND REJECT>
0044�	        AQ <NOT CAPABLE>
   0045�	        AQ <BUSY>
0046�	        AQ <CAN'T SENSE>
   0047�	        AQ <MEMORY ERROR>
            0048�	        AQ <BUS OUT CHECK>
 0049�	        AQ <OVERRUN>
  0050�	        AQ <DATA CHECK ON ERASE GAP>
 0051�	        AQ <DATA CHECK ON WRITE OR WRITE TAPE MARK>
 0052�	        AQ <DATA CHECK ON READ>
 0053�	        AQ <ID BURST CHECK>
0054�	                REPEAT ^D20,<0>
     �  0001�	SAXCNI: REPEAT ^D18,<0>
    0002�	        AQ <PI REQUEST>
    0003�	        AQ <PARITY ERROR>
  0004�	        AQ <NON-EXISTENT MEMORY>
0005�	        AQ <INTERUPT ENABLE CHL 0>
   0006�	        AQ <INTERUPT ENABLE CHL 1>
   0007�	        AQ <INTERUPT ENABLE CHL 2>
   0008�	        AQ <INTERUPT ENABLE CHL 3>
                       0009�	        AQ <GO CHL 0>
 0010�	        AQ <GO CHL 1>
 0011�	        AQ <GO CHL 2>
 0012�	        AQ <GO CHL 3>
 0013�	        AQ <STATUS CHL 0>
  0014�	        AQ <STATUS CHL 1>
  0015�	        AQ <STATUS CHL 2>
  0016�	        AQ <STATUS CHL 3>
  0017�	        REPEAT 3,<0>
      �  0001�	FTASNS: TLZ FL,FERDSK
 0002�	        SKIPE USESNS
  0003�	        PUSHJ P,COMUNI
0004�	         POPJ P,
 0005�	         POPJ P,
 0006�	PRTSNT: SKIPN PRVERR    ;DO WE NEED SENSE DATA?
0007�	        POPJ P,         ;NO, EXIT
    0008�	        PUSHJ P,COMOPN
0009�	        OSTR [ASCIZ / LAST SENSE
0010�	/]
                    0011�	PRTSNS: MOVEI T1,6      ;FALL INTO HERE
   0012�	        MOVE T6,[POINT 8,4(PTR)]        ;POINTER TO SENSE BYTES
    0013�	PRTSN1: MOVEI T5,4
    0014�	        OCHI 11
  0015�	PRTSN2: ILDB T2,T6
    0016�	        PUSHJ P,OUTHEX
0017�	        CAILE T5,1
    0018�	        OCHI ","
 0019�	        SOJG T5,PRTSN2
0020�	        OSTR [ASCIZ /
 0021�	/]
0022�	        SOJG T1,PRTSN1
0023�	        POPJ P,
  0024�	
  0025�	OUTOC1: CAIL T2,100
   0026�	        JRST OUTOCT
   0027�	        OCHI "0"
 0028�	        CAIGE T2,10
   0029�	        OCHI "0"
 0030�	        JRST OUTOCT
   0031�	
                                0032�	UNISNS: TRO FL,FERDSK
 0033�	        PUSHJ P,COMUNI
0034�	         POPJ P,
 0035�	         POPJ P,
 0036�	        LDB T2,[POINT 24,4(PTR),23]
  0037�	        CAIN T2,20
    0038�	        JRST UNIENV     ;ENVIRON
0039�	        SKIPN USESNS
  0040�	        POPJ P,
  0041�	        JRST PRTSNT
   0042�	
  0043�	UNIENV: SKIPN USEENV
  0044�	        POPJ P,
  0045�	        PUSHJ P,COMOPN
0046�	        OSTR [ASCIZ / ENVIRONMENTAL DATA
  0047�	        CONTROL /]
    0048�	        LDB T2,[POINT 2,5(PTR),1]
    0049�	        PUSHJ P,OUTDEC
0050�	        OSTR [ASCIZ / DRIVE /]
                                          0051�	        LDB T2,[POINT 6,5(PTR),7]
    0052�	        MOVSI T3,-10
  0053�	DRVEV1: CAMN T2,[EXP 70,61,52,43,34,25,16,7](T3)
    0054�	        JRST DRVEV2
   0055�	        AOBJN T3,DRVEV1
    0056�	        OSTR [ASCIZ /UNKNOWN/]
  0057�	        SKIPA
    0058�	DRVEV2: OCHI "A"(T3)
  0059�	        OSTR [ASCIZ /
 0060�	/]
    �  0001�	        OSTR [ASCIZ /   BYTES READ,SEARCHED /]
 0002�	        LDB T2,[POINT 32,6(PTR),31]
  0003�	        PUSHJ P,OUTDCC
0004�	        LDB T2,[POINT 16,7(PTR),15]
  0005�	        JUMPE T2,ENVR1
0006�	        OSTR [ASCIZ /
 0007�	        CORRECTABLE DATA CHECKS /]
                  0008�	        PUSHJ P,OUTDCC
0009�	ENVR1:  LDB T2,[POINT 16,7(PTR),31]
  0010�	        JUMPE T2,ENVR2
0011�	        OSTR [ASCIZ /
 0012�	                RETRY DATA CHECKS /]
 0013�	        PUSHJ P,OUTDCC
0014�	ENVR2:  OSTR [ASCIZ /
 0015�	        SEEKS /]
 0016�	        LDB T2,[POINT 16,10(PTR),15]
 0017�	        PUSHJ P,OUTDCC
0018�	        LDB T1,[POINT 1,10(PTR),16]     ;INTERFACE IDENT
 0019�	        LDB T2,[POINT 8,10(PTR),31]
  0020�	        JUMPE T2,ENVR3
0021�	        OSTR [ASCIZ /
 0022�	        SEEK ERRORS /]
0023�	        PUSHJ P,OUTDCC
0024�	ENVR3:  LDB T2,[POINT 8,11(PTR),7]
                            0025�	        JUMPE T2,ENVR4
0026�	        OSTR [ASCIZ /
 0027�	        COMMAND OVERRUN INTERFACE /]
 0028�	        OSTR ACTAB(T1)
0029�	        PUSHJ P,OUTDCC
0030�	ENVR4:  LDB T2,[POINT 8,11(PTR),15]
  0031�	        JUMPE T2,ENVR5
0032�	        OSTR [ASCIZ /
 0033�	        DATA OVERRUN INTERFACE /]
    0034�	        OSTR ACTAB(T1)
0035�	        PUSHJ P,OUTDCC
0036�	ENVR5:  LDB T2,[POINT 8,11(PTR),23]
  0037�	        JUMPE T2,ENVR6
0038�	        OSTR [ASCIZ /
 0039�	        COMMAND OVERRUN INTERFACE /]
 0040�	        OSTR BDTAB(T1)
0041�	        PUSHJ P,OUTDCC
0042�	ENVR6:  LDB T2,[POINT 8,11(PTR),31]
            0043�	        JUMPE T2,ENVR7
0044�	        OSTR [ASCIZ /
 0045�	        DATA OVERRUN INTERFACE /]
    0046�	        OSTR BDTAB(T1)
0047�	        PUSHJ P,OUTDCC
0048�	ENVR7:  OSTR [ASCIZ /
 0049�	/]
0050�	        POPJ P,
  0051�	
  0052�	ACTAB:  ASCIZ /A /
    0053�	        ASCIZ /C /
    0054�	BDTAB:  ASCIZ /B /
    0055�	        ASCIZ /D /
    0056�	
  0057�	OUTDCC: CAIGE T2,^D1000
    0058�	        JRST OUTDEC     ;JUST PRINT IF SMALL
   0059�	        IDIVI T2,^D1000
    0060�	        HRLM T3,(P)     ;DIVIDE INTO 3 DIGIT HUNKS
  0061�	        PUSHJ P,OUTDCC
0062�	        OCHI ","
                               0063�	        HLRZ T2,(P)
   0064�	        CAIL T2,^D100
 0065�	        JRST OUTDEC     ;NO EXTRA ZEROS NEEDED
 0066�	        OCHI "0"        ;AT LEAST 1 EXTRA
 0067�	        CAIGE T2,^D10
 0068�	        OCHI "0"        ;AND POSSIBLY 2 ZEROS NEEDED
0069�	        JRST OUTDEC
   0070�	
  0071�	OUTHEX: IDIVI T2,20
   0072�	        PUSHJ P,HEXDG
 0073�	        MOVE T2,T3
    0074�	HEXDG:  CAIG T2,^D9
   0075�	        TROA T2,"0"
   0076�	        ADDI T2,"A"-^D10
   0077�	        OCHR T2
  0078�	        POPJ P,
  0079�	
  0080�	        END STPT
 I^J