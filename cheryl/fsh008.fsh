42XFORMAT01:P034/L24            S,JOBDAT        06-Jun     1 1984       




                        
                        
                        
      
      
      
      
      
      
                  
                  
                  
      
      
      
      
      
      
                        
                        
                        




























              
    
    
        
    
      
                

S - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534        MACRO %53B(1156)-1 17:31  5-Jun-84 Page 1
S       MAC     26-Apr-71 10:47         CONFIG - CONFIGURATION DEFINITION

     1                                  ;THIS SUB-PROGRAM ASSEMBLED WITH SYSTEM PARAMETER FILE - S.MAC
     2
     3                                          IF2,<IFNDEF LISTSN,<            ;LIST S.MAC IN COMMON ONLY.
     4                                                                  TAPE>>
     5
     6                                                                          ;SKIP PASS2 IN ALL OTHER CASES
     7
     8                                  IF2,<
     9                                  SUBTTL  SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS
    10                                  >
    11                                  ;       TH/TNM/AF/CHW/RCC/PH  15 OCT 70  V447
    12
    13                                  ;THIS FILE IS ASSEMBLED IN FRONT OF EACH SUBPROGRAM IN THE MONITOR
    14
    15                                  DEFINE  XPP(A,B)                ;SYSTEM PARAMETER16                                  <A=:B>
    17                                  DEFINE XP(A,B)          ;NON-PRINTING PARAMETER
    18                                  <A==:B>
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 2
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

    19                                  ;ACCUMULATOR ASSIGNMENTS
    20                                  ;*** ON JUNE 1,1971 ALL ACCUMULATOR NAMES WERE CHANGED TO REDUCE TO
    21                                  ;*** SIXTEEN NAMES.  THE OLD ASSIGNMENTS WILL BE FOUND AFTER THE
    22                                  ;*** CURRENT ASSIGNMENTS, UNDER REPEAT 0.
    23
    24                                  ;SEE FILSER.FLO FOR SUBROUTINE CALLING CONVENTIONS
    25
    26                                  ;* MEANS LOADED BY UUO HANDLER ON ALL UUOS
    27
    28                                  XPP S,0         ^;*I/O DEVICE STATUS WORD (SEE BELOW FOR BITS)
    29                                  XPP P,1         ^;*PUSH DOWN POINTER (SEPARATE LIST FOR EACH PI
    30                                                  ; CHANNEL AND EACH USER JOB)
    31                                  XPP J,2         ^;BUFFER ITEM COUNT, OR JOB NUMBER
    32                                                  ;IN LEVEL D FILSER ADR OF CONTROLLER DATA BLOCK - ONE PER CONTROLLER
    33                                                  ;IN REMOTE COMMUNICATIONS HANDLER ADR OF STATION DATA BLOCK
    34                                  XPP PG,3        ^;THIS DOES REPLACE R. IN GENERAL A PAGE NUMBER
    35                                                  ;UNTIL PAGING IS COMPLETE, PARENTAL GUIDENCE
    36                                                  ;IS SUGGESTED IN USING PG
    37                                  XPP F,4         ^;*LH=UUOS DONE SO FAR FOR THIS DEVICE (SEE BELOW)
    38                                                  ; RH=ADDRESS OF DEVICE DATA BLOCK - ONE PER FILE
    39                                  XPP U,5         ^;TTY OUTPUT BUFFER POINTER FOR COMMANDS, ERROR
    40                                                  ; MESSAGES, ETC.        ;OR TEMPORARY
    41                                                  ;ADDRESS OF 3 WORD BUFFER HEADER IN USER AREA
    42                                                  ;IN LEVEL D FILSER ADR OF UNIT DATA BLOCK - ONE FOR EACH DISK UNIT
    43                                                  ; (POSITIONER) EVEN IF SAME TYPE
    44                                                  ;IN TERMINAL HANDLER ADR OF LINE DATA BLOCK OF THIS TTY
    45                                  XPP T1,6        ^;TEMPORARY (SOMETIMES PRESERVED ACROSS SUBRTNS)
    46                                  XPP T2,T1+1     ^;TEMPORARY (SOMETIMES PRESERVED ACROSS SUBRTNS)
    47                                                  ;IN TERMINAL HANDLER CHARACTER ADDRESS IN CHARACTER POOL
    48                                  XPP T3,T2+1     ^;TEMPORARY
    49                                                  ;IN TERMINAL HANDLER CHARACTER (SEVEN BIT ASCII)
    50
    51                                  ;ONLY 0 THRU 10 SAVED FOR INTERRUPT SERVICE - LEVEL C AND BEFORE
    52
    53                                  XPP T4,T3+1     ^;*ADDRESS OF DEVICE SERVICE ROUTINE'S DISPATCH TABLE
    54
    55                                  ;0 THRU 11 SAVED FOR LEVEL D
    56
    57                                  XPP W,12        ^;CONTENTS OF FIRST WORD OF 3 WORD USER BUFFER HEADER
    58                                                  ;*USER I/O CHANNEL NUMBER
    59                                  XPP M,13        ^;*CURRENT UUO IN PROGRESS
    60                                                  ; R IN INDEX FIELD FOR RELOCATION
    61                                  XPP P1,14       ^;PERMANENT AC'S
    62                                  XPP P2,P1+1     ^;
    63                                  XPP P3,P2+1     ^;
    64                                  XPP P4,P3+1     ^;CONTENTS OF 2ND WORD OF USER BUFFER
    65
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 3
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

    66                                  ;ACCUMULATOR ASSIGNMENTS
    67                                  REPEAT 0,<
    68                                  ;*** THESE TWO PAGES ARE INCLUDED FOR HISTORICAL REASONS AS
    69                                  ;*** A REFERENCE. NOTE THAT THEY ARE NOT ASSEMBLED.
    70                                  
    71                                  ;* MEANS LOADED BY UUO HANDLER ON ALL UUOS
    72                                  
    73                                  XP IOS,0        ;*I/O DEVICE STATUS WORD (SEE BELOW FOR BITS)
    74                                  XP TAC,6        ;TEMPORARY (SOMETIMES PRESERVED ACROSS SUBRTNS)
    75                                  XP TAC1,7       ;TEMPORARY (SOMETIMES PRESERVED ACROSS SUBRTNS)
    76                                  XP PDP,1        ;*PUSH DOWN POINTER (SEPARATE LIST FOR EACH PI
    77                                                  ; CHANNEL AND EACH USER JOB)
    78                                  XP ITEM,2       ;BUFFER ITEM COUNT, OR JOB NUMBER
    79                                  XP DAT,5        ;TTY OUTPUT BUFFER POINTER FOR COMMANDS, ERROR
    80                                                  ; MESSAGES, ETC.        ;OR TEMPORARY
    81                                  XP JBUF,DAT     ;ADDRESS OF 3 WORD BUFFER HEADER IN USER AREA
    82                                  XP DEVDAT,4     ;*LH=UUOS DONE SO FAR FOR THIS DEVICE (SEE BELOW)
    83                                                  ; RH=ADDRESS OF DEVICE DATA BLOCK
    84                                  XP PROG,3       ;*LH=HIGHEST RELATIVE LOCATION IN USER AREA
    85                                                  ; RH=ABSOLUTE ADDRESS OF USER AREA
    86                                  XP JDAT,PROG    ;*RH=ADDRESS OF JOB DATA AREA
    87                                                  ; LH=HIGHEST RELATIVE LOCATION IN USER AREA
    88                                  XP TEM,10       ;TEMPORARY USED ONLY IN SCNSER I/O ROUTINE
    89                                  
    90                                  ;ONLY 0 THRU 10 SAVED FOR INTERRUPT SERVICE - LEVEL C AND BEFORE
    91                                  
    92                                  XP DSER,11      ;*ADDRESS OF DEVICE SERVICE ROUTINE'S DISPATCH TABLE
    93                                  
    94                                  ;0 THRU 11 SAVED FOR LEVEL D
    95                                  
    96                                  XP BUFPNT,12    ;CONTENTS OF FIRST WORD OF 3 WORD USER BUFFER HEADER
    97                                  XP UCHN,BUFPNT  ;*USER I/O CHANNEL NUMBER
    98                                  XP BUFWRD,17    ;CONTENTS OF 2ND WORD OF USER BUFFER
    99                                  XP UUO,13       ;*CURRENT UUO IN PROGRESS
   100                                                  ; PROG IN INDEX FIELD FOR RELOCATION
   101                                  XP AC1,14       ;TEMPORARY AC'S (MORE TEMPORARY THAN TAC,TAC1)
   102                                  XP AC2,15       ;
   103                                  XP AC3,16       ;
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 4
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   104                                  ;ACCUMULATOR ASSIGNMENTS (LEVEL D)
   105                                  ;SEE FILSER.FLO FOR SUBROUTINE CALLING CONVENTIONS
   106                                  
   107                                  ;GLOBAL - INTERRUPT AND UUO LEVELS
   108                                  
   109                                  XP S,IOS        ;DEVICE IO STATUS
   110                                  XP P,PDP        ;PUSH DOWN POINTER
   111                                  XP K,ITEM       ;ADR. OF CONTROLLER DATA BLOCK - ONE FOR EACH CONTROLLER
   112                                  XP R,PROG       ;JOB RELOCATION (RH) PROTECTION(LH)
   113                                  XP F,DEVDAT     ;ADR. OF DEVICE DATA BLOCK - ONE FOR EACH FILE - USER PAIR
   114                                  XP U,DAT        ;ADR. OF UNIT DAT BLOCK - ONE FOR EACH DISK UNIT (POSITIONER)
   115                                                  ;EVEN IF SAME TYPE
   116                                  
   117                                  ;TEMPORARY - INTERRUPT AND UUO LEVELS - NEED NEVER BE PUSHED BEFORE USE
   118                                  
   119                                  XP T,TAC        ;FIRST OF 4 CONSECUTIVE TEMP ACS
   120                                  XP T1,TAC1      ;SECOND OF 4 CONSECUTIVE TEMP ACS
   121                                  XP T2,TEM       ;THIRD OF 4 CONSECUTIVE TEMP ACS
   122                                  XP T3,DSER      ;FOURTH OF 4 CONSECUTIVE TEMP ACS
   123                                  
   124                                  ;GLOBAL - UUO LEVEL ONLY
   125                                  
   126                                  XP UCHN,UCHN    ;
   127                                  XP UUO,UUO      ;
   128                                  
   129                                  ;PRESERVED - INTERRUPT AND UUO LEVELS - MUST BE PUSHED BEFORE BEING USED
   130                                  
   131                                  XP P1,AC1       ;4 CONSECUTIVE ACS
   132                                  XP P2,AC2       ;
   133                                  XP P3,AC3       ;
   134                                  XP P4,BUFWRD    ;
   135                                  
   136                                  ;DEFINITIONS FOR TERMINAL HANDLERS - SCNSER,BTHINT(ETC),COMCON,ERRCON,ONCE
   137                                  
   138                                  XP LINE,U       ;ADDRESS OF LINE DATA BLOCK OF THIS TTY
   139                                  XP CH,TEM       ;CHARACTER (SEVEN BIT ASCII)
   140                                  XP CA,T1        ;CHARACTER ADDRESS IN CHARACTER POOL
   141                                  
   142                                  >       ;::: END OF REPEAT 0
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 5
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   143                                  ; DEVICE DATA BLOCK NAMES
   144                                          XP DEVNAM,0             ^;NAME IN SIXBIT ASCII
   145                                                                  ; C(LH)=DEVICE MNEMONIC
   146                                                                  ; C(RH)=DEVICE NUMBER, LEFT JUSTIFIED
   147                                          XP DEVCHR,1             ^;CHARACTERISTIC
   148                                                                  ; BITS 0-6=JOB NUMBER (BYTE POINTER=PJOBN)
   149                                                                  ; ZERO VALUE IMPLIES NOT ASSIGNED
   150                                                                  ;BITS 12-16=HUNG DEVICE COUNT. SET WHEN
   151                                                                  ; DEVICE BECOMES ACTIVE. DECREMENTED EVERY SECOND.
   152                                          XP HUNGST,400           ^;BITS 7-9 ARE A CODE FOR HUNG DEVICE
   153                                                                  ; TIMEOUT. 0 MEANS DEVICE CANNOT BE HUNG
   154                                                                  ; 1-7 MEANS HUNG TIME IS 2**N-1 SECONDS
   155                                                                  ; POINTER = PDVTIM
   156                                                                  ;BITS 10-16 ARE THE COUNTDOWN TIMER
   157                                                                  ; FOR HUNG DEVICE. POINTER = PDVCNT
   158                                                                  ; TRANSITION TO ZERO MEANS DEVICE HUNG
   159                                                                  ; BITS 17-23=DEVICE NUMBER, BINARY (BYTE PNTR=PUNIT)
   160                                                                  ; BITS 24-35=BUFFER SIZE
   161                                          XP DEVIOS,2             ^;STATUS WORD.  SEE BELOW
   162                                          XP DEVSER,3             ^;C(LH)=NEXT DEVICE DATA BLOCK
   163                                                                  ; C(RH)=DEVICE SERVICE DISPATCH TABLE
   164                                  ;  DEVICE SERVICE DISPATCH TABLE ASSIGNMENTS
   165                                          XP DDO,-2       ^;DUMP OUTPUT
   166                                          XP DDI,-1       ^;DUMP INPUT
   167                                          XP DDXZ,0       ^;SIZE OF DISPATCH TABLE FOR CHANIO
   168                                          XP DDINT,1      ^;INTERUPT SETUP
   169                                          XP DBYT,2       ^;BYTE SIZES FOR IMAGE,IMAGE BINARY
   170                                          XP DVSIZ,3      ^;BUFFER SIZES
   171                                          XP DINI,4       ^;INITIALIZE
   172                                          XP DHNG,5       ^;HUNG DEVICE
   173                                          XP DRL,6        ^;RELEASE
   174                                          XP DCL,7        ^;CLOSE
   175                                          XP DCLO,DCL     ^;CLOSE OUPTU=CLOSE
   176                                          ;IMMEDIATE ADDRESS PART OF CLOSE UUO
   177                                                  XP CLSOUT,1     ^;INHIBIT CLOSING OUTPUT
   178                                                  XP CLSIN,2      ^;INHIBIT CLOSING INPUT
   179                                                  XP CLSDLL,4     ^;INHIBIT DEALLOCATION ON CLOSE OUTPUT
   180                                                  XP CLSACC,10    ^;INHIBIT UPDATE OF ACCESS DATE ON READS (AND BAT BLOCK ON E
   181                                  RR)
   182                                                  XP CLSNMB,20    ^;INHIBIT DELETING NMB ON CLOSE WITH ONLY LOOKUP
   183                                                  XP CLSRST,40            ^;RESET (INHIBIT SUPERSEDE/CREATE)
   184                                                  XP CLSDAT,100           ^;DELETE ACCESS TABLE ON CLOSE
   185                                                  XP CLSDMP,100000        ^;SET DUMPED BIT
   186                                          XP DOU,10       ^;OUTPUT
   187                                          XP DIN,11       ^;INPUT
   188                                          XP DXFR,12      ^;TRANSFER ROUTINE
   189                                          XP DZAP,DXFR    ^;ZAP ROUTINE
   190                                          XP DGTRD,13     ^;GET READY (WAIT NOW)
   191                                          XP DMT,14       ^;MTAPE
   192                                          XP DGF,15       ^;UGETF
   193                                          XP DEN,16       ^;ENTER
   194                                          XP DLK,17       ^;LOOKUP        
   195                                          XP DRN,20       ^;RENAME
   196                                          XP DSI,21       ^;USETI
   197                                          XP DSO,22       ^;USETO
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 5-1
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   198                                          XP DCLI,23      ^;CLOSE INPUT
   199                                          XP DUFD,24      ^;DISK UFD
   200                                          XP DSEK,25      ^;SEEK
   201                                          XP DVMAP,26     ^;MAP.
   202                                          XP DFDEL,27     ^;FILE PAGE DELETE.
   203                                          XP DFCRE,30     ^;FILE PAGE CREATE.
   204                                          XP DFEXC,31     ^;FILE PAGES EXCHANGE.
   205                                          XP DSIM,32      ^;SIMULTANEOUS UPDATE (DISK ONLY)
   206                                          XP DFVLR,33     ^;VALIDATE A FILE'S RIBS.
   207                                          XP DVSMAP,34    ^;SUPER MAP.
   208                                          XP DFFIF,35     ^;FIND INTERESTING RETRIEVAL PNTR.
   209                                          XP DFTRN,36     ^;TRUNCATE FILE WITHIN LAST PAGE.
   210                                          XP DMOVPG,37    ^;MAKE VP MAPPABLE FROM FILE
   211
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 6
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   212                                          XP DEVMOD,4             ^;BIT 35-J=1 IF MODE J IS LEGAL FOR THIS DEVICE
   213                                                                  ; BIT 18 DEVICE ASSIGNED BY CONSOLE COMMAND
   214                                                                  ; BIT 19 DEVICE ASSIGNED BY PROGRAM (INIT)
   215
   216                                  ;RIGHT HALF OF DEVICE CHARACTERISTICS WORD (DEVCHR UUO)
   217                                          XP ASSCON,400000        ^;ASSIGNED BY CONSOLE COMMAND ASSIGN
   218                                          XP ASSPRG,200000        ^;ASSIGNED BY PROGRAM (INIT UUO)
   219                                  ;LEFT HALF DEVICE CHARACTERISTICS (DEVCHR UUO)
   220                                          XP DVOUT,1              ^;OUTPUT DEVICE
   221                                          XP DVIN,2               ^;INPUT DEVICE
   222                                          XP DVDIR,4              ^;HAS A DIRECTORY
   223                                          XP DVTTY,10             ^;IS A TTY
   224                                          XP DVMTA,20             ^;IS A MAG TAPE (REWIND)
   225                                          XP DVAVAL,40            ^;1 IF DEVICE IS AVAILABLE TO THIS JOB
   226                                                                  ; SET BY DEVCHR UUO
   227                                          XP DVDTA,100            ^;IT IS A DECTAPE
   228                                          XP DVPTR,200            ^;IS A PAPER TAPE READER
   229                                          XP DVPTP,400            ^;IS A PAPER TAPE PUNCH
   230                                                                  ; (OTHER UUOS BESIDES INPUT,OUTPUT,CLOSE,RELEASE)
   231                                          XP DVDIS,2000           ^;IS A DISPLAY
   232                                          XP DVRMT,4000           ^;DEVICE IS A REMOTE TERMINAL
   233                                          XP DVNZP,10000  ^;DO NOT ZAP ON RESET (DVRMT OR DVTTY)
   234                                          XP TTYATC,20000         ^;TTY IS CONTROLING TTY FOR JOB
   235                                          XP DVLPT,40000          ^;IS A LPT (CARRIAGE CONTROL IN FORTRAN)
   236                                          XP DVCDR,100000         ^;IS A CARD READER (TRAILING SPACES FOR MACRO)
   237                                          XP DVDSK,200000         ^;IS A DISK
   238                                          XP DVDIRIN,400000       ^;DECTAPE DIRECTORY IN CORE IF 1 (MUST BE SIGN BIT)
   239
   240                                          XP DEVLOG,5             ^;LOGICAL NAME FOR JOB DEVICE
   241                                          XP DEVBUF,6             ^;C(LH)=REL. ADDRESS OF 3 WORD OUTPUT BUFFER HEADER
   242                                                                  ; C(RH)=REL. ADDRESS OF 3 WORD INPUT BUFFER HEADER
   243                                          XP DEVIAD,7             ^;C(LH)=PROG IN INDEX FIELD
   244                                                                  ;BITS 1 AND 2 CONTAIN THE COUNT OF NUMBER OF USER
   245                                                                  ; CHANNELS INIT'ED ON THIS DEVICE (DECTAPE ONLY)
   246                                                                  ; IADPTR-COMMON BYTE POINTER TO 2 BIT COUNT
   247                                                                  ;C(RH)=RELATIVE ADDRESS OF INPUT BUFFER THE 
   248                                                                  ; SERVICE ROUTINE IS FILLING.
   249                  000007                  XP DEVADR,DEVIAD^DEVADR==:DEVIAD^
   250                                          XP DEVOAD,10            ^;C(LH)=PROG IN INDEX FIELD
   251                                                                  ;C(RH)=RELATIVE ADDRESS OF OUTPUT BUFFER THE
   252                                                                  ; SERVICE ROUTINE IS EMPTYING.
   253                  000010                  XP DEVPTR,DEVOAD^DEVPTR==:DEVOAD^
   254                                          XP DEVCLS,11            ^;CLASS AND BUFFER POINTER
   255                                          XP DEVSTS,12            ^;WORD FOR DEVICE CONI
   256                                          XP DEVPWC,13            ^;PARTIAL WORD COUNT
   257                                          XP DEVWUC,14            ^;ACTIVE PARTIAL WORD COUNT
   258
   259                  000043          LENFXL=^D35             ;LENGTH OF FIXED LIST AREA IN DSK AND MTA DDBS
   260
   261                                          XP DEVABC,13            ^;ADVANCE BUFFER COUNT (DSK,MTA)
   262                                          XP DEVBWC,14            ^;BUFFR WORD COUNT (DSK,MTA)
   263                  000015                  XP DEVCTR,15^DEVCTR==:15^
   264                  000016                  XP DEVINT,16^DEVINT==:16^
   265                                  ;FOR LONG DISPATCH TABLE DEVICES ONLY:
   266                                          XP DEVFIL,15            ^;FILE NAME IN SIXBIT
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 6-1
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   267                                          XP DEVEXT,16            ^;LH=EXTENSION, RH=UNUSED
   268                                          XP DEVPPN,17            ^;PROJECT,PROGRAMMER NUMBER (DISK ONLY)
   269                                                                  ; OTHER DEVICES NEED NOT HAVE THIS LOCATION IN THEM.
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 7
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   270                                  ; I/O STATUS WORD ASSIGNMENTS
   271                                  ;DATA MODES: BITS 32-35 (BYTE POINTER=PIOMOD)
   272                                          XP A,0                  ^;ASCII
   273                                          XP AL,1                 ^;ASCII LINE
   274                                          XP XA,2                 ^;EXTENDED ASCII
   275                                          XP I,10                 ^;IMAGE
   276                                          XP IB,13                ^;IMAGE BINARY
   277                                          XP B,14                 ^;BINARY
   278                                          XP SD,15                ^;SCOPE DUMP MODE
   279                                          XP DR,16                ^;DUMP BY RECORDS
   280                                          XP D,17                 ^;DUMP ACROSS RECORDS
   281                                  ; STATUS BITS
   282                                  ;RIGHT HALF (USER)
   283                                          XP IOWC,20              ^;DON'T COMPUTE WORD COUNT
   284                                          XP IOCON,40             ^;CONTINUOUS (CONT=0)
   285                                          XP IONRCK,100           ^;READ WITH NO REREAD CHECK
   286                                          XP IONDX,200            ^;READ INDEX BLOCKS.
   287                                  ;BITS 27,28     DENSITY OF MAG TAPE
   288                                  ;               00=INSTALLATION STANDARD
   289                                  ;               01=200 BPI
   290                                  ;               10=556 BPI
   291                                  ;               11=800 BPI
   292                                          XP IOPAR,1000           ^;WRITE EVEN PARITY (BCD) IF 1 ON MAG TAPE
   293                                          XP IOTEND,2000          ^;END OF MAG TAPE
   294                                          XP IOBOT,4000           ^;BEGINNING OF MAG TAPE
   295                                          XP IOACT,10000          ^;DEVICE ACTIVE
   296                                          XP IODEND,20000         ^;DATA END ENCOUNTERED
   297                                          XP IOBKTL,40000         ^;BLOCK TOO LARGE
   298                                          XP IODTER,100000        ^;DATA ERROR-IE HARDWARE OR SOFTWARE PARITY AND/OR CHECKSUM
   299                                                                  ; INDICATES DATA MAY BE BAD
   300                                          XP IODERR,200000        ^;DEVICE ERROR-IE THE DEVICE IS BAD
   301                                                                  ; THE DATA IS PROBABLY INTACT ON THE MEDIUM
   302                                                                  ; IF READING (USUAL)
   303                                                                  ; THE DATA IS PROBABLY INCORRECTLY WRITTEN
   304                                                                  ; ON THE MEDIUM
   305                                                                  ;  IF WRITING (UNUSUAL)
   306                                          XP IOIMPM,400000        ^;IMPROPER MODE DETECTED BY UUOCON OR DEVICE
   307                                                                  ; SERVICE ROUTINE
   308                                  ; LEFT HALF (SYSTEM)
   309                                          XP IOW,1                ^;I/O WAIT
   310                                          XP IOBEG,2              ^;VIRGIN DEVICE
   311                                          XP IOFST,4              ^;NEXT ITEM WILL BE THE FIRST ITEM OF A BUFFER
   312                                          XP IOSTBL,10            ^;RECOVERABLE DEVICE ERROR FLAG
   313                                          XP IO,20                ^;OUT=1, IN=0
   314                                          XP IOEND,40             ^;SERVICE ROUTINE HAS TRANSMITTED LAST DATA
   315                                          XP IOHNG,100            ^;DEVCHK SETS, WSYNC SEES AND CALLS ERRCON.
   316
   317                                  ;DEVICE DEPENDENT BITS ARE ALLOCATED FROM BIT 0 TO HIGHER BIT NUMBERS.
   318
   319                                  ;COMMAND DECODER USE OF AC IOS:
   320
   321                                  ;RH=DISPATCH ADDRESS - SAVJOB,GETJOB,RUNJOB
   322                                  ;LH:
   323                                          XP NSRBIT,400000        ^;HIGH SEG TO BE FLAGGED NON-SHARABLE (SAVE VS SSAVE
   324                                                                  ; COMMAND) DO NOT CONFUSE WITH SIGN BIT OF JBTSTS
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 7-1
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   325                                                                  ; WHICH SAYS SEG IS SHARABLE
   326
   327                                  ;SPECIAL BITS FOR PHYSICAL ONLY CODE
   328
   329                                          XP UPHNLY,200000        ^;IN CALLI'S
   330                                          XP PHONLY,400000        ^;IN W FOR UUOS
   331
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 8
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   332                                  ;LEFT HALF USRJDA (JOB DEVICE ASSIGNMENTS) UUO'S FOR THIS CHANNEL SINCE LAST INIT
   333                                  ;SET IN LH OF DEVDAT AT BEGINNING OF UUO,STORED IN MEMORY(USRJDA) IF UUO IS SUCCESSFUL
   334                                          XP      INITB,400000            ^;INIT-SAVEGET DEPENDS ON THIS BEING SIGN BIT
   335                                          XP IBUFB,200000         ^;INIT WITH INPUT BUFFER SPECIFIED
   336                                          XP OBUFB,100000         ^;INIT WITH OUTPUT BUFFER SPECIFIED
   337                                          XP LOOKB,40000          ^;LOOKUP
   338                                          XP ENTRB,20000          ^;ENTER
   339                                          XP INPB,10000           ^;INPUT
   340                                          XP OUTPB,4000           ^;OUTPUT
   341                                          XP ICLOSB,2000          ^;INPUT CLOSE
   342                                          XP OCLOSB,1000          ^;OUTPUT CLOSE
   343                                          XP INBFB,400            ^;INBUF
   344                                          XP OUTBFB,200           ^;OUTBUF
   345                                          XP SYSDEV,100           ^;THIS DEVICE IS SYSTEM TAPE
   346                                                                  ; PROJ.PROG. NO 1,1 ON DSK
   347                                          XP RENMB,40             ^;RENAME UUO IN PROGRESS (NEVER STORED IN MEMORY)
   348                                          XP DSKRLB,20            ^;TO DISTINGUISH RELEASE FROM RESET UUO IN DSKSER.
   349                                                                  ; RELEASE CLEARS THEM ALL - LEVEL C
   350                                          XP RESETB,20            ^;RESET UUO IN PROGRESS - LEVEL D (NEVER STORED IN MEMORY)
   351                                          XP GETB,10              ^;GET IN PROGRESS USE EX PROT INSTEAD OF RD
   352                                          XP MAPB,4               ^;
   353
   354                                  ;MTAPE UUO BITS
   355                                          XP SLICE,40             ^;SET SLICE LEVEL IF A 1 ACCORDING TO SLEVEL
   356                                          XP SLEVEL,20            ^;VALUE OF SLICE LEVEL IF SLICE A 1
   357
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 9
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   358                                  ;MACROS TO MOVE DATA BETWEEN THE USER AND THE OPERATING SYSTEM.
   359
   360                                  DEFINE UHRRZ (A,B)
   361                                          <XCTBU  <HRRZ A,B>>
   362
   363                                  DEFINE UHRLZ(A,B)
   364                                          <XCTBU  <HRLZ A,B>>
   365
   366                                  DEFINE UHLLZ(A,B)
   367                                          <XCTBU  <HLLZ A,B>>
   368
   369                                  DEFINE UHLRZ(A,B)
   370                                          <XCTBU  <HLRZ A,B>>
   371
   372                                  ;CONDITIONAL ASSEMBLY CONTROL FOR DIFFERENT PROCESSORS
   373
   374                  000001          CPUKI==1                ;FOR KI10
   375                  000002          CPUKL==2                ;FOR KL10
   376                  000003          CPUKS==3                ;FOR KS10
   377                  000004          CPUF3==4                ;FOR FOONLY
   378
   379                                  DEFINE IFCPU(CP)<
   380                                  CPZZ==0
   381                                  IRP CP,<
   382                                  IFE CPUTYP-CPU'CP,<CPZZ==1>
   383                                  >;END IRP
   384                                  REPEAT CPZZ>
   385
   386                                  DEFINE IFNCPU(CP)<
   387                                  CPZZ==1
   388                                  IRP CP,<
   389                                  IFE CPUTYP-CPU'CP,<CPZZ==0>
   390                                  >;END IRP
   391                                  REPEAT CPZZ>
   392
   393                                  DEFINE CPUSYM<
   394                                  IFCPU (F3),<SEARCH F3SYM>
   395                                  IFCPU (KI),<SEARCH KISYM>
   396                                  IFCPU (KL),<SEARCH KLSYM>
   397                                  IFCPU (KS),<SEARCH KSSYM>
   398                                  >
   399
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 10
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   400                                  ;ERROR CODES RETURNED TO USERS ON LOOKUP AND ENTER AND RENAME FAILURES  (DISK ONLY)
   401                                  ; IN RH OF 2ND WORD OF 4 WORD ARGUMENT BLOCK
   402                                  ;THE SAME ERROR CODES ARE RETURNED ON RUN AND GETSEG UUOS FOR ALL DEVICES
   403
   404                                          XP FNFERR,0     ^;FILE NOT FOUND OR 0 FILE NAME
   405                                          XP IPPERR,1     ^;INCORRECT PROJECT,PROGRAMMER NUMBERS
   406                                          XP PRTERR,2     ^;PROTECTION FAILURE (OR DIRECTORY FULL ON DTA)
   407                                          XP FBMERR,3     ^;FILE BEING MODIFIED
   408                                          XP AEFERR,4     ^;ALREADY EXISTING FILE (OR RENAME) OR DIFFERENT FILE NAME ON UPDATE
   409                                   ENTER
   410                                          XP ISUERR,5     ^;ILLEGAL SEQUENCING OF UUOS
   411                                                          ; (RENAME WITHOUT LOOKUP OR ENTER; LOOKUP AFTER ENTER)
   412                                          XP TRNERR,6     ^;TRANSMISSION ERROR OR BAD UFD
   413                                          XP NSFERR,7     ^;NOT A SAVE FILE (RUN,GETSEG UUO ONLY)
   414                                          XP NECERR,10    ^;NOT ENOUGH CORE (RUN,GETSEG UUO ONLY)
   415                                          XP DNAERR,11    ^;DEVICE NOT AVAILABLE (RUN,GETSEG UUO ONLY)
   416                                          XP NSDERR,12    ^;NO SUCH DEVICE (RUN,GETSEG UUO ONLY)
   417                                          XP ILUERR,13    ^;ILLEGAL UUO (GETSEG ONLY) NOT TWO RELOC REG. CAPABILITY
   418
   419                                  ;MORE LOOKUP/ENTER/RENAME ERROR CODES
   420
   421                                          XP NRMERR,14    ^;NO ROOM ON THIS FILE STRUCTURE ON ENTER OR ALLOCATION
   422                                                          ; OR USER QUOTA EXCEEDED(OVERDRAW DOES NOT COUNT ON ENTER)
   423                                          XP WLKERR,15    ^;WRITE LOCK ERROR - CAN'T WRITE
   424                                                          ; ON FILE STRUCTURE. EITHER HARDWARE
   425                                                          ; OR SOFTWARE WRITE PROTECTED.
   426                                          XP NETERR,16    ^;NOT ENOUGH MONITOR TABLE SPACE
   427                                          XP PAOERR,17    ^;PARTIAL ALLOCATION ONLY
   428                                          XP BNFERR,20    ^;BLOCK NOT FREE ERROR ON ALLOCATION WHERE STARTING
   429                                                          ; LOGICAL BLOCK NUMBER OF FILE STRUCUTRE SPECIFIED.
   430                                          XP NTRERR,21    ^;PRIVS WILL NOT ALLOW BUT OP COMPLETED
   431                                          XP LKMERR,22    ^;MULTIPLE LOOKUP ERROR, TOO MANY SPEC
   432                                  ; JOB BUFFER AREA HEADER
   433                                          XP JBFADR,0             ^;BIT 0=1 IF THIS BUFFER RING HAS NEVER BEEN
   434                                                                  ; REFERENCED FROM THE USER'S PROGRAM BY
   435                                                                  ; AN INPUT OR OUTPUT COMMAND.
   436                                                                  ; BITS 1-17=UNUSED
   437                                                                  ; BITS 18-35=CURRENT BUFFER ADDRESS
   438                                          XP JBFPTR,1             ^;BYTE POINTER TO NEXT BYTE -1
   439                                          XP JBFCTR,2             ^;POSITIVE ITEM COUNT
   440                                  ; JOB BUFFER HEADER
   441                                          XP IOUSE,400000         ^;1 IF BUFFER IS FULL (OR BEING EMPTIED)
   442                                                                  ; 0 IF BUFFER IS EMPTY (OR BEING FILLED)
   443                                                                  ; BITS 1-17=BUFFER SIZE
   444                                                                  ; BITS 18-35=NEXT BUFFER ADDRESS
   445                                          XP IOADVB,200000        ^;1 IF BUFFER HAS ALREADY BEEN
   446                                                                  ;ADVANCED. CAN HAPPEN IF INTERUPT
   447                                                                  ;FROM MIDDLE OF I/O. BIT IS IN
   448                                                                  ;BUFFER HEADER
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 11
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   449                                  ;SYMBOLS FOR MAKING PARTS OF WORDS BE A CONSTANT OF ZERO
   450                                  ; SO THAT FUTURE PROGRAMMERS WILL KNOW THAT THAT BYTE MUST BE ZERO.
   451
   452                                          XP ZERO36,0     ^;36 BITS OF ALWAYS ZERO
   453                                          XP ZERO18,0     ^;18 BITS (LH OR RH DEPENDING ON WHICH FIELD OF XWD.
   454                                          XP ZERO13,0     ^;INDIRECT BIT
   455                                          XP ZERO5,0      ^;5 BITS (USUALLY LH BITS 13 THRU 17, I.E., @ AND INDEX FIELD
   456                                                          ; OF POINTERS WHICH WANT TO BE REFERENCED USING INDIRECTION
   457
   458                  000000                  XP UUNNAM,0^UUNNAM==:0^
   459                  000001                  XP UUNEXT,1^UUNEXT==:1^
   460                  000002                  XP UUNATT,2^UUNATT==:2^
   461                  000003                  XP UUNPPN,3^UUNPPN==:3^
   462                  000000                  XP UUXNUM,0^UUXNUM==:0^
   463                  000001                  XP UUXPPN,1^UUXPPN==:1^
   464                  000002                  XP UUXNAM,2^UUXNAM==:2^
   465                  000003                  XP UUXEXT,3^UUXEXT==:3^
   466                  000004                  XP UUXPRV,4^UUXPRV==:4^
   467                  000005                  XP UUXSIZ,5^UUXSIZ==:5^
   468                  000006                  XP UUXVER,6^UUXVER==:6^
   469                  000007                  XP UUXFUT,7^UUXFUT==:7^
   470                  000010                  XP UUXEST,10^UUXEST==:10^
   471                  000011                  XP UUXALC,11^UUXALC==:11^
   472                  000012                  XP UUXPOS,12^UUXPOS==:12^
   473                  000013                  XP UUXFT1,13^UUXFT1==:13^
   474                  000014                  XP UUXLCW,14^UUXLCW==:14^
   475                  000015                  XP UUXMTA,15^UUXMTA==:15^
   476                  000016                  XP UUXDEV,16^UUXDEV==:16^
   477                  000017                  XP UUXSTS,17^UUXSTS==:17^
   478                  000020                  XP UUXELB,20^UUXELB==:20^
   479                  000021                  XP UUXEUN,21^UUXEUN==:21^
   480                  000022                  XP UUXQTF,22^UUXQTF==:22^
   481                  000023                  XP UUXQTO,23^UUXQTO==:23^
   482                  000024                  XP UUXMXA,24^UUXMXA==:24^
   483                  000025                  XP UUXUSD,25^UUXUSD==:25^
   484                  000026                  XP UUXAUT,26^UUXAUT==:26^
   485                  000027                  XP UUXUNM,27^UUXUNM==:27^
   486                  000030                  XP UUXUN1,30^UUXUN1==:30^
   487                  000031                  XP UUXTRU,31^UUXTRU==:31^
   488                  000032                  XP UUXXT2,32^UUXXT2==:32^
   489                  000033                  XP UUXALP,33^UUXALP==:33^
   490                  000034                  XP UUXSNM,34^UUXSNM==:34^
   491                  000035                  XP UUXPJC,35^UUXPJC==:35^
   492                  000036                  XP UUXPJ1,36^UUXPJ1==:36^
   493                  000037                  XP UUXPJ2,37^UUXPJ2==:37^
   494                  000040                  XP UUXPID,40^UUXPID==:40^
   495                                          XP UUXENT,UUXPID        ^;LAST ARG OR VALUE FOR EXTENDED UUOS
   496
   497          254000  000000          OPDEF PJRST [JRST]      ;PJRST IS USED IN PLACE OF THE LAST PAIR OF
   498                                                  ; INSTRUCTIONS IN A SUBROUTINE WHEN THEY ARE PUSHJ
   499                                                  ; FOLLOWED BY A POPJ.  PJRST IS USED INSTEAD OF JRST, SO
   500                                                  ; THAT SOMEONE READING THE CODE WILL INDERSTAND THAT A
   501                                                  ; SUBROUTINE IS BEING CALLED.
   502
   503          265000  000000          OPDEF PJSP      [JSP]   ;PJSP IS USED IN PLACE OF MOVEI .+2, PJRST SUB
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 11-1
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   504          321000  000000          OPDEF PJUMPL    [JUMPL]
   505          323000  000000          OPDEF PJUMPLE   [JUMPLE]
   506          322000  000000          OPDEF PJUMPE    [JUMPE]
   507          327000  000000          OPDEF PJUMPG    [JUMPG]
   508          325000  000000          OPDEF PJUMPGE   [JUMPGE]
   509          326000  000000          OPDEF PJUMPN    [JUMPN]
   510                                  DEFINE STOPCD (A) <sall
   511                                  IFB <A> <IF2,<IFNDEF SYSCRS,<EXTERNAL SYSCRS>>
   512                                          JSR     SYSCRS>
   513                                  IFIDN <A> <SLO> <IF2,<IFNDEF SLOCRS,<EXTERNAL SLOCRS>>
   514                                          JSR     SLOCRS>
   515                                  
   516                                  IFIDN <A> <NO> <IF2,<IFNDEF NOCRS,<EXTERNAL NOCRS>>
   517                                          JSR     NOCRS>  ;;DON'T RUN DSKCLN
   518                                  IFNB <A> <IFDIF <A> <SLO> <IFDIF <A> <NO> <IF2,<IFNDEF SYSCRS,<EXTERNAL SYSCRS>>
   519                                  JSR SYSCRS>>>
   520                                  >
   521
   522                                  XP DC.SIZ,3     ^;; BECAUSE THERE IS NO BETTER WAY NEEDED by COMMON/ONCDSK
   523
   524
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 12
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   525                                  ;JOB STATUS WORD (JBTSTS TABLE), ONE WORD FOR EACH JOB
   526
   527                                          XP RUN,400000           ^;USER WANTS JOB TO RUN (MUST BE SIGN BIT)
   528                                          XP CMWB,200000          ^;JOB TYPED A COMMAND WHICH NEEDS CORE
   529                                                                  ; WHICH IS ON DISK.  SET BY COMMAND DECODER
   530                                                                  ; CLEARED WHEN JOB IN CORE AGAIN.
   531                                          XP MRQ,100000           ^;1) JOB HAS PAGE FAULTED AND NEEDS
   532                                                                  ; THE SWAPPER TO SWAP SOMETHING IN
   533                                                                  ; 2) SWAPPER HAS STOLEN PAGES FROM
   534                                                                  ; JOB AND TAKEN AWAY CONTEXT PGES AS WELL
   535                                          XP JNA,40000            ^;THIS JOB NUMBER IS ASSIGNED (JOB INITIALIZED)
   536                                          XP JERR,20000           ^;A MONITOR DETECTED ERROR HAS OCCURRED
   537                                                                  ; JOB CAN NOT CONTINUE
   538                                          XP CNTRLC,400           ^;^C WAS TYPED WHILE JOB WAS IN MONITOR MODE
   539                                                                  ; AND NOT IN TTY WAIT - DELAY STOPPING JOB
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 13
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   540                                          ;BITS 10-14 USED TO INDICATE JOB IN WAIT FOR A SHARABLE DEVICE
   541                                          ;0 MEANS JOB NOT WAITING FOR SHARABLE DEVICE
   542                                          ;SEE SCHEDULER (CLKCSS) FOR DEFINITION OF WAIT CODES
   543
   544                                          XP JWSIZ,5              ^;SIZE OF WAIT CODE
   545                                          XP JWPOS,^D14           ^;RIGHT MOST BIT POS. OF WAIT CODE
   546                                          XP WTMASK,370           ^;MASK FOR CLEARING WAIT CODES
   547
   548                                          XP JLOG,4               ^;JOB SUCCESSFULLY LOGGED IN
   549                                          XP JRQ,2                ^;JOB HAS CHANGED STATE AND MUST BE REQUEUED AT CLOCK
   550                                                                  ; LEVEL BEFORE RESCHEDULING CAN TAKE PLACE
   551                                          XP JACCT,1              ^;PRIVILEGED SYSTEM CUSP IS BEING RUN WHICH CANNOT
   552                                                                  ; BE STOPPED (E.G., LOGIN
   553                                                                  ; OR LOGOUT).  PROTECT IT FROM CURIOUS EYES.
   554                                                                  ; DISABLE CONTROL C, MADE IT ACT LIKE ALT-MODE
   555
   556                                  ;BITS IN RIGHT HALF OF JBTSTS
   557
   558                                          XP JWSADJ, 400000       ^;1 TO DO MWS ADJUSTMENT FOR JOB --
   559                                                                  ;SET/CLEARED BY RESET ACCORDING TO
   560                                                                  ;ADJMWS, CLEARED BY WSCTL UUO
   561                                          XP WAKFLG,200000        ^;WAKE UUO PENDING FOR JOB
   562                                          XP JACCT2,100000        ^;LIKE JACCT BUT SETTABLE
   563                                          XP UTRP,040000          ^;TRAP TO USER ON UUO EXIT (REE, DDT)
   564                                          XP JDCON,020000         ^;JOB IN ^C STATE FOR DEVICE
   565                                          XP SCHPRV,10000         ^;PRIVILEGED SCHEDUALING FLAG
   566                                          XP PRF,4000             ^;PRE-REFERENCE REQUEST. SAME AS MRQ
   567                                                                  ; IN THAT IT MAKES SWAPPER DO THE JOB,
   568                                                                  ; BUT DOESN'T MAKE JOB UNRUNNABLE
   569                                          XP SWPINP,2000          ^;SWAP IN PROGRESS. IN RH BECAUSE JOB
   570                                                                  ; IS STILL RUNNABLE IF ITS ON.
   571                                          XP SETICP,1000          ^;SET IF JOB HAS BEEN SCANNED TO BE
   572                                                                  ; SWAPPED OUT. CLEARED WHEN ICPT IS
   573                                                                  ;RESET.
   574                                          XP EXCFLG,400           ^;EXIT IN CHILD PENDING
   575                                          XP KJP, 100             ^;KJOB PENDING
   576                                  ;MASKS USED TO TEST STATUS CONDITIONS:
   577
   578                                          XP RUNABLE,RUN+JNA      ^;STATUS BIT PATTERN FOR JOB TO BE RUNABLE
   579                  000405                  XP RUNMSK,JLOG+JACCT+CNTRLC^RUNMSK==:JLOG+JACCT+CNTRLC^
   580                                                                  ; BITS WHICH DO NOT MATTER FOR RUNABILITY
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 14
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   581
   582                                  ;BITS IN LH JBTPPN TABLE
   583
   584                                          XP JBPWLK,400000        ^;LEFTMOST BIT OF WRITELOCK FIELD (STR # 0)
   585                                          XP JBPNCR,400           ^;LEFTMOST BIT OF NO-CREATE FIELD (STR # 0)
   586                                          XP JBLWLK,1000          ^;RIGHTMOST BIT OF WRITELOCK FIELD (STR # 8)
   587                                          XP JBLNCR,1             ^;RIGHTMOST BIT OF NO-CREATE FILED (STR # 8)
   588                                          XP NCRMSK,777           ^;ALL NO-CREATE BITS
   589
   590                                  ;PARAMETER FOR TEMPORARY FILE STORAGE UUO FOR SHORT (CCL) FILES THAT LIVE IN CORE...
   591                                  ; DEFINE NUMBER OF DATA WORDS IN EACH BLOCK OF LINKED LIST IN CORE.  ACTUAL
   592                                  ; BLOCK LENGTH IS ONE GREATER TO ACCOMODATE FILE NAME AND CHAIN TO NEXT BLOCK.
   593
   594                  000004          XP TMPBL,4^TMPBL==:4^
   595
   596                                  ;TELETYPE PARAMETERS....
   597
   598                                          XP STTYBF,20            ^;SIZE OF TTY BUFFER
   599                                          XP STTYB1,STTYBF+1      ^;LENGTH+1
   600
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 15
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   601                                  ;JOB PRIVILEGE BITS - JBTPRV TABLE
   602                                  ;SET BY LOGINN FROM LUD.SYS FILE AS MODIFIED BY CUSTOMER FOR
   603                                  ; HIS PARTICULAR INSTALLATION
   604
   605                                  ;LH BITS -- MOSTLY DIGITAL STANDARD STUFF
   606
   607                                          XP PVLOS, 400000        ^;LogoutOnStop - must be sign bit
   608                                          XP PVNOAT,200000        ^;DON'T ATTACH ON LOGIN
   609                                          XP PVSTIM,6             ^;BITS IN TIME ZONE FIELD
   610                                          XP PVNTIM,7             ^;LOC OF TIME ZONE FIELD
   611                                          XP PVMTIM,176000        ^;MASK FOR TIME ZONE FILED
   612                                          XP PVNMAI,001000        ^;[dws] (new) mail waiting bit
   613                                          XP PVDINA,000400        ^;DEFAULT INACTIVITY HANG TIMEOUT
   614                                          XP PVSCMD,000200        ^;special command mode
   615                                          XP PVSCOR,7             ^;NUMBER OF BITS IN FIELD FOR CORE
   616                                          XP PVNCOR,^D17          ^;A USER IS ALLOWED TO HAVE
   617                                          XP PVMCOR,177           ^;MASK FOR CORE BITS
   618
   619                                  ;RH BITS -- SOME DIGITAL STANDARD, SOME TYMSHARE-DEFINED
   620
   621                                          XP PVEXO,400000         ^;PROGRAM IS RUN ONLY
   622                                          XP PVSHNG,2             ^;SIZE OF HANGUP/ZAP ACTION FIELD
   623                                          XP PVNHNG,^D20          ^;POS. OF HANGUP/ZAP ACTION FIELD
   624                                          XP PVMHNG,300000        ^;MASK FOR HANG/ZAP ACTION FIELD
   625                                              XP .PVHKJ,0         ^;0  KJOB ON HANG/ZAP
   626                                              XP .PVHDT,1         ^;1  DETACH ON HANG/ZAP
   627                                              XP .PVHCN,2         ^;2  DETACH-CONTINUE ON HANG/ZAP
   628                                              XP .PVHTM,3         ^;3  DETACH-TIMEOUT-KJOB ON HANG/ZAP
   629                                          XP PVTYMP,040000        ^;TYMSHARE PROPRIETARY
   630                                          XP PVACTS,020000        ^;ACCOUNT SUPERVISOR
   631                                          XP PVMAIL,010000        ^;MAIL WAITING BIT
   632                                          XP PVEXOG,004000        ^;EX ONLY GET IN PROGRESS
   633                                          XP PVBUD,002000         ^;TRU BUDGET BEING USED
   634                                          XP PVRCMD,001000        ^;RESTRICTED COMMAND MODE
   635                                          XP PVSMOD,2             ^;MODE (TYMEX, PDP, ETC.)
   636                                          XP PVNMOD,^D28          ^;POSITION FOR MODE BITS
   637                                          XP PVMMOD,000600        ^;MASK FOR MODE
   638                                          XP PVSCRM,7             ^;SIZE,MAX PERMITTED CORE FIELD
   639                                          XP PVNCRM,^D35          ^;POSITION
   640
   641                                  ;BITS IN JBTWCH    -    WATCH SYSTEM RESPONSE COMMAND
   642                                  ;LH BITS:       (BITS 13-35 = TIME OF DAY IN JIFFIES USER STARTS TO WAIT)
   643                                  ;MUST BE IN FOLLOWING ORDER WITH JBPWDY AS LEFT MOST BIT OF ALL OF THEM
   644                                          XP      JBPWDY,200000   ^;WATCH TIME OF DAY STARTED TO WAIT
   645                                          XP      JBPWRN,100000   ^;WATCH RUN TIME WHEN RETURN TO COMMAND LEVEL
   646                                          XP      JBPWWT,40000    ^;WATCH WAITING TIME RETURN TO COMMAND LEVEL
   647                                          XP      JBPWDR,20000    ^;WATCH NO. 128 WORD DISK BLOCKS READ
   648                                          XP      JBPWDW,10000    ^;WATCH NO. 128 WORD DISK BLOCKS WRITTEN
   649                                                  ;ADD NEW DATA HERE (ALSO INCLUDE IN WCHALL)
   650                                          XP      WCHALL,JBPWDY!JBPWRN!JBPWWT!JBPWDR!JBPWDW       ^;ALL WATCH BITS
   651
   652                                  ;BITS IN JBTCTX - CONTEXT PAGE CONTROL JOB TABLE
   653                                  ; (JBTCTX IS NCTXPG * JOBN WORDS LONG.)
   654                                  ; ALL BITS ARE IN LH.
   655
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 15-1
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   656                                  ; BITS APPEARING ONLY IN FIRST JOBN LOCATIONS OF JBTCTX
   657
   658                                          XP CTXCIN,400000        ^;CONTEXT PAGES ARE IN CORE AND ACTIVE
   659                                                                  ; IN OWNERS MAP SLOTS (%UPT)
   660                                                                  ; (MUST BE SIGN BIT)
   661                                          XP CTXCEX,200000        ^;IF 1, DISK PAGES ARE ALLOCATED.
   662                                          XP CTXVIR,100000        ^;IF 1, DISK PAGES HAVE JUST BEEN
   663                                                                  ; ALLOCATED BUT CONTEXT PAGES HAVE
   664                                                                  ; NOT BEEN SETUP YET.
   665                                          XP JSTCTX,40000         ^;TELLS SWAPPER TO JUST BRING IN CONTEXT PAGES
   666                                          XP CTXSWE,20000         ^;CONTEXT PAGES HAVE SWAP ERROR.
   667
   668                                  ; BITS APPEARING IN EACH JOBN SIZE BLOCK OF JBTCTX, I.E.
   669                                  ; FOR EACH CONTEXT PAGE
   670
   671                                          XP CTXUCU,10000         ^;1 IF USE COUNT IS INCREMENTED FOR
   672                                                                  ; CORE PAGE, BUT CONTEXT PAGES NOT
   673                                                                  ; ACTIVE YET.
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 16
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   674                                  ;LICENSE BITS AND FIELDS AND SO ON (AND ON)
   675
   676                                          XP LICWCR,400000        ^;WRITE CORE
   677                                          XP LICSPY,200000        ^;READ CORE (SPY AND PEEK)
   678                                          XP LICOPR,100000        ^;OPER LICENSE
   679                                          XP LICSYS,40000         ^;SYSTAT GET ARGS FOR OTHER JOBS
   680                                          XP LICGDV,20000         ^;GET DEVICES FROM JOB 0
   681                                          XP LICTDV,10000         ^;TRANSFER (REASSIGN) DEVICES
   682                                          XP LICSTR,4000          ^;FIDDLE WITH STRUCTURES
   683                                          XP LICRMT,2000          ^;REMOTE
   684                                          XP LICJAL,1000          ^;SET JACCT AND JLOG (WRITE UFDS)
   685                                          XP LICAC,400            ^;CREATE SPECIAL AUX. CIRCUITS
   686                                          XP LICXC,200            ^;FIDDLE WITH CHARGES
   687
   688                                          XP LICFMK,17            ^;MASK FOR FILE PRIVS
   689                                          XP LICWPS,^D17          ^;POSITION FOR WRITE PRVS
   690                                          XP LICRPS,^D15          ^;AND FOR READ
   691                                          XP LICWFL,2             ^;WRITE ON DSK (MAYBE S-USETO)
   692                                          XP LICWPJ,1             ^;WRITE IN PROJECT
   693                                          XP LICRFL,10            ^;AND FOR READ
   694                  000004                  XP LICRPJ,4^LICRPJ==:4^
   695
   696                                          XP LICUNU,160           ^;BITS NOT YET USED
   697
   698                                  ;BITS FOR TRAP ENABLE (BY APRENB UUO)
   699
   700                                          XP ENBUUO,100000        ^;TRAP ON UUO EXECUTED
   701                                          XP ENBESC,002000        ^;TRAP ON ESCAPE (OR ^C)
   702                                          XP ENBLIN,040000        ^;TRAP ON BREAK CHARACTER
   703                                          XP ENBCHR,004000        ^;TRAP ON CHR RECIEVED
   704                                          XP ENBCLK,1000          ^;TRAP ON CLOCK TICK
   705                                          XP ENBHMS,000040        ^;TRAP ON HUNG DEV, NO MSG
   706                                          XP ENBHNG,000020        ^;TRAP ON HUNG DEV
   707                                          XP ENBRPT,400000        ^;REPETITIVE ENABLE
   708                                          XP ENBOV,1B32           ^;ENABLE FOR OVERFLOW
   709                                          XP ENBFOV,1B29          ^;ENABLE FOR FLOATING OVERFLOW
   710                                          XP ENBMPT,1B22          ^;ENABLE FOR MEM. PROT (ILL MEM REF
   711                                          XP ENBPDL,1B19          ^;ENABLE FOR PDLOV
   712
   713                                  ;THE BITS REURNED IN JOBCNI FOR THE ABOVE
   714
   715                  400000                  XP FLGUUO,400000^FLGUUO==:400000^
   716                                          XP FLGESC,000001        ^;IN LH
   717                  004000                  XP FLGLIN,004000^FLGLIN==:004000^
   718                  000400                  XP FLGCHR,000400^FLGCHR==:000400^
   719                                          XP FLGHNG,000002        ^;IN LH, HUNG DEV
   720                                          XP FLGOV,1B32           ^;OVERFLOW
   721                                          XP FLGFOV,1B29          ^;FLOATING OVERFLOW
   722                                          XP FLGMPT,1B22          ^;ILL MEM REF
   723                                          XP FLGPDL,1B19          ^;PDL OV
   724
   725                                  ;BITS FOR HIBERNATE UUO
   726
   727                                          XP HIBCHR,10            ^;IN HIBERNATE UUO FOR CHR
   728                                          XP HIBLIN,20            ^;FOR LINE
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 16-1
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   729                                          XP HIBYLB,40            ^;HIBERNATE ON YELLOW BALL
   730                                          XP HIBPRT,100           ^;PORT NUMBER PRESENT
   731                                          XP HIBWKU,200           ^;ALLOW WAKE UUO
   732                                          XP HIBFEX,400           ^;ENABLE FOR FRAME EXITS
   733                                          XP HINTIM,^D17  ^;LOCATION OF SEC. MIN, ETC. FIELD
   734                                          XP HISTIM,2             ^;SIZE
   735                                          XP HINPRT,^D8   ^;POSITION OF PORT FIELD
   736                                          XP HISPRT,^D9   ^;SIZE
   737
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 17
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   738                                  ;VARIOUS ALARM BITS FOR CELL ALR620
   739
   740                                  XP ALROPR,20    ^;GIVES REASON 1. NO SET OPR
   741                                  XP ALRACT,40    ^;GIVES REASON 2. OPR ACTION NEEDED
   742                                  XP ALRUSR,100   ^;GIVES REASON 4. MESSAGE TO DET JOB
   743                                  XP ALRRMT,200   ^;GIVES REASON 10. REMOTE PERIPHERAL 620 HAS CRASHED
   744                                  XP ALRCTY,400   ^;GIVES REASON 20. MESSAGE OUTPUT ON CTY FOR OPER
   745                                  XP ALRSCH,1000  ^;GIVES REASON 40. SYSTEM HAS FINISHED AUTO-RELOAD
   746                                  XP ALRDEV,2000  ^;GIVES REASON 100. ERROR FOR DEVICE OPR ACTION NEEDED
   747
   748
   749                                  ;BITS IN THE "STATES" WORD, INDICATE OPERATIONAL STATE OF SYSTEM
   750
   751                                  XP STAUTO,1B17  ^;1 IF IN AUTO-RESTART CONDITION
   752                                  XP STSHUT,1B18  ^;1 IF SYSTEM SHUT
   753                                  XP STSUPR,1B19  ^;1 IF SYSTEM SUPER-SHUT
   754                                  XP STRLB,1B20   ^;1 IF RESTRICTED LOGINS. SEE LOGINN,NONRES:-7  AAA
   755
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 18
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   756                                  ;DEVICE CODES
   757
   758                  000274          XP SAX0,274^SAX0==:274^
   759                  000400          XP SAX1,400^SAX1==:400^
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 19
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   760                                  ;FRAME ACCESS RIGHTS DEFINITIONS
   761
   762                                  COMMENT \
   763                                  ARGUMENTS TO THE "X" MACRO:
   764                                  1) USER ACCESS RIGHT NUMBER. ONCE ASSIGNED, MUST NOT CHANGE.
   765                                     MUST BE ASSIGNED IN CONSECUTIVE ASCENDING ORDER.
   766                                     OPEN MODULE FRMSER AND TYPEOUT VALUE OF .UAMAX
   767                                     TO FIND OUT LAST VALUE ASSIGNED.
   768
   769                                  2) ABBRIEVIATION. USED TO DEFINE SYMBOLS .AR???
   770
   771                                  3) ACCESS LEVEL: LEGAL VALUES X=EXECUTE ONLY,R=READ ACCESS,
   772                                     W=WRITE ACCESS.
   773                                     DETERMINES WHAT MINIMUM FILE ACCESS IS NEEDED TO OBTAIN THAT RIGHT.
   774
   775                                  4) LICENSE. DETERMINES WHAT MINIMUM LICENSE NEEDED TO OBTAIN
   776                                     THE RIGHT VIA LICENSE. LEGAL VALUES IN DESCENDING ORDER:
   777                                     WC = WRITE CORE, RC = READ CORE,
   778                                     SY = SYSTAT (OR MATCHING AUN OR MATCHING GAN AND ACCT SUPER)
   779                                     TP = TYMSHARE PROPRIETARY. A LICENSE DESIGNATOR OF A CERTAIN LEVEL
   780                                     IMPLIES ALL RIGHTS ASSOCIATED WITH THAT LEVEL AND BELOW.
   781
   782                                  5) FAST. IF NON-BLANK, THE RIGHT IS A "FAST" ACCESS RIGHT WHICH
   783                                     WILL BE KEPT IN CORE. OTHERWISE, THE RIGHT IS "SLOW", AND
   784                                     ALL BIT MAPS IT APPEARS IN ARE IN THE CONTEXT PAGES.
   785
   786                                  THE MONITOR'S ACCESS RIGHT CODE FOR EACH RIGHT IS DETERMINED
   787                                  BY THE RELATIVE POSITION OF THE PARTICULAR "X" MACRO THAT
   788                                  DEFINES THE RIGHT, E.G. THE FIFTH RIGHT DEFINED WITHIN
   789                                  THE ARMAC MACRO IS MONITOR ACCESS RIGHT NUMBER 4, AND
   790                                  THE .AR??? SYMBOL FOR THAT RIGHT WILL BE DEFINED TO 4.
   791                                  \
   792
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 20
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   793                                  DEFINE ARMAC <
   794                                  ;;MAP MANIPULATION
   795                                  
   796                                  X (0,RDM,R,RC)  ;;RIGHT TO FIND OUT THINGS ABOUT A FRAME'S MAP
   797                                                  ;; (VPGSTS, WSCTL TO READ WS, ETC.)
   798                                  X (1,CHM,W,WC)  ;;RIGHT TO CHANGE MAP (REMOVE, MAP, VCREAT)
   799                                                  ;; (ALSO REPLICATE TO OTHER FRAME)
   800                                  
   801                                  ;;VIRTUAL ADDRESS SPACE DATA MANIPULATION
   802                                  
   803                                  X (2,RAC,R,RC)  ;;READ ACS
   804                                  X (3,WAC,W,WC)  ;;WRITE ACS
   805                                  X (4,VAR,R,RC)  ;;READ VIRTUAL ADDRESS SPACE DATA (REPLICATE READ ONLY, ETC)
   806                                  X (5,VAW,W,WC)  ;;WRITE VIRTUAL ADDRESS SPACE DATA (REPLICATE MAX WRITE, ETC.)
   807                                                  ;;(MUST BE SEPERATE FROM CHANGE MAP BECAUSE TARGET FRAME
   808                                                  ;;MIGHT HAVE FILE ACCESS THAT CALLER DOES NOT).
   809                                  
   810                                  ;;CONTROL
   811                                  
   812                                  X (6,HLT,W,WC)  ;;HALT
   813                                  X (7,STP,X,WC)  ;;STOP (LIKE CONTROL-C, TRAPPABLE BY SUBJECT FRAME)
   814                                  X (10,HNG,W,WC) ;;HANG
   815                                  X (11,CLR,X,WC) ;;CLEAR (MUST BE STOPPED FIRST)
   816                                  X (12,SVA,X,WC,F)       ;;START AT ENTRY VECTOR ADDRESS
   817                                  X (13,SAA,W,WC,F)       ;;START ANYWHERE
   818                                  X (14,RVA,W,WC) ;;RESTART AT ENTRY VECTOR ADDRESS
   819                                  X (15,RAA,W,WC) ;;RESTART AT ARBITRARY ADDRESS
   820                                  
   821                                  ;;READING FRAME STATUS
   822                                  
   823                                  X (16,RUN,X,<TP,SY,AUN>,F)      ;;READ USERNAME (AND JBTSTS TO SEE IF LOGGED IN)
   824                                  X (17,RDS,R,<SY,AUN>,F) ;;READ FRAME STATE (PC, HALT BLOCK)
   825                                  X (20,RAD,R,<SY,AUN>,F) ;;READ ACCOUNTING DATA
   826                                  X (21,RFI,R,<SY,AUN>,F) ;;READ FRAME INFORMATION (AUN, PPN, UID, ETC.)
   827                                  X (22,RPI,R,<SY,AUN>,F) ;;READ PROCESS INFORMATION (FPN, PROCESS NAME, PNO)
   828                                  
   829                                  ;ACCESS RIGHTS
   830                                  
   831                                  X (23,SMF,W,WC)         ;;SET MAX FRAME RIGHTS. NEED TO HAVE WRITE ACCESS
   832                                                          ;; TO FILE, OR ELSE CAN OVERRIDE THE FRAME'S OWN SETTING.
   833                                  
   834                                  ;WAKEUP
   835                                  
   836                                  X (24,WAK,W,WC)         ;;DO WAKE UUO FOR FRAME
   837                                  
   838                                  
   839                                  ;TTY ATTACHING AND DETACHING
   840                                  
   841                                  X (25,ATT,W,<AUN,JL>,F) ;;ATTACH A PORT TO TARGET FRAME IF IT HAS NONE
   842                                  X (26,DET,X,<WC>,F)     ;;TAKE PORT AWAY FROM TARGET FRAME
   843                                  
   844                                  
   845                                  ;GRAFTING
   846                                  
   847                                  X (27,TKP,W,<WC>,F)     ;;TAKE PARENT AWAY FROM A FRAME
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 20-1
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   848                                  X (30,GVP,W,<JL>,F)     ;;GIVE PARENT TO A FRAME
   849                                                          ;; (CAN'T BE AUN, OR ELSE USERS COULD GET CONTROL OVER OTHER JOBS WI
   850                                  TH SAME USERNAME9
   851                                  X (31,GVC,W,<WC>,F)     ;;GIVE CHILD TO A FRAME.
   852                                  
   853                                  ;License
   854                                  
   855                                  X (32,PLC,W,<WC>,F)     ;;Pass license to a frame
   856                                  
   857                                  >;END ARMAC MACRO DEFINITION
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 21
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   858                                  ;MACRO TO CALL A SPECIFIED MACRO FOR EACH FAST ACCESS RIGHT,
   859                                  ; AN EXECUTION MACRO, THE SPECIFIED MACRO FOR
   860                                  ; EACH SLOW ACCESS RIGHT, AND THEN THE EXECUTION MACRO AGAIN.
   861                                  ; USED TO GENERATE TABLES OF ACCESS RIGHTS ACCORDING
   862                                  ; TO THE ARGUMENTS IN THE "X" MACRO IN MACRO DEFINITION
   863                                  ; ARMAC.
   864                                  DEFINE ARCALL(CALL,DO)<
   865                                  DEFINE X(NUM,NAM,RWX,LIC,FAST)<
   866                                  IFNB <FAST> <
   867                                  'CALL
   868                                  >;END IFNB FAST
   869                                  >;END X MACRO DEFINITION
   870                                  
   871                                          DO              ;;FIRST CALL FOR EACH FAST RIGHT
   872                                  
   873                                  DEFINE X(NUM,NAM,RWX,LIC,FAST)<
   874                                  IFB <FAST> <
   875                                  'CALL
   876                                  >;END IFNB FAST
   877                                  >;END X MACRO DEFINITION
   878                                  
   879                                          DO              ;;NOW CALL FOR SLOW ONES
   880                                  >;END ARCALL MACRO DEFINITION
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 22
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   881                                  ;GENERATE DEFINITIONS .AR???, EQUAL TO BIT NUMBER IN MONITOR
   882                                  ; ACCESS BIT MAP. FIRST 36 ARE "FAST" ACCESS RIGHTS, THOSE
   883                                  ; KEPT IN JBT TABLES FOR FAST ACCESS. THOSE ABOVE FIRST
   884                                  ; 36 ARE "SLOW", KEPT IN CONTEXT PAGES.
   885
   886
   887                                  DEFINE ARDEF(NAME)<XP .AR'NAME,ZZ
   888                                  ZZ==ZZ+1
   889                                  >;END ARDEF MACRO DEFINITION
   890                                  DEFINE ARDO<IFNDEF FARMAX,<ZZ==0>
   891                                  IFDEF FARMAX,<ZZ==^D36>
   892                                  
   893                                  ARMAC
   894                                  IFNDEF FARMAX,<XP FARMAX,ZZ-1>
   895                                  IFDEF FARMAX,<XP .ARMAX,ZZ-1            ;;HIGHEST ACCESS RIGHTS CODE FOR CHECKING BOUNDS
   896                                  XP FARSIZ,<<FARMAX+1+^D35>/^D36>        ;NUMBER OF WORDS IN FAST RIGHTS JBT TABLES
   897                                  XP .ARSIZ,<<.ARMAX+1+^D35>/^D36>-FARSIZ ;NUMBER OF WORDS FOR SLOW ACCESS RIGHTS BITS
   898                                  IFN FARSIZ-1,<PRINTX TOO MANY FAST ACCESS RIGHTS BITS
   899                                  QQQQQQ>
   900                                  >;END IFDEF FARMAX
   901                                  >;END ARDO MACRO DEFINITION
   902
   903                                  ARCALL(<ARDEF('NAM)>,ARDO)^
   904
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 23
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   905                                  ;FRAME DESCRIPTOR DEFINITIONS
   906
   907                                  ;A FRAME DESCRIPTOR CONSISTS OF AN 18 BIT QUANTITY. 18-20
   908                                  ; ARE THE FRAME DESCRIPTOR TYPE, AND 21-35 ARE THE DATA
   909                                  ; FOR THE TYPE.
   910
   911                                  ;FRAME DESCRIPTOR TYPES
   912                                  ;THE FRAME DESCRIPTOR TYPES FOR OWN FRAME AND ABSOLUTE FRAME
   913                                  ; WERE CHOSEN TO BE 0 AND 7 RESPECTIVELY, TO BE COMPATIBLE WITH
   914                                  ; THE OLD JOB NUMBER CONVENTIONS.
   915
   916                                  XP FDFMSK,7777          ^;MASK TO EXTRACT FRAME NUMBER FROM 18 BIT QUANTITY.
   917                                  XP FDDMSK,77777         ^;DATA FIELD MASK FOR FRAME DESCRIPTOR.
   918
   919
   920                                  XP .FDABS,<0*100000>            ^;ABSOLUTE FRAME NUMBER
   921                                  XP .FDFAM,<1*100000>            ^;FAMILY DESCRIPTOR. 21-23 HAVE SUBTYPE
   922                                     XP .FMCHL,<0*10000>            ^;CHILD
   923                                     XP .FMPAR,<1*10000>            ^;PARENT FRAME.
   924                                     XP .FMMAX,<1*10000>            ^;MAXIMUM LEGAL VALUE.
   925
   926                                  XP .FDOTF,<2*100000>            ^;OTHER FRAME.
   927                                  XP .FDFRH,<3*100000>            ^;FRAME HANDLE
   928                                  XP .FDSLF,<7*100000>            ^;OWN FRAME. DATA IS USUALLY 77777.
   929
   930                                  ;DEFINE GLOBAL MACRO HERE TO GENERATE BYTE POINTER TO
   931                                  ; SUB ERROR CODE LOCATION IN VUUOS.
   932
   933                                  DEFINE FDEERP(LOC)<[POINT 6,'LOC,5]>
   934
   935                                  ;GLOBAL MACROS TO SCAN JBTFTR
   936
   937                                  DEFINE PRNTBP(AC)<[POINT 12,JBTFTR('AC),11]>
   938                                  DEFINE NEIGBP(AC)<[POINT 12,JBTFTR('AC),11+12]>
   939                                  DEFINE CHLDBP(AC)<[POINT 12,JBTFTR('AC),11+2*12]>
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 24
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   940                                  ;HANDLE DEFINITIONS
   941
   942                                  ;A HANDLE IS A BLOCK OF FREE CORE CONTAINING DATA DESCRIBING
   943                                  ; A FRAME AND WHAT ACCESS RIGHTS THE HOLDER HAS OVER THAT FRAME.
   944
   945                                  XP .FHFNO,0             ^;ABSOLUTE FRAME NUMBER THIS HANDLE DESCRIBES
   946                                   XP .FHTYP,0            ^;ANOTHER NAME
   947                                      XP FH.TYP,(7B17)    ^;MASK FOR HANDLE TYPES.
   948                                          XP .FHFRM,0     ^;FRAME HANDLE
   949                                          XP .FHPRC,1     ^;PROCESS HANDLE
   950                                          XP .FHLIC,2     ^;LICENSE HANDLE.
   951                                          XP .FHMAX,2     ^;MAX VALUE FOR CHECKING.
   952                                  ;       XP .FHCLB,?     ;WHEN CLUB HANDLES ARE IMPLEMENTED
   953
   954                                      DEFINE HTPPTR(LOC)<POINT 3,'LOC,17> ;GENERATE BYTE POINTER
   955                                  XP .FHUID,1             ^;36 BIT UNIVERSAL ID NUMBER
   956                                  XP .FHPNO,2             ^;"PROGRAM NUMBER" OF GRANTING PROGRAM.
   957                                  XP .FHART,3             ^;ACCESS RIGHTS BITS
   958                                  XP .FHEND,.FHART+<.ARSIZ+FARSIZ>-1      ^;LAST WORD IN HANDLE
   959
   960                                  XP .FHSIZ,.FHEND+1      ^;SIZE OF A HANDLE.
   961
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 25
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

   962                                  ;UPT AND EPT ASSEMBLY TIME DEFINITIONS
   963
   964                                  DEFINE MAPALC(NAM,SIZ)
   965                                  <
   966                                  IFB <SIZ>,<ZZPAG==ZZPAG-1>
   967                                  IFNB <SIZ>,<ZZPAG==ZZPAG-<SIZ>>
   968                                  XP %'NAM'.N,ZZPAG
   969                                  XP %'NAM',%'NAM'.N_^D9
   970                                  >;END MAPALC MACRO DEFINITION
   971
   972                                  ;DEFINE CONSTANT UPT ADDRESS SPACE SLOTS
   973                                  ; (HAVE NO LMAP ENTRIES, JUST USED FOR MAPPING BY PCB CODE)
   974
   975                  000400          ZZPAG==377+1            ;HIGHEST EXEC VIRTUAL ADDRESS IN UPT + 1
   976
   977                                  MAPALC(SAT)^
   978                                  MAPALC(RIB)^
   979                                  MAPALC(RB2)^
   980
   981                                  XP CNVVPN,1000-340      ^;ADD THIS TO REAL PAGE NUMBER IN EXEC PER PROCESS
   982                                                          ; SPACE TO GET VIRTUAL PAGE NUMBER
   983
   984                                  XP VPMAX,CNVVPN+ZZPAG-1 ^;MAXIMUM NON-SPECIAL UPT VP NUMBER (1000 = 340)
   985
   986                                  ;GENERATE CONSTANT EPT ADDRESS SPACE SLOTS
   987
   988                  001000          ZZPAG==777+1            ;HIGHEST PAGE DESCRIBED IN EPT + 1
   989
   990                                  MAPALC(ERR)^
   991                                  MAPALC(SWP)^
   992                                  MAPALC(DRI)^            ;DR11C BLOCK INPUT PAGE
   993                                  MAPALC(DRO)^            ;DR11C BLOCK OUTPUT PAGE
   994
   995                                  XP EVPMAX,ZZPAG-1       ^;MAXIMUM EXEC VIRTUAL PAGE THAT OTHER MODULES
   996                                                          ; CAN ALLOCATE
   997
   998                                  ;MACRO TO ALLOCATE VIRTUAL PAGES FOR ONCE MODULES
   999
  1000                                  DEFINE MAPONC(NAM,SIZE)<
  1001                                  XP SIZ'NAM,SIZE
  1002                                  MAPALC(NAM,SIZE)
  1003                                  >
  1004
  1005                                  MAPONC(CTX,3)^  ;RESERVED FOR OTHER MODULES (CONTEXT PAGES - %UPS)
  1006
  1007                                  MAPONC(DUM,1)^           ;PADDING FOR ONCE DATA BASE
  1008                                  MAPONC(REF,3)^          ;MAX SIZE OF REFSTR
  1009                                  MAPONC(OND,7)^          ;MAX SIZE OF ONCDSK
  1010                                  MAPONC(ONC,4)^          ;MAX SIZE OF ONCE
  1011
  1012                                  ;MACRO TO CKECK THAT ENOUGH PAGES HAVE BEEN ALLOCATED FOR ONCE
  1013                                  ;MODULES AND PRINT AN ERROR MESSAGE IF NOT
  1014
  1015                                  DEFINE ONSZCK(NAME,NAM,NM)<
  1016                                  DEFINE X(RSIZ,DSIZ)<
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 25-1
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

  1017                                  PRINTX NAME REQUIRES AT LEAST RSIZ PAGES, ONLY DSIZ ARE ALLOCATED.
  1018                                  >
  1019                                  IF2, <IFIDN <NM><>, <
  1020                                  IFG NAM'LNP-SIZ'NAM*1000,<X(\<NAM'LNP/1000>,\SIZ'NAM)>
  1021                                  >>
  1022                                  IF2, <IFDIF <NM><>, <
  1023                                  IFG NAM-SIZ'NM,<X(\NAM,\SIZ'NM)>
  1024                                  >>
  1025                                  >
  1026
  1027                                  ;THE ONCE TIME PCB MAP SLOTS
  1028
  1029                                  ;MACRO TO GENERATE THE SLOT NAMES, USED IN ONCE MACROS
  1030
  1031                                  DEFINE OPCNAM<
  1032                                  X HOM
  1033                                  X HMR
  1034                                  X STA
  1035                                  X STR
  1036                                  X BAT
  1037                                  X TMP
  1038                                  X T2P
  1039                                  >
  1040
  1041
  1042                  000000          NMOCPC==0               ;COUNT NUMBER OF PAGES
  1043                                  DEFINE X(A)<NMOCPC==NMOCPC+1>
  1044                                  OPCNAM  ^               ;COUNT THE NUMBER OF ONCE PCB PAGES.
  1045
  1046
  1047                                  DEFINE X(A)
  1048                                  <MAPALC('A)
  1049                                  >
  1050                                  OPCNAM  ^               ;ALLOCATE THEM.
  1051
  1052                  743000          BOTTM==ZZPAG_^D9        ;LOWEST ONCE TIME PAGE.
  1053
  1054                  000401          ZZPAG==400+1            ;MINIMUM PAGE WE CAN ALLOCATE + 1
  1055                                  MAPALC(MIN)^            ;%MIN IS LOWEST ADDRESS.
  1056
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 26
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

  1057                                  ;MACROS TO MANIPULATE PAGE MAP SLOTS.
  1058
  1059                                  DEFINE EPTPGS(PG,PGS)
  1060                                  <IFL PG-340,<PRINTX ERROR IN EPTPGP PAGE NUMBER PG
  1061                                          QQQQQQ  ;CAUSE ERROR>
  1062                                  IFGE PG-340,<
  1063                                   IFL PG-400,<POINT 18,PGS+UPTEP0+<<PG-340>/2>,17+18*<<PG>&1>>
  1064                                   IFGE PG-400,<POINT 18,EPT+EPTPG0+<<PG-400>/2>,17+18*<<PG>&1>>
  1065                                  >>
  1066
  1067                                  DEFINE EPTPGP (PG)
  1068                                  <       EPTPGS (<PG>,%UPS)>
  1069
  1070                                  ;MACRO TO GENERATE A SLOT POINTER FOR AN EPT BASED VIRTUAL PAGE.
  1071                                  ; PG IS THE VIRTUAL PAGE NUMBER. (MUST BE BETWEEN 400 AND
  1072                                  ; 777. NO CHECK HERE BECAUSE SYMBOL MAY BE EXTERNAL)
  1073
  1074                                  DEFINE EPTPTR(PG) <
  1075                                          POINT 18,EPT+EPTPG0+<<PG-400>/2>,17+18*<<PG>&1>
  1076                                  >
  1077
  1078
  1079                                  ;MACRO TO GENERATE A SLOT POINTER FOR A UPT BASED VIRTUAL PAGE.
  1080                                  ; PG IS THE VIRTUAL PAGE NUMBER, UPX IS WHERE THE UPT
  1081                                  ; PAGE IS ADDRESSABLE.
  1082
  1083                                  DEFINE UPXPTR(PG,UPX)<
  1084                                          POINT 18,UPX+UPTEP0+<<PG-340>/2>,17+18*<<PG>&1>>
  1085
  1086                                  ;MACRO TO GENERATE A SLOT POINTER FOR VIRTUAL PAGE PG
  1087                                  ; WHEN UPT IS KNOWN TO BE IN %UPS.
  1088
  1089                                  DEFINE UPSPTR(PG)<
  1090                                          UPXPTR(PG,%UPS)>
  1091
  1092                                  DEFINE UPMPTR(PG)<POINT 18,%UPT+400+<PG-340>/2,17+18*<<PG>&1>>
  1093
  1094                                  ;UXCTFU, UXCTTU, AND UXCTBU MACROS.
  1095                                  ; USED TO EXECUTE AN INSTRUCTION THAT SPECIFICALLY REFERS
  1096                                  ; TO USER ADDRESS SPACE (PREVIOUS CONTEXT CAN BE EXEC SPACE).
  1097
  1098                                  DEFINE X(A)<IRP A,<
  1099                                  DEFINE UXCT'A'U(INST)<SALL
  1100                                          IF2,<IFNDEF DOXCT,<EXTERNAL DOXCT>>
  1101                                          PUSHJ   P,DOXCT
  1102                                            XCT'A'U       <INST>
  1103                                  >;END DEFINE UXCT'A'U
  1104                                  >;END IRP A
  1105                                  >;END DEFINE X
  1106
  1107                                  X(<T,F,B>)^     ;GENERATE UXCTFU, UXCTTU, AND UXCTBU.
  1108
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 27
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

  1109                                  ;SOFTWARE PAGE FAIL WORD
  1110                                  ; EXISTS BECAUSE OF DISPARITY BETWEEN KI10 AND KL10 PAGE FAIL
  1111                                  ; WORD FORMAT. CURRENTLY SETUP TO MAKE KL PAGE FAIL WORD CONVERT
  1112                                  ; FASTER THAN KI PAGE FAIL WORD.
  1113
  1114                                                  ;BIT 0 RESERVED FOR A COPY OF PC.USR
  1115                                  XP SPFW.U,1B18  ^;SET IF FAULT ADDRESS IS IN USER SPACE
  1116                                  XP SPFW.H,1B19  ^;ON FOR ADDRESS BREAK, PROPRIETARY VIOL, HARD PAGE ERRORS.
  1117                                  XP SPFW.A,1B20  ^;COPY OF A BIT FROM MAP
  1118                                  XP SPFW.W,1B21  ^;COPY OF W BIT
  1119                                  XP SPFW.S,1B22  ^;COPY OF S BIT
  1120                                  XP SPFW.T,1B23  ^;SET IF INSTRUCTION WILL EVENTUALLY TRY TO WRITE
  1121
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 28
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

  1122                                  ; SYSTEM MACROS
  1123
  1124                                  ;MACRO TO PREVENT SCHEDULING, USED AT UUO LEVEL WHEN A
  1125                                  ;REENTRANT ROUTINE IS CHANGING COMMON DATA NOT YET
  1126                                  ;ASSIGNED TO A PARTICULAR JOB
  1127
  1128                                  DEFINE NOSCHED
  1129                                  <>
  1130
  1131                                  ;MACRO TO ALLOW SCHEDULING ONCE MORE
  1132
  1133                                  DEFINE SCHEDULE
  1134                                  <>
  1135
  1136                                  ;MACRO TO PREVENT CORE SHUFFLING, USED AT UUO LEVEL WHEN
  1137                                  ;A ROUTINE SETS UP AN ABSOLUTE USER ADDRESS IN AN AC
  1138                                  ;OTHER THAN PDP,PROG, OR JDAT. THE MAIN EXAMPLE IS A BLT
  1139                                  ;FROM EXEC TO USER OR USER TO EXEC.
  1140
  1141                                  DEFINE NOSHUFF
  1142                                  <>
  1143
  1144                                  ;MACRO TO ALLOW SHUFFLING ONCE MORE
  1145
  1146                                  DEFINE SHUFFLE
  1147                                  <>
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 29
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

  1148                                  COMMENT #Rules for State code Type selection
  1149
  1150                                  The code putting a frame into an SJ state code must leave the
  1151                                  data base in the monitor consistent. The code should not have any
  1152                                  sharable resources when it puts the frame into the SJ state code.
  1153                                  The code must not have any pending interrupt conditions (e.g. DDBs
  1154                                  with IOW set so that SETIOD will be called for the frame) that could
  1155                                  unexpectedly wake the job out of some unrelated wait state.
  1156                                  The code doesn't have to leave either the monitor's or the user's data
  1157                                  base in a continuable state - all code that operates on frames that
  1158                                  doesn't want to disturb the current state of the frame (i.e. it can be started
  1159                                  at the address it stopped without any ill effects on the running
  1160                                  program) is responsible for delaying its action until the UUO
  1161                                  code it was stopped out of has completed. This is what the UTRP
  1162                                  bit is used for.
  1163                                  (Note - I believe that if a job was in an SJ state as a result
  1164                                  of a UUO which will stop the job rather than go through USRXIT,
  1165                                  such as EXIT, the UTRP bit would remain set and the command
  1166                                  that was deferred would not be performed. This is the same
  1167                                  problem that causes address breaks while in the monitor not
  1168                                  to get printed out if the program EXITs out of the breaking
  1169                                  UUO instead of returning to the user.)
  1170
  1171                                  Note that in general, I/O waits (IO, MB) cannot be SJ, since
  1172                                  they leave a DDB with IOW set.
  1173                                  TTY IO wait is an exception, since all frame stopping code will
  1174                                  take all TTY devices out of I/O wait, and the TTY code is written
  1175                                  soas to leave both the monitor and user data base in a continuable
  1176                                  and consistent state.
  1177
  1178                                  All I/O wait states must be prepared for the event of a hung
  1179                                  device. In this event, the DHNG routine for the device is called,
  1180                                  which is responsible for clearing any pending interrupt conditions
  1181                                  for the DDB (IOW bit) as well as cleaning up the device's data
  1182                                  base. ERRCON will clear IOACT for the device.
  1183                                  The monitor data base must be consistent after the DHNG call -
  1184                                  but neither the monitor or the user data base has to be
  1185                                  continuable, since hung device is a fatal condition which stops
  1186                                  the job.
  1187
  1188                                  All device drivers must make sure that the monitor data base
  1189                                  is consistent if DHNG is called, but in general they do not
  1190                                  have to leave it consistent at the time they call WSYNC.
  1191                                  If they do not, the corresponding satisfied state must be
  1192                                  a DJ rather than an SJ state. If the driver is setup so that
  1193                                  the data base is left consistent at WSYNC time and the only
  1194                                  thing that stops the I/O wait code from being SJ is the
  1195                                  IOW DDB, then the corresponding satisfied state can be SJ.
  1196                                  #;END COMMENT
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 30
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

  1197                                  ;DEFINE THE QUEUES, QUANTUM RUNNING TIME IN JIFFIES, AND PRIORITY
  1198                                  ;PRIORITY GOES BACKWARD FROM LOW TO HIGH
  1199                                  ;THE QUEUE NUMBERS START AT 0 AND GO UP BY ONE READING DOWN THE PAGE
  1200                                  ;THE THIRD ARG CAN BE "DJ" FOR DELAY JOB IF CONTOL C TYPED
  1201                                  ; OR "SJ," FOR STOP JOB (WHEN IN EXEC MODE)
  1202
  1203                                  DEFINE QUEUES
  1204                                  <       X RN,7,DJ,      ;;STRAIGHT RUN (LOWEST PRIORITY) (Q=0)
  1205                                          X WS,6,DJ,      ;;I/O WAIT SATISFIED
  1206                                          X TS,6,SJ,      ;;TTY I/O WAIT SATISFIED
  1207                                          X SS,,DJ,       ;;SWAPPER WAIT SATISFIED
  1208                                          X SI,4,DJ,      ;;SAT PRIMARY PCB IO OFF WAIT.
  1209                                          X RI,4,DJ,      ;;RIB PRIMARY PCB IO OFF WAIT.
  1210                                          X PS,4,DJ,      ;;SAT PRIMARY PCB WAIT.
  1211                                          X PR,4,DJ,      ;;RIB PRIMARY PCB WAIT.
  1212                                          X M2,4,DJ,      ;;2 PCBS WAIT.
  1213                                          X DA,4,DJ,      ;;DISK STORAGE ALLOCATION WAIT
  1214                                          X CB,4,DJ,      ;;DISK CORE-BLOCK SCAN WAIT
  1215                                          X FC,4,DJ       ;;FREE CORE WAIT FOR I/O LIST AREA
  1216                                          X MT,4,SJ,      ;;MAGTAPE CONTROL WAIT (UP TO 8 UNITS)
  1217                                          X AX,4,SJ,      ;;WAIT FOR AUX CIRCUIT RESOURCE
  1218                                          X AC,4,SJ,      ;;WAIT FOR SPACE IN ACCOUNTING BUFFER
  1219                                          X BP,4,SJ,      ;;BLOCK I/O PORT WAIT
  1220                                  >
  1221
  1222                                  ;;JOB STATUS CODES WHICH HAVE NO CORRESPONDING QUEUES
  1223                                  ;;JOBS ARE UNRUNABLE WHEN IN THESE STATES
  1224
  1225                                  DEFINE CODES
  1226                                  <       X IOW,,DJ,      ;;I/O WAIT
  1227                                          X MBW,,DJ,      ;;MONITOR BUFFER I/O WAIT
  1228                                          X CW,,DJ,       ;;CONTEXT PAGE WRITE LOCK QUEUE.
  1229                                          X TIOW,,SJ,     ;;TTY I/O WAIT
  1230                                          X SW,,DJ,       ;;SWAPPER OUTPUT WAIT (PGYPGO)
  1231                                          X MLOW,,DJ,     ;;PCB LOCK Q WAIT.
  1232                                          X ILW,,SJ,      ;;CLUB INTERLOCK WAIT.
  1233                                          X FLW,,DJ,      ;;ATOMIC FILE LOCKING WAIT.
  1234                                          X SLP,,SJ,      ;;JOB SLEEPING
  1235                                          X NUL,,SJ,      ;;JOB NUMBER NOT ASSIGNED
  1236                                          X STOP,,SJ,     ;;STOP (CONTROL C)
  1237                                  >
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 31
S       MAC     26-Apr-71 10:47         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

  1238                                          SALL            ;CLEAN MACROS, PLEASE.
  1239
  1240                                          ASUPPRESS       ;;ELIMINATE ALL SYMBOLS NOT REFERENCED LATER
  1241                                                          ;; FROM THE SYMBOL TABLE LISTING
  1242
  1243                                  ;;LAST PAGE SHOULD BE WRITTEN WITH 'HP' TECO COMMAND SO FORM-FEED IS
  1244                                  ;; NOT APPENDED AFTER 'LIST' CAUSING EXTRA BLANK PAGE IN MONITOR LISTING.
  1245                                  ;;HOWEVER, 2 CARRIAGE RETURN-LINE FEED'S FOLLOWING THE 'LIST' ARE DESIRABLE.
  1246
  1247                                  IFDEF LISTSN, <IFN LISTSN, <  PAGE  >>
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 1
KLSYM   MAC     29-Feb-69 23:36         SYSTEM PARAMETER DEFINITIONS FOR PDP-6 AND PDP-10 TIME SHARING MONITORS

  1248                                  00300   ;THIS MODULE ASSEMBLED WITH KL-10 PARAMETER FILE - KLSYM.MAC
  1249                                  00400   
  1250                                  00500           IF2,<IFNDEF LISTSN,<            ;LIST KLSYM.MAC IN COMMON ONLY
  1251                                  00600                                   TAPE>>
  1252                                  00700   
  1253                                  00800                                           ;SKIP PASS2 IN ALL OTHER CASES
  1254                                  00900   IF2,<
  1255                                  01000   SUBTTL KL-10 PARAMTER DEFINTIONS FOR PDP-10 MONITOR
  1256                                  01100   ;       /EVS 3 MAR 78
  1257                                  01200   >;END IF2
  1258                                  01300   
  1259                                  01400   ;CPU TYPE SYMBOL DEFINITION
  1260                                  01500   
  1261                  000002          01600   CPUTYP==CPUKL
  1262                                  01700   DEFINE IFKMC<REPEAT 0,>
  1263                                  01800   DEFINE IFNKMC<REPEAT 1,>
  1264

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 2
KLSYM   MAC     29-Feb-69 23:36         KL-10 INSTRUCTION AND OPCODE DEFINITIONS

  1265                                  00100   SUBTTL KL-10 INSTRUCTION AND OPCODE DEFINITIONS
  1266                                  00200   
  1267                                  00300   ;KL10 INTERNAL DEVICE OPCODES
  1268                                  00400   
  1269                  000000          00500   APR==0
  1270                  000004          00600   PI==4
  1271                  000010          00700   PAG==10
  1272                  000014          00800   CCA==14                 ;CACHE
  1273                  000020          00900   TIM==20                 ;INTERVAL TIMER,TIME BASE
  1274                  000024          01000   MTR==24                 ;ACCOUNTING METERS, PERFORMANCE METER
  1275                                  01100   
  1276                                  01200   ;OPDEFS FOR KL10 INSTRUCTIONS
  1277          700600  000000          01300           OPDEF   WRPI    [CONO PI,]      ;
  1278          700640  000000          01400           OPDEF   RDPI    [CONI PI,]      ;
  1279          105000  000000          01500           OPDEF   ADJSP   [105B8] ;ADJUST STACK POINTER
  1280          256000  000000          01600           OPDEF   PXCT    [XCT]   ;PREVIOUS CONTEXT EXECUTE
  1281          114000  000000          01700           OPDEF   DADD    [114B8] ;DOUBLE ADD
  1282          115000  000000          01800           OPDEF   DSUB    [115B8] ;DOUBLE SUB
  1283          116000  000000          01900           OPDEF   DMUL    [116B8] ;DOUBLE MUL
  1284          117000  000000          02000           OPDEF   DDIV    [117B8] ;DOUBLE DIV
  1285          133000  000000          02100           OPDEF   ADJBP   [IBP]   ;ADJUST BYTE POINTER
  1286          700000  000000          02200           OPDEF   APRID   [BLKI APR,]     ;READ PROCESSOR SERIAL, UCODE VERSION
  1287          700100  000000          02300           OPDEF   WRFIL   [BLKO APR,]     ;WRITE CACHE REFILL ALGORITHM
  1288          700240  000000          02400           OPDEF   RDAPR   [CONI APR,]
  1289          700200  000000          02500           OPDEF   WRAPR   [CONO APR,]
  1290          700140  000000          02550           OPDEF   WRADB   [DATAO APR,]
  1291          700400  000000          02600           OPDEF   RDERA   [BLKI PI,]      ;READ ERROR ADDRESS REGISTER
  1292          700500  000000          02700           OPDEF   SBDIAG  [BLKO PI,]      ;SBUS DIAGNOSTIC
  1293          701100  000000          02800           OPDEF   CLRPT   [BLKO PAG,]     ;CLEAR ONE ENTRY IN HARDWARE
  1294                                  02900                                           ; PAGE TABLE
  1295          701200  000000          03000           OPDEF   WREBR   [CONO PAG,]     ;
  1296          701240  000000          03075           OPDEF   RDEBR   [CONI PAG,]     ;
  1297          701140  000000          03100           OPDEF   WRUBR   [DATAO PAG,]    ;
  1298          701040  000000          03150           OPDEF   RDUBR   [DATAI PAG,]    ;
  1299          701440  000000          03200           OPDEF   SWPIA   [DATAI CCA,]    ;INVALIDATE ALL CACHE DATA,
  1300                                  03300                                           ; WITHOUT UPDATING CORE
  1301          701500  000000          03400           OPDEF   SWPVA   [BLKO CCA,]     ;SWEEP CACHE, VALIDATING CORE
  1302                                  03500                                           ; FOR ALL PAGES, LEAVING CACHE VALID
  1303          701540  000000          03600           OPDEF   SWPUA   [DATAO CCA,]    ;UNLOAD ALL PAGES, UPDATING
  1304                                  03700                                           ; CORE AND INVALIDATING CACHE
  1305          701640  000000          03800           OPDEF   SWPIO   [CONI CCA,]     ;INVALIDATE ONE PAGE
  1306          701700  000000          03900           OPDEF   SWPVO   [CONSZ CCA,]    ;VALIDATE ONE PAGE
  1307          701740  000000          04000           OPDEF   SWPUO   [CONSO CCA,]    ;UNLOAD ONE PAGE
  1308          702000  000000          04100           OPDEF   RDPERF  [BLKI TIM,]     ;READ DOUBLE-WORD PERFORMANCE
  1309                                  04200                                           ; ANALYSIS COUNTER
  1310          702040  000000          04300           OPDEF   RDTIME  [DATAI TIM,]    ;READ DOUBLE-WORD TIME BASE
  1311          702100  000000          04400           OPDEF   WRPAE   [BLKO TIM,]     ;WRITE PERFORMANCE ANALYSIS
  1312                                  04500                                           ; ENABLES
  1313          702400  000000          04600           OPDEF   RDMACT  [BLKI MTR,]     ;READ DOUBLE-WORD MBOX
  1314                                  04700                                           ; ACCOUNTING COUNT
  1315          702440  000000          04800           OPDEF   RDEACT  [DATAI MTR,]    ;READ DOUBLE-WORD EBOX
  1316                                  04900                                           ; ACCOUNTING COUNT
  1317

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 3
KLSYM   MAC     29-Feb-69 23:36         HARDWARE BITS -- FOR KL10 PROCESSOR

  1318                                  00100           SUBTTL  HARDWARE BITS -- FOR KL10 PROCESSOR
  1319                                  00200   
  1320                                  00300   ;APRID BITS.
  1321                                  00400   
  1322                  007777          00500   APRSER==7777            ;PROCESSOR SERIAL NUMBER.
  1323                                  00600   
  1324                                  00700   
  1325                                  00800   ;LEFT HALF RDAPR (APR CONI) BITS.
  1326                                  00900   
  1327          004000  000000          01000   LP.SEE==1B6             ;SBUS ERROR ENABLED
  1328          002000  000000          01100   LP.NEE==1B7             ;NXM ERROR ENABLED
  1329          001000  000000          01200   LP.IFE==1B8             ;I/O PAGE FAIL ERROR ENABLED
  1330          000400  000000          01300   LP.PEE==1B9             ;PARITY ERROR ENABLED
  1331          000200  000000          01400   LP.CDE==1B10            ;CACHE DIRECTORY PARITY ERROR ENABLED
  1332          000100  000000          01500   LP.PDE==1B11            ;PAGE TABLE DIRECTORY PARITY ERROR ENABLED
  1333          000040  000000          01600   LP.PFE==1B12            ;POWER FAIL ENABLED
  1334          000020  000000          01700   LP.SDE==1B13            ;SWEEP DONE ENABLED
  1335                                  01800   
  1336                                  01900   ;RIGHT HALF CONI (APR CONI) BITS
  1337                                  02000   
  1338                  200000          02100   LP.CSB==1B19            ;CACHE SWEEP BUSY
  1339                  004000          02200   LP.SBE==1B24            ;S-BUSS ERROR
  1340                  002000          02300   LP.NXM==1B25            ;NXM
  1341                  001000          02400   LP.IOF==1B26            ;I/O PAGE FAIL
  1342                  000400          02500   LP.PAR==1B27            ;PARITY ERROR
  1343                  000200          02600   LP.CDP==1B28            ;CACHE DIRECTORY PARITY ERROR
  1344                  000100          02700   LP.ADP==1B29            ;ADDRESS PARITY ERROR
  1345                  000040          02800   LP.PWF==1B30            ;POWER FAIL
  1346                  000020          02900   LP.CSD==1B31            ;CACHE SWEEP DONE
  1347                  000010          03000   LP.INT==1B32            ;INTERRUPT REQUEST
  1348                  000007          03100   LP.PIA==7B35            ;PIA
  1349                                  03200   
  1350                                  03300   ;WRAPR (CONO APR BITS)
  1351                  200000          03400   LP.IOR==1B19            ;IO RESET
  1352                  100000          03500   LP.ESF==1B20            ;ENABLE SELECTED FLAGS (BITS 24-31)
  1353                  040000          03600   LP.DSF==1B21            ;DISABLE SELECTED FLAGS (BITS 24-31)
  1354                  020000          03700   LP.CSF==1B22            ;CLEAR SELECTED FLAGS (BITS 24-31)
  1355                  010000          03800   LP.SSF==1B23            ;SET SELECTED FLAGS (BITS 24-31)
  1356                  004000          03900   LP.SBE==1B24            ;S-BUSS ERROR
  1357                  002000          04000   LP.NXM==1B25            ;NXM
  1358                  001000          04100   LP.IOF==1B26            ;I/O PAGE FAIL
  1359                  000400          04200   LP.PAR==1B27            ;PARITY ERROR
  1360                  000200          04300   LP.CDP==1B28            ;CACHE DIRECTORY PARITY
  1361                  000100          04400   LP.ADP==1B29            ;ADDRESS PARITY
  1362                  000040          04500   LP.PWF==1B30            ;POWER FAIL
  1363                  000020          04600   LP.CSD==1B31            ;CACHE SWEEP DONE
  1364                  000007          04700   LP.PIA==7B35            ;PIA
  1365                                  04800   
  1366

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 4
KLSYM   MAC     29-Feb-69 23:36         HARDWARE BITS -- FOR KL10 PROCESSOR

  1367                                  00100   ;HERE ARE APR BITS THAT ARE COMPATIBLE BETWEEN KL10 AND KI10.
  1368                                  00200   ; USE NAMES FORMERLY USED FOR KI10 APR BITS TO MAKE
  1369                                  00300   ; THINGS EASIER.
  1370                                  00400   
  1371                  200000          00500   XP APRIOB,LP.IOR        ;IOB RESET
  1372                  001000          00600   XP APRIOP,LP.IOF        ;IO PAGE FAIL
  1373                  002000          00700   XP APRNXM,LP.NXM        ;NXM
  1374                  000400          00800   XP APRPAR,LP.PAR        ;(MB) PARITY ERROR
  1375                  000040          00900   XP APRPOW,LP.PWF        ;POWER FAILURE
  1376                                  00910   
  1377                                  00920   ;MASKS FOR INTERRUPTS
  1378                                  00930   
  1379                  003340          00940   XP APFMSK,LP.ADP+LP.IOF+LP.CDP+LP.PWF+LP.NXM ;FATAL ERROR INTERRUPTS
  1380                  007760          00950   XP APRMSK,APFMSK+LP.PAR+LP.CSD+LP.SBE           ;MASK FOR ALL INTERRUPT CONDITIONS
  1381                                  00960   
  1382                                  00970   DEFINE CLPARF<CONO APR,LP.CSF+LP.PAR+LP.SBE> ;CLEAR PARITY ERROR MACRO
  1383                  022400          00980   XP CLRNXM,<LP.CSF+LP.NXM+LP.PAR>        ;CONO APR,CLRNXM CLEARS NXM
  1384                                  00990                                   ;(NXM ALSO CAUSES MB PARITY ERROR TO COME UP)
  1385                                  01000   
  1386                                  01100   ;LEFT HALF CONI PI BITS
  1387          000100  000000          01200   LI.PR1==1B11            ;PROGRAM P1 REQUEST FOR CHANNEL 1
  1388          000040  000000          01300   LI.PR2==1B12            ;PROGRAM PI REQUEST FOR CHANNEL 2
  1389          000020  000000          01400   LI.PR3==1B13            ;PROGRAM PI REQUEST FOR CHANNEL 3
  1390          000010  000000          01500   LI.PR4==1B14            ;PROGRAM PI REQUEST FOR CHANNEL 4
  1391          000004  000000          01600   LI.PR5==1B15            ;PROGRAM PI REQUEST FOR CHANNEL 5
  1392          000002  000000          01700   LI.PR6==1B16            ;PROGRAM PI REQUEST FOR CHANNEL 6
  1393          000001  000000          01800   LI.PR7==1B17            ;PROGRAM PI REQUEST FOR CHANNEL 7
  1394                                  01900   
  1395                                  02000   ;RIGHT HALF PI CONI BITS.
  1396                                  02100   
  1397                  400000          02200   LI.EPA==1B18                    ;EVEN PARITY ADDRESSES
  1398                  200000          02300   LI.EPD==1B19                    ;EVEN PARITY DATA
  1399                  100000          02400   LI.EPC==1B20            ;EVEN PARITY IN CACHE DIRECTORY
  1400                  040000          02500   LI.IP1==1B21                    ;INTERRUPT IN PROGRESS ON PI CHANNEL 1
  1401                  020000          02600   LI.IP2==1B22                    ;INTERRUPT IN PROGRESS ON PI CHANNEL 2
  1402                  010000          02700   LI.IP3==1B23                    ;INTERRUPT IN PROGRESS ON PI CHANNEL 3
  1403                  004000          02800   LI.IP4==1B24                    ;INTERRUPT IN PROGRESS ON PI CHANNEL 4
  1404                  002000          02900   LI.IP5==1B25                    ;INTERRUPT IN PROGRESS ON PI CHANNEL 5
  1405                  001000          03000   LI.IP6==1B26                    ;INTERRUPT IN PROGRESS ON PI CHANNEL 6
  1406                  000400          03100   LI.IP7==1B27                    ;INTERRUPT IN PROGRESS ON PI CHANNEL 7
  1407                  077400          03200   LI.IPA==LI.IP1+LI.IP2+LI.IP3+LI.IP4+LI.IP5+LI.IP6+LI.IP7
  1408                                  03300                                   ;INTERRUPT IN PROGRESS ON ANY OR ALL PI CHANNELS
  1409                  000200          03400   LI.PIA==1B28                    ;PI ACTIVE
  1410                  000100          03500   LI.CO1==1B29                    ;PI CHANNEL 1 ON
  1411                  000040          03600   LI.CO2==1B30                    ;PI CHANNEL 2 ON
  1412                  000020          03700   LI.CO3==1B31                    ;PI CHANNEL 3 ON
  1413                  000010          03800   LI.CO4==1B32                    ;PI CHANNEL 4 ON
  1414                  000004          03900   LI.CO5==1B33                    ;PI CHANNEL 5 ON
  1415                  000002          04000   LI.CO6==1B34                    ;PI CHANNEL 6 ON
  1416                  000001          04100   LI.CO7==1B35                    ;PI CH7NNEL 7 ON
  1417                  000177          04200   LI.ACO==LI.CO1+LI.CO2+LI.CO3+LI.CO4+LI.CO5+LI.CO6+LI.CO7
  1418                                  04300   
  1419                                  04400   ;BITS IN CONO PI (WRPI)
  1420                                  04500   
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 4-1
KLSYM   MAC     29-Feb-69 23:36         HARDWARE BITS -- FOR KL10 PROCESSOR

  1421                  020000          04600   LI.CPP==1B22            ;CLEAR PROGRAM REQUEST
  1422                  010000          04700   LI.CPS==1B23            ;CLEAR PI SYSTEM
  1423                  004000          04800   LI.REQ==1B24            ;REQUEST INTERRUPT ON CHANNEL (EVEN IF CHAN IS OFF)
  1424                  002000          04900   LI.CON==1B25            ;TURN SELECTED CHANNEL ON
  1425                  001000          05000   LI.COF==1B26            ;TURN SELECTED CHANNEL OFF
  1426                  000400          05100   LI.PIF==1B27            ;TURN SYSTEM OFF
  1427                  000200          05200   LI.PIN==1B28            ;TURN SYSTEM ON
  1428                  000177          05300   LI.ACO==LI.ACO          ;MASK FOR SELECTING CHANNELS.
  1429

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 5
KLSYM   MAC     29-Feb-69 23:36         HARDWARE BITS -- FOR KL10 PROCESSOR

  1430                                  00100   ;BITS FOR KL10 PROGRAM CLOCKS
  1431                                  00200   
  1432                                  00300   
  1433                                  00400   ;BITS IN CONO TIM,
  1434                                  00500   
  1435                  400000          00600   TO.CIT==1B18            ;CLEAR INTERVAL TIMER
  1436                  040000          00700   TO.SIT==1B21            ;START INTERVAL TIMER
  1437                  020000          00800   TO.CTD==1B22            ;CLEAR TIMER DONE
  1438                  000001          00900   TO.PRP==1B35            ;POSITION OF PERIOD FIELD
  1439                  000014          01000   TO.PRS==^D12            ;SIZE OF PERIOD FIELD
  1440                  007777          01100   TO.PRF==7777B35         ;THE FIELD ITSELF
  1441                                  01200   
  1442                                  01300   
  1443                                  01400   ;BITS IN CONI TIM,
  1444                                  01500   
  1445          000001  000000          01600   TI.INP==1B17            ;POSITION OF INTERVAL TIMER FIELD
  1446                  000014          01700   TI.INS==^D12            ;SIZE OF IT
  1447          007777  000000          01800   TI.INF==7777B17         ;THE FIELD ITSELF
  1448                  040000          01900   TI.TIO==1B21            ;INTERVAL TIMER ON
  1449                  020000          02000   TI.ITD==1B22            ;INTERVAL TIMER DONE
  1450                  010000          02100   TI.TOV==1B23            ;TIMER OVERFLOW
  1451                  000001          02200   TI.PRP==1B35            ;PERIOD REGISTER POSITION
  1452                  000014          02300   TI.PRS==^D12            ;SIZE
  1453                  007777          02400   TI.PRF==7777B35         ;FIELD
  1454                                  02500   
  1455                                  02600   
  1456                                  02700   ;BITS IN CONO MTR,
  1457                                  02800   
  1458                  400000          02900   MO.LAC==1B18            ;LOAD ACCOUNTING CONTROL
  1459                  040000          03000   MO.AIP==1B21            ;ACCT INCLUDE PI
  1460                  020000          03100   MO.AEN==1B22            ;ACCT INCLUDE EXEC NO PI
  1461                  010000          03200   MO.AO==1B23             ;ACCT ON
  1462                  004000          03300   MO.TOF==1B24            ;TIME BASE OFF
  1463                  002000          03400   MO.TON==1B25            ;TIME BASE ON
  1464                  001000          03500   MO.CTB==1B26            ;CLEAR TIME BASE
  1465                  000007          03600   MO.IPI==7B35            ;INTERVAL TIMER PI
  1466                                  03700   
  1467                                  03800   ;BITS IN CONI MTR,
  1468                                  03900   
  1469                  040000          04000   MI.AIP==1B21            ;ACCT INCLUDE PI
  1470                  020000          04100   MI.AEN=1B22             ;ACCT INCLUDE EXEC NO PI
  1471                  010000          04200   MI.AO==1B23             ;ACCT ON
  1472                  002000          04300   MI.TON==1B25            ;TIME BASE ON
  1473                  000007          04400   MI.IPI==7B35            ;INTERVAL TIMER PI
  1474

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 6
KLSYM   MAC     29-Feb-69 23:36         HARDWARE BITS -- FOR KL10 PROCESSOR

  1475                                  00100   ;LEFT HALF WRPAE BITS
  1476                                  00200   
  1477          400000  000000          00300   PE.CP0==1B0             ;CHANNEL 0 PERFORMANCE ENABLE
  1478          200000  000000          00400   PE.CP1==1B1             ; CHANNEL 1
  1479          100000  000000          00500   PE.CP2==1B2
  1480          040000  000000          00600   PE.CP3==1B3
  1481          020000  000000          00700   PE.CP4==1B4
  1482          010000  000000          00800   PE.CP5==1B5
  1483          004000  000000          00900   PE.CP6==1B6
  1484          002000  000000          01000   PE.CP7==1B7
  1485          001000  000000          01100   PE.CPI==1B8             ;CHANNEL PERFORMANCE IGNORE
  1486                                  01200   
  1487          000400  000000          01300   PE.UCI==1B9             ;MICROCODE STATE IGNORE
  1488          000200  000000          01400   PE.PRL==1B10            ;PROBE LOW ENABLE
  1489          000100  000000          01500   PE.PRI==1B11            ;PROBE STATE IGNORE
  1490                                  01600   
  1491          000040  000000          01700   PE.CCR==1B12            ;CACHE REFILL ENABLE
  1492          000020  000000          01800   PE.CCF==1B13            ;CACHE FILL ENABLE
  1493          000010  000000          01900   PE.EWB==1B14            ;EBOX WRITE BACK
  1494          000004  000000          02000   PE.SWB==1B15            ;SWEEP WRITE BACK ENABLE
  1495          000002  000000          02100   PE.CCI==1B16            ;CACHE CONDITION IGNORE
  1496                                  02200   
  1497                                  02300   ;RIGHT HALF WRPAE BITS
  1498                                  02400   
  1499                  400000          02500   PE.PP0==1B18            ;PI 0 PERFORMANCE ENABLE
  1500                  200000          02600   PE.PP1==1B19
  1501                  100000          02700   PE.PP2==1B20
  1502                  040000          02800   PE.PP3==1B21
  1503                  020000          02900   PE.PP4==1B22
  1504                  010000          03000   PE.PP5==1B23
  1505                  004000          03100   PE.PP6==1B24
  1506                  002000          03200   PE.PP7==1B25
  1507                  001000          03300   PE.NPI==1B26            ;NO PI
  1508                                  03400   
  1509                  000400          03500   PE.PCU==1B27            ;PC USER ENABLE
  1510                  000200          03600   PE.PCI==1B28            ;PC IGNORE
  1511                  000100          03700   PE.EVM==1B29            ;EVENT MODE (RATHER THAN DURATION MODE)
  1512                  000040          03800   PE.CLR==1B30            ;CLEAR PERFORMANCE METER
  1513                                  03900   
  1514                                  04000   ;COMBINATIONS
  1515                                  04100   
  1516                  777000          04200   PE.PIN==PE.NPI!<377*<PE.PP7>>   ;PI CONDI9ION IGNORE
  1517                                  04300   
  1518                                  04400   
  1519                                  04500   ;VALUES FOR THE CLOCKS
  1520                                  04600   
  1521                  010000          04700   .EBCPT==10000           ;EBOX COUNTS/EBOX TICK
  1522                  010000          04800   .MBCPT==10000           ;MBOX COUNTS/MBOX TICK
  1523                  010000          04900   .TBCPT==10000           ;TIME BASE COUNTS/TIME BASE TICK
  1524                                  05000   
  1525                  000027          05100   TB.LTP==^L<.TBCPT>      ;POSITION THAT TIME BASE STARTS COUNTING IN
  1526

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 7
KLSYM   MAC     29-Feb-69 23:36         HARDWARE BITS -- FOR KL10 PROCESSOR

  1527                                  00100   ;BITS IN CONO PAG
  1528                  400000          00200   LG.CSL==1B18            ;CACHE STRATEGY LOOK
  1529                  200000          00300   LG.CSW==1B19            ;CACHE STRATEGY WRITE
  1530                  040000          00400   LG.KLP==1B21            ;KL PAGING IN EFFECT.
  1531                  020000          00500   LG.TEN==1B22            ;TRAP ENABLE
  1532                  007777          00600   LG.EPT==7777            ;ADDRESS OF EPT
  1533                                  00700   
  1534                                  00800   ;BITS IN WRUBR (DATAO PAG).
  1535          400000  000000          00900   LG.LAB==1B0             ;LOAD AC BLOCKS
  1536          200000  000000          01000   LG.LPC==1B1             ;LOAD PREV CONTEXT
  1537          100000  000000          01100   LG.LUB==1B2             ;LOAD USER BASE REGISTER
  1538          007000  000000          01200   LG.CAC==7B8             ;CURRENT AC BLOCK #
  1539          000700  000000          01300   LG.PAC==7B11            ;PREV. AC BLOCK #
  1540          000040  000000          01400   LG.CSX==1B12            ;CSWX
  1541          000037  000000          01500   LG.PCS==37B17           ;PREVIOUS CONTEXT SECTION
  1542                  400000          01600   LG.IAM==1B18            ;INHIBIT STORING ACCOUNTING METER
  1543                  017777          01700   LG.UPT==17777           ;ADDRESS OF UBR
  1544                                  01800   
  1545

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 8
KLSYM   MAC     29-Feb-69 23:36         HARDWARE BITS -- FOR KL10 PROCESSOR

  1546                                  00100   ;DTE20 CONO BITS (NAMES FROM KL10 EFS CHAP 4.3)
  1547                                  00200   
  1548                                  00300   
  1549                  020000          00400   TO11DB==1B22    ;TO -11 DOOR BELL
  1550                  010000          00500   CR11B==1B23     ;CLEAR RELOAD -11 BUTTO0
  1551                  004000          00600   SR11B==1B24     ;SET RELOAD -11 BUTTON
  1552                  001000          00700   CL11PT==1B26    ;CLEAR -11 REQUESTING A 10 INTERRUPT BIT
  1553                  000400          00800   TO11ER==1B27    ;TO -11 ERROR
  1554                  000100          00900   CLTO11==1B29    ;CLEAR TO -11 NORMAL TERMINATION FLAG (TO11DN)
  1555                  000040          01000   CLTO10==1B30    ;CLEAR TO -10 NORMAL TERMINATION FLAG (TO10DN)
  1556                  000020          01100   PILDEN==1B31    ;ENABLE LOADING PIA
  1557                  000010          01200   PI0ENB==1B32    ;PI0 ENABLE
  1558                  000007          01300   PIA==7B35       ;PIA
  1559                                  01400   
  1560                                  01500   ;DTE20 CONI BITS 
  1561                  100000          01600   RM==1B20        ;RESTRICTED MODE 11
  1562                  040000          01700   DEAD11==1B21    ;11 POWER FAILURE
  1563                  020000          01800   TO11DB==1B22    ;TO -11 DOORBELL PRESSED
  1564                  001000          01900   TO10DB==1B26    ;TO -10 DOORBELL
  1565                  000400          02000   TO11ER==1B27    ;ERROR OCCURRED DURING TO-11 XFER (CLEARED BY CLTO11)
  1566                  000100          02100   TO11DN==1B29    ;TO -11 NORMAL TERMINATION
  1567                  000040          02200   TO10DN==1B30    ;TO -10 NORMAL TERMINATION
  1568                  000020          02300   TO10ER==1B31    ;TO -10 ERROR
  1569                  000010          02400   PI0ENB==1B32    ;PI0 ENABLE
  1570                  000007          02500   PIA==7B35       ;PIA
  1571                                  02600   
  1572                  000200          02700   DTE==200        ;DEVICE CODE FOR DTE20
  1573

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 9
KLSYM   MAC     29-Feb-69 23:36         HARDWARE PAGING PARAMETERS

  1574                                  00100   SUBTTL HARDWARE PAGING PARAMETERS
  1575                                  00200   
  1576                                  00300   ;PAGE FAIL (AND MAP INSTRUCTION) WORD DEFINITIONS
  1577                                  00400   
  1578                  400000          00500   XP PFW.U,(1B0)          ;USER/EXEC ADDRESS SPACE BIT
  1579                  200000          00510   XP PFW.H,(1B1)          ;"HARDWARE" REASON FOR PAGE FAIL.
  1580                                  00600   
  1581                                  00700   ;THE FOLLOWING DEFINITIONS APPLY IF PFW.H IS ZERO:
  1582                                  00800   
  1583                  100000          00900   XP PFW.A,(1B2)          ;COPY OF A BIT FROM MAP SLOT
  1584                  040000          01000   XP PFW.W,(1B3)          ;W BIT FROM MAP SLOT
  1585                  020000          01100   XP PFW.S,(1B4)          ;S BIT
  1586                  010000          01200   XP PFW.T,(1B5)          ;ON IF WRITE WAS ATTEMPTED.
  1587                                  01300                           ; (DOESN'T SAY THATS WHY IT FAILED, THOUGH.)
  1588                  004000          01400   XP PFW.P,(1B6)          ;PUBLIC BIT FROM MAP SLOT
  1589                  002000          01500   XP PFW.C,(1B7)          ;CACHE BIT
  1590                  001000          01600   XP PFW.R,(1B8)          ;PAGED REFERENCE (MAP INSTRUCTION)
  1591                                  01700   
  1592                                  01800   ;IF PFW.H IS 1, FOLLOWING CODES APPLY:
  1593                                  01900   
  1594                  000021          02000   XP PF.PRV,21            ;PROPRIETARY VIOLATION
  1595                  000022          02100   XP PF.RFE,22            ;PAGE REFILL ERROR
  1596                  000023          02200   XP PF.ABK,23            ;ADDRESS BREAK
  1597                  000024          02300   XP PF.ILI,24            ;ILLEGAL INDIRECT (KL PAGING ONLY)
  1598                  000025          02400   XP PF.PTP,25            ;PAGE TABLE PARITY ERROR
  1599                  000027          02500   XP PF.ILS,27            ;ILLEGAL SECTION (EXTENDED ADDRESSING)
  1600                  000036          02600   XP PF.ARP,36            ;AR DATA PARITY ERROR
  1601                  000037          02700   XP PF.AXP,37            ;ARX DATA PARITY ERROR
  1602                                  02800   
  1603                                  02900   ;PAGE MAP POINTER BITS (KI PAGING)
  1604                                  03000   
  1605                  400000          03100   XP PGE.A,400000
  1606                  200000          03200   XP PGE.P,200000
  1607                  100000          03300   XP PGE.W,100000
  1608                  040000          03400   XP PGE.S,40000
  1609                  020000          03500   XP PGE.C,20000          ;CACHE BIT
  1610

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 10
KLSYM   MAC     29-Feb-69 23:36         HARDWARE PAGING PARAMETERS

  1611                                  00100   ;PC BITS.
  1612                                  00200   
  1613                  020000          00250   XP PC.FPD,1B22  ;FIRST PART DONE
  1614                  010000          00300   XP PC.USR,1B23
  1615                  004000          00400   XP PC.UIO,1B24  ;USER IO
  1616                  002000          00500   XP PC.PUB,1B25  ;PUBLIC
  1617                  001000          00600   XP PC.ADR,1B26  ;ADDRESS FAILURE INHIBIT
  1618                  000600          00700   XP PC.TRP,3B28  ;TRAP FLAGS
  1619                  400000          00800   XP PC.OV,1B18   ;OVERFLOW
  1620                  040000          00900   XP PC.FOV,1B21  ;FLOATING OVERFLOW
  1621                  000100          01000   XP PC.FXU,1B29  ;FLOATING EXPONENT UNDERFLOW
  1622                  000040          01100   XP PC.DCK,1B30  ;DIVIDE CHECK
  1623

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 11
KLSYM   MAC     29-Feb-69 23:36         HARDWARE PAGING PARAMETERS

  1624                                  00100   ;LOCATIONS IN UPT FIXED BY KL-10 HARDWARE
  1625                                  00200   
  1626                  000000          00300   XP UPTGP0,0             ;PAGE 0 OF USER
  1627                  000400          00400   XP UPTEP0,400           ;FIRST PAGE OF EXEC (340) IN UPT
  1628                                  00500   
  1629                  000420          00510   XP UPTPGT,420           ;(REALLY SOFTWARE LOCATION).
  1630                  000421          00600   XP UPTOVT,421           ;OVERFLOW TRAP INSTRUCTION
  1631                  000422          00700   XP UPTPOV,422           ;PDL OVERFLOW
  1632                  000423          00800   XP UPTTR3,423           ;TRAP 3
  1633                  000424          00900   XP UPTMUU,424           ;MUUO STORED HERE
  1634                  000425          01000   XP UPTMUP,425           ;MUUO PC STORED HERE
  1635                  000426          01100   XP UPTPCW,426           ;PROCESS CONTEXT WORD (SECTION, ETC)
  1636                                  01200                           ; (427 UNUSED)
  1637                  000430          01300   XP UPTKNT,430           ;KERNAL NO TRAP WORD
  1638                  000431          01400   XP UPTKTR,431           ;KERNEL TRAP
  1639                  000432          01500   XP UPTSNT,432           ;SUPERVISOR NO TRAP
  1640                  000433          01600   XP UPTSTR,433           ;SUPERVISOR TRAP
  1641                  000434          01700   XP UPTCNT,434           ;CONCEALED NO TRAP
  1642                  000435          01800   XP UPTCTR,435           ;CONCEALED TRAP
  1643                  000436          01900   XP UPTPNT,436           ;PUBLIC NO TRAP
  1644                  000437          02000   XP UPTPTR,437           ;PUBLIC TRAP
  1645                                  02100                           ; (440 TO 477 AVAILABLE TO SOFTWARE.)
  1646                  000500          02200   XP UPTPFW,500           ;PAGE FAIL WORD, USER OR EXEC, STORED HERE.
  1647                  000501          02300   XP UPTOPP,501           ;OLD PAGE FAIL PC
  1648                  000502          02400   XP UPTNPP,502           ;NEW PAGE FAIL PC
  1649                                  02500                           ; (503 AVAILBLE TO SOFTWARE)
  1650                  000504          02600   XP UPTHEC,504           ;HI ORDER EBOX CLOCK WORD
  1651                  000505          02700   XP UPTLEC,505           ;LO ORDER EBOX CLOCK WORD
  1652                  000506          02800   XP UPTHMC,506           ;HI ORDER MBOX CLOCK WORD
  1653                  000507          02900   XP UPTLMC,507           ;LO ORDER MBOX CLOCK WORD
  1654                                  03000                           ;(510-577 RESERVED FOR USE BY HARDWARE)
  1655                                  03100   
  1656                  000600          03200   XP UPTFSL,600           ;BEGINNING OF CONTIGUOUS AREA AVAILABLE TO
  1657                                  03300                           ; SOFTWARE.
  1658                                  03400   
  1659

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 12
KLSYM   MAC     29-Feb-69 23:36         HARDWARE PAGING PARAMETERS

  1660                                  00100   ;AC BLOCK DEFINITIONS
  1661                                  00200   
  1662                  000000          00290   XP USRACB,0             ;USER AC BLOCK (MUST BE DEFINED AS ZERO)
  1663                  000001          00300   XP EX0ACB,1             ;FOR EXEC MODE.
  1664                                  00400   XP EX1ACB,2             ; ALTERNATE BETWEEN THESE TWO AS UUOS AND PAGE FAULTS ARE DO
  1665                  000002                  NE.
  1666                  000002          00600   XP NULACB,2             ;CONTAINS NULL JOB
  1667                  000003          00610   XP SA0ACB,3             ;AC BLOCK FOR SA 10 CHANNEL'S PI LEVEL.
  1668                  000003          00620   XP SA1ACB,3             ;FOR BOTH CHANNELS.
  1669                  000006          00700   XP RS1ACB,6             ;RESERVED (KL PAGING)
  1670                  000007          00800   XP RS2ACB,7             ;RESERVED TO UCODE (EXT. INST, PARITY ERROR DATA)
  1671                  000006          00850   XP NUMACB,6             ;NUMBER OF AC BLOCKS AVAILABLE ON THIS MACHINE
  1672                                  00900   
  1673                                  01000   ;MACRO TO USE WHEN JUST ENTERING EXEC MODE TO SWITCH TO
  1674                                  01100   ; THE EXEC AC BLOCK
  1675                                  01200   
  1676                                  01300   DEFINE EXECAC,<SALL
  1677                                  01400           DATAO PAG,[LG.LAB+<EX0ACB>B8+<USRACB>B11]>
  1678                                  01500   
  1679                                  01600   DEFINE USERAC,<SALL
  1680                                  01700           DATAO   PAG,[LG.LAB+<USRACB>B8+<USRACB>B11]
  1681                                  01800   >
  1682

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 13
KLSYM   MAC     29-Feb-69 23:36         HARDWARE PAGING PARAMETERS

  1683                                  00100   ;LOCATIONS IN EPT FIXED BY KL-10 HARDWARE
  1684                                  00200   
  1685                                  00300                           ; (0-37 RESERVED FOR CHANNEL LOGOUT)
  1686                  000040          00400   XP EPTLUU,40            ;LOCAL UUO STORED HERE
  1687                  000041          00500   XP EPTLUI,41            ;INSTRUCTION EXECUTED FOR LOCAL UUOS
  1688                                  00600   
  1689                                  00700                           ; (42-57) STANDARD PI INTERRUPT INSTRUCTIONS
  1690                                  00800                           ; (40+2*N)
  1691                                  00900                           ; (60-63) RESERVED FOR CHANNELS
  1692                                  01000                           ; (64-137) RESERVED FOR HARDWARE
  1693                                  01100   
  1694                                  01200   ;DTE HARDWARE LOCATIONS. 8 WORDS FOR EACH LOCATION,
  1695                                  01300   ; MAXIMUM OF 4 DTES.
  1696                                  01400   
  1697                  000140          01500   XP EPTDT0,140           ;DTE20 0
  1698                  000150          01600   XP EPTDT1,150           ;DTE20 1
  1699                  000160          01700   XP EPTDT2,160           ;DTE20 2
  1700                  000170          01800   XP EPTDT3,170           ;DTE20 3
  1701                  000000          01810           XP DTEEBP,0     ;TO ELEVEN BYTE POINTER
  1702                  000001          01820           XP DTETBP,1     ;TO 10 BYTE POINTER
  1703                  000002          01830           XP DTEDII,2     ;INTERRUPT INSTRUCTION LOCATION
  1704                  000003          01835           XP DTEUNU,3     ;UNUSED
  1705                  000004          01840           XP DTEEPW,4     ;EXAMINE PROTECT WORD (NON-PRIV DTES)
  1706                  000005          01850           XP DTEERW,5     ;EXAMINE RELOCATION WORD
  1707                  000006          01860           XP DTEDPW,6     ;DEPOSIT PROTECTION WORD
  1708                  000007          01870           XP DTEDRW,7     ;DEPOSIT RELOCATION WORD
  1709                                  01900   
  1710                                  02000   ;PAGE MAP POINTERS
  1711                                  02100   
  1712                  000200          02200   XP EPTPG0,200           ;FIRST WORD OF PAGE MAP SLOTS (PG 400) IN EPT
  1713                                  02300   
  1714                  000420          02400   XP EPTPGT,420           ;(SOFTWARE LOCATION IN KL)
  1715                  000421          02500   XP EPTOVT,421           ;OVERFLOW
  1716                  000422          02600   XP EPTPOV,422           ;PDL OVERFLOW
  1717                  000423          02700   XP EPTTR3,423           ;TRAP 3
  1718                                  02800                           ; (424-443 RESERVED FOR USE BY HARDWARE)
  1719                                  02900   ;THE FOLLOWING LOCATIONS ARE ESTABLISHED BY SOFWARE CONVENTION
  1720                                  03000   ; BETWEEN THE KL-10 AND ITS CONSOLE FRONT END.
  1721                                  03100   ; THEY ARE USED FOR THE "SECONDARY PROTOCOL".
  1722                                  03200   
  1723                  000444          03250   XP SPCDBG,444           ;BEGINNING OF SPC DATA AREA
  1724                  000444          03300   XP SPCFLG,444           ;SET NON-ZERO WHEN SECONDARY PROTOCOL COMMAND
  1725                                  03400                           ; IS COMPLETE. MUST
  1726                                  03500                           ; BE CLEARED BEFORE SECONDARY PROTOCOL COMAND IS ISSUED.
  1727                                  03600   
  1728                  000450          03700   XP SPCF11,450           ;FROM-11 DATA.
  1729                  000451          03800   XP SPCCMW,451           ;SPC COMMAND WORD
  1730                  004400          03900           XP .DTESP,11B27         ;ENTER SECONDARY PROTOCOL
  1731                  004000          04000           XP .DTCTO,10B27         ;OUTPUT CHARACTER ON CTY
  1732                  001400          04010           XP .DTRSW,3B27          ;READ SWITCHES INTO SPCSWR AND SPCF11.
  1733                  000455          04100   XP SPCMTD,455           ;CTY OUTPUT DONE FLAG. (SPCFLG SET IMMEDIATELY,
  1734                                  04200                           ; THIS ONE SETS WHEN CHAR IS ACTUALLY OUT.)
  1735                  000456          04300   XP SPCMTI,456           ;CTY INPUT PRESENT. IF NON-ZERO, CTY
  1736                                  04400                           ; CHAR IS PRESENT IN SPCF11.
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 13-1
KLSYM   MAC     29-Feb-69 23:36         HARDWARE PAGING PARAMETERS

  1737                  000457          04410           XP SPCSWR,457   ;SWITCHES APPEAR HERE.
  1738                  000457          04415   XP SPCDND,457           ;END OF SPC DATA AREA
  1739                  000004          04420             XP SS4,4      ;"SENSE SWITCH 4" (USED FOR AUTO RELOAD SELECTION.)
  1740                                  04500   
  1741                                  04600                           ; (460-507 RESERVED FOR USE BY HARDWARE)
  1742                                  04700   
  1743                                  04800   ;METER LOCATIONS
  1744                                  04900   
  1745                  000510          05000   XP EPTHTB,510           ;HI ORDER TIME BASE WORD
  1746                  000511          05100   XP EPTLTB,511           ;LO ORDER TIME BASE WORD (THESE FOR UCODE USE ONLY.)
  1747                                  05200   
  1748                  000512          05300   XP EPTHPA,512           ;HI ORDER PERFORMANCE ANALYSIS COUNT
  1749                  000513          05400   XP EPTLPA,513           ;LO ORDER
  1750                  000514          05500   XP EPTITI,514           ;INTERVAL TIMER INTERRUPT INSTRUCTION
  1751                                  05600   
  1752                                  05700                           ; (515-577 RESERVED FOR USE BY HARDWARE)
  1753                                  05800   
  1754                  000600          05900   XP EPTMP0,600           ;FIRST LOCATION OF MAP SLOTS FOR EXEC
  1755                                  06000                           ; PAGES 0-337. (USED TO BE UNMAPPED,
  1756                                  06100                           ; BUT NEED SLOTS TO CONTROL CACHE.)
  1757                  000760          06200   XP EPTFSL,760           ;START OF CONTIGUOUS BLOCK AVAILABLE TO SOFTWARE.
  1758

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 14
KLSYM   MAC     29-Feb-69 23:36         SYSTEM MACROS - CLEAR PAGE TABLE

  1759                                  00100   SUBTTL SYSTEM MACROS - CLEAR PAGE TABLE
  1760                                  00200   
  1761                                  00300   ;MACROS TO CLEAR EITHER ALL OF PAGE TABLE, OR ONE ENTRY.
  1762                                  00400   
  1763                                  00500   DEFINE CLRPTA,<SALL
  1764                                  00510           IF2,<IFNDEF EPT,<EXTERN EPT>
  1765                                  00520                IFNDEF EPTEBR,<EXTERN EPTEBR>>
  1766                                  00600           CONO    PAG,@EPT+EPTEBR>
  1767                                  00700   
  1768                                  00710   
  1769                                  00720   ;CLEAR ONE ENTRY IN PAGE TABLE. ARG IS ADDRESS OF
  1770                                  00730   ; LOCATION TO CLEAR (CAN BE INDEXED, INDIRECT).
  1771                                  00740   
  1772                                  00800   DEFINE CLRPTO(ARG)<SALL
  1773                                  00810           IFB <ARG>,<PRINTX MISSING ARGUMENT TO CLRPTO
  1774                                  00820                           QQQQQQ>
  1775                                  00900           CLRPT   ARG>
  1776                                  01000   
  1777                                  01100   ;MACRO TO CLEAR PAGE TABLE FOR PAGE WHOSE NUMBER IS IN RH(W).
  1778                                  01200   ; PAGE NUMBER IS IN CORE1 STYLE FORMAT (1000 IS EXEC
  1779                                  01300   ; 340)
  1780                                  01400   
  1781                                  01500   DEFINE CLRPTW<SALL
  1782                                  01600           IF2,<IFNDEF CLPTW,<EXTERN CLPTW>>
  1783                                  01700           PUSHJ   P,CLPTW>
  1784

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 15
KLSYM   MAC     29-Feb-69 23:36         SYSTEM MACROS - CHARGING

  1785                                  00100   SUBTTL SYSTEM MACROS - CHARGING
  1786                                  00200   
  1787                                  00300   ;MACROS TO MANIPULATE CHARGING CLOCK.
  1788                                  00400   
  1789                                  00500   DEFINE CHARGE<SALL
  1790                                  00510           IF2,<IFNDEF ITMCHN,<EXTERNAL ITMCHN>>
  1791                                  00600           CONO    MTR,MO.LAC+MO.AEN+MO.AO+MO.TON+ITMCHN>
  1792                                  00800   
  1793                                  00900   DEFINE NOCHARGE<SALL
  1794                                  00910           IF2,<IFNDEF ITMCHN,<EXTERNAL ITMCHN>>
  1795                                  01000           CONO    MTR,MO.LAC+ITMCHN>
  1796                                  01200   
  1797                                  01300   DEFINE CHGSTS(LOC)<SALL
  1798                                  01400           CONI    MTR,LOC>
  1799                                  01600   
  1800                  010000          01700           XP      CHGON,MO.AO             ;BIT TO LOOK AT AFTER CHGSTS.
  1801

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 16
KLSYM   MAC     29-Feb-69 23:36         SYSTEM MACROS - CHARGING

  1802                                  00100   ;MACROS TO MOVE DATA BETWEEN THE USER AND THE OPERATING SYSTEM.
  1803                                  00200   
  1804                                  00300   DEFINE UMOVE(A,B)
  1805                                  00400           <XCTFU  <MOVE A,B>>
  1806                                  00500   
  1807                                  00600   DEFINE UMOVEM (A,B)
  1808                                  00700           <XCTTU  <MOVEM A,B>>
  1809

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 17
KLSYM   MAC     29-Feb-69 23:36         SYSTEM MACROS - EXECUTIVE EXECUTE.

  1810                                  00100   SUBTTL SYSTEM MACROS - EXECUTIVE EXECUTE.
  1811                                  00150   ;SAME IN KS AND KL.
  1812                                  00200   
  1813                                  00300   ;BITS IN PXCT AC FIELD
  1814                  000010          00400           PX.EAC==10              ;EFFECTIVE ADDRESS OF OBJECT INSTRUCTION
  1815                  000004          00500           PX.MEM==4               ;MEMORY OPERAND (BOTH FETCH AND STORE)
  1816                  000002          00600           PX.BYT==2               ;EFFECTIVE ADDRESS OF BYTE POINTER
  1817                  000001          00700           PX.SRC==1               ;STACK WORD IN PUSH/POP; SOURCE IN BLT
  1818                                  00800   
  1819                                  00900           DEFINE  XCTBU(INST)<SALL
  1820                                  01000           GINST==<PXCT PX.MEM,[INST]>
  1821                                  01100   
  1822                                  01200   
  1823                                  01300           PXGEN(<INST>,<DPB,IDPB,LDB,ILDB>,<PX.SRC>)
  1824                                  01400                           ;;INCLUDE BYTE INSTRUCTIONS BECAUSE XCTBU IS USED ON KI10 FO
  1825                                          R READ-MODIFY-WRITE.
  1826                                  01500           PXGEN(<INST>,<BLT,PUSH,POP>,<PX.SRC!PX.MEM>)
  1827                                  01600           GINST
  1828                                  01700           PURGE GINST
  1829                                  01800   >;END XCTBU MACRO DEFINITION
  1830                                  01900   
  1831                                  02000           DEFINE XCTFU(INST)<SALL
  1832                                  02100           GINST==<PXCT PX.MEM,[INST]>
  1833                                  02200                   ;;INCLUDE DPB AND IDPB BECAUSE XCTFU USED FOR RMW ON KI
  1834                                  02300           PXGEN(<INST>,<LDB,ILDB,DPB,IDPB,POP,BLT>,<PX.SRC>)
  1835                                  02400           GINST
  1836                                  02500           PURGE GINST
  1837                                  02600   >;END XCTFU MACRO DEFINITION
  1838                                  02700   
  1839                                  02800           DEFINE XCTTU(INST)<SALL
  1840                                  02900           GINST==<PXCT PX.MEM,[INST]>
  1841                                  03000           PXGEN(<INST>,<LDB,ILDB,IDPB,DPB>,<QQQQQQ>)      ;;CAN'T LOAD USERS AC THIS W
  1842                                          AY.
  1843                                  03100                                   ;;MAKE IDPB AND DPB ILLEGAL BECAUSE CAN'T DO IT ON K
  1844                                          I, MUST USE FU OR BU INSTEAD.
  1845                                  03200           PXGEN(<INST>,<PUSH>,<PX.SRC>)
  1846                                  03300           PXGEN(<INST>,<POP,BLT>,<PX.MEM>)
  1847                                  03400           GINST
  1848                                  03500           PURGE GINST
  1849                                  03600   >;END XCTTU MACRO DEFINITION
  1850                                  03700   
  1851                                  03800   
  1852                                  03900           DEFINE PXGEN(INST,CODES,BITS)<
  1853                                  04000           ZZ==0
  1854                                  04100           IRPC INST,<
  1855                                  04200           ZZ1==0
  1856                                  04300           IFIDN < > <INST>,<ZZ1==1>
  1857                                  04400           IFIDN < > <INST>,<ZZ1==1>
  1858                                  04500           IFN ZZ1,<STOPI>
  1859                                  04600           IFE ZZ1,<
  1860                                  04700           ZZ==ZZ_6
  1861                                  04800           ZZ==ZZ+''INST''
  1862                                  04900   >;END IFE ZZ1
  1863                                  05000   >;END IRPC INST
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 17-1
KLSYM   MAC     29-Feb-69 23:36         SYSTEM MACROS - EXECUTIVE EXECUTE.

  1864                                  05100           IRP CODES,<
  1865                                  05200           IFE <ZZ-''CODES''>,<GINST==<PXCT BITS,[INST]>>
  1866                                  05300   >;END IRP CODES
  1867                                  05400   
  1868                                  05500           PURGE ZZ1
  1869                                  05600   >;END PXGEN MACRO DEFINITION
  1870

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 18
KLSYM   MAC     29-Feb-69 23:36         CACHE SWEEP CONTROL MACROS

  1871                                  00100   SUBTTL CACHE SWEEP CONTROL MACROS
  1872                                  00200   
  1873                                  00300   ;MACRO TO START CACHE UNLOAD
  1874                                  00400   
  1875                                  00500   DEFINE CSHUNL<
  1876                                  00600           PUSHJ   P,CSUNL##>
  1877                                  00700   
  1878                                  00800   ;MACRO TO START CACHE VALIDATE
  1879                                  00900   
  1880                                  01000   DEFINE CSHVAL <PUSHJ P,CSVAL##>
  1881                                  01100   
  1882                                  01200   ;MACRO TO MAKE SURE EDGES OF USER'S BUFFER DID NOT GET INTO
  1883                                  01300   ; CACHE DURING INPUT TRANSFER BY USER OR OTHER ENTITY
  1884                                  01400   ; REFERENCING ADJACENT WORD TO BUFFER. RESTRICTION - BUFFER
  1885                                  01500   ; CANNOT BE IN MONITOR PAGES 0-337, OR ELSE ONE OF THE
  1886                                  01600   ; FOUR REFERENCES MAY BE TO THE BUFFER ITSELF.
  1887                                  01700   ; T1 HAS ADDRESS OF WORD TO THROW OUT OF CACHE.
  1888                                  01800   
  1889                                  01900   DEFINE CSHREF<SALL
  1890                                  01910   IF2,<IFNDEF CSRTAB,<EXTERNAL CSRTAB>>
  1891                                  02000           ANDI    T1,777          ;;GET REL LOCATION IN PAGE
  1892                                  02100           SKIP    @CSRTAB+0
  1893                                  02200           SKIP    @CSRTAB+1
  1894                                  02300           SKIP    @CSRTAB+2
  1895                                  02400           SKIP    @CSRTAB+3
  1896                                  02500   >;END CSHREF MACRO DEFINITION.
  1897

COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 19
KLSYM   MAC     29-Feb-69 23:36         CACHE SWEEP CONTROL MACROS

  1898                                  00100           ASUPPRESS               ;ONLY LIST REFERENCED SYMBOLS
  1899                                  00200   
  1900                                  00300   IFDEF LISTSN,<IFN LISTSN,<PAGE>>
COMMON - MONITOR COMMON DATA AREA AND CONFIGURATION DEFINITION - V534   MACRO %53B(1156)-1 17:31  5-Jun-84 Page 1
CONF39  MAC     27-Aug-72 22:07         CONFIG - CONFIGURATION DEFINITION

  1901                                          SUBTTL  CONFIG - CONFIGURATION DEFINITION
  1902                  000002                    XP SAXC0N,2  ;2 CHANNELS
  1903                  000000                      XP BP00,0  ;1 3830
  1904                  000001                      XP FT00,1  ;1 3803
  1905                  000000                      XP FT01,0  ;2 3803
  1906                  000001                  XP BP01,1
  1907                  000300                  BPA==300
  1908                  000020                  BPAMX==^D16
  1909                  000020                  XP BPAUN,^D16
  1910                  000004                  FTAUN==4
  1911                  000177                  XP JOBN,^D127
  1912                  000221                  XP RPORTN,^D145
  1913                  000036                  XP SPCBN,^D30   ;NUMBER OF SAT PCB'S; DEFAULTS TO 15 IN COMMOD
  1914                  000016                  XP RPCBN,^D14   ;NUMBER OF RIB PCB'S; DEFAULTS TO 7 IN COMMOD





                                                
                                                
                                                
                              
                              
                              
                              
                              
                              
                                          
                                          
                                          
                                    
                                    
                                    
                                    
                                    
                                    
                                                            
                                                            
                                                            



                                                                        
                                                                        
                                                                        
                              
                              
                              
                              
                              
                              
                              
                              
                              
                                                
                                                
                                                
                              
                              
                              
                                          
                                          
                                          




                              
             
             
                 
                 
                
                             

JOBDAT - JOB DATA AREA (FIRST 140 LOC OF USER AREA)     MACRO %53B(1156)-1 17:55  5-Jun-84 Page 1
S       MAC     26-Apr-71 10:47         T. HASTINGS/TH/PFC  TS 29 MAY 71   V427(431)

     1                                  ;THIS SUB-PROGRAM ASSEMBLED WITH SYSTEM PARAMETER FILE - S.MAC
     2
     3                                          IF2,<IFNDEF LISTSN,<            ;LIST S.MAC IN COMMON ONLY.
     4                                                                  TAPE>>
     5                                  00300   ;THIS MODULE ASSEMBLED WITH KL-10 PARAMETER FILE - KLSYM.MAC
     6                                  00400   
     7                                  00500           IF2,<IFNDEF LISTSN,<            ;LIST KLSYM.MAC IN COMMON ONLY
     8                                  00600                                   TAPE>>
     9                                  00100   SUBTTL  T. HASTINGS/TH/PFC  TS 29 MAY 71   V427(431)
    10                                  00200   
    11                                  00300   ;TO ELIMINATE MOST OF UNWANTED GLOBALS USERS
    12                                  00400   ;ASSEMBLING INSTRUCTIONS TO MAKE USER VERSION FOR CUSP:
    13                                  00500   ;.COMPILE  JOBDAT
    14                                  00600   
    15                                  00700   ;MONITOR ASSEMBLY INSTRUCTIONS:
    16                                  00800   ;.COMPILE  EJBDAT=S+JOBDAT
    17                                  00900   ;       NOTE--IF LEVEL C S.MAC IS USED, EJBDAT WILL BE FOR LEVEL C
    18                                  01000   ;               OTHERWISE, IT WILL BE FOR LEVEL D.
    19                                  01100   ;               USER VERSION IS THE SAME IN EITHER CASE.
    20                                  01200   
    21                                  01300   IFNDEF P,<UJOBDAT==1>   ;IF NOT ASSEMBLED WITH S.MAC, MAKE USER VERSION
    22                                  01400   
    23                                  01500   TITLE   JOBDAT - JOB DATA AREA (FIRST 140 LOC OF USER AREA) 
    24

JOBDAT - JOB DATA AREA (FIRST 140 LOC OF USER AREA)     MACRO %53B(1156)-1 17:55  5-Jun-84 Page 2
JOBDAT  MAC     25-May-68 18:22         MACRO DEFINITIONS FOR THIS ROUTINE

    25                                  00100   SUBTTL MACRO DEFINITIONS FOR THIS ROUTINE
    26                                  00200   
    27                                  00300   ;THIS AREA PROVIDES STORAGE OF ITEMS OF INTEREST TO BOTH
    28                                  00400   ;THE MONITOR AND THE USER
    29                                  00500   
    30                                  00600   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    31                                  00700   ;;;   ALL NEW USER SYMBOLS MUST BE OF THE FORM:                ;;;
    32                                  00800   ;;;   .JBXXX   IF THE SYMBOL IS IN THE LOW SEGMENT             ;;;
    33                                  00900   ;;;   .JBHXX   IF THE SYMBOL IS IN THE HIGH SEGMENT            ;;;
    34                                  01000   ;;;                                                            ;;;
    35                                  01100   ;;;   THE OLD FORMS OF JOBXXX AND JOBHXX ARE LEGAL ONLY FOR    ;;;
    36                                  01200   ;;;   COMPATABILITY WITH OLD PROGRAMS AND WILL EVENTUALLY DIE  ;;;
    37                                  01300   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    38                                  01400   
    39                                  01500   ;MACRO TO DEFINE SYMBOLS FOR USER USE
    40                                  01600   ;THESE CANNOT BE CHANGED WITHOUT INVALIDATING OLD SAVED FILES
    41                                  01700   
    42                                  01800           DEFINE U(SYMBOL,VALUE,LENGTH)
    43                                  01900           <IFE  U2,<IFNDEF UJOBDAT,< SYMBOL==VALUE>
    44                                  02000                   IFDEF UJOBDAT,<SYMBOL=VALUE>
    45                                  02100           ENTRY SYMBOL
    46                                  02200           LOC=VALUE+LENGTH>>
    47                                  02300   
    48                                  02400   ;MACRO TO DEFINE SUPPRESSED SYMBOLS FOR USER USE
    49                                  02500   
    50                                  02600           DEFINE US(SYMBOL,VALUE,LENGTH)
    51                                  02700           <IFE  U2,<       SYMBOL==VALUE
    52                                  02800           INTERN SYMBOL
    53                                  02900           LOC=VALUE+LENGTH>>
    54                                  03000   
    55                                  03100   ;MACRO TO DEFINE SYMBOLS FOR USER USE OF BOTH JOB AND .JB FORMAT
    56                                  03200   ;SAME AS U
    57                                  03300   
    58                                  03400           DEFINE UJOB(SYMBOL,VALUE,LENGTH)
    59                                  03500           <IFE  U2,<      .JB'SYMBOL=VALUE
    60                                  03600                           JOB'SYMBOL=VALUE
    61                                  03700           ENTRY .JB'SYMBOL,JOB'SYMBOL
    62                                  03800           LOC=VALUE+LENGTH>>
    63                                  03900   
    64                                  04000   ;MACRO TO DEFINE SYMBOLS FOR USER USE OF BOTH JOB AND .JB FORMAT
    65                                  04100   ;SAME AS US
    66                                  04200   
    67                                  04300           DEFINE USJOB(SYMBOL,VALUE,LENGTH)
    68                                  04400           <IFE  U2,<       .JB'SYMBOL==VALUE
    69                                  04500                            JOB'SYMBOL==VALUE
    70                                  04600           INTERN .JB'SYMBOL,JOB'SYMBOL
    71                                  04700           LOC=VALUE+LENGTH>>
    72

JOBDAT - JOB DATA AREA (FIRST 140 LOC OF USER AREA)     MACRO %53B(1156)-1 17:55  5-Jun-84 Page 3
JOBDAT  MAC     25-May-68 18:22         MACRO DEFINITIONS FOR THIS ROUTINE

    73                                  00100   ;MACRO TO DEFINE SYMBOLS FOR MONITOR USE ONLY
    74                                  00200   ;THESE MAY BE CHANGED TO SUIT MONITOR
    75                                  00300   
    76                                  00400           DEFINE M(SYMBOL,VALUE,LENGTH)
    77                                  00500           <IFE  U2,<      SYMBOL==VALUE
    78                                  00600           IFNDEF UJOBDAT,<INTERNAL SYMBOL> ;MAKE GLOBAL ONLY IF ASSEM FOR MONITOR
    79                                  00700           LOC=VALUE+LENGTH>
    80                                  00800           IFN  U2,<PURGE  SYMBOL>>
    81                                  00900   
    82                                  01000   ;MACRO TO DEFINE PARAMETERS OF INTEREST TO MONITOR ONLY
    83                                  01100   ;THESE MAY BE CHANGED TO SUIT MONITOR & WILL NOT PRINT OUT WITH DDT
    84                                  01200   
    85                                  01300           DEFINE XP(SYMBOL,VALUE)
    86                                  01400           <IFE  U2,<      SYMBOL==VALUE
    87                                  01500           IFNDEF UJOBDAT,<INTERN SYMBOL>> ;MAKE GLOBAL ONLY IF ASSEM FOR MONITOR
    88                                  01600           IFN  U2,<PURGE  SYMBOL>>
    89                                  01700   
    90                                  01800   IFDEF UJOBDAT,<
    91                                  02000           P=0             ;OK TO DEFINE TO BE WRONG SINCE DO NOT APPEAR IN U MACRO
    92                                  02100   IF2,<  U2==1>           ;FLAG SPECIAL HANDLE IN PASS 2 FOR USER VERSION
    93                                  02200   >
    94                  000000          02300   IFNDEF  U2,<U2==0>
    95                                  02400   
    96                                  02500   IFNDEF  UJOBDAT,<IFNDEF P1,<LC=0>>      ;SET LC=0 IF LEVEL C MONITOR VERSION
    97                                  02600   IFNDEF  LC,<LC=1>               ;ELSE, SET IT TO 1
    98

JOBDAT - JOB DATA AREA (FIRST 140 LOC OF USER AREA)     MACRO %53B(1156)-1 17:55  5-Jun-84 Page 4
JOBDAT  MAC     25-May-68 18:22         LOW SEGMENT DATA AREA

    99                                  00100   SUBTTL LOW SEGMENT DATA AREA
   100                                  00200   
   101                                  01600   UJOB UUO,40,1           ^;USER UUO TRAP LOC.(UUO STORED HERE)
   102                                  01700   UJOB 41,41,1            ^;USER UUO JSR LOCATION
   103                                  01800                           ;(SET FROM HIGH SEG DATA AREA ON GET IN NO LOW FILE)
   104                                  01900   UJOB ERR,42,1           ^;LH UNUSED-SAVE FOR LATER THINGS - SO USER PROGRAMS
   105                                  02000                           ;SHOULD IGNORE LH IN ALL PROGRAMS
   106                                  02100                           ;RH=COUNT OF NO. OF ERRORS IN RPG(RAPID PROGRAM
   107                                  02200                           ;GENERATION) SEQUENCE OF CUSPS.
   108                                  02300                           ;NOT CHANGED FROM GET TO GET.
   109                                  02700   UJOB REL,44,1           ^;LH=0 - RH=HIGHEST REL. ADR. IN USER AREA(IE LOW SEGMENT)
   110                                  02750   
   111                                  02800                           ;SET BY MONITOR EACH TIME JOB RUNS OR CHANGES CORE SIZE
   112                                  03300   UJOB BLT,45,3   ^;3 WORDS USED BY LINKING LOADER TO MOVE
   113                                  03400                           ; PROGRAM DOWN BEFORE CALLING EXIT.
   114                                  03500                           ;OK TO USE EXEC PD LIST BEFORE EXECUTING UUO
   115                                  03700   
   116                                  04100   USJOB(MUU,66,1)^        ;STORE USER TRAPPED UUO HERE
   117                                  04200   
   118                                  04300   
   119                  000072          04400   LOC=72
   120

JOBDAT - JOB DATA AREA (FIRST 140 LOC OF USER AREA)     MACRO %53B(1156)-1 17:55  5-Jun-84 Page 5
JOBDAT  MAC     25-May-68 18:22         LOW SEGMENT DATA AREA

   121                                  01200   U JOBHCU,LOC,1          ^;HIGHEST USER IO CHANNEL IN USE
   122                                  01250   
   123                                  01300                           ;ONLY JOBJDA...JOBJDA+C(JOBHCU) ARE COPIED INTO
   124                                  01400                           ;MONITOR WHEN JOB IS RUN. 0 MEANS NONE OR
   125                                  01500                           ;CHAN. 0 IN USE, NEG LH MEANS SAVEGET HAS ACTIVE IO(RH STILL
   126                                          
   127                                  01600                           ; HIGHEST CHAN IN USE)
   128                  000074          01700   LOC=LOC+1
   129                                  01800   UJOB DDT,74,1           ^;LH UNUSED,RH=STARTING ADDRESS OF USER DDT
   130                                  02000   US JOBJDA,LOC,20                ^;JOB DEVICE ASSIGNMENT TABLE
   131                                  02050   
   132                                  02100                           ;LH=UUOS DONE SO FAR, RH=ADR. OF DEVICE DATA BLOCK IN MONITO
   133                                          R
   134                                  02200   XP JOBSV,JOBJDA+1       ^;FIRST LOC READ INTO OR WRITTEN FROM BY NEW SAVGET
   135                                  02300                           ; WHICH ZERO COMPRESSES ON ALL DEVICES
   136                                  02400                           ; THIS LOC CONTAINS THE FIRST IOWD WITH NO-NO. OF DATA WORDS
   137                                          
   138                                  02500                           ; IN LH, FIRST ADR-1 IN RH
   139                                  02600                           ; MONITOR SUPPRESSES STORING IN RH OF JOBHRL DURING
   140                                  02700                           ; SAVEGET(USRCHU NEG.)
   141                                  02800                           ; SO THAT OLD ZERO COMPRESSED DECTAPE FILES WILL
   142                                  02900                           ; ALWAYS FIT IN CORE (JOBHRL USRD TO BE 0)
   143                                  03000                           ; THIS CHECK COULD HAVE BEEN ELIMINATED, IF JOBSV HAD BEEN
   144                                  03100                           ; DEFINED AS JOBHRL+1(JOBSYM), HOWEVER JOBSYM ALMOST
   145                                  03200                           ; ALWAYS HAS NON-ZERO DATA, SO SAVEGET WOULD HAVE TO
   146                                  03300                           ; BE WRITTEN TO EXPAND DOWN OR UP RATHER THAN JUST UP
   147                                  03400   XP JOBSVM,JOBSV-1       ^;FIRST LOC-1, USED FOR SETTING UP DUMPE MODE
   148                                  03500                           ; COMMAND LIST FOR SAVGET
   149                                  03900   XP JOBNSV,JOBSV+14      ^;JOBSV+4...JOBSV+7--USED TO WRITE NULL HIGH AND
   150                                  04000                           ; LOW FILE ON MTA ONLY WHEN SEGMENT HAS NOTHING
   151                                  04100                           ; TO BE WRITTEN.  THUS MTA ALWAYS WRITES 2 FILES.
   152                                  04700   UJOB CN6,JOBJDA+11      ^;6 TEMP LOCATIONS USED BY CHAIN TO HOLD ERROR ROUTINE
   153                                  04800                           ; WHEN IT LOADS NEXT CHAIN LINK.(JOBJDA+11...16)
   154                                  04900                           ; THESE LOCATIONS ARE OK TO USE SINCE CHAIN RELEASES ALL
   155                                  05000                           ; USER CHANELS AND MONITOR WILL NOT DESTROY THEM
   156                                  05100                           ; WHEN JOB CONTEXT IS SWITCHED
   157                                  05200   US JOBCNK,JOBJDA+5      ^;8 TEMP LOCATIONS USED BY CHAIN TO HOLD ERROR ROUTINE
   158

JOBDAT - JOB DATA AREA (FIRST 140 LOC OF USER AREA)     MACRO %53B(1156)-1 17:55  5-Jun-84 Page 6
JOBDAT  MAC     25-May-68 18:22         LOW SEGMENT DATA AREA

   159                                  00100   XP JOBSDD,JOBJDA+17     ^;PLACE TO SAVE JOBDDT ON SAVE SO ZERO EXPANSION ON GET
   160                                  00200                           ;ALWAYS MOVES UP
   161                                  00300   XP JOBSD1,JOBSDD-1      ^;FOR COMPUTING IOWD'S
   162                                  00500                           ;USED BY ANYACT ROUT. IN CORE1
   163                                  00600   UJOB PFI,JOBJDA+17      ^;HIGHEST LOC. IN JOB DATA AREA PROTECTED FROM IO
   164                                  00800   UJOB HRL,115,1          ^;LH IS FIRST FREE LOC IN HIGH SEG RELATIVE TO ITS ORIGIN
   165                                  00850   
   166                                  00900                           ;ANALOGOUS TO LH OF JOBSA FOR LOW SEG
   167                                  01000                           ; (IN OTHER WORDS LH=LENGTH TO SAVE ON SAVE COMMAND)
   168                                  01100                           ; SET BY LOADER
   169                                  01200                           ;RH ANALOGOUS TO JOBREL, IE HIGHEST LEGAL
   170                                  01300                           ;USER ADDRESS IN HIGH SEG. SET BY MONITOR EVERY TIME
   171                                  01400                           ;USER RUNS.  IF JOBHRL=0, JOB DOES NOT HAVE A HIGH SEG
   172                                  01500                           ;USER PROGRAMS SHOULD BE WRITTEN SO THAT
   173                                  01600                           ;THEY CAN BE ONE OR TWO SEGMENT PROGRAMS. JOBHRL
   174                                  01700                           ;CAN BE TESTED FOR NON-ZERO TO SEE IF HIGH SEG EXISTS
   175                                  01800   UJOB SYM,116,1          ^;POINTER TO LOADER AND DDT SYMBOL TABLE POINTER
   176                                  01900   UJOB USY,117,1          ^;POINTER TO UNDEFINED SYMBOL TABLE
   177                                  02000                           ;SET BY LOADER, NOT YET USED BY DDT
   178                                  02100   UJOB SA,120,1           ^;LH=INITIAL FIRST FREE LOCATION IN LOW SEG (SET BY LOADER)
   179                                  02200                           ;RH=STARTING ADDRESS OF USER PROGRAM
   180                                  02300   UJOB FF,121,1           ^;(SET FROM HIGH DATA AREA ON GET IF NO LOW FILE)
   181                                  02400                           ;CURRENT FIRST FREE LOCATION IN LOW SEG
   182                                  02500                           ; USED AND UPDATED BY MONITOR TO ASSIGN I/O BUFFERS IN TOP
   183                                  02600                           ; OF USER AREA. USER MAY CHANGE CONTENTS IN ORDER TO AFFECT
   184                                  02700                           ; PLACEMENT OF BUFFERS BY MONITOR
   185                                  02800   M JOBS41,122,1          ^;C(JOB41) SAVED HERE ON SAVE COMMAND
   186                                  02900                           ;RESTORE FROM HERE ON GET
   187                                  03000   M JOBEXM,LOC,1          ^;LAST LOC EXAMINED OR DEPOSITED USING 
   188                                  03100                           ;D OR E COMMANDS
   189                                  03200                           ;LH=-1 IF LAST COM WAS AN E. 0 IF IT WAS A D
   190                                  03300   UJOB REN,124,1          ^;REENTER ADDRESS FOR REENTER COMMAND
   191                                  03400                           ; (SET FROM HIGH DATA AREA ON GET IF NO LOW FILE)
   192                                  03500   UJOB APR,125,1          ^;PLACE TO TRAP TO IN USER AREA ON APR TRAP
   193                                  03600                           ;ENABLED BY APRENB UUO
   194                                  03700   UJOB CNI,126,1          ^;APR IS CONIED INTO C(JOBCNI) ON APR TRAP
   195                                  03800   UJOB TPC,127,1          ^;PC IS STORED HERE ON USER APR TRAP
   196                                  03900   UJOB OPC,130,1          ^;OLD PC IS STORED HERE ON START,DDT,REENTER,
   197                                  04000                           ;STARTC COMMANDS
   198                                  04100   UJOB CHN,131,1          ^;LH=FIRST LOC AFTER FIRST FORTRAN 4 LOADED PROGRAM
   199                                  04200                           ;RH=FIRST LOC AFTER FIRST FORTRAN 4 BLOCK DATA
   200                                  04300                           ;TO BE USED FOR JOB CHAINING
   201                                  04400   M JOBFDV,LOC,1          ^;DEV. DATA BLOCK ADR. FOR FINISH COMMAND
   202

JOBDAT - JOB DATA AREA (FIRST 140 LOC OF USER AREA)     MACRO %53B(1156)-1 17:55  5-Jun-84 Page 7
JOBDAT  MAC     25-May-68 18:22         LOW SEGMENT DATA AREA

   203                                  00100   UJOB COR,133,1          ^;(SET FROM HIGH DATA AREA ON GET IF NO LOW FILE)
   204                                  00200                           ;LH=HIGHEST LOCATION LOADED(LOW SEG) WITH PROG OR DATA
   205                                  00300                           ; SET BY LOADER(BLOCK STATEMENTS DO NOT COUNT HERE)
   206                                  00400                           ; SAVE WILL NOT WRITE THE LOW SEG OF A TWO SEG PROG,
   207                                  00500                           ; IF LH IS 137 OR LESS AND GET WILL NOT READ
   208                                  00600                           ;RH=SIZE OF CORE FOR LOW SEG ON RUN,SAVE,GET COM.
   209                                  00700                           ;(SET FROM HIGH DATA AREA ON GET IF NO LOW FILE)
   210                                  00800                           ;SET BY SAVE TO CORE ASSIGNMENT TO BE USED ON GET
   211                                  00900                           ; (UNLESS USER TYPES A LARGER ARG TO GET)
   212                                  01000                           ; TO FIRST FREE LOC-1(OR TOP IF USER DDT) OR
   213                                  01100                           ; TO USER'S CORE ARG TO SAVE IF BIGGER
   214                                  01200                           ;GET ALWAYS SETS RH TO INITIAL CORE ASSIGNMENT SO THAT PROG
   215                                  01300                           ; CAN RESTORE CORE TO ORIGINAL ASSIGNMENT ON RESTARTING
   216                                  01400                           ;134-135 UNUSED
   217                                  01410   
   218                                  01420   US .JBCST,136,1         ^;JOB DATA LOCATION TO BE DEFINED BY "CUSTOMER".
   219                                  01430                           ; DEFINED FOR COMPATIBILITY WITH TOPS10 PROGRAMS.
   220                                  01440   
   221                                  01500   USJOB VER,137,1         ^;CONTAINS VERSION NO.(OCTAL) OF PROGRAM BEING RUN
   222                                  01600                           ;GENERAL FORMAT IS:
   223                                  01700                           ;  BITS 0-2     WHO LAST EDITTED THIS:
   224                                  01800                           ;               0=DIGITAL DEVELOPMENT GROUP
   225                                  01900                           ;               1=OTHER DIGITAL
   226                                  02000                           ;               2-4=RESERVED TO CUSTOMER
   227                                  02100                           ;               5-7=RESERVED TO HIS USERS
   228                                  02200                           ;       3-11    DIGITAL MAJOR VERSION NUMBER
   229                                  02300                           ;       12-17   DIGITAL MINOR VERSION NUMBER
   230                                  02400                           ;       18-35   EDIT NUMBER
   231                                  02500                           ;GET LOADS IT FROM THE SAVE FILE.  NEVER CONVERTED
   232                                  02600                           ;TO DECIMAL BY MAN OR MACHINE. E 137 WILL PRINT VERSION NO.
   233                                  02700                           ;SET BY LOC 137 IN CUSP SOURCE
   234                                  02800                           ;(SET FROM HIGH DATA AREA ON GET IF NO LOW FILE)
   235                                  02900   UJOB DA,140             ^;FIRST LOC NOT USED BY JOB DATA AREA
   236

JOBDAT - JOB DATA AREA (FIRST 140 LOC OF USER AREA)     MACRO %53B(1156)-1 17:55  5-Jun-84 Page 8
JOBDAT  MAC     25-May-68 18:22         HIGH SEGMENT DATA AREA

   237                                  00100   SUBTTL HIGH SEGMENT DATA AREA
   238                                  00200   
   239                                  00300   ; LOCATIONS ARE RELATIVE TO BEGINNING OF HIGH SEGMENT, SINCE
   240                                  00400   ; THE HIGH SEGMENT CAN BEGIN AT 400000 OR HIGHER
   241                                  00500   ; THIS AREA IS USED TO INITIALIZE CERTAIN LOCATIONS IN THE LOW SEG JOB DATA AREA
   242                                  00600   ; IN CASE THER WAS NO LOW SEG SAVED.(LH JOBCOR 137 OR LESS AS SET BY LOADER)
   243                                  00700   ; LOW SEG JOB DATA AREA LOCATIONS SET FROM HIGH SEG DATA AREA ARE INDICATED ABOVE BY
   244                                          :
   245                                  00800   ;(SET FROM HIGH SEG IF NEC)
   246                                  00900   ; THESE LOCATIONS ARE SET FROM LOW JOB DATA AREA ONLY IF HIGH SEG IS NON-SHARABLE
   247                                  01000   ; AT THE TIME THE SAVE IS PERFORMED (SHRSEG=0 IN JBTSTS)
   248                                  01100   
   249                  400000          01200   USJOB HGH,400000^IFE  U2,<       .JBHGH==400000
   250                                  01300                           ;NORMAL BEGINNING ADDRESS OF HIGH SEGMENT
   251                  000000          01400   XP JOBHSA,0^IFE  U2,<   JOBHSA==0
   252                                  01500                           ;USED TO RESTORE JOBSA
   253                  000001          01600   XP JOBH41,1^IFE  U2,<   JOBH41==1
   254                                  01700                           ;USED TO RESTORE JOB41
   255                  000002          01800   US .JBHCR,2^IFE  U2,<    .JBHCR==2
   256                                  01900   XP JOBHCR,.JBHCR        ^;USED TO RESTORE JOBCOR(BOTH HALVES)
   257                  000003          02000   XP JOBHRN,3^IFE  U2,<   JOBHRN==3
   258                                  02100                           ;LH RESTORES LH OF JOBHRL(FIRST REL. FREE LOC. IN HIGH)
   259                                  02200                           ;RH RESTORES JOBREN,LH SET TO 0 FOR FUTURE
   260                  000004          02300   USJOB HVR,4^IFE  U2,<    .JBHVR==4
   261                                  02400                           ;RESTORE BOTH HALVES OF JOBVER
   262                  000004          02500           XP JOBPOP,4^IFE  U2,<   JOBPOP==4
   263                                  02600                           ;HIGHEST LOC TO BE RESTORED(POPPED) BY GET
   264                                  02700   
   265                                  02800                   ;;;; 7 RESERVED TO ALLOW EXPANSION IN THE FUTURE
   266                                  02900                   ;;;; IT WILL CONTAIN SOME SORT OF POINTER
   267                                  03000   
   268                  000010          03100   USJOB HDA,10^IFE  U2,<   .JBHDA==10
   269                                  03200                           ;FIRST LOC NOT USED BY HIGH SEG DATA AREA
   270                                  03300                           ;LOADER WILL LOAD FIRST WORD HERE
   271                                  03400                           ;VALUE CANNOT BE CHANGED WITHOUT
   272                                  03500                           ;CHANGING LOADER AND RELOADING TO MAKE NEW SAVE FILES
   273                                  03600   IFDEF  UJOBDAT,<PURGE  P>       ;CLEAN UP USER VERSION SYMBOL TABLE
   274                                  03700   IFN  U2,<PURGE  UJOBDAT>        ;DITTO
   275                                  03800   PURGE  LOC,U2           ;CLEAN UP SYMBOL TABLE
   276                                  03900   IF2     <PURGE  LC>     ;DITTO
   277                                  04000   
   278                                  04100           END

NO ERRORS DETECTED

PROGRAM BREAK IS 000000
CPU TIME USED 00:43.915

16P CORE USED
JOBDAT - JOB DATA AREA (FIRST 140 LOC OF USER AREA)     MACRO %53B(1156)-1 17:55  5-Jun-84 Page S-1
JOBDAT  MAC     25-May-68 18:22         SYMBOL TABLE

JOB41           000041  ent     .JBDDT          000074  ent     
JOBAPR          000125  ent     .JBERR          000042  ent     
JOBBLT          000045  ent     .JBFF           000121  ent     
JOBCHN          000131  ent     .JBHCR          000002  sin     
JOBCN6          000106  ent     .JBHDA          000010  sin     
JOBCNI          000126  ent     .JBHGH          400000  sin     
JOBCNK          000102  sin     .JBHRL          000115  ent     
JOBCOR          000133  ent     .JBHVR          000004  sin     
JOBDA           000140  ent     .JBMUU          000066  sin     
JOBDDT          000074  ent     .JBOPC          000130  ent     
JOBERR          000042  ent     .JBPFI          000114  ent     
JOBEXM          000123  sin     .JBREL          000044  ent     
JOBFDV          000132  sin     .JBREN          000124  ent     
JOBFF           000121  ent     .JBSA           000120  ent     
JOBH41          000001  sin     .JBSYM          000116  ent     
JOBHCR          000002  sin     .JBTPC          000127  ent     
JOBHCU          000072  sen     .JBUSY          000117  ent     
JOBHDA          000010  sin     .JBUUO          000040  ent     
JOBHGH          400000  sin     .JBVER          000137  sin     
JOBHRL          000115  ent     
JOBHRN          000003  sin     
JOBHSA          000000  sin     
JOBHVR          000004  sin     
JOBJDA          000075  sin     
JOBMUU          000066  sin     
JOBNSV          000112  sin     
JOBOPC          000130  ent     
JOBPFI          000114  ent     
JOBPOP          000004  sin     
JOBREL          000044  ent     
JOBREN          000124  ent     
JOBS41          000122  sin     
JOBSA           000120  ent     
JOBSD1          000113  sin     
JOBSDD          000114  sin     
JOBSV           000076  sin     
JOBSVM          000075  sin     
JOBSYM          000116  ent     
JOBTPC          000127  ent     
JOBUSY          000117  ent     
JOBUUO          000040  ent     
JOBVER          000137  sin     
M               000013  int     
P               000001  int     
P1              000014  int     
U               000005  int     
.JB41           000041  ent     
.JBAPR          000125  ent     
.JBBLT          000045  ent     
.JBCHN          000131  ent     
.JBCN6          000106  ent     
.JBCNI          000126  ent     
.JBCOR          000133  ent     
.JBCST          000136  sin     
.JBDA           000140  ent     

JOBDAT - JOB DATA AREA (FIRST 140 LOC OF USER AREA)     MACRO %53B(1156)-1 17:55  5-Jun-84 Page 1
S       MAC     26-Apr-71 10:47         T. HASTINGS/TH/PFC  TS 29 MAY 71   V427(431)


Symbol cross reference

JOB41      103#    103
JOBAPR     193#    193
JOBBLT     113#    113
JOBCHN     199#    199
JOBCN6     153#    153
JOBCNI     195#    195
JOBCNK     158#    158
JOBCOR     204#    204
JOBDA      236#    236
JOBDDT     130#    130
JOBERR     105#    105
JOBEXM     188#    188
JOBFDV     202#    202
JOBFF      181#    181
JOBH41     253#    254
JOBHCR     257#    257
JOBHCU     122#    122
JOBHDA     269#    269
JOBHGH     250#    250
JOBHRL     165#    165
JOBHRN     257#    258
JOBHSA     251#    252
JOBHVR     261#    261
JOBJDA     131#    131     135     153     158     160     164
JOBMUU     117#    117
JOBNSV     150#    150
JOBOPC     197#    197
JOBPFI     164#    164
JOBPOP     262#    263
JOBREL     110#    110
JOBREN     191#    191
JOBS41     186#    186
JOBSA      179#    179
JOBSD1     162#    162
JOBSDD     160#    160     162
JOBSV      135#    135     148     150
JOBSVM     148#    148
JOBSYM     176#    176
JOBTPC     196#    196
JOBUSY     177#    177
JOBUUO     102#    102
JOBVER     222#    222
LC          97     276
LISTSN       3       7
LOC        102#    103#    105#    110#    113#    117#    119#    122     122#    128     128#    130#    131     131#
           153#    158#    164#    165#    176#    177#    179#    181#    186#    188     188#    191#    193#    195#
           196#    197#    199#    202     202#    204#    219#    222#    236#    250#    256#    261#    269#    275
M           77#
P           21
P1          96
JOBDAT - JOB DATA AREA (FIRST 140 LOC OF USER AREA)     MACRO %53B(1156)-1 17:55  5-Jun-84 Page 1
S       MAC     26-Apr-71 10:47         T. HASTINGS/TH/PFC  TS 29 MAY 71   V427(431)


Symbol cross reference

U           43#
U2          94      94#    102     103     105     110     113     117     122     130     131     135     148     150
           153     158     160     162     164     165     176     177     179     181     186     188     191     193
           195     196     197     199     202     204     219     222     236     249     251     252     253     254
           255     257     258     260     262     263     268     274     275
UJOBDA      90      96     122     135     148     150     160     162     186     188     202     252     254     257
           258     263     273
.JB41      103#    103
.JBAPR     193#    193
.JBBLT     113#    113
.JBCHN     199#    199
.JBCN6     153#    153
.JBCNI     195#    195
.JBCOR     204#    204
.JBCST     219#    219
.JBDA      236#    236
.JBDDT     130#    130
.JBERR     105#    105
.JBFF      181#    181
.JBHCR     255#    256     257
.JBHDA     268#    269
.JBHGH     249#    250
.JBHRL     165#    165
.JBHVR     260#    261
.JBMUU     117#    117
.JBOPC     197#    197
.JBPFI     164#    164
.JBREL     110#    110
.JBREN     191#    191
.JBSA      179#    179
.JBSYM     176#    176
.JBTPC     196#    196
.JBUSY     177#    177
.JBUUO     102#    102
.JBVER     222#    222
JOBDAT - JOB DATA AREA (FIRST 140 LOC OF USER AREA)     MACRO %53B(1156)-1 17:55  5-Jun-84 Page 1
S       MAC     26-Apr-71 10:47         T. HASTINGS/TH/PFC  TS 29 MAY 71   V427(431)


Macro/Opdef cross reference

M           77     185     187     201
U           43     121
UJOB        59#    101     102     104     109     112     129     152     163     164     175     176     178     180
           190     192     194     195     196     198     203     235
US          51#    130     157     218     255
USJOB       68#    116     221     249     260     268
XP          86#    134     147     149     159     161     251     253     256     257     262
  $ 
q