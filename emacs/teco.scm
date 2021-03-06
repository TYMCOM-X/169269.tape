File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)1		ERRMSG=1
1)	SUBTTL	Text Editor and COrrector	RC CLEMENTS/PMH/CAM/JMP/GSB/RCM/CBD
1)	SUBTTL	Introduction
****
2)1	SUBTTL	Text Editor and COrrector	RC CLEMENTS/PMH/CAM/JMP/GSB/RCM/CBD/JCS/Nothead
2)	SUBTTL	Introduction
**************
1)1		TECEDT==320
1)		TECWHO==7
1)		SEARCH	JOBDAT,MACTEN,UUOSYM	;UNIVERSAL FILES
****
2)1		TECEDT==355
2)		TECWHO==2
2)		SEARCH	JOBDAT,MACTEN,UUOSYM	;UNIVERSAL FILES
**************
1)1	OPDEF	AUXCAL	[42000,,0]
1)	;COPYRIGHT 1970,1971,1972, DIGITAL EQUIPMENT CORP., MAYNARD, MASS.
1)	;COPYRIG HT 1975 SNEVETS CORP.,BOHOKEN, J.N.
1)	;COPYRIGHT 1976 ARMADILLO U., OSTENTATIOUS, USA
1)	;COPYRIGHT 1976 MAJEBATH CORP.,UNIV. OF NH,DURHAM,NH
1)	;	"BROUGHT TO YOU BY THE PEOPLE WHO BROUGHT YOU LOGIN"
1)	IFN	0	<
****
2)1	;COPYRIGHT 1970,1971,1972, DIGITAL EQUIPMENT CORP., MAYNARD, MASS.
2)	;COPYRIGHT 1975 SNEVETS CORP.,BOHOKEN, J.N.
2)	;COPYRIGHT 1976 ARMADILLO U., AUSTINTATIOUS, USA
2)	;Copyright 1978 Privateer U, Bourbon Strut, Nude Oleander, Lousyanna
2)	IFN	0	<
**************
1)1	XP	%TECOV,	24
1)		LOC	.JBVER
****
2)1	XP	%TECOV,	26
2)		LOC	.JBVER
**************
1)1	;		TABLE OF CONTENTS FOR TECO - Text Editor and COrrector
1)	;
1)	;
1)	;			   SECTION			      PAGE
1)	;    1. Introduction . . . . . . . . . . . . . . . . . . . . .   1
1)	;    2. Table of Contents. . . . . . . . . . . . . . . . . . .   2
1)	;    3. REVISION HISTORY . . . . . . . . . . . . . . . . . . .   3
****
2)2	;                   Table of Contents for TECO
2)	;
2)	;
2)	;			   Section			      Page
2)	;
2)	;    1. Introduction . . . . . . . . . . . . . . . . . . . . .   1
2)	;    2. Table of Contents  . . . . . . . . . . . . . . . . . .   2
2)	;    3. REVISION HISTORY . . . . . . . . . . . . . . . . . . .   3
**************
1)1	;         4.2   CHKEO, ERROR & U . . . . . . . . . . . . . . .   5
1)	;    5. DEFAULT ASSEMBLY PARAMETERS. . . . . . . . . . . . . .   6
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)	;    6. ACCUMULATOR ASSIGNMENTS. . . . . . . . . . . . . . . .   7
1)	;    7. CONTROL FLAGS
1)	;         7.1   AC FF. . . . . . . . . . . . . . . . . . . . .   8
1)	;         7.2   AC F2. . . . . . . . . . . . . . . . . . . . .   9
1)	;    8. I-O CHANNELS . . . . . . . . . . . . . . . . . . . . .  10
1)	;    9. MISC PARAMETERS. . . . . . . . . . . . . . . . . . . .  11
1)	;   10. PSEUDO RUN UUO IF NEEDED . . . . . . . . . . . . . . .  12
1)	;   11. STARTUP TIME INITIALIZATION. . . . . . . . . . . . . .  13
1)	;   12. TEXT BUFFER INITIALIZATION . . . . . . . . . . . . . .  14
1)	;   13. REENTER COMMAND. . . . . . . . . . . . . . . . . . . .  15
1)	;   14. INITIALIZATION OF JOB DEPENDENT PARAMETERS . . . . . .  16
1)	;   15. CCL Command processor. . . . . . . . . . . . . . . . .  17
1)	;   16. RETURN NON-NULL TTY CHARACTER IN CH. . . . . . . . . .  19
1)	;   17. TYPE A CHARACTER . . . . . . . . . . . . . . . . . . .  21
1)	;   18. MESSAGE TYPE-OUT & NUMBER TYPE-OUT . . . . . . . . . .  23
1)	;   19. RETURN NEXT COMMAND CHAR AT CURRENT LEVEL. . . . . . .  24
1)	;   20. SCAN COMMAND STRING FOR CHARACTER IN TT. . . . . . . .  25
1)	;   21. SKAN ROUTINE DISPATCH TABLES . . . . . . . . . . . . .  28
1)	;   22. ACCEPT COMMAND STRING ROUTINE. . . . . . . . . . . . .  29
1)	;   23. EXPAND THE COMMAND BUFFER. . . . . . . . . . . . . . .  31
1)	;   24. PROCESS SPECIAL COMMAND EDITING CHARACTERS . . . . . .  33
1)	;   25. BACK UP BYTE POINTER IN AA, LOAD APPROPRIATE CHARACT .  35
1)	;   26. RUBOUT PROCESSOR . . . . . . . . . . . . . . . . . . .  36
1)	;   27. VIDEO RUBOUT PROCESSOR . . . . . . . . . . . . . . . .  37
1)	;   28. COMMAND DECODER. . . . . . . . . . . . . . . . . . . .  40
1)	;   29. NUMERIC INPUT, VALRET, & ALTMODE PROCESSOR . . . . . .  41
1)	;   30. COMMA & PARENTHESES PROCESSOR. . . . . . . . . . . . .  42
1)	;   31. MATHEMATICAL & LOGICAL OPERATORS . . . . . . . . . . .  43
1)	;   32. FLAGS - EOF, FORM FEED & . H Z POSITIONS . . . . . . .  44
1)	;   33. = & ^T COMMANDS. . . . . . . . . . . . . . . . . . . .  45
1)	;   34. ^H, ^F AND ^^ COMMANDS . . . . . . . . . . . . . . . .  46
1)	;   35. EXTENDED ^T OPERATIONS . . . . . . . . . . . . . . . .  47
1)	;   36. BACKSLASH PROCESSOR - AND NA COMMAND . . . . . . . . .  48
1)	;   37. Q-REGISTER COMMANDS
1)	;        37.1   U & Q. . . . . . . . . . . . . . . . . . . . .  49
1)	;        37.2   %. . . . . . . . . . . . . . . . . . . . . . .  50
1)	;        37.3   X. . . . . . . . . . . . . . . . . . . . . . .  51
1)	;        37.4   G. . . . . . . . . . . . . . . . . . . . . . .  53
1)	;        37.5   M, W, [ & ]. . . . . . . . . . . . . . . . . .  54
1)	;   38. MISCELLANEOUS CHARACTER DISPATCHER . . . . . . . . . .  55
1)	;   39. ^G COMMAND (GETTAB OR EXIT). . . . . . . . . . . . . .  56
1)	;   40. E COMMANDS
1)	;        40.1   DISPATCH ROUTINE & TABLE . . . . . . . . . . .  57
1)	;        40.2   EL (SETUP AND OUTPUT ROUTINES) . . . . . . . .  58
1)	;        40.3   EE (SAVE TECO'S STATE) . . . . . . . . . . . .  60
1)	;        40.4   NEL & EE (LOW CORE). . . . . . . . . . . . . .  62
1)	;        40.5   EE (RESTART CODE). . . . . . . . . . . . . . .  63
1)	;        40.6   EI & EP (EDIT INSERT & EDIT PUT) . . . . . . .  64
1)	;        40.7   EX & EXIT ROUTINES . . . . . . . . . . . . . .  67
1)	;	 40.71	EQ (EXIT AND REENTER). . . . . . . . . . . . .  67A
1)	;        40.8   ED (RUN UUO ON EXIT) . . . . . . . . . . . . .  69
1)	;        40.9   ET, EO & EU. . . . . . . . . . . . . . . . . .  70
1)	;        40.10  ES . . . . . . . . . . . . . . . . . . . . . .  71
1)	;        40.11  EH (CHANGE ERROR MESSAGE LEVEL). . . . . . . .  72
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)	;        40.12  EV (SET TERMINAL CHARACTERISTICS). . . . . . .  73
1)	;        40.13  TERMINAL CHARACTERISTICS TABLES. . . . . . . .  75
1)	;        40.14  EK (KILL) AND EN (RENAME). . . . . . . . . . .  76
1)	;        40.15  ER (PREPARE TO READ A FILE). . . . . . . . . .  77
1)	;        40.16  FILE SPEC SETUP. . . . . . . . . . . . . . . .  79
1)	;        40.17  EB (EDIT BACKUP PROCESSOR) . . . . . . . . . .  80
1)	;        40.18  I/O ERROR ROUTINES . . . . . . . . . . . . . .  82
1)	;        40.19  EW (EDIT WRITE). . . . . . . . . . . . . . . .  83
1)	;        40.20  EZ & EF. . . . . . . . . . . . . . . . . . . .  86
1)	;        40.21  EM (MTAPE UUO'S) . . . . . . . . . . . . . . .  87
1)	;        40.22  EB (FINISH UP COMMAND) . . . . . . . . . . . .  88
1)	;        40.23  EW (SUBROUTINES FOR EW). . . . . . . . . . . .  90
1)	;        40.24  MISC. ROUTINES . . . . . . . . . . . . . . . .  91
1)	;   41. ^V, ^W, ^X COMMANDS. . . . . . . . . . . . . . . . . .  93
1)	;   42. ROUTINE TO PARSE FILE DESIGNATOR . . . . . . . . . . .  94
1)	;   43. TABLES FOR FILSPEC PARSER. . . . . . . . . . . . . . .  98
1)	;   44. Y. . . . . . . . . . . . . . . . . . . . . . . . . . . 101
1)	;   45. ^Y ! ^P - QUICK PAGE SCAN COMMANDS . . . . . . . . . . 103
1)	;   46. READ A CHARACTER FROM INPUT FILE . . . . . . . . . . . 104
1)	;   47. INSERT COMMAND . . . . . . . . . . . . . . . . . . . . 105
1)	;   48. ALPHA CASE CONVERTED . . . . . . . . . . . . . . . . . 109
1)	;   49. CHECK FOR NON-CONTROL CHARACTERS . . . . . . . . . . . 110
1)	;   50. NI . . . . . . . . . . . . . . . . . . . . . . . . . . 111
1)	;   51. NT . . . . . . . . . . . . . . . . . . . . . . . . . . 112
1)	;   52. PUT A CHARACTER IN THE OUTPUT FILE . . . . . . . . . . 113
1)	;   53. PW . . . . . . . . . . . . . . . . . . . . . . . . . . 117
1)	;   54. NJ, NC, & NL COMMANDS. . . . . . . . . . . . . . . . . 119
1)	;   55. ROUTINE TO RETURN CURRENT ARGUMENT IN B. . . . . . . . 120
1)	;   56. ND . . . . . . . . . . . . . . . . . . . . . . . . . . 121
1)	;   57. SEARCH COMMANDS. . . . . . . . . . . . . . . . . . . . 122
1)	;   58. SCAN INSERT ARGUMENT IF F-SEARCH . . . . . . . . . . . 127
1)	;   59. ACTUAL SEARCH. . . . . . . . . . . . . . . . . . . . . 128
1)	;   60. SEARCH STRING FOUND. . . . . . . . . . . . . . . . . . 129
1)	;   61. AUTOTYPE AFTER SUCCESSFUL SEARCHES . . . . . . . . . . 131
1)	;   62. V COMMAND. . . . . . . . . . . . . . . . . . . . . . . 134
1)	;   63. ^E COMMANDS. . . . . . . . . . . . . . . . . . . . . . 135
1)	;   64. ^EW, ^ED, ^EL, ^ES COMMANDS. . . . . . . . . . . . . . 136
1)	;   65. ^E[A,B,C,. .]. . . . . . . . . . . . . . . . . . . . . 137
1)	;   66. RANDOM ^<CHAR> PROCESSORS. . . . . . . . . . . . . . . 138
1)	;   67. F SEARCHES . . . . . . . . . . . . . . . . . . . . . . 140
1)	;   68. <> . . . . . . . . . . . . . . . . . . . . . . . . . . 141
1)	;   69. OTAG$. . . . . . . . . . . . . . . . . . . . . . . . . 143
1)	;   70. " ' PROCESSING . . . . . . . . . . . . . . . . . . . . 145
1)	;   71. EXECUTE INDIVIDUAL " COMMANDS. . . . . . . . . . . . . 146
1)	;   72. ROUTINE TO TEST CHARACTER FOR $,%,.,0-9,A-Z. . . . . . 147
1)	;   73. ERROR MESSAGE PRINTOUT . . . . . . . . . . . . . . . . 148
1)	;   74. ROUTINE TO TYPE C(TT) IN SIXBIT. . . . . . . . . . . .
1)	;   75. ERROR PROCESSING ROUTINES. . . . . . . . . . . . . . . 154
1)	;   76. DISPATCH TABLE FOR SPECIAL INFORMATION TYPEOUT . . . . 155
1)	;   77. SPECIAL INFORMATION TYPEOUT ROUTINES . . . . . . . . . 156
1)	;   78. UUO HANDLER. . . . . . . . . . . . . . . . . . . . . . 159
1)	;   79. COMMAND TO COMPLEMENT TRACE MODE. "?" AS A COMMAND . . 160
1)	;   80. ROUTINE TO RETURN STRING OPERATION STRING ARGUMENTS. . 161
1)	;   81. ROUTINE TO RETURN IN CH THE CHARACTER TO THE RIGHT O . 162
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)	;   82. ROUTINES TO MOVE CHARACTERS AROUND . . . . . . . . . . 163
1)	;   83. GARBAGE COLLECTOR. . . . . . . . . . . . . . . . . . . 166
1)	;   84. **********AUTOMATIC MEMORY EXPANSION*********. . . . . 170
1)	;   85. COMMAND DISPATCH TABLE . . . . . . . . . . . . . . . . 172
1)	;   86. LOW SEGMENT. . . . . . . . . . . . . . . . . . . . . . 173
1)		SUBTTL REVISION HISTORY
****
2)2	;         4.2   CHKEO, ERROR . . . . . . . . . . . . . . . . .   5
2)	;    5. DEFAULT ASSEMBLY PARAMETERS  . . . . . . . . . . . . .   6
2)	;    6. ACCUMULATOR ASSIGNMENTS  . . . . . . . . . . . . . . .   7
2)	;    7. CONTROL FLAGS
2)	;         7.1   AC FF  . . . . . . . . . . . . . . . . . . . .   8
2)	;         7.2   AC F2  . . . . . . . . . . . . . . . . . . . .   9
2)	;    8. I-O CHANNELS . . . . . . . . . . . . . . . . . . . . .  10
2)	;    9. MISC PARAMETERS  . . . . . . . . . . . . . . . . . . .  11
2)	;   10. PSEUDO RUN UUO IF NEEDED . . . . . . . . . . . . . . .  12
2)	;   11. STARTUP TIME INITIALIZATION  . . . . . . . . . . . . .  13
2)	;   12. TEXT BUFFER INITIALIZATION . . . . . . . . . . . . . .  15
2)	;   13. REENTER COMMAND  . . . . . . . . . . . . . . . . . . .  16
2)	;   14. INITIALIZATION OF JOB DEPENDENT PARAMETERS . . . . . .  17
2)	;   15. CCL Command processor  . . . . . . . . . . . . . . . .  18
2)	;   16. RETURN NON-NULL TTY CHARACTER IN CH. . . . . . . . . .  22
2)	;   17. TYPE A CHARACTER.  . . . . . . . . . . . . . . . . . .  24
2)	;   18. MESSAGE TYPE-OUT & NUMBER TYPE-OUT . . . . . . . . . .  27
2)	;   19. RETURN NEXT COMMAND CHAR AT CURRENT LEVEL  . . . . . .  29
2)	;   20. SCAN COMMAND STRING FOR CHARACTER IN TT  . . . . . . .  30
2)	;   21. SKAN ROUTINE DISPATCH TABLES . . . . . . . . . . . . .  33
2)	;   22. ACCEPT COMMAND STRING ROUTINE  . . . . . . . . . . . .  35
2)	;   23. EXPAND THE COMMAND BUFFER  . . . . . . . . . . . . . .  37
2)	;   24. PROCESS SPECIAL COMMAND EDITING CHARACTERS . . . . . .  39
2)	;   25. BACK UP BYTE POINTER IN AA, LOAD APPROPRIATE CHARACT .  41
2)	;   26. SPECIAL "IMMEDIATE" COMMAND PROCESSOR  . . . . . . . .  42
2)	;   27. RUBOUT PROCESSOR . . . . . . . . . . . . . . . . . . .  44
2)	;   28. VIDEO RUBOUT PROCESSOR . . . . . . . . . . . . . . . .  46
2)	;   29. COMMAND DECODER  . . . . . . . . . . . . . . . . . . .  50
2)	;   30. NUMERIC INPUT, VALRET, & ALTMODE PROCESSOR . . . . . .  51
2)	;   31. COMMA & PARENTHESES PROCESSOR  . . . . . . . . . . . .  52
2)	;   32. MATHEMATICAL & LOGICAL OPERATORS . . . . . . . . . . .  53
2)	;   33. FLAGS - EOF, FORM FEED & . H Z POSITIONS . . . . . . .  54
2)	;   34. = & ^T COMMANDS  . . . . . . . . . . . . . . . . . . .  55
2)	;   35. ^H, ^F AND ^^ COMMANDS . . . . . . . . . . . . . . . .  56
2)	;   36. EXTENDED ^T OPERATIONS . . . . . . . . . . . . . . . .  57
2)	;   37. BACKSLASH PROCESSOR  . . . . . . . . . . . . . . . . .  58
2)	;   38. nA COMMAND . . . . . . . . . . . . . . . . . . . . . .  59
2)	;   39. Q-REGISTER COMMANDS
2)	;        39.1   U & Q  . . . . . . . . . . . . . . . . . . . .  60
2)	;        39.2   %  . . . . . . . . . . . . . . . . . . . . . .  62
2)	;        39.3   X  . . . . . . . . . . . . . . . . . . . . . .  63
2)	;        39.4   G  . . . . . . . . . . . . . . . . . . . . . .  65
2)	;        39.5   M, W, [ & ]  . . . . . . . . . . . . . . . . .  66
2)	;   40. MISCELLANEOUS CHARACTER DISPATCHER . . . . . . . . . .  67
2)	;   41. ^G COMMAND (GETTAB OR EXIT)  . . . . . . . . . . . . .  68
2)	;   42. E COMMANDS
2)	;        42.1   DISPATCH ROUTINE & TABLE . . . . . . . . . . .  69
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)	;        42.2   EL (SETUP AND OUTPUT ROUTINES) . . . . . . . .  70
2)	;        42.3   EE (SAVE TECO'S STATE) . . . . . . . . . . . .  72
2)	;        42.4   NEL & EE (LOW CORE)  . . . . . . . . . . . . .  74
2)	;        42.5   EE (RESTART CODE)  . . . . . . . . . . . . . .  75
2)	;        42.6   EI & EP (EDIT INSERT & EDIT PUT) . . . . . . .  76
2)	;        42.7   EX & EXIT ROUTINES . . . . . . . . . . . . . .  80
2)	;        42.8   ED (RUN UUO ON EXIT) . . . . . . . . . . . . .  82
2)	;        42.9   ET, EO & EU  . . . . . . . . . . . . . . . . .  83
2)	;        42.10  ES . . . . . . . . . . . . . . . . . . . . . .  84
2)	;        42.11  EH (CHANGE ERROR MESSAGE LEVEL)  . . . . . . .  85
2)	;        42.12  EV (SET TERMINAL CHARACTERISTICS)  . . . . . .  86
2)	;        42.13  TERMINAL CHARACTERISTICS TABLES  . . . . . . .  88
2)	;        42.14  EK (KILL) AND EN (RENAME)  . . . . . . . . . .  90
2)	;        42.15  ER (PREPARE TO READ A FILE)  . . . . . . . . .  91
2)	;        42.16  FILE SPEC SETUP  . . . . . . . . . . . . . . .  93
2)	;        42.17  EB (EDIT BACKUP PROCESSOR) . . . . . . . . . .  94
2)	;        42.18  I/O ERROR ROUTINES . . . . . . . . . . . . . .  97
2)	;        42.19  EW (EDIT WRITE)  . . . . . . . . . . . . . . .  98
2)	;        42.20  EZ & EF  . . . . . . . . . . . . . . . . . . . 102
2)	;        42.21  EM (MTAPE UUO'S) . . . . . . . . . . . . . . . 103
2)	;        42.22  EB (FINISH UP COMMAND) . . . . . . . . . . . . 104
2)	;        42.23  EW (SUBROUTINES FOR EW)  . . . . . . . . . . . 107
2)	;        42.24  MISC. ROUTINES . . . . . . . . . . . . . . . . 108
2)	;   43. ^V, ^W, ^X COMMANDS  . . . . . . . . . . . . . . . . . 110
2)	;   44. ROUTINE TO PARSE FILE DESIGNATOR . . . . . . . . . . . 111
2)	;   45. TABLES FOR FILSPEC PARSER  . . . . . . . . . . . . . . 115
2)	;   46. Y  . . . . . . . . . . . . . . . . . . . . . . . . . . 118
2)	;   47. ^Y ! ^P - QUICK PAGE SCAN COMMANDS . . . . . . . . . . 120
2)	;   48. READ A CHARACTER FROM INPUT FILE . . . . . . . . . . . 121
2)	;   49. INSERT COMMAND . . . . . . . . . . . . . . . . . . . . 122
2)	;   50. ALPHA CASE CONVERTED . . . . . . . . . . . . . . . . . 126
2)	;   51. CHECK FOR NON-CONTROL CHARACTERS . . . . . . . . . . . 127
2)	;   52. NI . . . . . . . . . . . . . . . . . . . . . . . . . . 128
2)	;   53. T COMMAND  . . . . . . . . . . . . . . . . . . . . . . 129
2)	;   54. V COMMAND  . . . . . . . . . . . . . . . . . . . . . . 130
2)	;   55. PUT A CHARACTER IN THE OUTPUT FILE . . . . . . . . . . 131
2)	;   56. PW . . . . . . . . . . . . . . . . . . . . . . . . . . 135
2)	;   57. NJ, NC, & NL COMMANDS  . . . . . . . . . . . . . . . . 137
2)	;   58. ROUTINE TO RETURN CURRENT ARGUMENT IN B  . . . . . . . 138
2)	;   59. ND . . . . . . . . . . . . . . . . . . . . . . . . . . 139
2)	;   60. Searches
2)	;        60.1   Commands . . . . . . . . . . . . . . . . . . . 140
2)	;        60.2   pattern source setup . . . . . . . . . . . . . 141
2)	;        60.3   set up search matrix . . . . . . . . . . . . . 143
2)	;        60.4   New fast search routine  . . . . . . . . . . . 158
2)	;        60.5   Old slow but sure routine  . . . . . . . . . . 161
2)	;        60.6   pattern found  . . . . . . . . . . . . . . . . 163
2)	;        60.7   Autotype after succesful searches  . . . . . . 164
2)	;        60.8   Pattern not found in this buffer . . . . . . . 165
2)	;   61. <> . . . . . . . . . . . . . . . . . . . . . . . . . . 167
2)	;   62. OTAG$  . . . . . . . . . . . . . . . . . . . . . . . . 169
2)	;   63. " ' PROCESSING . . . . . . . . . . . . . . . . . . . . 171
2)	;   64. EXECUTE INDIVIDUAL " COMMANDS  . . . . . . . . . . . . 172
2)	;   65. ROUTINE TO TEST CHARACTER FOR $,%,.,0-9,A-Z  . . . . . 173
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)	;   66. ERROR MESSAGE PRINTOUT . . . . . . . . . . . . . . . . 174
2)	;   67. ROUTINE TO TYPE C(TT) IN SIXBIT  . . . . . . . . . . . 179
2)	;   68. ERROR PROCESSING ROUTINES  . . . . . . . . . . . . . . 180
2)	;   69. DISPATCH TABLE FOR SPECIAL INFORMATION TYPEOUT . . . . 181
2)	;   70. SPECIAL INFORMATION TYPEOUT ROUTINES . . . . . . . . . 182
2)	;   71. UUO HANDLER  . . . . . . . . . . . . . . . . . . . . . 184
2)	;   72. COMMAND TO COMPLEMENT TRACE MODE. "?" AS A COMMAND . . 185
2)	;   73. ROUTINE TO RETURN STRING OPERATION STRING ARGUMENTS. . 186
2)	;   74. ROUTINE TO RETURN IN CH THE CHARACTER TO THE RIGHT O . 187
2)	;   75. ROUTINES TO MOVE CHARACTERS AROUND . . . . . . . . . . 188
2)	;   76. GARBAGE COLLECTOR  . . . . . . . . . . . . . . . . . . 191
2)	;   77. AUTOMATIC MEMORY EXPANSION . . . . . . . . . . . . . . 195
2)	;   78. COMMAND DISPATCH TABLE . . . . . . . . . . . . . . . . 197
2)	;   79. LOW SEGMENT  . . . . . . . . . . . . . . . . . . . . . 198
2)3		SUBTTL REVISION HISTORY
**************
1)1	320	Fixed EE command to gettab the FPN and NAM/wrs
1)	317	 ADD IN UNH FEATURES SUCH AS "FTRESCAN","FTEAGAIN","FTSWTCH",
1)		AND "FTKL10"
1)		 ADD IN THE ^G_ COMMAND TO TYPE OUT THE CONTENTS OF THE
1)		SEARCH BUFFER	(FTNCM2)
1)		 ADD IN THE "V" FOR VERIFY COMMAND.	(FTNCM1)
1)		 ADD IN THE COMMANDS <LF> AND ^H; IF THESE ARE SEEN AS THE FIRST 
1)		CHARACTERS IN THE COMMAND STRING, THEN DO EITHER AN LT$$ OR A
1)		-LT$$ RESPECTIVELY.  THESE WORK JUST LIKE THE *A COMMAND TO PUT
1)		THE LAST COMMAND STRING INTO Q-REGISTER A 	(FTNCM0)
1)		 RE-DO THE TABLE OF CONTENTS TO BE ACCURATE
1)		B.J. THOMAS, UNH, DURHAM, NH	17-FEB-78
1)	{
****
2)3	317	Fix /SUPLSN.  Slow punch routine will be used on a sequenced
2)		file IF /SUPLSN not set for INPUT file.  Minor bugs in 
2)		default PPN handler, initalization, and edit 313.
2)	320	Fix EA so that privileged programs don't bomb if the LOOKUP
2)		fails.  (Monitor thinks USETI is a super.)  Fix bug in *i
2)		command: X3 routine should not add the garbage collection
2)		constant in this case.  Add ADDS 580 terminal by popular
2)		demand.  Fix a very rare ill mem ref bug:  if MEMSIZ falls
2)		exactly on a 1K boundary, and Z is allowed to equal MEMSIZ,
2)		then the routine at NROOM6 fails, since it must reference
2)		(Z/5)+1. So make sure Z always stays less than MEMSIZ.
2)	321	Fix X command to allow buffer length of greater than 2**18
2)		characters; i.e. do not use immediate instructions to perform
2)		necessary arithmetic.
2)	***The following adapted from Storage Technology Corp.'s revisions.
2)	322	Fix double OCT error if first character of new command is
2)		8 or 9.
2)	323	Add "\\" command which reads/writes same as "\" but in octal.
2)	324	Add VT50 terminal.
2)	325	Add three immediate commands which work if they are the
2)		first things typed:   <LF> = 1LT, <^H> = -1LT, and, in the
2)		spirit of DDT, <;> = 0LT.  Fix several bugs in log file processing:
2)		^G's were getting inserted twice; * commands weren't being
2)		inserted at all; first character in log file (usually *)
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		missing if previous command was ^G^G'ed.
2)	326	Change INIT to OPEN in TTOPEN and CCLTMP.
2)		Fix an obscure search bug which makes S^ES$ blow up
2)		if the character after the end of the buffer HAPPENS
2)		to be a blank or tab.
2)	327	Fix serious problem arising when ^P and ^Y are used on
2)		sequenced files.  n^P usually threw away page n-1; ^Y
2)		went into an infinite loop.
2)	330	Fix bug in \\.
2)	331	Fix Ill Mem Ref in ";" immediate command.  Add H1500, ADM3A,
2)		ACT-IV, ACT-V and HP2640 terminals.  Improve handling of
2)		; and ^H commands.  Modify ET command: 2ET means image typeout.
2)		Clear digit string bit to prevent 2.5 or 3Z4 from returning
2)		wierd values.
2)	332	Improve U command.  m,nUi will now store the value n into
2)		Q-reg i, and return m.  This allows m,nUiUj to store two
2)		values, such as those passed to a macro.  Improve [ command.
2)		n[i now behaves like [inUi, allowing the Q-reg to be saved
2)		before a value is stored.  m,n[i[j will work as described
2)		above.  Issue error msg if attempt to store a number smaller than
2)		-377777,,0 octal.
2)	333	Support File Daemon, improve protection logic for EB's.
2)		.BAK files will always be given a protection of 0xx or 4xx.
2)	334	Replace complete searching algorithm. (U. of New Orleans)
2)	335	Change EO level to 3, and restore several of the obolete
2)		DEC features for EO < 3, such as position of pointer after
2)		searches, etc. (NSA)
2)	336	Don't shrink too much after an EI file is processed, so that
2)		the purpose of "R TECO 50K" isn't defeated by the initial 
2)		EITECO.INI.
2)	337	Change EI-EP file defaulting.  If no device or directory is
2)		specified, first look on [-], then on [,,TEC]/SCAN,
2)		and finally on TED:.  Add /DEFAULT I/O switch to clear
2)		sticky defaults.  Read TECO.ERR from the device and PPN that
2)		TECO was run from; if that fails, try SYS:.  Other minor
2)		changes to error message processing.  Change /READ to /READONLY.
2)	340	Add warning message for ER and EB when file is found in
2)		directory other than the one specified (LIB: or /SCAN).
2)		Fix /INPLACE so it will really overwrite the file in these
2)		cases.  Fix EN so file stays in the same directory unless
2)		a new directory is explicitly given.
2)	341	Fix Ill mem ref in ^N processing for new search.
2)	342	Fix backwards bounded searches which occur after the pointer.
2)		For example, HK IA12345$ J 6,0S123$$ shouldn't fail.
2)		Fix core problem preventing REENTER after ^Z.
2)	343	Modify CCL command handler to support MAKE A=B command.  Change
2)		our pseudo altmode character from % to $ (dollar sign).
2)		Make EWfile/APPEND$ equivalent to EAfile$.  Make EBfile/READONLY$
2)		equivalent to ERfile$.
2)	344	Fix several bugs in slow search algorithm.  Due to overwhelming
2)		popular demand, finally remove DEC's "feature" which
2)		treats all searches inside iterations as colon searches.
2)		Such searches will never issue an error message, but
2)		if EO > 2, they will now return no value.  Semi-colons
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		will still work correctly, since a ; with no arg looks at
2)		what happened in the last search.  Searches using a previous
2)		string will now remember the exact match setting.
2)	345	Fix LSN routines to properly handle page marks. (DEC edit 217).
2)	346	Implement generalized nA command, which returns the ASCII value
2)		of the nth character to the right of the pointer. 0A
2)		returns the character to the left, and -nA returns the
2)		n+1st character to the left of the pointer.  If .+n-1 is
2)		out of bounds, a 0 is returned.  An m,nA command will
2)		cause m to be returned if the character is out of bounds.
2)		Implement :nA command to append n lines to the buffer.
2)	347	Implement the nV command equivalent to n-1TnT.
2)	*** Start of Version 124A ***
2)	NOTE:  All applicable DEC edits through 226 have been installed.
2)	350	Make sure there is room for at least 5000 characters when
2)		TECO starts up.
2)	351	Don't issue "Superseding existing file" message if /INPLACE.
2)		Fix V command for negative numbers.
2)	352	Fix Ill mem ref in CCL command processor when TMP file doesn't
2)		end with <cr> or "}".
2)	353	Fix problem with EB close routine so that it doesn't get fooled
2)		by old .BAK and .TMP files not in the default path.
2)	354	Fix Ill. Mem. Ref. after TECO runs out of core.
2)	355	Fix another Ill. Mem. Ref in EP command.  Make EP a little faster.
2)	{
**************
1)1		SUBTTL	MACRO DEFINITIONS -- CHKEO, ERROR & U
1)	;CHECK EO FLAG: CHKEO	EO#,ADDR
****
2)5		SUBTTL	MACRO DEFINITIONS -- CHKEO, ERROR
2)	;CHECK EO FLAG: CHKEO	EO#,ADDR
**************
1)1	NDS.	VC,	0			;V COMMAND NOT IMPLEMENTED
1)	NDS.	EOVAL,	2			;THE STANDARD SETTING OF THE EO FLAG FOR
1)						;THIS VERSION IS 2
1)	BUGSW==1
1)	NDS.	BUGSW,	0			;STANDARD IS DON'T SAVE SYMBOLS
****
2)6	NDS.	VC,	0			;OLD V COMMAND NOT IMPLEMENTED,
2)						;[347] USE NEW V COMMAND INSTEAD
2)	NDS.	EOVAL,	3			;[335] THE STANDARD SETTING OF THE EO FLAG FOR
2)						;THIS VERSION IS 3
2)	NDS.	BUGSW,	0			;STANDARD IS DON'T SAVE SYMBOLS
**************
1)1	;EOVAL=N			(WHERE 0<N<2, IF EO-CONTROLLED FEATURES ADDED
1)	;				 SINCE EO=N WAS STANDARD ARE NOT WANTED)
****
2)6	;EOVAL=N			(WHERE 0<N<3, IF EO-CONTROLLED FEATURES ADDED
2)	;				 SINCE EO=N WAS STANDARD ARE NOT WANTED)
**************
1)1	;
1)	;				IF NON-ZERO, THEN ...
1)	FTSWTCH==0		;NO SWITCH.INI AT TYMSHARE
1)	NDS.	FTSWTCH,	-1	; READ SWITCH.INI IF NO TECO.INI
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)	NDS.	FTNCM0,		-1	; USE NEW COMMANDS " ","<^H>"
1)	NDS.	FTNCM1,		-1	; THE "V" COMMAND
1)	NDS.	FTNCM2,		-1	; PRINT OUT THE SEARCH BUFFER; "^G_" COMMAND
1)	NDS.	FTFDAE,		-1	; ALLOW FOR FILE DAEMON
1)	NDS.	FTKL10,		-1	; CPU HAS KL-10 INSTRUCTION SET
1)	NDS.	FTEAGAIN,	-1	; ALLOW "EQ" FOR EDIT AGAIN
1)	FTRESCAN==0
1)	NDS.	FTRESCAN,	-1	; ALLOW "R TECO-FILESPEC"
1)	IFN	FTRESCAN,<
1)		..TMP==CCL+TEMP-2
1)	IFN	..TMP,<
1)		PRINTX ?FTRESCAN REQUIRES CCL AND TEMP
1)		PASS 2
1)		END
1)			>
1)		PURGE	..TMP
1)		>
1)	IFN	FTNCM1,<
1)		IFN	VC,<PRINTX % V COMMAND WILL GIVE VERIFY
1)		VC==0	>>
1)	SUBTTL	ACCUMULATOR ASSIGNMENTS
****
2)7	SUBTTL	ACCUMULATOR ASSIGNMENTS
**************
1)1	IFN	FTNCM0,<F.LFCM==1B17		; <LF> COMMAND >
1)	IFE	FTNCM0,<F.XXXX==1B17		;***FREE***>
1)	F.PMAT==1B16		;PREVAILING MATCH MODE
****
2)8	F.IMAG==1B17		;[331] TYPEOUT IN IMAGE MODE
2)	F.PMAT==1B16		;PREVAILING MATCH MODE
**************
1)1	F.TEMP==1B12		;TMPCOR UUO ALLOWED
1)	F.EOFI==1B11		;INPUT CLOSED BY EOF
****
2)8	F.XXXX==1B12		;[343] **** FREE ****
2)	F.EOFI==1B11		;INPUT CLOSED BY EOF
**************
1)1	S.RTYP==1B10		;^G<BLANK> IN PROGRESS-ALWAYS USE ARROW MODE
1)	S.EA==	1B09		;EDIT APPEND IN PROGRESS
****
2)9	S.XXXX==1B10		;[331] ***FREE***
2)	S.EA==	1B09		;EDIT APPEND IN PROGRESS
**************
1)1	.GTNAM==3	;GETTAB FOR NAME OF PROGRAM CURRENTLY RUNNING
1)	.GTFPN==-25	;GETTAB FOR DIRECTORY CURRENT PROGRAM CAME FROM
1)	BEGPAG==200	;FAKE ASCII CHAR = BEGINNING OF BUFFER
****
2)11	BEGPAG==200	;FAKE ASCII CHAR = BEGINNING OF BUFFER
**************
1)1	STABLN==^D131	;LENGTH OF SEARCH TABLE
1)	GCTBL==	LPF+40
****
2)11	SMATLN==^D131	;Number of characters in the search matricies
2)	BITMLN==SMATLN/^D36+1 ;Number of words needed to hold SMATLN bits
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)	STABLN==^D131	;Length of Otag$ build table
2)	GCTBL==	LPF+40
**************
1)1	IFN	FTKL10,<			;; [BJT]
1)		OPDEF	ADJSP [105B8]		;; [BJT] KL-10 INSTRUCTIONS
1)		OPDEF	ADJBP [133B8]		;; [BJT]
1)		>				;; [BJT]
1)	SUBTTL	PSEUDO RUN UUO IF NEEDED
****
2)11	EODEC==	2	;[335] Same for version 124+
2)12	SUBTTL	PSEUDO RUN UUO IF NEEDED
**************
1)1		MOVE	A,[PUSHJ P,UUOH];SET UUO TRAP
1)		MOVEM	A,.JB41
1)	IFN	FTSWTCH,<
1)		SETZM	SW.INI		; ZERO SWITCH.INI FLAGS
1)		SETZM	INI.SW
1)		>
1)		MOVE	P,[XWD -LPDL,PDL]	;START ONE WORD DOWN
1)		HRRZ	B,.JBFF		;MAKE SURE WE HAVE AT LEAST 202 FREE WDS
1)		ADDI	B,202
1)		CAML	B,.JBREL
****
2)13		MOVEM	11,ERRDEV	;[337] Save device we RUN from, for TECO.ERR
2)		MOVEM	7,ERRPPN	;[337] Save PPN as well
2)		MOVE	A,[PUSHJ P,UUOH]	;SET UUO TRAP
2)		MOVEM	A,.JB41
2)		MOVE	P,[XWD -LPDL,PDL]	;START ONE WORD DOWN
2)		HRRZ	B,.JBFF		;MAKE SURE WE HAVE AT LEAST 1000. FREE WDS
2)		ADDI	B,^D1000	;[350]
2)		CAML	B,.JBREL
**************
1)1		EXCH	A,.JBFF
****
2)13		SUBI	A,47		;[352] Buffer space for TMPCOR, etc.
2)		EXCH	A,.JBFF
**************
1)1		HRREI	A,TYCASW	;GET WHATEVER IS DEFAULT TYPE-OUT CASE FLAGGING MODE
****
2)13					;Fall through to next page...
2)14		HRREI	A,TYCASW	;GET WHATEVER IS DEFAULT TYPE-OUT CASE FLAGGING MODE
**************
1)1	IFN BISSW,< 			;BIS SUPPORT
1)		SETZM	A		;SEE IF KL10
****
2)14	IFN BISSW,< ;BIS SUPPORT
2)		SETZM	A		;SEE IF KL10
**************
1)1	SUBTTL	TEXT BUFFER INITIALIZATION
****
2)14					;Fall through to next page...
2)15	SUBTTL	TEXT BUFFER INITIALIZATION
**************
1)1		TXZ	F2,S.SSEQ!S.SLOG!S.NTRC
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		MOVE	P,[XWD -LPDL,PDL]	;INITIALIZE PUSHDOWN LIST
****
2)15		TXZ	F2,S.SSEQ!S.SLOG!S.NTRC!S.OCTL	;[322]
2)		MOVE	P,[XWD -LPDL,PDL]	;INITIALIZE PUSHDOWN LIST
**************
1)1	IFN	FTSWTCH,<
1)		SETOM	INI.SW		; SAY WE WILL TRY TO READ SWITCH.INI
1)		>
1)		PUSHJ	P,INIFIL	;GET IT INTO CORE
1)	IFN	FTSWTCH,<
1)		SETZM	INI.SW		; WELL, UN-DO THIS
1)		>
1)		JRST	CLIS		;GO DO REST
****
2)15		PUSHJ	P,INIFIL	;GET IT INTO CORE
2)		JRST	CLIS		;GO DO REST
**************
1)1		PUSH	P,E
1)		MOVE	P,[IOWD 4,TEMPDL]	;SET UP STACK FOR SURE
1)		RELEAS	TTY,		;CLOSE TTY
1)		PUSHJ	P,TTOPEN	;REOPEN TTY
****
2)16		MOVE	P,[IOWD 4,TEMPDL]	;SET UP STACK FOR SURE
2)		PUSH	P,E		;SAVE AN AC
2)		MOVEI	E,TTY		;CLOSE TTY
2)		RESDV.	E,		;RESET TTY
2)		JFCL
2)		PUSHJ	P,TTOPEN	;REOPEN TTY
**************
1)1		HRROI	A,-23		;GET AUN
1)		GETTAB	A,
1)		 JFCL
1)		MOVEM	A,USRPPN
****
2)17		GETPPN	A,		;GET USER'S PROJ-PROG #
2)		  JFCL			;[317]IN CASE SKIP RETURN
2)		MOVEM	A,USRPPN
**************
1)1	TECO2:	PJOB	A,		;GET JOB #
1)		MOVEM	A,JOBN
****
2)17	TECO2:	MOVE	A,[F%FDAE&LH.ALF!.GTFET]	;[333] See if FILDAE is there
2)		GETTAB	A,		;[333]
2)		  SETZ	A,		;[333] Assume not
2)		SETZM	FDAEM		;[333] Ditto
2)		TXNE	A,F%FDAE&RH.ALF	;[333] Well?
2)		SETOM	FDAEM		;[333] Yes
2)		PJOB	A,		;GET JOB #
2)		MOVEM	A,JOBN
**************
1)1		HRRI	B,(SIXBIT /TEC/);FORM NAME ###TEC
1)		MOVEM	B,TMPTEC	;SAVE
****
2)17		HRRI	B,(SIXBIT /TEC/)	;FORM NAME ###TEC
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		MOVEM	B,TMPTEC	;SAVE
**************
1)1	IFE	FTEAGAIN,<
1)		MOVE	A,[XWD 2,TT]	;SET UP FOR TMPCOR READ & DELETE
1)		>
1)	IFN	FTEAGAIN,<
1)		MOVE	A,[XWD 1,TT]	; SET UP ARG BLOCK FOR READ AND NO DELETE
1)		>
1)		HRLZI	TT,'EDT'	;SET UP READ BLOCK FOR TMPCOR UUO
1)		HRLZI	TT1,-15		;INCREASE CAPACITY TO 75 CHARS.
1)		HRRI	TT1,SAVE-1	;PLACE TO READ TMPCOR FILE
1)		TMPCOR	A,		;READ AND DELETE FILE EDT
1)		JRST	CCLTMP		;NO FILE EDT OR NO TMPCOR UUO
1)		MOVE	T,TTYPT2	;SET UP DDTOUT BUFFER POINTER
1)		MOVEI	C,2		;INIT CHAR CTR
1)		HRRZI	AA,SAVE		;GET START OF BUFFER AREA
1)		HRLI	AA,350700	;PICK UP EDT CHARACTERS, SKIP LINED "S"
1)	CCLTM1:	ILDB	B,AA		;GET NEXT EDT CHARACTER
1)		CAIE	B,.CHCRT	;ONLY TERMINATORS ARE CR AND OLD ALTMODE
1)		CAIN	B,.CHALT
1)		AOJA	C,CCLTM2	;WE MUST BE DONE
1)		CAIN	B,"%"		;WAS IT OUR PSEUDO ALTMODE?
1)		MOVEI	B,.CHESC	;YES, MAKE IT A REAL ALTMODE
1)		IDPB	B,T		;STORE THIS CHAR IN OUTPUT BUFFER
1)		AOJA	C,CCLTM1	;YES, GET REST OF CHARACTERS
1)	CCLTM2:	TXO	FF,F.TEMP	;SET TMPCOR FLAG
1)		JRST	CCLIL1		;RETURN TO MAIN FLOW
1)	CCLTMP:	>
1)		HLLZ	B,TMPTEC	;GET SIXBIT JOB #
1)		HRRI	B,(SIXBIT /EDT/);REST OF NAME
1)		MOVEM	B,XFILNM+.RBNAM
****
2)18		SETZ	I,		;CLEAR TO DENOTE NO TMPCOR
2)		MOVE	A,[XWD 2,TT]	;SET UP FOR TMPCOR READ & DELETE
2)		HRLZI	TT,'EDT'	;SET UP READ BLOCK FOR TMPCOR UUO
2)		HRRZ	TT1,.JBFF	;[343] Get first free location
2)		ADDI	TT1,46		;[343] Allow more than enough space
2)		CAML	TT1,.JBREL	;[343] Do we have it?
2)		CORE	TT1,		;[343] No - expand
2)		  JFCL			;[343] Do the best we can
2)		HRRZ	TT1,.JBFF	;[343] Where to put it
2)		SUB	TT1,[XWD 46,1]	;[343] Make an IOWD
2)		TMPCOR	A,		;READ AND DELETE FILE EDT
2)		JRST	CCLTMP		;NO FILE EDT OR NO TMPCOR UUO
2)		HRRZ	AA,.JBFF	;[343] Start of buffer area
2)		HRLI	AA,350700	;PICK UP EDT CHARACTERS, SKIP LINED "S"
2)		JSP	I,CCLTM1	;[343] Denote we have TMPCOR and continue below
2)	>;END OF IFN TEMP
2)19	;Here if TMPCOR failed.  Read DSK:nnnEDT.TMP.
2)	CCLTMP:	HLLZ	B,TMPTEC	;GET SIXBIT JOB #
2)		HRRI	B,(SIXBIT /EDT/)	;REST OF NAME
2)		MOVEM	B,XFILNM+.RBNAM
**************
1)1		INIT	CCLCHN,.IOASC
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		SIXBIT	/DSK/		;TO READ THE FILE
1)		EXP	CCLB		;INPUT BUFFER
1)		JRST	TECO		;IF NO DSK, SAY "*"
****
2)19		OPEN	CCLCHN,[EXP .IOASC	;[326]
2)				SIXBIT	/DSK/	;[326] TO READ THE FILE
2)				EXP	CCLB]	;[326] INPUT BUFFER
2)		JRST	TECO		;IF NO DSK, SAY "*"
**************
1)1	CCLIL0:	MOVE	T,TTYPT2	;OUTPUT CHARS
1)		MOVEI	C,2		;INIT CHAR CTR
1)	CCLIL:
1)	IFN	FTRESCAN,<
1)		SKIPE	CCLSW		; CCL ENTRY ???
1)		 JRST	CCLIL4		;NO, CONTINUE NORMALLY
1)		INCHRW	B		; NO , GET CHAR FROM INVOKING COMMAND
1)		JRST	CCLIL2		; AND THEN CONTINUE NORMALLY
1)	CCLIL4:	>
1)		ILDB	B,CCLB+.BFPTR	;INPUT THE FILE NAME & EXT
1)	IFN	FTRESCAN,<
1)	CCLIL2:	SKIPE	CCLSW		; CCL IN PROGRESS OR RESCAN ??
1)		JRST	CCLIL3		; YES, DO  CCL
1)		CAIE	B,.CHESC	; ALT MODE IN RESCAN ??
1)		JRST	CCLIL3		; NO, CONTINUE
1)		AOJ	C,		; ADD ONE TO CHARACTER COUNT
1)		JRST	CCLIL1		; YES, FINISH COMMAND
1)		>
1)	CCLIL3:	CAIN	B,.CHCRT	; WAS BREAK A <CR> ?
1)		 JRST	CCLIL		; YES: IGNORE IT
1)		CAIE	B,.CHLFD	;CHECK FOR LEGAL COMMAND CHAR
1)		CAIN	B,.CHALT	;EVERYTHING BUT LF AND OLD ALT
1)		AOJA	C,CCLIL1	;IT'S NOT
1)		CAIN	B,"%"		;IS IT OUR PSEUDO ALTMODE?
1)		MOVEI	B,.CHESC	;YES
1)		IDPB	B,T		;PUT IT IN THE DDT IN BUFFER
1)		AOJA	C,CCLIL		;MORE CHARS
1)	CCLIL1:	MOVEI	A,"W"		;PREPARE FOR EW COMMAND
1)		CAILE	B,.CHCRT	;WAS BREAK A CRLF?
****
2)19		MOVE	AA,CCLB+.BFPTR	;[343] Get byte pointer to input
2)	;Fall back into normal process on next page
2)20	;Here when we have the command, either from TMP: or from DSK:.
2)	CCLTM1:	MOVE	T,TTYPT2	;[343] Get output byte pointer
2)		MOVEI	C,2		;[343] Initialize the character count
2)		HRLI	C,-<<46*5>-4>	;[343] Max of 186. chars
2)		MOVEI	A,"="		;[343] Flag no equals sign seen
2)		SETZ	TT1,		;[343] Flag no dollar sign seen
2)	;Loop back here on each new character in TMP file
2)	CCLIL:	ILDB	B,AA		;[343] Get next EDT character
2)		CAIN	B,"$"		;[343] Is it a dollar sign? (Our pseudo altmode)
2)		 JRST	CCLALT		;[343] Yes
2)		CAMN	B,A		;[343] First equals sign seen?
2)		 JRST	CCLEQL		;[343] Yes
2)		CAIE	B,.CHCRT	;[343] CR?
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		CAIN	B,.CHALT	;[343] Old altmode?
2)		JRST	CCLNUL		;[343] Assume we're done
2)		SKIPE	B		;[352] Ignore nulls
2)	CCLIL1:	IDPB	B,T		;[343] Else store the character
2)		AOBJN	C,CCLIL		;[343] Loop for all characters
2)	; Fall through if too many characters; we can't overflow TTYBFS
2)	CCLOVF:	JUMPN	B,CCLOV1	;[352] Is current char a null?
2)		LDB	B,T		;[352] Yes, assume we're OK, pick up last char
2)		ADD	T,[7B5]		;[352] Backup byte pointer
2)		JUMPG	T,CCLNUL	;[352]
2)		SUB	T,[430000,,1]	;[352] Fixup if necessary
2)		JRST	CCLNUL		;[352] Go wrap things up
2)	CCLOV1:	ERROR	E.CTL		;[343] CCL command too long
2)	; Here when a dollar sign seen
2)	CCLALT:	MOVEI	B,.CHESC	;[343] Change it into a real altmode
2)		JUMPN	TT1,CCLIL1	;[343] Is this the first one we've seen?
2)		MOVE	TT1,AA		;[343] Yes, save input byte pointer
2)		JUMPL	A,CCLIL1	;[343] Was there a prior equal sign?
2)		MOVNI	A,2		;[343] No, so flag to ignore all future equal signs
2)		JRST	CCLIL1		;[343] Return to loop
2)	; Here on the first "=" in the command string (unless $ seen first)
2)	CCLEQL:	MOVEI	B,.CHESC	;[343] Replace first equals sign
2)		IDPB	B,T		;[343]  with <ESC>ER
2)		AOBJP	C,CCLOVF	;[343] Count the escape
2)		MOVE	D,T		;[343] Save T & C
2)		MOVE	E,C		;[343] In case .TE A=B
2)		ADD	C,[2,,2]	;[343] Count the "ER" we will add
2)		JUMPGE	C,CCLOVF	;[343] Error if too many characters
2)		MOVEI	B,"E"		;[343] Since we expect
2)		IDPB	B,T		;[343]  an input file
2)		MOVEI	B,"R"		;[343]  spec to follow
2)		IDPB	B,T		;[343]  the first one.
2)		SETO	A,		;[343] Prevent finding later equals
2)		TXO	FF,F.CCL	;[343] Do a EY in any case
2)		JRST	CCLIL		;[343] and loop back for next character
2)21	; Here on a null (End of command). See if it was MAKE or TECO
2)	CCLNUL:	MOVEI	TT,"W"		;[343] Prepare for EW command
2)		CAILE	B,.CHCRT	;WAS BREAK A CRLF?
**************
1)1		MOVEI	A,"B"		;NOW PREPARE FOR EB
1)	CCLDUN:	MOVEI	B,.CHESC
1)		IDPB	B,T		;TERMINATING TWO ALT'S
1)		IDPB	B,T		;LAST ALT
1)		ADDI	C,2		;COUNT 2ND ALT & ADD 1 TO FOOL TYI0
1)		MOVEI	B,"E"		;NOW FILL IN THE EB OR EW
****
2)21		MOVEI	TT,"B"		;[343] Now prepare for EB
2)		AOJN	A,CCLDUN	;[343]  continue unless EB and "=" was seen
2)		MOVE	T,D		;[343] If .TE A=B, we never saw the "="
2)		MOVE	C,E		;[343] In case .MA A=B, then .TE<CRLF>
2)		JUMPE	TT1,CCLDUN	;[343] Jump ahead unless there was a $ after "A=B"
2)		MOVE	AA,TT1		;[343] There was, so restore input BP to that point
2)		MOVNI	A,-2		;[343] Reset A so we don't do this again
2)		JRST	CCLIL		;[343] And return to that point, leaving out the "=B"
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)	CCLDUN:	MOVEI	B,.CHESC
2)		IDPB	B,T		;[343] TERMINATING TWO ALT'S
2)		IDPB	B,T		;LAST ALT
2)		ADDI	C,3		;[343] COUNT BOTH ALTS & ADD 1 TO FOOL TYI0
2)		MOVEI	B,"E"		;NOW FILL IN THE EB OR EW
**************
1)1		IDPB	A,T		;AND EITHER W OR B
1)		MOVEM	C,TIB+.BFCNT	;SET BUFR CTR
1)	IFN TEMP,<
1)	IFE	FTRESCAN,<
1)		TXZE	FF,F.TEMP	;TMPCOR UUO IN PROGRESS?
1)		>
1)	IFN	FTRESCAN,<
1)		TXZN	FF,F.TEMP	; TMPCOR UUO IN PROGRESS OR
1)		SKIPN	CCLSW		; ARE WE HERE FOR CCL ENTRY ??
1)		>
1)		JRST	CCLDU2>		;YES, DONT CLOSE DSK
1)		CLOSE	CCLCHN,0	;NOW FLUSH FILE
1)		SETZM	XFILNM+.RBNAM	;BY RENAME TO 0
1)		RENAME	CCLCHN,XFILNM+.RBNAM	;GO.
1)		  JFCL			;NOGO?
****
2)21		IDPB	TT,T		;[343] And either W or B
2)		HRRZM	C,TIB+.BFCNT	;SET BUFR CTR
2)	IFN TEMP,<JUMPN	I,CCLDU2>	;[343] IF TMPCOR THEN DON'T HAVE TO CLOSE
2)		SETZM	XFILNM+.RBNAM	;BY RENAME TO 0
2)		RENAME	CCLCHN,XFILNM	;GO.
2)		  JFCL			;NOGO?
**************
1)1		>
1)	SUBTTL	RETURN NON-NULL TTY CHARACTER IN CH.
****
2)21	>;END OF IFN CCL
2)22	SUBTTL	RETURN NON-NULL TTY CHARACTER IN CH.
**************
1)1		JRST	ECNTRL		;NO, BUT WATCH OUT FOR OLD ALTMODES
1)		TXO	F2,S.SLOG	;DON'T PUT THE ^G IN THE LOG FILE
****
2)22		JRST	ALTLIN		;NO, BUT WATCH OUT FOR OLD ALTMODES
2)		TXO	F2,S.SLOG	;DON'T PUT THE ^G IN THE LOG FILE
**************
1)1	;ECHO ^<CHAR> FOR CONTROL CHARS
1)	ECNTRL:	CAIL	CH," "		;CONTROL CHAR?
1)		JRST	ALTLIN		;NO, CHECK FOR OLD ALTMODE
1)		CAIN	CH,"H"-100	;CHECK FOR SPECIAL CASES
1)		POPJ	P,
1)		CAIN	CH,"I"-100
1)		POPJ	P,
1)		CAIN	CH,"M"-100
1)		POPJ	P,
1)		CAIN	CH,"J"-100
1)		POPJ	P,
1)		CAIN	CH,"L"-100
1)		POPJ	P,
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		CAIN	CH,"U"-100
1)		POPJ	P,
1)		CAIN	CH,33
1)		POPJ	P,
1)		PUSH	P,CH
1)		MOVEI	CH,"^"		;TYPE AN UPARROW
1)		PUSHJ	P,TYOM
1)		MOVE	CH,(P)
1)		MOVEI	CH,100(CH)	;CONVERT CHAR TO UPPERCASE
1)		PUSHJ	P,TYOM		;AND TYPE IT OUT
1)		POP	P,CH		;RESTORE OLD CHAR
1)		POPJ	P,
1)	;CONVERT 175 & 176 TO ALTMODE (033) UNLESS TTY LC IS ON
****
2)22	;CONVERT 175 & 176 TO ALTMODE (033) UNLESS TTY LC IS ON
**************
1)1		OPEN	TTY,TTYBLK	; OPEN THE TTY:
1)		 JRST	.-1		; I REALLY WANT THAT TTY:
1)		INBUF	TTY,1
****
2)23		OPEN	TTY,TTYBLK	;[326] INIT THE CONSOLE
2)		JRST	.-1		;[326] I REALLY WANT TTY
2)		INBUF	TTY,1
**************
1)1	TTYBLK:	IO.FCS!.IOASC		; ASCII MODE, FULL CHARACTER SET
1)		SIXBIT	\TTY\		; WANT THE TTY:
1)		XWD	TOB,TIB		; ADDRESS OF BUFFER HEADERS
1)	SUBTTL	TYPE A CHARACTER.
****
2)23	TTYBLK:	EXP	IO.FCS!.IOASC	;[326] TTY OPEN BLOCK
2)		SIXBIT	/TTY/
2)		TOB,,TIB
2)24	SUBTTL	TYPE A CHARACTER.
**************
1)1	;UNLESS F.TCTL IS TRUE, CONTROL CHARACTERS ARE TYPED WITH "^"
1)	;FOLLOWED BY THE CORRESPONDING PRINTING CHARACTER.
1)	TYOS:	TXOA	F2,S.TXTC	;TYPE <CR>, ETC INSTEAD OF PRINTER CONTROLS
****
2)24	TYOS:	TXOA	F2,S.TXTC	;TYPE <CR>, ETC INSTEAD OF PRINTER CONTROLS
**************
1)1	TYO:	TXZ	F2,S.NCFL+S.TXTC	;CLR NO-CASE-FLAGGING FLAG & SPECIAL FLAG
1)		PUSH	P,CH		;SAVE CHAR IN CASE ^ OR ' NEEDED
1)		TXNE	F2,S.RTYP	;^G-SPACE IN PROGRESS?
1)		JRST	.+3		;YES, ALWAYS USE ^ FOR CONTROL CHARS
1)		TXNE	FF,F.TCTL	;IS ET IN EFFECT?
1)		JRST	TYOB		;YES, TYPE CONTROL CHARS LITERALLY
1)		PUSHJ	P,ALTEO		;CONVERT OLD ALTMODES IF EO=1
1)	IFN CRT,<SKIPN	CRTTYP		;IF CRT IN USE,
****
2)24	TYO:	TXZ	F2,S.NCFL+S.TXTC ;CLR NO-CASE-FLAGGING FLAG & SPECIAL FLAG
2)		PUSH	P,CH		;SAVE CHAR IN CASE ^ OR ' NEEDED
2)		TXZ	FF,F.TCTL!F.IMAG ;[331] Zero literal and image flags
2)		SKIPN	ETVAL		;[331] ET = 0?
2)		JRST	TYOF		;[331] It's 0, so use up-arrow mode
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		PUSH	P,A		;[331] Save a #%&ing AC!
2)		MOVE	A,ETVAL		;[331] Get ET value
2)		CAIN	A,1		;[331] ET=1?
2)		TXO	FF,F.TCTL	;[331] Yes
2)		CAIN	A,2		;[331] ET=2?
2)		TXO	FF,F.IMAG	;[331] Yes, set image mode
2)		POP	P,A		;[331] Retore A
2)		JRST	TYOB		;[331] Go type character
2)	TYOF:	PUSHJ	P,ALTEO		;[331] CONVERT OLD ALTMODES IF EO=1
2)	IFN CRT,<SKIPN	CRTTYP		;IF CRT IN USE,
**************
1)1		CAIN	CH,.CHBEL	;IF BELL AND ET IS OFF, WE MUST
1)		TXNE	FF,F.TCTL	;FALL INTO TYOA TO GET A DING
1)		POPJ	P,		;RETURN
1)	TYOA:	TXNE	F2,S.OLOG!S.LOUT	;PUT CHARACTER IN LOG FILE
1)		PUSHJ	P,LOGOUT	;RIGHT!
1)	IFN	FTNCM0,<		; CONDITIONAL FOR <LF> COMMAND
1)		TXNE	FF,F.LFCM	; IF NO <LF> PRINT TO TTY:
1)		 POPJ	P,		; IF <LF> COMMAND, NO OUTPUT TO TTY:
1)				>
1)		TXO	FF,F.TYOF	;MARK WILL NEED TO OUTPUT
1)		SOSG	TOB+.BFCNT	;OUTPUT SPACE AVAIL?
****
2)25		TXZN	FF,F.TCTL!F.IMAG	;[331] CLEAR LITERAL AND IMAGE FLAGS
2)		CAIE	CH,.CHBEL	;[331] IF BELL, WE NEED A DING
2)		POPJ	P,		;NO, RETURN
2)		JRST	TYOA1		;[325] BUT DON'T PUT THE DING INTO LOG FILE
2)	TYOA:	TXNE	F2,S.OLOG!S.LOUT	;PUT CHARACTER IN LOG FILE
2)		PUSHJ	P,LOGOUT	;RIGHT!
2)	TYOA1:	TXNE	FF,F.IMAG	;[331] Do we want image typeout?
2)		JRST	TYOK		;[331] Yes
2)		TXO	FF,F.TYOF	;[325]  MARK WILL NEED TO OUTPUT
2)		SOSG	TOB+.BFCNT	;OUTPUT SPACE AVAIL?
**************
1)1	TYO1:	PUSH	P,CH		;TYPE CONTROL CHARACTER IN FORM "^CH"
****
2)25	TYOK:	TXZE	FF,F.TYOF	;[331] If output pending...
2)		OUTPUT	TTY,0		;[331] put it out
2)		IONEOU	CH		;[331] Output the image character
2)		POPJ	P,		;[331] Return
2)26	TYO1:	PUSH	P,CH		;TYPE CONTROL CHARACTER IN FORM "^CH"
**************
1)1		TXNE	F2,S.OCTL	;OCTAL RADIX?
1)		MOVEI	A,10		;YES, CHANGE TO RADIX 8
****
2)27		TXZE	F2,S.OCTL	;[323] OCTAL RADIX?
2)		MOVEI	A,10		;YES, CHANGE TO RADIX 8
**************
1)1	OUTMES:	HRLI	A,(POINT 7,,)	;THIS ROUTINE WILL OUTPUT A STRING LITERALLY
1)		ILDB	CH,A
1)		JUMPE	CH,CPOPJ
1)		PUSHJ	P,TYOA
1)		TLNE	A,700000	;NO MORE THAN 5 CHARACTERS, THOUGH
1)		JRST	OUTMES+1
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		POPJ	P,
****
2)28	;ROUTINE TO TYPE A STRING LITERALLY
2)	OUTIMG:	TXO	FF,F.IMAG	;[331] Use image mode
2)	OUTMES:	HRLI	A,(POINT 7,,)	;THIS ROUTINE WILL OUTPUT A STRING LITERALLY
2)	OUTMS1:	ILDB	CH,A
2)		JUMPE	CH,OUTMS2	;[331]
2)		PUSHJ	P,TYOA
2)		TLNE	A,700000	;NO MORE THAN 5 CHARACTERS, THOUGH
2)		JRST	OUTMS1
2)	OUTMS2:	TXZ	FF,F.IMAG	;[331] Clear image flag
2)		POPJ	P,
**************
1)1	skan19:	skipe	eqm		;Ignore tabs inside of macros
1)		jrst	skan0
1)	SKAN14:	MOVEI	T,.CHESC	;DELIMITER IS ALTMODE
****
2)31	SKAN14:	MOVEI	T,.CHESC	;DELIMITER IS ALTMODE
**************
1)1		XWD	SKAN19,.CHTAB	;TAB
1)		XWD	SKAN12,"_"
****
2)33		XWD	SKAN14,.CHTAB	;TAB
2)		XWD	SKAN12,"_"
**************
1)1	IFE	FTRESCAN,<
1)		JRST	LIS0		;NO
1)		>
1)	IFN	FTRESCAN,<
1)		JRST	CLIS2		; SEE IF USER TYPED "R TECO-FILESPEC"
1)		>
1)		PUSHJ	P,CCLIN		;GET THE CCL COMMAND TO TYI BUFFER
****
2)35		JRST	LIS0		;NO
2)		PUSHJ	P,CCLIN		;GET THE CCL COMMAND TO TYI BUFFER
**************
1)1	IFN	FTRESCAN,<
1)	CLIS2:	RESCAN	1		; RESET INPUT POINTER
1)		JRST	CLIS2A		; SOMETHING THERE
1)		JRST	LIS0		; NOTHING THERE
1)	CLIS2A:	INCHRW	CH		; YES, GET A CHAR
1)		PUSHJ	P,CKEOL		; IS IT A BREAK CHARACTER ??
1)		CAIN	CH,.CHESC	; ALTMODE ?
1)		JRST	LIS0		; YES - GO TYPE A "*"
1)		CAIE	CH,.CHBEL	; A BELL ??
1)		CAIN	CH,.CHCNZ	; AN EOF ?
1)		JRST	LIS0		; YES, GO TYPE  "*"
1)		CAIE	CH,"-"		; IS IT A DASH (WHAT WE WANT ) ??
1)		JRST	CLIS2A		; NO, GET ANOTHER CHAR
1)		PUSHJ	P,CCLIL0	; YES, GO CALL CCL ENTRY
1)		SETOM	CCLSW		; FAKE CCL ENTRY
1)		JRST	LIS02		; CODE TO PICK UP FILE NAME
1)		>
1)	LIS0:	AOS	INI		;ALLOW ^G^G *I$ ON FIRST COMMAND
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

****
2)35	LIS0:	AOS	INI		;ALLOW ^G^G *I$ ON FIRST COMMAND
**************
1)1		 TXO	F2,S.NALT	;DON'T CONVERT
1)	IFN CRT,<
1)		HRROI	A,27		;GET TERM WIDTH
1)		AUXCAL	A,A
1)		MOVEM	A,TTYWID	;STORE IT
****
2)35		MOVEI	TT,.TOALT	;CODE FOR ALT TESTING
2)		MOVE	A,[XWD 2,TT]	;SET UP FOR TRMOP
2)		TRMOP.	A,		;GET ALTMODE INFO FROM MONITOR
2)		 LDB	A,[POINTR (F2,S.LCTT)] ;IF THIS FAILS USE LC BIT
2)		SKIPE	A		;SHOULD WE CHANGE TO OLD ALTMODES?
2)		 TXOA	F2,S.NALT	;DON'T CONVERT
2)		  TXZ	F2,S.NALT	;DO CONVERT
2)	IFN CRT,<
2)		MOVX	TT,.TOWID	;GET WIDTH OF TTY
2)		MOVE	A,[XWD 2,TT]	;USING A TRMOP.
2)		TRMOP.	A,
2)		  MOVEI	A,^D72		;ASSUME 72 IF NO TRMOP.
2)		MOVEM	A,TTYWID	;STORE IT
**************
1)1	LIS01:	TXZ	F2,S.SLOG
1)		TXON	FF,F.EMSG	;UNLESS ONE ALREADY IN
1)		PUSHJ	P,TYI
1)	IFN	FTNCM0,<		; CHECK FOR NEW COMMANDS <LF>, <^H>
1)		TXZ	FF,F.LFCM	; SAY "NO LF YET"
1)		CAIE	CH,.CHLFD	; IS IT A SPACE ?
1)		 JRST	LIS010		; NO, CONTINUE
1)		TXO	FF,F.LFCM	; FLAG THAT WE HAD A <LF>
1)		OUTCHR	[.CHCRT]	; OUTPUT THE <CR>
1)		MOVE	AA,CBUF		; BYTE POINTER TO BUFFER
1)		MOVEI	A,4		; NUMBER OF CHARACTERS
1)		MOVEI	CH,"L"		; PUT AN L INTO THE BUFFER
1)		IDPB	CH,AA		; PLACE IT
1)		MOVEI	CH,"T"		; NOW, A T
1)		IDPB	CH,AA		; PLACE IT
1)		MOVEI	CH,.CHESC	; AND AN ESCAPE
1)		IDPB	CH,AA		; PLACE THIS, TOO
1)		IDPB	CH,AA		; FINISH THE COMMAND (LT$$)
1)		MOVEM	A,COMCNT	; SAVE THE COUNT
1)		TXO	FF,F.ALT	; SET THIS
1)		JRST	LI7
1)	LIS010:	CAIE	CH,.CHCNH	; 1ST CHAR A ^H ?
1)		 JRST	LIS011		; NO, CONTINUE
1)		MOVE	AA,CBUF		; BUFFER POINTER
1)		MOVEI	A,5		; 5 CHARS TO GO
1)		MOVEM	A,COMCNT	; STORE NUMBER
1)		TXO	FF,F.ALT	; SET THIS
1)		MOVEI	CH,"-"		; MAKE UP THE COMMAND "-LT$$"
1)		IDPB	CH,AA		; AND PUT IT INTO THE COMMAND BUFFER
1)		MOVEI	CH,"L"
1)		IDPB	CH,AA
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		MOVEI	CH,"T"
1)		IDPB	CH,AA
1)		MOVEI	CH,.CHESC	; 2 ESCAPES TO END THE COMMAND
1)		IDPB	CH,AA
1)		IDPB	CH,AA
1)		JRST	LI7		; GO DO IT
1)	LIS011:	>
1)		CAIE	CH,"*"		;1ST CHAR AN ASTERISK?
****
2)35	LIS01:	TXZ	F2,S.SLOG!S.ASTR	;[325] LOG FILE IS FULLY ACTIVE AGAIN
2)		TXOE	FF,F.EMSG	;[325] IS ONE ALREADY IN?
2)		JRST	LIS01A		;[325] YES
2)		TXO	FF,F.DDTM	;[325] NO, FORCE CHARACTER MODE ON IT
2)		PUSHJ	P,TYI
2)	LIS01A:	CAIN	CH,.CHLFD	;[325] IF 1ST CHAR IS LF,
2)		JRST	IM1LT		;[325] DO A 1LT.
2)		CAIN	CH,";"		;[325] IF IT'S A SEMI-COLON,
2)		JRST	IM0LT		;[325] DO A 0LT.
2)		CAIN	CH,.CHCNH	;[325] IF IT'S A BACKSPACE, 
2)		JRST	IMN1LT		;[325] DO A -1LT.
2)		CAIE	CH,"*"		;1ST CHAR AN ASTERISK?
**************
1)1		SETZM	EATCH		;NO CHARACTER READ YET
****
2)36		TXNE	F2,S.LIN	;[325] PUT THE * INTO LOG FILE?
2)		PUSHJ	P,LOGOUT	;[325] YES
2)		SETZM	EATCH		;NO CHARACTER READ YET
**************
1)1		MOVE	A,TIB+.BFPTR	;GET POINTER TO CURRENT CH
****
2)36		TXNE	F2,S.LIN	;[325] PUT IN LOG FILE?
2)		PUSHJ	P,LOGOUT	;[325] YES
2)		MOVE	A,TIB+.BFPTR	;GET POINTER TO CURRENT CH
**************
1)1		CAMG	C,MEMSIZ	;WILL THIS OVERFLOW?
1)		JRST	.+5		;NO, FORGET THIS EVER HAPPENED
1)		PUSH	P,17		;WILL OVERFLOW, THEREFORE, SAVE AC#17
1)		MOVE	17,C		;THIS IS THE REQUEST FOR MEMORY
1)		PUSHJ	P,GRABKQ	;GET THE NECESSARY CORE
1)		POP	P,17		;RESTORE AC#17
1)	SUBTTL	 EXPAND THE COMMAND BUFFER
****
2)36		CAMGE	C,MEMSIZ	;[320] WILL THIS OVERFLOW?
2)		JRST	.+5		;NO, FORGET THIS EVER HAPPENED
2)		MOVEM	17,AC2+15	;[354] Will overflow, therefore save AC#17
2)		MOVE	17,C		;THIS IS THE REQUEST FOR MEMORY
2)		PUSHJ	P,GRABKQ	;GET THE NECESSARY CORE
2)		MOVE	17,AC2+15	;[354] Restore AC#17
2)37	SUBTTL	 EXPAND THE COMMAND BUFFER
**************
1)1	IFN	FTNCM0,<		; <LF> COMMAND CONDITIONAL
1)		TXZ	FF,F.LFCM	;ZERO THIS ALWAYS
1)				>	; END OF IFN FTNCM0
1)		TXZ	F2,S.SLOG
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

****
2)38		TXZ	F2,S.SLOG
**************
1)1		TXNE	F2,S.LOUT
1)		TXO	F2,S.OLOG
****
2)38	BUFTY0:	TXNE	F2,S.LOUT	;[325]
2)		TXO	F2,S.OLOG
**************
1)1		PUSHJ	P,LOGOUT	;NO, SEND VERBATIM
1)		TXNE	F2,S.LOUT
****
2)38		PUSHJ	P,LOGOUT	;NO, SEND VEBATIM
2)		TXNE	F2,S.LOUT
**************
1)1	IFN	FTNCM2,<		; CONDITIONAL FOR ^G_ COMMAND
1)		CAIE	CH,"_"		; WAS IT A BACK ARROW ??
1)		 JRST	LI51
1)		PUSHJ	P,BACKUP	; BACK UP 1 CHAR
1)		PUSHJ	P,BACKUP	; BACK UP BY TWO
1)		PUSHJ	P,CRR		; TYPE A CRLF
1)		PUSH	P,D		; SAVE THIS
1)		MOVE	D,SRHCTR	; GET # OF CHARS IN BUFFER
1)		PUSH	P,AA		; SAVE THE BYTE POINTER
1)		MOVEI	AA,SRHARG	; ADDRESS OF BUFFER
1)		HRLI	AA,(POINT 7,,)	; MAKE IT A POINTER
1)	LI50:	ILDB	CH,AA		; GET A CHARACTER
1)		PUSH	P,AA		; SAVE THIS
1)		PUSHJ	P,TYOS		; TYPE IT OUT
1)		POP	P,AA		; GET IT BACK
1)		SOJG	D,LI50		; TYPE TILL DONE
1)		PUSHJ	P,CRR		; OUTPUT A CRLF
1)		POP	P,AA		; RESTORE THE BYTE POINTER
1)		POP	P,D		; RETRIEVE THIS, TOO.
1)		JRST	LI2		; THEN EXIT
1)	LI51:		>			; END OF IFN FTNCM2
1)		CAIE	CH," "		;YES, IS THIS A SPACE?
****
2)39		CAIE	CH," "		;YES, IS THIS A SPACE?
**************
1)1	RETYP1:	TXO	F2,S.RTYP	;FLAG ^G<SPACE> IN PROGRESS
1)	RETY1A:	SKIPL	COMCNT		;SEE IF ANY COMMANDS
1)		PUSHJ	P,TYOM		;TYPE A CHAR OF COMMAND LINE
****
2)39		JRST	RETY3A		;[331] Found a CR-EOL
2)	RETYP3:	PUSH	P,CH		;SAVE 1ST CHAR
2)		PUSHJ	P,CRR		;TYPE CR-LF BEFORE COMMAND LINE
2)		MOVEI	CH,"*"		;RETYPE THE *
2)		PUSHJ	P,TYOM
2)		POP	P,CH		;RETRIEVE 1ST CHARACTER
2)	RETY3A:	PUSH	P,ETVAL		;[331] Save ET value
2)		SETZM	ETVAL		;[331] ET=0 for retyping
2)		JUMPE	CH,RETYP4	;DON'T PRINT ^@ IF NULL COMMAND STRING
2)	RETYP1:	SKIPL	COMCNT		;SEE IF ANY COMMANDS
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		PUSHJ	P,TYOM		;TYPE A CHAR OF COMMAND LINE
**************
1)1		JRST	RETY1A
1)	RETYP2:	CAIN	CH,.CHESC	;LOOKING AT AN ALTMODE?
1)		TXO	FF,F.ALT	;YES, BETTER SET FLAG
1)		TXZ	F2,S.RTYP	;END OF ^G<SPACE>
1)		POPJ	P,		;RETURN
1)	RETYP3:	PUSH	P,CH		;SAVE 1ST CHAR
1)		PUSHJ	P,CRR		;TYPE CR-LF BEFORE COMMAND LINE
1)		MOVEI	CH,"*"		;RETYPE THE *
1)		PUSHJ	P,TYOM
1)		POP	P,CH		;RETRIEVE 1ST CHARACTER
1)		JUMPE	CH,RETYP4	;DON'T PRINT ^@ IF NULL COMMAND STRING
1)		JRST	RETYP1
1)	LI6:	TXOE	FF,F.BELL	;YES. SET BELL FLAG. TWO SUCCESSIVE BELLS?
****
2)39		JRST	RETYP1
2)	RETYP2:	POP	P,ETVAL		;[331] Restore ET value
2)		CAIN	CH,.CHESC	;LOOKING AT AN ALTMODE?
2)		TXO	FF,F.ALT	;YES, BETTER SET FLAG
2)		POPJ	P,		;RETURN
2)40	LI6:	TXOE	FF,F.BELL	;YES. SET BELL FLAG. TWO SUCCESSIVE BELLS?
**************
1)1		TXO	F2,S.GOIN!S.ASTR;SO YOU CAN DO *I AFTER ^G^G
1)		JRST	GO		;AND CLEAR COMMAND BUFFER.
****
2)40		TXO	F2,S.GOIN!S.ASTR	;SO YOU CAN DO *I AFTER ^G^G
2)		JRST	GO		;AND CLEAR COMMAND BUFFER.
**************
1)1	BACKUP:
1)	IFE	FTKL10,<
1)		ADD	AA,[7B5]	;BACK UP CHAR PTR
1)		JUMPG	AA,.+2		;OK NOW?
1)		SUB	AA,[430000,,1]	;NO NEEDS FURTHER FIXING
1)		>
1)	IFN	FTKL10,<
1)		PUSH	P,AA
1)		MOVNI	AA,1
1)		ADJBP	AA,(P)
1)		ADJSP	P,-1
1)		>
1)		LDB	CH,AA		;LOAD CHAR
****
2)41	BACKUP:	ADD	AA,[7B5]	;BACK UP CHAR PTR
2)		JUMPG	AA,.+2		;OK NOW?
2)		SUB	AA,[430000,,1]	;NO NEEDS FURTHER FIXING
2)		LDB	CH,AA		;LOAD CHAR
**************
1)1	CNTRLU:	PUSHJ	P,BACKLN	;BACK UP TO BEG OF LINE
1)		JUMPLE	C,CTLU1		;IF NOTHING LEFT, RETYPE *
****
2)41	CNTRLU:	PUSHJ	P,TYOM		;ECHO THE ^U
2)		PUSHJ	P,BACKLN	;BACK UP TO BEG OF LINE
2)		JUMPLE	C,CTLU1		;IF NOTHING LEFT, RETYPE *
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

**************
1)1		JRST	[MOVEI A,CTUSEQ	;YES, GET SPECIAL SEQUENCE
1)			 PUSHJ P,OUTMES	;OUTPUT IT
****
2)41		JRST	[SKIPN CTUSEQ	;DO WE HAVE A SPECIAL SEQUENCE?
2)			 JRST  .+1	;NO, USE A REGULAR CRLF
2)			 MOVEI A,CTUSEQ	;YES, GET SPECIAL SEQUENCE
2)			 PUSHJ P,OUTMES	;OUTPUT IT
**************
1)1	SUBTTL RUBOUT PROCESSOR
****
2)42	SUBTTL	SPECIAL "IMMEDIATE" COMMAND PROCESSOR
2)	;[325]  HERE TO MAKE AN INITIAL <LF> DO A "1LT$$"
2)	IM1LT:	TXO	F2,S.SLOG	;TURN OFF LOG FILE BRIEFLY
2)		MOVEI	CH,.CHCRT	;[331] Type a <CR> to get to left margin
2)		PUSHJ	P,TYOA		;[331]
2)	IFN CRT,<
2)		SKIPE	CRTTYP		;DO WE HAVE A SCREEN,
2)		SKIPN	DELLF		;AND A WAY OF GOING UP?
2)		JRST	IM1LTA		;NO
2)		MOVEI	A,DELLF		;WE ARE ON A CRT,
2)		PUSHJ	P,OUTIMG	;[331] CANCEL THE <LF> SO WE DON'T WASTE SPACE
2)		MOVEI	A,BACSEQ	;NOW GET RID OF THE "*" IN CASE OF BLANK LINE
2)		PUSHJ	P,OUTMES	;...
2)		>	;END OF CRT
2)	IM1LTA:	HRRI	B,[BYTE (7) "+","L","T",.CHESC,.CHESC]	;LOG FILE COMMAND
2)		JRST	IMCOM		;GO TO THE COMMON CODE
2)	;HERE TO MAKE A <^H> DO A "-LT$$"
2)	IMN1LT:	HRRI	B,[BYTE (7) "-","L","T",.CHESC,.CHESC]	;[331] COMMAND FOR LOG FILE
2)		TXOA	FF,F.NEG	;[331] FAKE A -1 ARG
2)					;AND FALL INTO IM0LT FOR A WHILE...
2)	;HERE TO MAKE A <;> DO A "0LT$$"
2)	IM0LT:	TXZ	FF,F.NEG	;[331] MAKE SURE F.NEG IS OFF
2)		TXO	F2,S.SLOG	;TURN OFF LOG FILE
2)	IFN CRT,<
2)		SKIPE	CRTTYP		;[331] ARE WE ON A SCREEN?
2)		JRST	[SKIPE	CTUSEQ		;[331] YES, DO WE HAVE A LINE DELETE MECHANISM?
2)			JRST	[MOVEI A,CTUSEQ	;[331] YES, WE MUST BE ON A SCREEN
2)				 PUSHJ P,OUTMES	;[331] DELETE THE LINE
2)				 JRST IM0LT1]	;[331] GET BACK IN LINE
2)						;[331] NO EOL, SO WE DO IT WITH BACKSPACE
2)			TXNE	FF,F.NEG	;[331] WAS THIS A ;?
2)			JRST	[PUSHJ P,BACONE	;[331] YES, SO BLANK OUT THE *
2)				 JRST IM0LT1]	;[331] AND JUMP BACK IN LINE
2)			MOVEI	A,BACCHR	;[331] IT WAS A ; SO BACK OVER IT
2)			PUSHJ	P,OUTMES	;[331]
2)			PUSHJ	P,BACTWO	;[331] AND BLANK OUT THE *;
2)			JRST	IM0LT1]		;[331] NOW PROCEED
2)		>	;END OF CRT
2)		PUSHJ	P,CRR		;NOT A SCREEN--DO A CRLF
2)	IM0LT1:	TXNE	FF,F.NEG	;HAVE WE ALREADY FAKED A -1 ARG?
2)		JRST	IMCOM		;YES, SKIP AHEAD TO COMMON CODE
2)		TXO	FF,F.ARG	;FAKE THE PRESENCE OF A 0 ARG.
2)		HRRI	B,[BYTE (7) "0","L","T",.CHESC,.CHESC]	;COMMAND FOR LOG FILE
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)					;FALL INTO COMMON CODE
2)43	IMCOM:	HRLI	B,(POINT 7,)	;FORM POINTER FOR LOG FILE COMMAND
2)		MOVEI	A,5		;FIVE CHARACTERS
2)		MOVEM	A,COMLEN	;SAVE IN CASE OF * COMMAND
2)		MOVE	AA,CBUF		;GET START OF COMMAND BUFFER
2)		POP	B,1(AA)		;STORE COMMAND THERE
2)		AOBJP	B,.+1		;READJUST B
2)		TXZ	F2,S.SLOG	;TURN LOG FILE BACK ON
2)		TXNN	F2,S.LIN	;TO PUT IT INTO LOG FILE?
2)		JRST	IMCOM1		;NO, SKIP THIS
2)		PUSH	P,F2		;SAVE FLAGS
2)		TXZ	F2,S.LOUT	;PRETEND /NOOUT SO CRLF GETS PUT IN
2)		PUSHJ	P,BUFTY0	;GO INSERT COMMAND IN LOG FILE
2)		POP	P,F2		;RESTORE FLAGS
2)	IMCOM1:	SETZM	B		;PUT ZERO INTO B IN CASE WE'RE DOING "0LT"
2)		PUSHJ	P,GETARG	;COMPUTE +L/0L/-L
2)		XOR	B,C		;APPLY L MOVEMENT TO POINTER
2)		XORM	B,PT		;...
2)		TXZ	FF,F.ARG!F.ARG2	;FAKE NO ARGS
2)		PUSHJ	P,TYPE		;GO TYPE THE LINE
2)		JRST	GO
2)44	SUBTTL RUBOUT PROCESSOR
**************
1)1		TLZ	A,4	;TURN OFF NO ECHO BIT
1)		SETLCH	A
****
2)45		TLZ	A,GL.LCP	;TURN OFF NO ECHO BIT
2)		SETLCH	A
**************
1)1	BACNOR:	PUSHJ	P,BACONE
****
2)46		TRNA			;[331]
2)	BACNOR:	PUSHJ	P,BACONE
**************
1)1		PUSHJ	P,OUTMES	;AND TYPE IT
1)		SOJA	T,EOL1		;LOOP
1)	BACCR:	MOVEI	A,DELCR
1)		PUSHJ	P,OUTMES
1)		IBP	AA
****
2)46		PUSHJ	P,OUTIMG	;[331] AND TYPE IT
2)		SOJA	T,EOL1		;LOOP
2)47	BACCR:	MOVEI	A,DELCR
2)		PUSHJ	P,OUTIMG	;[331]
2)		IBP	AA
**************
1)1		PUSHJ	P,OUTMES	;MOVE UP TWO LINES
1)		PUSHJ	P,OUTMES
1)		PUSHJ	P,CRR		;TYPE A CRLF TO RESET HOR. POS.
****
2)48		PUSHJ	P,OUTIMG	;MOVE UP TWO LINES
2)		PUSHJ	P,OUTIMG
2)		PUSHJ	P,CRR		;TYPE A CRLF TO RESET HOR. POS.
**************
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)1		PJRST	RETYP1		;GO FAKE ^G<SPACE>
1)		IBP	AA		;GET THE NEXT ONE
****
2)48		PJRST	RETY3A		;[331] GO FAKE ^G<SPACE>
2)		IBP	AA		;GET THE NEXT ONE
**************
1)1		PJRST	OUTMES
1)	;ROUTINE TO CALCULATE THE WIDTH OF A CHARACTER
****
2)48		PUSHJ	P,OUTMES
2)		PJRST	BACONE		;[331] ONCE AGAIN
2)49	;ROUTINE TO CALCULATE THE WIDTH OF A CHARACTER
**************
1)1		TXZ	F2,S.OCTL	;NO, CLEAR OCTAL RADIX FLAG
1)		CAIE	A,140		;140 IS ILLEGAL
1)		CAILE	A,172		;ALSO 173-177 ARE ILLEGAL
****
2)50		TRNA			;[331] No, go clear flags
2)		JRST	CD91		;[331] Yes, leave flags alone
2)		TXZ	FF,F.SYL	;[331] Clear digit string bit
2)		TXZ	F2,S.OCTL	;NO, CLEAR OCTAL RADIX FLAG
2)	CD91:	CAIE	A,140		;[331] 140 IS ILLEGAL
2)		CAILE	A,172		;ALSO 173-177 ARE ILLEGAL
**************
1)1		TXZ	FF,F.SYL	;CLR DIGIT STRING BIT
1)		TXZ	F2,S.CTLV+S.CTVV+S.CTLW+S.CTWW+S.XMAT+S.EMAT+S.NCCT
1)		MOVEM	P,PDLSAV
****
2)50		TXZ	F2,S.CTLV+S.CTVV+S.CTLW+S.CTWW+S.EMAT+S.NCCT	;[344]
2)		MOVEM	P,PDLSAV
**************
1)1		TXZ	F2,S.OCTL	;CLR RADIX FLAG
1)		POPJ	P,
****
2)55	;[323] S.OCTL IS NOW CLEARED IN DPT
2)	;[323]	TXZ	F2,S.OCTL	;CLR RADIX FLAG
2)		POPJ	P,
**************
1)1	SUBTTL	BACKSLASH PROCESSOR - AND NA COMMAND
1)	;HAS THE VALUE OF THE NUMBER REPRESENTED BY THE DIGITS (OR MINUS SIGN)
****
2)58	SUBTTL	BACKSLASH PROCESSOR
2)	;HAS THE VALUE OF THE NUMBER REPRESENTED BY THE DIGITS (OR MINUS SIGN)
**************
1)1	BAKSL:	TXZE	FF,F.ARG	;WHICH KIND OF BACKSLASH?
1)		JRST	BAKSL1		;ARG TO MEMORY
1)		MOVE	I,PT		;MEMORY TO VALRET
****
2)58	BAKSL:	MOVE	A,CPTR		;[323] GET THE COMMAND BYTE POINTER
2)		ILDB	CH,A		;[323] SNEAK A LOOK AT NEXT CHAR.
2)		CAIN	CH,"\"		;[323] IS IT ANOTHER BACKSLASH?
2)		PUSHJ	P,SKRCH		;[323] YES, TRY GETTING IT FOR REAL
2)		 TXZA	F2,S.OCTL	;[323] NOPE, CLEAR OCTAL FLAG
2)		TXO	F2,S.OCTL	;[323] SET OCTAL FLAG
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		TXZE	FF,F.ARG	;WHICH KIND OF BACKSLASH?
2)		JRST	BAKSL1		;ARG TO MEMORY
2)		MOVEI	A,^D10		;[323] ASSUME DECIMAL RADIX
2)		TXZE	F2,S.OCTL	;[323] IS IT REALLY OCTAL?
2)		MOVEI	A,^D8		;[323] YES, SET IT
2)		MOVE	I,PT		;MEMORY TO VALRET
**************
1)1	BAKSL0:	CAIG	CH,"9"		;DIGIT?
1)		CAIGE	CH,"0"		;DIGIT?
****
2)58	BAKSL0:	CAIGE	CH,"0"(A)	;[330] DIGIT?
2)		CAIGE	CH,"0"		;DIGIT?
**************
1)1		IMULI	CH,12
1)		ADDM	CH,SYL		;SYL:= 10.*SYL+CH
1)		JRST	BAKSLA		;LOOP
****
2)58		IMULI	CH,(A)		;[323]
2)		ADDM	CH,SYL		;[323] SYL:= RADIX*SYL+CH
2)		JRST	BAKSLA		;LOOP
**************
1)1	;NA (WHERE N IS A NUMERIC ARGUMENT) = VALUE IN 7-BIT ASCII OF THE
1)	;CHARACTER TO THE RIGHT OF THE POINTER.
1)	ACMD:	TXNN	FF,F.ARG	;DOES AN ARGUMENT PRECEED A?
1)		JRST	APPEND		;NO. THIS IN AN APPEND COMMAND.
1)		MOVE	I,PT		;GET POINT
1)		CAMN	I,Z		;BUFFER EMPTY OR PT=Z
1)		JRST	BEGIN		;RETURN 0
1)		PUSHJ	P,GET		;CH:=CHARACTER TO THE RIGHT OF PT.
****
2)59	SUBTTL	nA COMMAND
2)	;nA (WHERE n IS A NUMERIC ARGUMENT) = VALUE IN 7-BIT ASCII OF THE
2)	;nTH CHARACTER TO THE RIGHT OF THE POINTER. 0A WILL RETURN THE
2)	;CHARACTER TO THE LEFT OF THE POINTER, -NA WILL RETURN THE N+1st
2)	;CHARACTER TO THE LEFT OF THE POINTER.  IF .+N-1 IS NOT WITHIN
2)	;BOUNDS, A 0 WILL BE RETURNED, EXCEPT IN THE CASE OF M,NA, IN
2)	;WHICH CASE M IS RETURNED.
2)	ACMD:	TXNE	FF,F.ARG	;[346] No argument implies Append
2)		TXNE	FF,F.COLN	;[346] Or is there a colon?
2)		JRST	APPEND		;Yes. THIS IN AN APPEND COMMAND.
2)		SETZ	CH,		;[346] Set up 0 for return value
2)		CHKEO	EODEC,ACMD2	;[346] If EO = 2, do old-style 1A
2)		TXZE	FF,F.ARG2	;[346] Was there a 2nd arg?
2)		MOVE	CH,C		;[346] Yes, use it instead
2)	ACMD1:	SOS	I,B		;[346] Get arg-1
2)		ADD	I,PT		;[346] Add in point
2)		CAML	I,BEG		;[346] Check bounds
2)		CAML	I,Z		;BUFFER EMPTY OR PT=Z
2)		TRNA			;[346] Out of bounds
2)		PUSHJ	P,GET		;CH:=CHARACTER TO THE RIGHT OF PT.
**************
1)1	SUBTTL	Q-REGISTER COMMANDS --  U & Q
1)	;NUI	PUTS THE NUMERIC VALUE N IN Q-REGISTER I.
1)	USE:	TXNN	FF,F.ARG	;INSIST ON ARG BEFORE U
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		ERROR	E.NAU
1)	USEA:	PUSHJ	P,QREGVI	;YES. CH:=Q-REGISTER INDEX.
1)		MOVEM	B,QTAB-"0"(CH)	;STORE ARGUMENT IN SELECTED Q-REG.
1)		JRST	RET
1)	;QI	HAS THE VALUE OF THE LATEST QUANTITY PUT INTO Q-REGISTER I.
****
2)59	ACMD2:	MOVEI	B,1		;[346] IF EO < 3, make arg=1
2)		JRST	ACMD1		;[346]
2)60	SUBTTL	Q-REGISTER COMMANDS --  U & Q
2)	;NUI	PUTS THE NUMERIC VALUE N IN Q-REGISTER I.
2)	;M,NUI	PUTS N INTO Q-REGISTER I AND RETURNS M.
2)	USE:	TXNN	FF,F.ARG	;INSIST ON ARG BEFORE U
2)		ERROR	E.NAU
2)		PUSHJ	P,CRANGE	;[332] Go check range of argument
2)	USEA:	PUSHJ	P,QREGVI	;YES. CH:=Q-REGISTER INDEX.
2)	USEA1:	MOVEM	B,QTAB-"0"(CH)	;STORE ARGUMENT IN SELECTED Q-REG.
2)		TXZN	FF,F.ARG2	;[332] IS THERE A SECOND ARG?
2)		JRST	RET		;[332] NO, RETURN
2)		MOVE	A,C		;[332] YES, RETURN IT
2)		JRST	VALRET		;[332]
2)	;QI	HAS THE VALUE OF THE LATEST QUANTITY PUT INTO Q-REGISTER I.
**************
1)1	SUBTTL	Q-REGISTER COMMANDS -- %
****
2)61	;[332] Routine to check range of number to be stored in a Q-reg.
2)	CRANGE:	TLNE	B,400000	;[332] Does arg look like a text pointer?
2)		TLNE	B,377777	;[332] (I.E. less than -377777,,0?)
2)		POPJ	P,		;[332] OK, return
2)		ERROR	E.AOR		;[337] Out of range
2)62	SUBTTL	Q-REGISTER COMMANDS -- %
**************
1)1		SUBI	C,-3(B)		;C:=LENGTH OF STRING+3.
1)		MOVEI	A,-3(C)		;STORE LENGTH OF STRING SAVED
1)	IFN VC,<MOVEM	A,VVAL>
****
2)63		SUB	C,B		;[321] C:=LENGTH OF STRING
2)		MOVE	A,C		;[321] A:=LENGTH OF STRING SAVED
2)		ADDI	C,3		;[321] C:=LENGTH OF STRING+3.
2)	IFN VC,<MOVEM	A,VVAL>
**************
1)1		JRST	USEA		;NO, MAKE QTAB ENTRY NORMALLY.
1)		MOVEM	B,QTAB-"0"+<STAR==124>	;INTO * Q-REG
1)		POPJ	P,		;AND RETURN
1)	;TRANSFER DATA TO Q-REGISTER BUFR
****
2)63		JRST	X0		;[332] NO, MAKE QTAB ENTRY NORMALLY.
2)		MOVEM	B,QTAB-"0"+<STAR==124>	;INTO * Q-REG
2)		POPJ	P,		;AND RETURN
2)	X0:	PUSHJ	P,QREGVI	;[332] CH:=Q-Register index
2)		MOVEM	B,QTAB-"0"(CH)	;[332] Store argument in selected Q-reg
2)		JRST	RET		;[332] Return
2)	;TRANSFER DATA TO Q-REGISTER BUFR
**************
1)1		ADD	B,OU		;B:=FIRST ARG ADDR + LENGTH OF STRING + 3 + RREL
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

****
2)63		CAML	B,BEG		;[320] IF WE ARE DOING A *I, DON'T CHANGE B!!
2)		ADD	B,OU		;B:=FIRST ARG ADDR + LENGTH OF STRING + 3 + RREL
**************
1)1		SKIPA	C,[POP PF,]
1)	;[I	PUSHES Q-REGISTER I ONTO THE Q-REGISTER PUSHDOWN LIST.
1)	OPENB:	MOVSI	C,261000+PF*40
1)		PUSHJ	P,QREGVI
1)		HRRI	C,QTAB-"0"(CH)	;C:=Q-REGISTER INDEX.
1)		XCT	C		;PUSH OR POP Q-REGISTER.
1)		JRST	RET
1)	SUBTTL	MISCELLANEOUS CHARACTER DISPATCHER
****
2)66		PUSHJ	P,QREGVI	;[332] GET Q-REG INDEX
2)		POP	PF,QTAB-"0"(CH)	;[332] POP THE Q-REG
2)		JRST	RET		;[332] RETURN
2)	;[I	PUSHES Q-REGISTER I ONTO THE Q-REGISTER PUSHDOWN LIST.
2)	;n[i	EQUIVALENT TO [i FOLLOWED BY nUi.
2)	;m,n[I	EQUIVALENT TO [I FOLLOWED BY m,nUi.
2)	OPENB:	TXNE	FF,F.ARG	;[332] Is there an argument?
2)		PUSHJ	P,CRANGE	;[332] Yes, go check the range
2)		PUSHJ	P,QREGVI
2)		PUSH	PF,QTAB-"0"(CH)	;[332] PUSH Q-REG
2)		TXNN	FF,F.ARG	;[332] WAS THERE AN ARG?
2)		JRST	RET		;[332] NO, RETURN
2)		JRST	USEA1		;[332] YES, GO STORE IT
2)67	SUBTTL	MISCELLANEOUS CHARACTER DISPATCHER
**************
1)1	IFE	FTEAGAIN,<	XWD	E$$IEC,OPNRD	;<EQ>,ER	>
1)	IFN	FTEAGAIN,<	XWD	EAGAIN,OPNRD	; EQ,ER	>
1)		XWD	AUTOTY,TYOCTL	;ES,ET
****
2)69		XWD	E$$IEC,OPNRD	;<EQ>,ER
2)		XWD	AUTOTY,TYOCTL	;ES,ET
**************
1)1		SKIPN	A,XFILNM+.RBEXT	;SPECIFY AN EXT?
****
2)70		MOVEI	E,LOGCHN	;MUST BE A DSK!!
2)		DEVTYP	E,		;WELL?
2)		JRST	ERRILD
2)		TXNE	E,77		;DSK?
2)		JRST	ERRILD
2)		SKIPN	A,XFILNM+.RBEXT	;SPECIFY AN EXT?
**************
1)1		PUSHJ	P,PPNSET	;SET UP DEFAULT DIRECTORY IF NECESSARY
1)		POPJ	P,
****
2)71		POPJ	P,
**************
1)1		HRROI	E,.GTNAM	;GET FILE NAME OF THIS TECO
1)		GETTAB	E,
1)		 SKIPA
1)		  MOVEM	E,STARTL+1
1)		HRROI	E,.GTFPN	;GET FILE DIR OF THIS TECO
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		GETTAB	E,
1)		 SKIPA
1)		  MOVEM	E,STARTL+4
1)		ENTER	SAVCHN,XFILNM	;ENTER THE OUTPUT FILE
****
2)72		ENTER	SAVCHN,XFILNM	;ENTER THE OUTPUT FILE
**************
1)1	GETBLK:	('DSK')
1)		'TECO  '
****
2)74	GETBLK:	('SYS')
2)		'TECO  '
**************
1)1	ECORE:	MOVEI	E,CORER		;WHERE GC WILL RETURN
1)		MOVEM	E,GCRET
****
2)75	ECORE:	MOVEM	PF,AC2+PF-2	;[354] PUT PF WHERE GC EXPECTS IT
2)	ECORE1:	MOVEI	E,CORER		;[354] WHERE GC WILL RETURN
2)		MOVEM	E,GCRET
**************
1)1		MOVEM	PF,AC2+PF-2	;PUT PF WHERE GC EXPECTS IT
1)		PUSH	P,.JBREL	;SAVE SIZE NOW IN CASE NO CHANGE
****
2)75		PUSH	P,.JBREL	;SAVE SIZE NOW IN CASE NO CHANGE
**************
1)1	EICMD:	TXZ	FF,F.COLN	;IGNORE : ON EI
1)		TXOA	F2,S.DOIT	;NOTE TO DO MI WHEN DONE READING
1)	EPCMD:	TXZ	F2,S.DOIT	;JUST READ IT INTO THE Q REG *
****
2)76	EICMD:	TXOA	F2,S.DOIT	;NOTE TO DO MI WHEN DONE READING
2)	EPCMD:	TXZ	F2,S.DOIT	;JUST READ IT INTO THE Q REG *
**************
1)1		TXNE	F2,S.DOIT	;DO IT?
1)		SKIPE	FILPPN		;ANY PPN ?
1)		 JRST	.+4		;YES
1)	;	MOVSI	E,'TED'		;GET THE DEFAULT DEVICE
1)		MOVSI	E,'DSK'		;; [UNH] USE DSK: AS DEVICE
1)		SKIPN	FILDEV		;ANY DEVICE SPECIFIED ?
1)		MOVEM	E,FILDEV	;AND SAVE
1)		SKIPN	E,XFILNM+.RBEXT	;SPECIFY EXT?
****
2)76		SKIPN	E,XFILNM+.RBEXT	;SPECIFY EXT?
**************
1)1		PUSHJ	P,DSPEC1	;DEFAULT DEVICE ETC
1)		MOVE	E,USRPPN	;GET LOGGED IN PPN
1)		TXNN	F2,S.INFO	;IF .INI USE LOGGED IN PPN
1)		MOVEM	E,XFILNM+1	;SAVE
1)		TXO	FF,F.INIT	;INIT FILE READ IN PROGRESS
1)		SETZM	LOGOPN+.OPMOD	;ASCII MODE
****
2)76	;***[337]***
2)	;Here to LOOKUP file for EI and EP. 
2)	;If no directory or device has been specified, then look for the
2)	;file as follows:
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)	;	[-]
2)	;	[,,TEC]/SCAN
2)	;	TED:
2)	EPIGET:	SETZM	EPISEQ		;Clear search sequencer
2)		SKIPN	FILPPN		;Directory specified?
2)		SKIPE	FILDEV		;Or device?
2)		SETOM	EPISEQ		;Yes, flag that no search sequence needed
2)		PUSHJ	P,DSPEC1	;DEFAULT DEVICE ETC
2)		SKIPGE	EPISEQ		;Do we need a search sequence?
2)		JRST	EPIG6		;No, go read file
2)		TXNE	F2,S.INFO	;Are we processing TECO.INI?
2)		JRST	EPIG1		;No, skip ahead
2)		MOVE	E,USRPPN	;Yes, always use [,]
2)		MOVEM	E,XFILNM+.RBPPN	;Store it
2)		JRST	EPIG6		;Go find the file
2)	EPIG1:	MOVEI	E,5		;Initialize search sequencer
2)		MOVEM	E,EPISEQ	;Store
2)	EPIG2:	SOSG	E,EPISEQ	;Get next step in search sequence
2)		JRST	LOOKIN		;Finished.  File was not found
2)		SETZM	FILDEV		;Clear device for possible error msg.
2)		CAIE	E,4		;First step?
2)		JRST	EPIG3		;No
2)		MOVSI	E,'DSK'		;Use DSK device
2)		MOVEM	E,LOGOPN+1	;Store
2)		SETZM	XFILNM+.RBPPN	;Set default directory
2)		JRST	EPIG6		;Go straight to find it
2)77	EPIG3:	CAIE	E,3		;Second step?
2)		JRST	EPIG3A		;No
2)		MOVEI	E,FILPTH	;Set PATH pointer
2)		MOVEM	E,XFILNM+.RBPPN	;in LOOKUP block
2)		MOVSI	E,'TEC'		;Set [,,TEC]
2)		MOVEM	E,FILSFD	;Store
2)		SETZM	FILSFD+1	;Set trailing 0
2)		MOVE	E,USRPPN	;Get logged-in PPN
2)		MOVEM	E,FILPPN	;Store it
2)		CAMN	E,DEFPTH+2	;Same as default path PPN?
2)		SKIPE	DEFPTH+3	;And no SFD's?
2)		TRNA			;No, then search [,] also
2)		JRST	EPIG7		;Yes, don't bother setting /SCAN
2)	EPIG4:	MOVEI	E,2		;Set /SCAN
2)		MOVEM	E,FILPTH+1	;Store
2)		JRST	EPIG7		;Go try
2)	EPIG3A:	CAIE	E,2		;Third step?
2)		JRST	EPIG5		;No
2)		MOVE	E,USRPPN	;Get logged-in PPN
2)		MOVEM	E,XFILNM+.RBPPN	;Store
2)		CAMN	E,DEFPTH+2	;Same as default path?
2)		SKIPE	DEFPTH+3
2)		JRST	EPIG7		;No, go try
2)		JRST	EPIG2		;Yes, try next search
2)	EPIG5:				;Must be fourth step
2)		MOVSI	E,'TED'		;Use TED:
2)		MOVEM	E,LOGOPN+1	;Store
2)		SETZM	E,XFILNM+1	;Clear directory spec
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		SETZM	FILPPN		;Clear this too for possible error msg.
2)	EPIG6:	TXO	FF,F.INIT	;INIT FILE READ IN PROGRESS
2)		SETZM	LOGOPN+.OPMOD	;ASCII MODE
**************
1)1		LOOKUP	INICHN,XFILNM	;LOOK FOR FILE
1)		JRST	LOOKIN		;INI LOOKUP FAILED OK?
1)	INIFI0:	PUSH	P,.JBREL	;SAVE FOR LATER
1)		MOVE	E,Z		;END OF TEXT BUFFER
****
2)77	EPIG7:	LOOKUP	INICHN,XFILNM	;LOOK FOR FILE
2)		JRST	EPIG2		;Failed, go step the sequencer
2)					;Found it...Fall through to next page
2)78		PUSH	P,.JBREL	;SAVE FOR LATER
2)		PUSH	P,.JBFF		;[336] Save this too
2)		MOVE	E,Z		;END OF TEXT BUFFER
**************
1)1		PUSH	P,17		;PRESERVE 17
1)		SETZM	17		;CLEAR FOR 1 K EXPAND
****
2)78		MOVEM	17,AC2+15	;[354] Preserve 17
2)		MOVE	17,(P)		;[355] Retrieve original .JBFF
2)		MOVEM	17,.JBFF	;[355] Put it back so it agrees with MEMSIZ
2)		SETZM	17		;CLEAR FOR 1 K EXPAND
**************
1)1	IFN	FTSWTCH,<
1)		SKIPN	SW.INI		; ARE WE SUPPOSED TO BE READING SWITCH.INI
1)		JRST	INILP0		; NO, SO CONTINUE
1)		CAIN	CH,"/"		;A SLASH ??
1)		MOVEI	CH,.CHESC	; MAKE IT AN ALTMODE
1)		CAIE	CH,.CHCRT	; DO WE HAVE A <CR> ?
1)		 JRST	INILP0		; NO, CONTINUE
1)		SETZM	SW.INI		; MAKE SURE TO UN-SET FLAG
1)		SETZM	INI.SW		; DO NOT TRY TO READ IT AGAIN
1)		OUTSTR	[BYTE(7) .CHCRT,.CHLFD,.CHNUL]
1)		JRST	INIDON		; AND GO FINISH
1)		>
1)	INILP0:	PUSHJ	P,CHKPUT	;PUT IT IN CORE SOMEWHERE
1)		JRST	INILP		;AND CONTINUE
1)	CHKPUT:	CAML	OU,MEMSIZ	;FIT?
****
2)78		CAML	OU,MEMSIZ	;[355] FIT?
2)		PUSHJ	P,GRABKQ	;[355] GET A K
2)		PUSHJ	P,PUT		;[355] STICK IT IN TEXT BUFFER
2)		AOJA	OU,INILP	;[355] DO REST OF IT
2)	CHKPUT:	CAML	OU,MEMSIZ	;FIT?
**************
1)1	SAVSIZ:	POP	P,17		;RESTORE 17
1)		MOVEM	OU,Z		;SAVE ALL THAT STUFF
****
2)79	SAVSIZ:	MOVE	17,AC2+15	;[354] Restore 17
2)		MOVEM	OU,Z		;SAVE ALL THAT STUFF
**************
1)1		MOVEM	B,.JBFF		;SAVE
1)		PUSHJ	P,CRE23		;YOU KNOW BY NOW!!
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)	;THIS POP HAS TO BE DONE BEFORE THIS!  COPYEI MIGHT DO A GC!
1)	;	POP	P,17		;RESTORE 17
1)		POP	P,E		;RESTORE OLD JOBREL
****
2)79		POP	P,E		;[336] Restore original .JBFF
2)		CAMLE	E,B		;[336] If it is larger than our new one...
2)		MOVE	B,E		;[336] then use old one so we don't shrink
2)		MOVEM	B,.JBFF		;SAVE
2)		PUSHJ	P,CRE23		;YOU KNOW BY NOW!!
2)		POP	P,E		;RESTORE OLD JOBREL
**************
1)1		RESET
1)		SKIPE	RUNIT+1		;TO RUN SOMETHING
****
2)80		PUSH	P,.JBFF		;[342] Save .JBFF
2)		RESET
2)		POP	P,.JBFF		;[342] Restore it
2)		SKIPE	RUNIT+1		;TO RUN SOMETHING
**************
1)1		SIXBIT	/RPG/		;RUN SYS:RPG
1)		REPEAT	4,<0>
1)		>
1)	IFN	FTEAGAIN,<
1)	EAGAIN:	PUSHJ	P,FINIS1	; FINISH ALL I/O
1)		SETOM	CCLSW		; FAKE CCL ENTRY
1)		PUSHJ	P,TTOPEN	; FAKE TTY OPEN SO THAT WE DO NOT GET
1)		JRST	GO		; ADDRESS CHECKS, THEN GO....
1)	>
1)	SUBTTL E COMMANDS -- ED (RUN UUO ON EXIT)
****
2)81		SIXBIT	/COMPIL/	;RUN SYS:COMPIL
2)		REPEAT	4,<0>
2)		>
2)82	SUBTTL E COMMANDS -- ED (RUN UUO ON EXIT)
**************
1)1	TYOCTL:	POP	P,CH		;CLR RET. ADDR. FROM PDL
****
2)83	;		 0 = Normal typeout
2)	;		 1 = Literal typeout
2)	;		 2 = Image typeout  (IONEOU)
2)	TYOCTL:	POP	P,CH		;CLR RET. ADDR. FROM PDL
**************
1)1		TXNE	FF,F.TCTL	;NO, FLAG ON?
1)		JRST	FFOK		;YES, RETURN -1
1)		JRST	BEGIN		;NO, RETURN 0
1)	TYOCT1:	TXZ	FF,F.TCTL	;CLEAR ET FLAG
1)		JUMPE	B,RET		;ARGUMENT NON-ZERO?
1)		TXO	FF,F.TCTL	;YES. SET ET FLAG
1)		JRST	RET		;RETURN
1)	;EO COMMAND
****
2)83		SKIPE	A,ETVAL		;[331] Get ET value
2)		CHKEO	EODEC,FFOK	;[331] If EO > 2 and non-zero, return -1
2)		JRST	VALRET		;[331] Return the value
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)	TYOCT1:	CHKEO	EODEC,TYOCT3	;[331] Jump if old style ET
2)		SKIPL	B		;[331] Check range
2)		CAILE	B,2		;[331] ...
2)		  ERROR	E.ETA		;[331] Illegal value
2)	TYOCT2:	MOVEM	B,ETVAL		;[331] Store value
2)		JRST	RET		;RETURN
2)	TYOCT3:	JUMPE	B,TYOCT2	;[331] Old ET can be only 0 or 1
2)		MOVEI	B,1		;[331] Non zero means 1
2)		JRST	TYOCT2		;[331] Go store and return
2)	;EO COMMAND
**************
1)1		SIXBIT	/BEE/
1)		SIXBIT	/ADM2/
1)		SIXBIT	/ADM3/
1)		SIXBIT	/DPT/
****
2)88		SIXBIT	/ACT4/		;[331]
2)		SIXBIT	/ACT5/		;[331]
2)		SIXBIT	/ADD580/
2)		SIXBIT	/ADM2/
2)		SIXBIT	/ADM3/
2)		SIXBIT	/ADM3A/		;[331]
2)		SIXBIT	/BEE/
2)		SIXBIT	/DPT/
**************
1)1		SIXBIT	/H2000/
1)		SIXBIT	/VT05/
1)		SIXBIT	/VT52/
1)		SIXBIT	/DGC/
1)	NUMCRT==.-CRTTAB
****
2)88		SIXBIT	/H1500/		;[331]
2)		SIXBIT	/H2000/
2)		SIXBIT	/HP2640/	;[331]
2)		SIXBIT	/VT05/
2)		SIXBIT	/VT50/		;[324]
2)		SIXBIT	/VT52/
2)	NUMCRT==.-CRTTAB
**************
1)1		XWD	.CCRT.,VBEE
1)		XWD	.CCRT.,VADM2
1)		XWD	.CWAP.+.CCRT.,VADM3
1)		XWD	.CWAP.+.CCRT.,VDPT
****
2)88		XWD	.CCRT.+.CWAP.,VACT4
2)		XWD	.CCRT.+.CWAP.,VACT5
2)		XWD	.CCRT.,VADD5
2)		XWD	.CCRT.,VADM2
2)		XWD	.CWAP.+.CCRT.,VADM3
2)		XWD	.CWAP.+.CCRT.,VADM3A
2)		XWD	.CCRT.,VBEE
2)		XWD	.CWAP.+.CCRT.,VDPT
**************
1)1		XWD	.CCRT.,VHZL2
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		XWD	.CWAP.+.CCRT.,VVT05
1)		XWD	.CWAP.+.CCRT.,VVT52
1)		XWD	.CCRT.,VDGC
1)	VBEE:	EXP	10,0,0,4,10
****
2)88		XWD	.CCRT.,VHZL15
2)		XWD	.CCRT.,VHZL2
2)		XWD	.CWAP.+.CCRT.,VHP26	;[331] HP2640
2)		XWD	.CWAP.+.CCRT.,VVT05
2)		XWD	.CWAP.+.CCRT.,VVT50	;[331]
2)		XWD	.CWAP.+.CCRT.,VVT52	;[331] VT52 same as VT50
2)89	VBEE:	EXP	10,0,0,4,10
**************
1)1	VADM2:	EXP	10,0,1,1,1
1)		BYTE	(7) 10
1)		BYTE	(7) 14
1)		BYTE	(7) 40,10
1)		BYTE	(7) 13
1)		BYTE	(7) 12
1)		BYTE	(7) 10
1)		0
1)		BYTE	(7) 10
1)		0
1)		BYTE	(7) 15,33,124,15
1)	VTTY:				;DUMMY ADDRESS - ALL THIS IS IGNORED
1)	VCRT:				;GENERAL CRT SETTING = ADM3
1)	VADM3:	EXP	10,0,0,0,0
1)		BYTE	(7) 10
****
2)89	VACT5:
2)	VACT4:	EXP	10,0,0,4,10
2)		BYTE	(7) 10
**************
1)1		BYTE	(7) 13
1)		0
1)		0
1)		BYTE	(7) 13
1)		BYTE	(7) 10
1)		0
1)		BYTE	(7) 15,12
1)	VDPT:	EXP	10,0,0,4,8
1)		BYTE	(7) 10,31
1)		BYTE	(7) 40
1)		BYTE	(7) 36		;THIS MAY BE A LOCAL MOD AT U. OF T.
1)		BYTE	(7) 32
****
2)89		BYTE	(7) 32
**************
1)1		BYTE	(7) 10,31
1)		BYTE	(7) 31
1)		BYTE	(7) 15,36
1)	VCDC:	EXP	10,0,0,4,8
1)		BYTE	(7) 10
1)		BYTE	(7) 25
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		BYTE	(7) 40,10
1)		BYTE	(7) 32
1)		BYTE	(7) 32
1)		BYTE	(7) 32
1)		0
1)		BYTE	(7) 10,40,10,10
1)		0
1)		BYTE	(7) 15,12		;EOL SEEMS TO BE DISABLED ON A CDC (SHOULD BE ^V)
1)	VHZL1:	EXP	10,0,0,1,1
1)		BYTE	(7) 10
1)		0
1)		BYTE	(7) 20,10
1)		BYTE	(7) 12
1)		0
1)		0
1)		0
****
2)89		BYTE	(7) 10
2)		BYTE	(7) 0
2)		BYTE	(7) 15,36
2)	VADM2:	EXP	10,0,1,4,10
2)		BYTE	(7) 10
2)		BYTE	(7) 40
2)		BYTE	(7) 40,10
2)		BYTE	(7) 13
2)		BYTE	(7) 13
2)		BYTE	(7) 13
2)		0
**************
1)1		BYTE	(7) 15,12
1)	VHZL2:	EXP	10,0,0,0,0
1)		BYTE	(7) 10
****
2)89		BYTE	(7) 15,33,124,15
2)	VTTY:			;DUMMY ADDRESS - ALL THIS IS IGNORED
2)	VCRT:			;GENERAL CRT SETTING = ADM3
2)	VADM3:	EXP	10,0,0,0,0
2)		BYTE	(7) 10
**************
1)1		0
1)		0
1)		0
1)		0
1)		BYTE	(7) 10
1)		0
1)		BYTE	(7) 176,23,177
1)	VVT05:	EXP	10,0,0,4,8
1)		BYTE	(7) 10
****
2)89		EXP	0,0,0,0
2)		BYTE	(7) 10
2)		0
2)		0
2)	VADM3A:	EXP	10,0,1,4,10
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		BYTE	(7) 10
**************
1)1		BYTE	(7) 32
****
2)89		BYTE	(7) 13
2)		BYTE	(7) 13
2)		BYTE	(7) 13
2)		BYTE	(7) 13
2)		BYTE	(7) 10
2)		EXP	0,0
2)	VDPT:	EXP	10,0,0,4,8
2)		BYTE	(7) 10,31
2)		BYTE	(7) 40
2)		BYTE	(7) 36		;THIS MAY BE A LOCAL MOD AT U. OF T.
2)		BYTE	(7) 32
**************
1)1		BYTE	(7) 10
1)		0
1)		BYTE	(7) 15,36
1)	VVT52:	EXP	0,0,0,4,10
1)		BYTE	(7) 10
****
2)89		BYTE	(7) 10,31
2)		BYTE	(7) 31
2)		BYTE	(7) 15,36
2)	VCDC:	EXP	10,0,0,4,8
2)		BYTE	(7) 10
2)		BYTE	(7) 25
2)		BYTE	(7) 40,10
2)		BYTE	(7) 32
2)		BYTE	(7) 32
2)		BYTE	(7) 32
2)		0
2)		BYTE	(7) 10,40,10,10
2)		0
2)		0		;EOL SEEMS TO BE DISABLED ON A CDC (SHOULD BE ^V)
2)	VHP26:	EXP	10,0,0,4,10
2)		BYTE	(7) 10
**************
1)1		BYTE	(7) 10
****
2)89		BYTE	(7) 10,40,10,10
2)		0
2)		BYTE	(7) 15,33,113,15
2)	VHZL1:	EXP	10,0,0,1,1
2)		BYTE	(7) 10
2)		0
2)		BYTE	(7) 20,10
2)		BYTE	(7) 12
2)		0
2)		0
2)		0
2)		BYTE	(7) 10
2)		0
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		0
2)	VHZL15:	EXP	10,0,0,4,10
2)		BYTE	(7) 10
2)		BYTE	(7) 40
2)		BYTE	(7) 40,10
2)		BYTE	(7) 176,14
2)		0
2)		0
2)		0
2)		BYTE	(7) 10
2)		EXP	0
2)		BYTE	(7) 15,176,17,15
2)	VHZL2:	EXP	10,0,0,0,0
2)		BYTE	(7) 10
2)		BYTE	(7) 40
2)		BYTE	(7) 40,10
2)		0
2)		0
2)		0
2)		0
2)		BYTE	(7) 10
2)		0
2)		BYTE	(7) 176,23,177,15	;[331]
2)	VVT52:
2)	VVT50:	EXP	10,0,0,4,10
2)		BYTE	(7) 10
2)		BYTE	(7) 33,103
2)		BYTE	(7) 40,10
2)		BYTE	(7) 33,101
2)		BYTE	(7) 33,101
2)		BYTE	(7) 33,101
2)		BYTE	(7) 33,101
2)		BYTE	(7) 10
**************
1)1	VDGC:	EXP	0,0,0,6,10
1)		BYTE	(7) 31
1)		BYTE	(7) 30
1)		BYTE	(7) 40,31
1)		BYTE	(7) 27
1)		BYTE	(7) 27
1)		BYTE	(7) 27
1)		0
1)		BYTE	(7) 31
1)		0
1)		BYTE	(7) 15,13
1)	SUBTTL E COMMANDS -- EK (KILL) AND EN (RENAME)
****
2)89	VVT05:	EXP	10,0,0,4,8
2)		BYTE	(7) 10
2)		BYTE	(7) 40
2)		BYTE	(7) 40,10
2)		BYTE	(7) 32
2)		BYTE	(7) 32
2)		BYTE	(7) 32
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		BYTE	(7) 36,32		;[331]
2)		BYTE	(7) 10
2)		0
2)		BYTE	(7) 15,36
2)	VADD5:	EXP	10,0,0,4,8
2)		BYTE	(7) 25,10
2)		BYTE	(7) 40
2)		BYTE	(7) 40,25,10
2)		BYTE	(7) 32
2)		BYTE	(7) 32
2)		BYTE	(7) 32
2)		0
2)		BYTE	(7) 25,10
2)		BYTE	(7) 25,10
2)		0
2)90	SUBTTL E COMMANDS -- EK (KILL) AND EN (RENAME)
**************
1)1		PUSHJ	P,ERDFSP	;YES, SO FILL IN ALL MISSING PARTS
****
2)90		PUSH	P,FILPPN	;[340] Save directory spec
2)		PUSHJ	P,ERDFSP	;YES, SO FILL IN ALL MISSING PARTS
**************
1)1		MOVE	E,INFILE+2
****
2)90		POP	P,(P)		;[340] Pop the stack
2)		SKIPN	1(P)		;[340] Was an explicit directory given?
2)		 SETZM	XFILNM+.RBPPN	;[340] No, don't move the file
2)		MOVE	E,INFILE+2
**************
1)1		PUSHJ	P,PPNDEF	;YES, MAKE SURE DEFAULT IS SET
1)		MOVE	E,FILDEV	;INITIALIZE OPEN UUO ARGUMENTS
****
2)91		MOVE	E,FILDEV	;INITIALIZE OPEN UUO ARGUMENTS
**************
1)1	OPNRD2:	MOVEI	E,INFILE	;SAVE INPUT SPECS
1)		PUSHJ	P,SPCSAV
****
2)91	OPNRD2:	PUSHJ	P,CHKSPC	;[340] Issue warning if found elsewhere
2)		MOVEI	E,INFILE	;SAVE INPUT SPECS
2)		PUSHJ	P,SPCSAV
**************
1)1		MOVEM	E,INSWIT	;STORE SETTING FOR INPUT
****
2)91		XORM	E,SWITC		;[317]CLEAR THEM HERE, SO NO SUPLSN ON OUTPUT
2)		MOVEM	E,INSWIT	;STORE SETTING FOR INPUT
**************
1)1	OPNRD3:	MOVEI	B,RIQ		;USE QUICK ONE
****
2)91					;Fall through to next page...
2)92	OPNRD3:	MOVEI	B,RIQ		;USE QUICK ONE
**************
1)1		TXNN	FF,F.CCL	;ARE WE HERE FROM A .TECO COMMAND?
1)		POPJ	P,		;NO
1)		MOVE	B,SWITC		;GET I/O SWITCHES
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		TLNN	B,FS.REA	;DOES HE WANT READ ONLY? (/R)
1)		POPJ	P,		;NOPE
1)		TXZ	FF,F.EBTP	;YES, NO LONGER AN EB
1)		POP	P,B		;GET RID OF RETURN ADDRESS
1)		JRST	EBAKU3		;GO STRAIGHT TO THE YANK
1)	OPNIN:	MOVEI	T,IBUF1		;GET INPUT BUFFERS
****
2)92		TXNE	FF,F.EBTP	;[343] EB in progress?
2)		POPJ	P,		;[343] Yes, return
2)		TXZE	FF,F.CCL	;[343] ARE WE HERE FROM A .MAKE COMMAND?
2)		PUSHJ	P,YANK		;[343] Yes, do an EY
2)		POPJ	P,		;RETURN
2)	OPNIN:	MOVEI	T,IBUF1		;GET INPUT BUFFERS
**************
1)1	EIDFSP:	SKIPN	E,XFILNM+.RBNAM	;HE TYPE A NAME?
1)		MOVE	E,ERSPEC+1(A)	;NO, GET DEFAULT
1)		MOVEM	E,ERSPEC+1(A)	;SAVE IT
****
2)93	EIDFSP:	MOVE	E,SWITC		;[337] Get file switches
2)		TLNN	E,FS.DEF	;[337] /DEFAULT set?
2)		JRST	DEFSP1		;[337] No, continue
2)		MOVSI	E,ERSPEC(A)	;[337] Yes, we must clear the block
2)		HRRI	E,ERSPEC+1(A)	;[337] Set up the BLT
2)		SETZM	ERSPEC(A)	;[337] Zero the block
2)		BLT	E,ERSPEC+11(A)	;[337]
2)	DEFSP1:	SKIPN	E,XFILNM+.RBNAM	;HE TYPE A NAME?
2)		SKIPA	E,ERSPEC+1(A)	;[337] NO, GET DEFAULT
2)		MOVEM	E,ERSPEC+1(A)	;SAVE IT
**************
1)1		MOVE	E,ERSPEC+2(A)	;NO, GET DEFAULT
1)		MOVEM	E,ERSPEC+2(A)	;SAVE
****
2)93		SKIPA	E,ERSPEC+2(A)	;[337] NO, GET DEFAULT
2)		MOVEM	E,ERSPEC+2(A)	;SAVE
**************
1)1		BLT	B,FILPPN+5
1)		HRRI	B,SPCPPN	;PUT IT HERE TOO
1)		BLT	B,SPCPPN+5
1)		SKIPA			;DONT MAKE AN ERSATZ PPN THE DEFAULT
1)	DFSP1:	BLT	I,ERSPEC+9(A)	;NOW MAKE IT THE NEW DEFAULT
****
2)93		MOVE	E,B		;[317]SAVE BLT AC
2)		BLT	E,FILPPN+5	;[317]
2)		HRRI	B,SPCPPN	;PUT IT HERE TOO
2)		BLT	B,SPCPPN+5
2)		TXNE	F2,S.DPPN	;[340] Make [-] default, but not ersatz PPN
2)	DFSP1:	BLT	I,ERSPEC+9(A)	;NOW MAKE IT THE NEW DEFAULT
**************
1)1		SKIPN	E,FILDEV	;HE TYPE A DEVICE?
1)		MOVE	E,ERSPEC(A)	;NO, GET DEFAULT
1)		MOVEM	E,ERSPEC(A)	;SAVE
****
2)93		MOVEI	E,FILPTH	;[340] Get pointer to PATH block
2)		SKIPE	FILPPN		;[340] Does PATH block have something
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		MOVEM	E,XFILNM+.RBPPN	;[340] Yes, point to it
2)		SKIPN	E,FILDEV	;HE TYPE A DEVICE?
2)		SKIPA	E,ERSPEC(A)	;[337] NO, GET DEFAULT
2)		MOVEM	E,ERSPEC(A)	;SAVE
**************
1)1		MOVE	E,DEVSAV	;GET DEVICE CHARACTERISTICS
****
2)94		MOVE	E,SWITC		;[343] Get I/O switches
2)		TLNE	E,FS.REA	;[343] /READONLY?
2)		JRST	EBAKU3		;[343] Yes, cancel EB and do an ER
2)		MOVE	E,DEVSAV	;GET DEVICE CHARACTERISTICS
**************
1)1		JRST	EBAKU6		;DO ER/EW
****
2)94		MOVE	E,[FILPPN,,SPCPPN]	;[340] Save the real path
2)		BLT	E,SPCPPN+5	;[340] so EW goes to the right place
2)		JRST	EBAKU6		;DO ER/EW
**************
1)1	EBAKU5:	MOVEM	E,EBDEV
****
2)94					;Fall through to next page...
2)95	EBAKU5:	MOVEM	E,EBDEV
**************
1)1		SKIPLE	MONITR		;SKIP IF 3 OR 4 SERIES MONITOR
1)	IFN	FTFDAE,<	JRST	[	CAIGE	E,300		; CHECK
1)						 JRST	EBAKU7		; PROTECTIONS
1)						CAIGE	E,400		; THIS IS OK
1)						 JRST	EBAKU8		; ERROR
1)						CAIL	E,600		; CHECK THIS
1)						 JRST	EBAKU8		; ERROR
1)						JRST	EBAKU7	]	; IS OK>
1)	IFE	FTFDAE,<	CAIGE	E,300		;MAY USER RENAME HIS FILE?>
1)		CAIL	E,500		;REJECT 3+ IN LEVEL D, 5+ IN LEVEL C
1)	EBAKU8:	..ERROR	E.EBP
1)	EBAKU7:	MOVEM	E,PROTEC	;SAVE INPUT FILE PROTECTION
1)		SKIPE	A,SPCPRO
1)		LDB	E,[POINT 9,A,8]
1)		MOVEM	E,BAKPRO	;THIS IS THE DESIRED PROT. FOR THE NEW FILE
1)		MOVSI	E,100000	;MEANWHILE, USE <100> FOR .TMP FILE
****
2)95		MOVEM	E,PROTEC	;SAVE INPUT FILE PROTECTION
2)		MOVEM	E,EBPROT	;[333] Also in 2 RENAME switch
2)		MOVE	A,E		;[333] Make full access CHKACC block
2)		HRLI	A,.ACREN	;[333] and check for enough privs to do it straight
2)		MOVE	AA,FILPPN	;[333] PPN of file owner
2)		MOVE	B,USRPPN	;[333] Our PPN
2)		MOVEI	E,A		;[333] Point to block
2)		CHKACC	E,		;[333] See
2)		  SETZ	E,		;[333] Assume ok
2)		JUMPE	E,EBAKU9	;[333] OK if OK
2)		HRROS	EBPROT		;[333] Flag that 2 RENAME's needed at close time
2)		HRLI	A,.ACCPR	;[333] See if we can change protection to reasonable
2)		MOVEI	E,A		;[333]
2)		CHKACC	E,		;[333] Try that
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		  SETZ	E,		;[333] Assume OK now  (??)
2)		SKIPE	E		;[333] Yes, skip to see if we are supposed to write
2)		..ERROR	E.EBP		;[333] No, it's too protected
2)		HRLI	A,.ACWRI	;[333] Yes, can we write to it
2)		MOVEI	E,A		;[333]
2)		CHKACC	E,		;[333]
2)		  SETZ	E,		;[333] ?????
2)		JUMPE	E,EBAKU9	;[333] OK
2)		..ERROR	E.EBP		;[333] So sorry
2)	EBAKU9:	MOVE	E,PROTEC	;[333] Get input file protection back
2)		SKIPE	A,SPCPRO
2)		LDB	E,[POINT 9,A,8]
2)		MOVEM	E,BAKPRO	;THIS IS THE DESIRED PROTECTION FOR THE NEW FILE
2)		MOVSI	E,100000	;MEANWHILE, USE <100> FOR .TMP FILE
**************
1)1		TXZ	FF,F.OOPN+F.UBAK;LET GO OF OUTPUT DEVICE & EB FLAG
1)		LDB	E,[POINT 6,XFILNM+.RBEXT,35]	;ERROR CODE
****
2)97		TXZ	FF,F.OOPN+F.UBAK	;LET GO OF OUTPUT DEVICE & EB FLAG
2)		LDB	E,[POINT 6,XFILNM+.RBEXT,35]	;ERROR CODE
**************
1)1	LOOKIN:
1)	IFN	FTSWTCH,<
1)		SKIPN	INI.SW		; ARE WE TRYING TO READ SWITCH.INI ?
1)		 JRST	LOOKI0		; NO, SO DON'T SCREW AROUND
1)		PUSHJ	P,DSPEC1	; SET UP DEFAULT SPECS
1)		MOVE	E,['SWITCH']	; FILE NAME
1)		MOVEM	E,XFILNM+.RBNAM	; PLACE TO STORE IT
1)		LOOKUP	INICHN,XFILNM	;TRY TO FIND IT
1)		JRST	LOOKI0		; NOPE SO LET IT DIE
1)		IN	INICHN,		; GET A BLOCK
1)		SKIPA
1)		POPJ	P,		; INPUT ERROR, PRETEND FILE IS NOT THERE
1)	INI00:	MOVSI	AA,-4		; LOOP FOR 4 CHARS
1)		SETZ	A,
1)	INI01:	PUSHJ	P,INI10		; GET A CHARACTER
1)		CAIG	CH,"@"		; ALPHABETIC ??
1)		JRST	INI01		; NO, GET ANOTHER
1)		LSH	A,7		; SHIFT IT
1)		ADD	A,CH		; BUILD A WORD
1)		SETZ	CH,
1)		AOBJN	AA,INI01	; LOOP
1)		LSH	A,^D8		; MAKE ASCIZ
1)		CAME	A,[ASCII!TECO!]
1)		JRST	INI20		; NO MATCH , FIND NEXT <CRLF>
1)	INI02:	PUSHJ	P,INI10		; GET A CHAR
1)		CAIN	CH,""""			; CHECK FOR "
1)		 JRST	INI40		; FOUND SOME TEXT, PRINT IT
1)		CAIE	CH,"/"		; A SLASH YET
1)		JRST	INI02		; GET ANOTHER TO FIND FIRST SLASH
1)		SETOM	SW.INI		; SET SWITCH TO SAY THAT YOU FOUND IT
1)		JRST	INIFI0		; AND RETURN
1)	INI10:	SOSGE	IINI+.BFCNT
1)		JRST	INI30
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		ILDB	CH,IINI+.BFPTR
1)		POPJ	P,
1)	INI20:	PUSHJ	P,INI10
1)		CAIE	CH,.CHCRT
1)		JRST	INI20
1)		PUSHJ	P,INI10		; GET <LF>
1)		JRST	INI00
1)	INI30:	IN	INICHN,
1)		JRST	INI10
1)		SETZM	SW.INI
1)		POP	P,A
1)		JRST	LOOKI0
1)	INI40:	PUSHJ	P,INI10		; GET A CHAR
1)		CAIN	CH,""""		; END QUOTE ?
1)		 JRST	INI02		; YES, LOOK FOR A /
1)		OUTCHR	CH		; NO, TYPE THE TEXT
1)		JRST	INI40		; KEEP GOING
1)	>
1)	LOOKI0:	RELEAS	INICHN,		;DON'T WANT CHANNEL ANYMORE
1)		TXZN	F2,S.INFO	;WE PUSH ANYTHING?
****
2)97	LOOKIN:	RELEAS	INICHN,		;DON'T WANT CHANNEL ANYMORE
2)		TXZN	F2,S.INFO	;WE PUSH ANYTHING?
**************
1)1		TXNE	FF,F.EBTP	;THIS AN EB TEMP FILE ENTER?
****
2)98		MOVEI	E,FILPTH	;[340] Make sure path pointer is set
2)		MOVEM	E,XFILNM+.RBPPN	;[340]
2)		TXNE	FF,F.EBTP	;THIS AN EB TEMP FILE ENTER?
**************
1)1		CAMN	B,FILPPN	;FILE IN SAME AREA?
****
2)98		JUMPL	B,OPNW5		;[320] -1 MEANS LOOKUP FAILED, SO SKIP ALL THIS
2)		CAMN	B,FILPPN	;FILE IN SAME AREA?
**************
1)1		SETSTS	OUTCHN,0	;CLEAR IOBKTL IF USETI ON ENTER ONLY
1)	OPNW5:	MOVEI	T,OBUF1		;WHERE OUTPUT BUFFERS MUST BE
****
2)99	OPNW5:	MOVEI	T,OBUF1		;WHERE OUTPUT BUFFERS MUST BE
**************
1)1		MOVEI	B,PPAQ		;ASSUME QUICK ROUTINE
1)		TLNN	E,FS.GEN	;MUST GENERATE LSN'S?
1)		TXNE	FF,F.SEQ	;OR SEQUENCED FILE
1)		MOVEI	B,PPA		;= USE SLOW ONE
1)	;THE FOLLOWING WAS REMOVED BECAUSE THE SLOW ROUTINE ALSO TAKES CARE OF
1)	;SUPPRESSING LSN'S!!!
1)	;	TLNE	E,FS.SUP	;IF TO SUPPRESS LSN'S USE NO PROCESS ROUTINE
1)	;	MOVEI	B,PPAQ		;QUICK OUTPUT
1)		MOVEM	B,OUTCH		;SAVE IT
****
2)99		MOVE	T,INSWIT	;[317]GET INPUT SWITCHES
2)		MOVEI	B,PPAQ		;ASSUME QUICK ROUTINE
2)		TLNE	E,FS.GEN	;[317]MUST GENERATE LSN'S?
2)		MOVEI	B,PPA		;= USE SLOW ONE
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		TXNE	FF,F.SEQ	;[317]SEQUENCED FILE?
2)		TLNE	T,FS.SUP	;[317]YES, BUT IS INPUT SUPPRESSING THEM?
2)		SKIPA			;[317]BUFFER WILL NOT HAVE SEQUENCE NUMBERS
2)		MOVEI	B,PPA		;[317]USE SLOW ROUTINE
2)		MOVEM	B,OUTCH		;SAVE IT
**************
1)1		SKIPE	E,FILDEV	;DO WE HAVE A DEVICE?
****
2)100		MOVE	E,SWITC		;[343] Get I/O switches
2)		TLNE	E,FS.APP	;[343] /APPEND?
2)		TXO	F2,S.EA		;[343] Yes, set append flag
2)		SKIPE	E,FILDEV	;DO WE HAVE A DEVICE?
**************
1)1		MOVSI	B,(SIXBIT /SFD/);CHECK FOR AN .SFD FILE
1)		CAMN 	B,XFILNM+.RBEXT
****
2)100		MOVSI	B,(SIXBIT /SFD/)	;CHECK FOR AN .SFD FILE
2)		CAMN 	B,XFILNM+.RBEXT
**************
1)1	;	JRST	OPNW4		;FALL
1)	OPNW4:	TXZE	FF,F.OOPN	;CALL HERE FROM EB
****
2)100	;	JRST	OPNW4		;FALL THROUGH
2)101	OPNW4:	TXZE	FF,F.OOPN	;CALL HERE FROM EB
**************
1)1	ifn 0,<
1)		MOVEI	B,"A"
****
2)101		MOVEI	B,"A"
**************
1)1	>;end ifn 0 (no devtyp uuo at tymshare)
1)		MOVEI	T,OBUF1
****
2)101		MOVEI	T,OBUF1
**************
1)1		SETZM	XFILNM+.RBSIZ	;LOOKUP OLD BACKUP ON DEFAULT PATH
1)		MOVE	B,PROTEC	;GET PROTECTION OF INPUT FILE
1)		TRZE	B,600		;ALWAYS ALLOW OWNER DELETION
1)		TRO	B,100		;IF OWNER FIELD >1 LEAVE IT AS 1
1)		LOOKUP	INCHN,XFILNM+.RBNAM
1)		JRST	BKCLS1
1)		LDB	B,[POINTR (XFILNM+.RBPRV,RB.PRV)]	;GET PROTECTION OF BACKUP FILE
****
2)104		MOVE	E,WRICHR	;[353] Get device characteristics
2)		TXNE	E,DV.DTA	;[353] DEC-tape?
2)		JRST	BKCLSD		;[353] Yes
2)		MOVEI	E,FILPTH	;[353] Set up path pointer
2)		MOVEM	E,XFILNM+.RBPPN	;[353]
2)		PUSHJ	P,PPNDEF	;[353] Set default path
2)		AOS	FILPTH+1	;[353] No scanning!
2)		MOVE	B,PROTEC	;GET PROTECTION OF INPUT FILE
2)		SKIPN	FDAEM		;[333] See what protection we want file to be
2)		TRZN	B,700		;[333] No FILDAE, make owner protection 0
2)		TRZ	B,300		;[333] FILDAE, leave 400 on if it is
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		LOOKUP	INCHN,XFILNM	;[353]
2)		JRST	BKCLS0		;[333] .BAK file not there or protection failure
2)		LDB	B,[POINTR (XFILNM+.RBPRV,RB.PRV)]	;GET PROTECTION OF BACKUP FILE
**************
1)1		RENAME	INCHN,XFILNM+.RBNAM
1)		JRST	BKCERR		;ERROR
1)	BKCLS1:	SETZM	XFILNM+.RBSIZ	;FIND BACKUP ON DEFAULT PATH
1)		MOVE	E,BAKNAM
1)		MOVEM	E,XFILNM+.RBNAM
****
2)104		RENAME	INCHN,XFILNM	;[353]
2)		JRST	BKCERR		;ERROR
2)		JRST	BKCLS1		;[333] Now go rename original file to .BAK
2)	;[353] Here to do short LOOKUP on DEC-tapes
2)	BKCLSD:	LOOKUP	INCHN,XFILNM+.RBNAM	;[353] Short LOOKUP for DTA
2)		  JRST	BKCLS1		;[353] None, assume not there
2)		SETZM	XFILNM+.RBNAM	;[353] Zero the file name
2)		RENAME	INCHN,XFILNM+.RBNAM	;[353] Delete
2)		  JRST	BKCERR		;[353] Most strange
2)		JRST	BKCLS1		;[353] Move on
2)	;Here when LOOKUP on .BAK file fails
2)	BKCLS0:	HRRZ	E,XFILNM+.RBEXT	;[333] Get error code
2)		JUMPE	E,BKCLS1	;[333] 0 means not found, so we're OK
2)		MOVEI	E,<E.BFL=='BFL'>;[333] Otherwise, load error code
2)		JRST	BKCERR		;[333] Can't LOOKUP existing .BAK file
2)105	BKCLS1:	MOVE	E,BAKNAM
2)		MOVEM	E,XFILNM+.RBNAM
**************
1)1		MOVEI	E,<E.ILR=='ILR'>	;ERROR CODE
1)		LOOKUP	INCHN,XFILNM+.RBNAM
1)		JRST	BKCERR		;ERROR
****
2)105		MOVE	E,WRICHR	;[353] Get device characteristics
2)		TXNE	E,DV.DTA	;[353] DEC-tape?
2)		JRST	BKCLD1		;[353] Yes
2)		MOVEI	E,FILPTH	;[353] Set up default path again
2)		MOVEM	E,XFILNM+.RBPPN	;[353] (May have gotten wiped)
2)		PUSHJ	P,PPNDEF	;[353]
2)		AOS	FILPTH+1	;[353] No scanning
2)		MOVEI	E,<E.ILR=='ILR'>	;ERROR CODE
2)		LOOKUP	INCHN,XFILNM	;[353]
2)		JRST	BKCERR		;ERROR
**************
1)1		MOVE	E,PROTEC	;GET PROT OF INPUT FILE
1)		CAIGE	E,200		;IS IT IN THE 200 RANGE?
1)		JRST	BKCLS5		;NO
1)	IFE	FTFDAE,<	XORI	E,300	;YES, RENAME IT TO 100 RANGE -- >
1)	IFN	FTFDAE,<	MOVE	B,E		; GET FILE PROT.
1)				TRZE	E,600		; MAKE THIS CORRECT
1)				 TRO	E,100		; AS IT SHOULD BE
1)				CAIGE	B,400		; 400 + LEVEL ?
1)				 JRST	BKCLS8		; NO, CONTINUE
1)				CAIL	B,600		; 500 - LEVEL ?
1)				 JRST	BKCLS8		; NO, CONTINUE
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)				TRZ	B,700		; MAKE THIS 400 LEVEL
1)				TRO	B,400		; .BAK FILE
1)				JRST	BKCLS7		; FINISH UP
1)			BKCLS8:	TRZE	B,600		; MAKE THIS 100 LEVEL
1)				 TRO	B,100		; .BAK FILE
1)	BKCLS7:	>
1)		DPB	E,[POINTR (XFILNM+.RBPRV,RB.PRV)]	;SO WE CAN DO THE
1)								;  REAL RENAME TO .BAK
1)		SETZM	XFILNM+.RBSIZ
1)		MOVEI	E,<E.IRB=='IRB'>	;ERROR
1)		RENAME	INCHN,XFILNM+.RBNAM
1)		JRST	BKCERR		;ERROR
****
2)105		SKIPL	EBPROT		;[333] Need to do 2 RENAMEs due to protection?
2)		JRST	BKCLS5		;[333] No, skip this bother
2)		MOVE	E,PROTEC	;GET PROT OF INPUT FILE
2)	;When we arrive at this point, we know the protection must be
2)	;<2xx>, the only one which requires a double rename but still
2)	;allows us to edit at all.
2)		XORI	E,300		;THEN RENAME IT TO 100 RANGE --
2)		DPB	E,[POINTR (XFILNM+.RBPRV,RB.PRV)]	;SO WE CAN DO THE REAL RENAME TO .BAK
2)		MOVEI	E,<E.IRB=='IRB'>	;ERROR
2)		RENAME	INCHN,XFILNM	;[353]
2)		JRST	BKCERR		;ERROR
**************
1)1		SETZM	XFILNM+.RBSIZ
1)		MOVEI	E,<E.IRB=='IRB'>	;ERROR CODE IN CASE WE NEED IT
1)		RENAME	INCHN,XFILNM+.RBNAM
1)		JRST	BKCERR		;ERROR
1)		MOVE	E,DEVSAV	;GET INPUT DEVICE CHARCATERISTICS
1)		TXNN	E,DV.DTA	;DECTAPE?
****
2)105		RENAME	INCHN,XFILNM	;[353]
2)		  TRNA			;[333] Try to recover
2)		JRST	BKCLS8		;[333] Now go rename the .TMP file
2)	;Here when renaming file to file.BAK with a lower protection fails.
2)	;We will try again, this time keeping the protection the same.
2)		LDB	E,[POINT 15,XFILNM+.RBEXT,35]	;[333] Get error code
2)		CAIE	E,ERPRT%	;[333] Protection failure?
2)		  JRST	BKCLS7		;[333] No, complete loss
2)		HLLZ	E,BAKNAM+1	;[333] Retrieve original extension
2)		MOVEM	E,XFILNM+.RBEXT	;[333] Store
2)		MOVEI	E,<E.ILR=='ILR'>;[333] Setup error code
2)		LOOKUP	INCHN,XFILNM	;[353][333] Lookup old source again
2)		  JRST	BKCERR		;[333] Most strange
2)		MOVSI	E,'BAK'		;[333] New extension
2)		HLLM	E,XFILNM+.RBEXT	;[333] Change only extension
2)		RENAME	INCHN,XFILNM	;[353][333] Try the rename again
2)		  TRNA			;[333] It's hopeless
2)		JRST	BKCLS8		;[333] Good, now go rename .TMP file
2)	BKCLS7:	MOVEI	E,'IRB'		;[333] Set error code
2)		JRST	BKCERR		;[333] Go issue message
2)106	;Here to rename original file to .BAK on a DEC-tape
2)	BKCLD1:	MOVEI	E,<E.ILR=='ILR'>	;[353] Set up error code
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		LOOKUP	INCHN,XFILNM+.RBNAM	;[353] Lookup original file
2)		  JRST	BKCERR			;[353] Curious
2)		MOVSI	E,'BAK'			;[353] New extension
2)		HLLM	E,XFILNM+.RBEXT		;[353] Store it
2)		RENAME	INCHN,XFILNM+.RBEXT	;[353] Change the name to .BAK
2)		  JRST	BKCLS7			;[353] Sigh
2)						;Fall thru...
2)	;Here to rename .TMP file to new source file
2)	BKCLS8:	RELEAS	INCHN,		;[353] Make sure input device finished
2)		MOVE	E,WRICHR	;[353] GET OUTPUT DEVICE CHARCATERISTICS
2)		TXNN	E,DV.DTA	;DECTAPE?
**************
1)1		TXNE	F2,S.EA		;NO MESSAGE IF APPENDING
1)		POPJ	P,		;SO RETURN
1)		JSP	A,CONMES	;TYPE %SUPERSEDING...
****
2)107		MOVE	E,SWITC		;[351] Get I/O switches
2)		TLNN	E,FS.INP	;[351] /INPLACE?
2)		TXNE	F2,S.EA		;OR APPENDING?
2)		POPJ	P,		;YES, RETURN
2)		JSP	A,CONMES	;TYPE %SUPERSEDING...
**************
1)1		JFCL				;USE THE BEST WE HAVE
1)		MOVSI	E,-6		;CHECK FOR INTENDED PATH
****
2)108		JFCL			;USE THE BEST WE HAVE
2)		MOVSI	E,-6		;CHECK FOR INTENDED PATH
**************
1)1		SETZM	SPCPPN+.PTSWT	;YES, DO THE MONITORS JOB--WE DONT WANT SFDS
1)		POPJ	P,		;RETURN
1)	SUBTTL	^V, ^W, ^X COMMANDS
****
2)109		SETZM	SPCPPN+1	;YES, DO THE MONITORS JOB--WE DONT WANT SFDS
2)		POPJ	P,		;RETURN
2)	;***[340]***
2)	;ROUTINE TO ISSUE WARNING MESSAGE IF FILE NOT FOUND ON 
2)	;SPECIFIED DIRECTORY.
2)	CHKSPC:	MOVEI	E,INCHN		;Set up input channel for PATH. UUO
2)		PUSHJ	P,CHKPTH	;See if file found on specified path
2)		TXNE	FF,F.COLN	;If : specified, no warning.
2)		POPJ	P,		;Yes, return
2)		JSP	A,CONMES	;Type a warning
2)		ASCIZ	/%File found in [/
2)		HLRZ	B,FILPPN	;Type PPN
2)		PUSHJ	P,OCTMS
2)		MOVEI	CH,","
2)		PUSHJ	P,TYOM
2)		HRRZ	B,FILPPN
2)		PUSHJ	P,OCTMS
2)		MOVE	TT1,[-5,,FILSFD]	;Type SFD's
2)	CHKSP1:	SKIPN	TT,(TT1)	;End of list?
2)		JRST	CHKSP2		;Yes
2)		MOVEI	CH,","		;No, type another comma
2)		PUSHJ	P,TYOM
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		PUSHJ	P,SIXBMS	;And SFD
2)		AOBJN	TT1,CHKSP1	;Loop
2)	CHKSP2:	JSP	A,CONMES	;Finish message
2)		ASCIZ	/]
2)	/
2)		POPJ	P,
2)110	SUBTTL	^V, ^W, ^X COMMANDS
**************
1)1	SW GENLSN	;;GENERATE LINE SEQUENCE NUMBER ON OUTPUT
****
2)117	SW DEFAUL	;;[337] CLEAR STICKY DEFAULTS BEFORE APPLYING FILESPEC
2)	SW GENLSN	;;GENERATE LINE SEQUENCE NUMBER ON OUTPUT
**************
1)1	SW READ		;;READ ONLY WHEN .TECO <FILESPEC>
1)	SW SUPLSN	;;SUPPRESS LINE SEQUENCE NUMBERS ON INPUT
****
2)117	SW READON	;;[337] READ ONLY WHEN .TECO <FILESPEC>
2)	SW SUPLSN	;;SUPPRESS LINE SEQUENCE NUMBERS ON INPUT
**************
1)1	YANKER:	SKIPN	EQM		;Y ILLEGAL FROM TTY
1)		ERROR	E.UEY
****
2)118	YANKER:	CHKEO	EODEC,YANK	;[335] Y is OK if EO level is 2 or less
2)		SKIPN	EQM		;Y ILLEGAL FROM TTY
2)		ERROR	E.UEY
**************
1)1	YANK2:	TXZ	FF,F.FORM	;RESET THE YANK,APPEND FORM FEED FLAG
****
2)118		MOVSI	C,377777	;[346] Set up "infinite" line count
2)		MOVEM	C,LFCNT		;[346]
2)	YANK2:	TXZ	FF,F.FORM	;RESET THE YANK,APPEND FORM FEED FLAG
**************
1)1		CAIE	CH,.CHFFD	;FORM FEED?
1)		AOJA	OU,YANK4	;NO. UPDATE DATA BUFFER PTR AND CHECK FOR OVERFLOW.
1)		TXO	FF,F.FORM	;YANK AND/OR APPEND TERMINATED ON A FORM FEED
1)	YANK51:	MOVEM	OU,Z		;YES. SET END OF DATA BUFFER AND RETURN
****
2)119		CAIN	CH,.CHFFD	;[346] FORM FEED?
2)		JRST	YANK5		;[346] Yes
2)		CAIE	CH,.CHLFD	;[346] Line feed?
2)		AOJA	OU,YANK4	;NO. UPDATE DATA BUFFER PTR AND CHECK FOR OVERFLOW.
2)		SOSLE	LFCNT		;[346] Yes, decrement line count
2)		AOJA	OU,YANK4	;[346] Still positive...Keep going
2)		AOJA	OU,YANK51	;[346] Time to stop
2)	YANK5:	TXO	FF,F.FORM	;[346] YANK AND/OR APPEND ENDS ON A FORM FEED
2)	YANK51:	MOVEM	OU,Z		;YES. SET END OF DATA BUFFER AND RETURN
**************
1)1	APPEND:	MOVE	OU,Z		;STORE DATA AT END OF BUFFER.
1)		PUSHJ	P,YANK2
****
2)119	;:nA	SAME AS A EXCEPT THAT INPUT STOPS AFTER THE NTH LINE FEED,
2)	;	UNLESS ONE OF THE REGULAR CONDITIONS TERMINATES IT FIRST.
2)	;	IF n IS MISSING, 0, OR NEGATIVE, IT IS TAKEN AS 1.
2)	APPEND:	MOVE	OU,Z		;STORE DATA AT END OF BUFFER.
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		PUSHJ	P,CHK2		;[346] GET ARG
2)		TXZN	FF,F.COLN	;[346] WAS COLON SET?
2)		MOVSI	B,377777	;[346] NO, REGULAR APPEND, SO SET LARGE COUNT
2)		MOVEM	B,LFCNT		;[346] STORE COUNT
2)		PUSHJ	P,YANK2
**************
1)1		PUSH	P,[RET]		;WHERE TO RETURN TO
1)	GETBAK:	CAMG	B,NFORMS	;DONE
1)		JRST	YANK		;YANK AND RETURN
1)		TXNE	FF,F.EOFI	;STUFF LEFT?
1)		AOJA	B,QERR		;NO
1)		SETZ	T,		;INSURE YANK AFTER OUTPUT
1)		TXNN	F2,S.YANK	;^Y =  NO OUTPUT
1)		PUSHJ	P,PUN1
1)		MOVE	B,SAVEAC
1)		JRST	GETBAK
1)	SUBTTL	READ A CHARACTER FROM INPUT FILE
****
2)120	STUP1:	TXNE	FF,F.EOFI	;[327] ANYTHING LEFT?
2)		AOJA	B,QERR		;[327] NO, RESET B AND GO TYPE ERROR
2)		PUSHJ	P,YANK1		;[327] GET A BUFFER-FULL
2)		TXNN	F2,S.YANK	;[327] IF ^Y, WE DON'T NEED TO OUTPUT
2)		PUSHJ	P,PUNCHR	;[327] OUTPUT CURRENT BUFFER
2)		MOVE	B,SAVEAC	;[327] RESTORE B
2)		CAMLE	B,NFORMS	;[327] ARE WE DONE?
2)		JRST	STUP1		;[327] NO, LOOP BACK
2)		PUSHJ	P,YANK1		;[327] YES, SO DO ONE MORE Y
2)		JRST	RET		;[327] AND RETURN
2)121	SUBTTL	READ A CHARACTER FROM INPUT FILE
**************
1)1	TAB:	skipe	eqm		;tab is a no op inside macros
1)		popj	p,
1)		TXZ	FF,F.ARG	;NO ARGUMENT WANTED
1)		PUSHJ	P,TAB2		;INSERT TAB
****
2)122	TAB:	TXZ	FF,F.ARG	;NO ARGUMENT WANTED
2)		PUSHJ	P,TAB2		;INSERT TAB
**************
1)1		TXO	FF,F.NNUL	;FLAG NON-NULL STRING (FOR F-SEARCH)
1)		CHKEO	EO21,INSER1	;IF EO=1, CTRL-CHARS ARE JUST TEXT
****
2)122	TXO	FF,F.NNUL	;FLAG NON-NULL STRING (FOR F-SEARCH)
2)		CHKEO	EO21,INSER1	;IF EO=1, CTRL-CHARS ARE JUST TEXT
**************
1)1	SUBTTL	NT	TYPE OUT THE STRING OF CHARACTERS
1)	;	STARTING AT THE RIGHT OF THE
1)	;	POINTER AND CONTINUING THROUGH THE NTH LINE FEED ENCOUNTERED.
****
2)129	SUBTTL	T COMMAND
2)	;	TYPE OUT STRING OF CHARACTERS STARTING AT THE RIGHT OF THE
2)	;	POINTER AND CONTINUING THROUGH THE NTH LINE FEED ENCOUNTERED.
**************
1)1	SUBTTL	PUT A CHARACTER IN THE OUTPUT FILE
****
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)130	SUBTTL	V COMMAND
2)	;nV Command --	Equivalent to (1-n)T nT
2)	IFE VC,<	;In case anybody is really using the old V command
2)	VCMD:	PUSHJ	P,CHK2		;[347] Get argument
2)		TXZ	FF,F.ARG2	;[347] Ignore second arg if any
2)		PUSH	P,B		;[347] Save it
2)		MOVN	B,B		;[351] Calculate 1-n
2)		ADDI	B,1		;[351]
2)		PUSHJ	P,TYPE		;[347] Type the lines above
2)		POP	P,B		;[347] Restore arg
2)		PJRST	TYPE		;[347] Type the lines below
2)	>
2)131	SUBTTL	PUT A CHARACTER IN THE OUTPUT FILE
**************
1)1		CAIG	A,.CHLFD
1)		JRST	PPA05		;NO, OUTPUT & COME BACK
1)	PPA07:	LDB	A,[POINT 6,OBF+.BFPTR,5]	;GET CURRENT BYTE POSITION IN OUT BUFR
1)		CAIG	A,1		;AT END OF WORD?
1)		JRST	PPA06		;YES
1)		IBP	OBF+.BFPTR	;NO, PAD OUT WORD WITH NULLS
1)		SOS	OBF+.BFCNT
1)		JRST	PPA07		;TRY AGAIN
1)	PPA06:	TXZ	FF,F.SQIN
****
2)132		CAIG	A,^D12		;[345] Page marks need 12 positions
2)		JRST	PPA05		;NO, OUTPUT & COME BACK
2)		PUSHJ	P,NULPAD	;[345] Go pad with nulls if necessary
2)	PPA06:	TXZ	FF,F.SQIN
**************
1)1		MOVE	A,LSNCTR	;GET LAST CREATED LSN WITH BIT 35 ON
****
2)132		CAIN	CH,.CHFFD	;[345] Form feed?
2)		JRST	PPA14		;[345] Yes, go handle it
2)		MOVE	A,LSNCTR	;GET LAST CREATED LSN WITH BIT 35 ON
**************
1)1		JRST	PPA01
1)	;OUTPUT EXISTING LSN WITH LEADING ZEROS
****
2)132		CAIE	CH,.CHFFD	;[345] Form feed?
2)		JRST	PPA01		;[345] No, just output
2)		TLNE	AA,FS.SUP	;[345] Suppressing LSN's?
2)		JRST	PPA01		;[345] Yes
2)		MOVEI	A,.CHCRT	;[345] No, insert a CRLF
2)		IDPB	A,OBF+.BFPTR	;[345] before a page mark
2)		MOVEI	A,.CHLFD	;[345] So it will be recognized
2)		IDPB	A,OBF+.BFPTR	;[345]
2)		SOS	OBF+.BFCNT	;[345] Update the counter
2)		SOS	OBF+.BFCNT	;[345]
2)		PUSHJ	P,NULPAD	;[345] Go pad with nulls if necessary
2)		JRST	PPA14		;[345] Mark the page
2)	;Routine to pad buffer with nulls till next word boundary
2)	;
2)	NULPAD:	LDB	A,[POINT 6,OBF+.BFPTR,5]	;GET CURRENT BYTE POSITION 
2)		CAIG	A,1		;AT END OF WORD?
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		POPJ	P,		;Yes, return
2)		IBP	OBF+.BFPTR	;NO, PAD OUT WORD WITH NULLS
2)		SOS	OBF+.BFCNT
2)		JRST	NULPAD		;TRY AGAIN
2)133	;OUTPUT EXISTING LSN WITH LEADING ZEROS
**************
1)1	SUBTTL	PW	OUTPUT THE ENTIRE BUFFER, FOLLOWED BY A FORM FEED CHARACTER.
****
2)134	;
2)	;	Here to insert an SOS type page mark.
2)	;
2)	PPA14:	MOVE	A,[BYTE (7) 40,40,40,40,40]	;[345] Five spaces
2)		TRO	A,1			;[345] Set the bit
2)		AOS	OBF+.BFPTR		;[345] Increment pointer
2)		MOVEM	A,@OBF+.BFPTR		;[345] and output
2)		MOVE	A,[BYTE (7) .CHCRT,.CHFFD,0,0,0] ;[345] CR,FF
2)		AOS	OBF+.BFPTR		;[345] Increment
2)		MOVEM	A,@OBF+.BFPTR		;[345] and deposit
2)		MOVNI	A,^D9			;[345] Adjust buffer counter
2)		ADDM	A,OBF+.BFCNT		;[345] (We already counted one at PPA:)
2)		TRO	FF,F.SQIN		;[345] Set the EOL flag
2)		MOVE	A,[<"00000">B34+1]	;[345] Reset the LSN's
2)		MOVEM	A,LSNCTR		;[345]
2)		POPJ	P,			;[345] Return
2)135	SUBTTL	PW	OUTPUT THE ENTIRE BUFFER, FOLLOWED BY A FORM FEED CHARACTER.
**************
1)1	SUBTTL	SEARCH COMMANDS
1)	BOUNDS:	PUSHJ	P,GETAG6	;GET THE STRING POINTERS
1)		TXZ	FF,F.NSRH!F.LARW!F.ARG	;FN + N GO TO FS AND S
1)		CAMLE	C,Z		;TOO BIG
1)		MOVE	C,Z
1)		CAMGE	C,BEG		;TOO SMALL
1)		MOVE	C,BEG
1)		MOVEM	C,PT		;PLACE TO START SEARCHIN'
1)		CAML	B,C		;MINUS IMPLIED?
1)		JRST	SAVESH		;NO, SAVE BOUNDS
1)		EXCH	C,B		;YES, EXCHANGE ARGS
1)		TXO	F2,S.MINS	;SAY MINUS SEARCH
1)	SAVESH:	MOVEM	C,LOWERB
1)		MOVEM	B,UPPERB
1)		JRST	SERCHA		;SEARCH
1)	;_ SEARCH
****
2)140		SUBTTL	Searches -- Commands
2)	;F Search
2)	FCMD:	PUSHJ	P,SKRCH		;GET CHAR AFTER F
2)		ERROR	E.MEF
2)		TXO	FF,F.SRCH	;SET F-SEARCH FLAG
2)		TRZ	CH,40		;UPPER OR lower CASE
2)		CAIN	CH,"S"		;FS?
2)		JRST	SERCH		;YES
2)		CAIN	CH,"N"		;FN?
2)		JRST	SERCHP		;YES
2)		TXZ	FF,F.SRCH	;MUST NOT BE ON
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		CAIE	CH,"D"		;SEARCH AND DESTROY
2)		ERROR	E.IFC
2)		TXO	F2,S.DELS	;TO DELETE
2)		JRST	SERCH		;S SEARCH ONLY
2)	;_ SEARCH
**************
1)1		SETZ	E,		;ASSUME FIRST OCCURRENCE IN CASE BOUNDED
****
2)140		MOVEM	E,UPPERB	;[342] PT is upper bound on backward searches
2)		SETZ	E,		;ASSUME FIRST OCCURRENCE IN CASE BOUNDED
**************
1)1		SETZM	UPPERB		;SAVE
1)		PUSHJ	P,CHK2		;GET 1ST ARG
****
2)140		PUSHJ	P,CHK2		;GET 1ST ARG
**************
1)1	ERRISA:	ERROR	E.ISA
1)	SERC33:	SKIPGE	E,B		;GET ARG WHERE IT WANTS IT
1)		TXO	F2,S.MINS	;MINUS SEARCH
1)	SERCHA:	MOVE	A,BEG		;GOOD LOWER BOUND
****
2)140		ERROR	E.ISA
2)	SERC33:	SKIPGE	E,B		;GET ARG WHERE IT WANTS IT
2)		TXOA	F2,S.MINS	;[342] MINUS SEARCH
2)		SETZM	UPPERB		;[342] No upperbound on forward searches
2)		JRST	SERCHA
2)141		SUBTTL	Searches -- pattern source setup
2)	;Here if bounded search, set up bounds
2)	BOUNDS:	PUSHJ	P,GETAG6	;GET THE STRING POINTERS
2)		TXZ	FF,F.NSRH!F.LARW!F.ARG	;FN + N GO TO FS AND S
2)		CAMLE	C,Z		;TOO BIG
2)		MOVE	C,Z
2)		CAMGE	C,BEG		;TOO SMALL
2)		MOVE	C,BEG
2)		MOVEM	C,PT		;PLACE TO START SEARCHIN'
2)		CAML	B,C		;MINUS IMPLIED?
2)		JRST	SAVESH		;NO, SAVE BOUNDS
2)		EXCH	C,B		;YES, EXCHANGE ARGS
2)		TXO	F2,S.MINS	;SAY MINUS SEARCH
2)	SAVESH:	MOVEM	C,LOWERB
2)		MOVEM	B,UPPERB
2)	;Adjust upper and lower bounds
2)	SERCHA:	MOVE	A,BEG		;GOOD LOWER BOUND
**************
1)1	;THE FOLLOWING NOT NEEDED ANYMORE
1)	;	MOVE	A,[MOVE	B,SYL]	;IN CASE F.COLN ON
1)	;	MOVEM	A,DLIM
1)		MOVEI	CH,.CHESC	;USE ALT-MODE DELIMITER IF NO @ SEEN
****
2)141		MOVEI	CH,.CHESC	;USE ALT-MODE DELIMITER IF NO @ SEEN
**************
1)1	SERCHB:	MOVEM	CH,B		;B:=SEARCH STRING DELIMITER
1)		MOVEM	CH,ARGTRM	;SAVE TERMINATOR FOR FS INSERTION
1)		SETZM	STAB		;CLEAR SEARCH MATRIX
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		MOVE	A,[XWD STAB,STAB+1]
1)		BLT	A,STAB+STABLN-1
1)		PUSHJ	P,SKRCH		;LOOK AHEAD 1 CHAR
1)		ERROR	E.USR
1)		CAIE	CH,(B)		;IS IT THE DELIMITER?
1)		JRST	SERCHT		;NO, AN ARGUMENT IS GIVEN
1)		SKIPN	SRHCTR		;YES, USE PREVIOUS SEARCH STRING
1)		ERROR	E.SNA
1)		JRST	SERCH0
1)	;MOVE NEW STRING TO STORAGE
1)	SERCHT:	SETZM	SRHCTR		;CLR STRING CTR
1)		MOVE	AA,[POINT 7,SRHARG]	;INIT STORAGE PTR
1)		JRST	SERCHD		;1ST CHAR ALREADY IN
1)	SERCHC:	PUSHJ	P,SKRCH		;GET NEXT CHAR OF CMD STRING
1)		ERROR	E.USR
1)	SERCHD:	CHKEO	EO21,SERCHE	;IF EO=1, ^R IS JUST TEXT
1)		CAIE	CH,.CHCNR	;^R?
1)	SERCHE:	CAIN	CH,.CHCNQ	;^Q?
1)		JRST	SERCHG		;YES, NEXT CHAR IS TEXT
1)		CAIN	CH,(B)		;THE DELIMITER?
1)		JRST	SERCH0		;YES
1)		CAIN	CH,.CHCNT	;^T?
1)		JRST	SERCHU		;YES
1)		TXNE	F2,S.NCCT	;^T FLAG ON?
1)		JRST	SERCHF		;YES, ^V AND ^W ARE JUST TEXT
1)		CAIE	CH,.CHCNV	;^V?
1)		CAIN	CH,.CHCNW	;^W?
1)		TXO	F2,S.XMAT	;YES, SET EXACT MATCH FLAG
1)	SERCHF:	AOS	A,SRHCTR	;BUMP STRING CTR
1)		CAILE	A,^D80		;STILL FIT IN STORE?
1)		ERROR	E.STC
1)		IDPB	CH,AA		;STORE CHARACTER
1)		JRST	SERCHC		;& GO BACK FOR MORE
1)	SERCHG:	AOS	SRHCTR		;COUNT THE ^R (^Q)
1)		IDPB	CH,AA		;& STORE IT
1)		PUSHJ	P,SKRCH		;GET NEXT CHAR
1)		ERROR	E.USR
1)		JRST	SERCHF		;STORE IT AS TEXT
1)	SERCHU:	TXC	F2,S.NCCT	;COMPLEMENT CONTROL CMD DISABLING SWITCH
1)		JRST	SERCHF
1)	;SET UP SEARCH MATRIX
1)	SERCH0:	TXZ	F2,S.NCCT	;REFRESH ^T FLAG
1)		SETZM	SCESQB		;CLR ^E[...] NEST CTR
1)		SETZM	CTGLEV		;CLR ^G NEST CTR
1)		MOVE	B,SRHCTR	;INIT STRING CTR
1)		MOVE	AA,[POINT 7,SRHARG]	;& POINTER
1)		MOVSI	D,400000	;INIT MATRIX BIT PTR
1)	SERCH2:	ILDB	CH,AA		;CH:=NEXT SEARCH STRING CHARACTER.
1)		SKIPN	SCESQB		;GATHERING DATA FOR ^E[...]?
1)		JRST	.+3		;NO
1)		SOJL	B,CNTREE	;YES, ERRORS GO TO ?ICE
1)		JRST	.+2
1)		SOJL	B,SERCHI	;END OF STRING?
1)		MOVEI	T,S2TABL	;CK FOR CTL CHAR IN STRING
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		TXNE	F2,S.NCCT	;^T FLAG ON?
1)		MOVEI	T,S3TABL	;YES, USE RESTRICTED TABLE
1)		PUSHJ	P,DISP1
1)		CHKEO	EO21,SRCH2B	;IF EO=1, FORCE EXACT MODE
1)		TXNN	F2,S.NCCT	;IF ^T FLAG ON, ALL ^CHARS ARE LEGAL
1)		PUSHJ	P,CKNCC		;CK FOR OTHER CTRL-CHARS (THEY ARE ILLEGAL)
1)	SRCH2E:	TXNE	F2,S.EMAT	;IGNORE S.XMAT FLAG?
1)		JRST	SRCH2F		;YES, FORCE ACCEPT-EITHER SEARCH
1)		TXNN	F2,S.XMAT	;NO, S.XMAT ON?
1)		TXNE	FF,F.PMAT	;NO, PREVAILING EXACT MATCH FLAG ON?
1)		JRST	SRCH2B		;S.EMAT=0 & S.XMAT OR F.PMAT =1 IMPLIES EXACT MODE
1)	SRCH2F:	CAIL	CH,"A"+" "	;ACCEPT-EITHER SEARCH MODE
1)		CAILE	CH,"Z"+" "	;IS IT LOWER CASE ALPHA?
1)		SKIPA			;NO
1)		TRZ	CH,40		;YES, MAKE IT UPPER CASE
1)		CAIL	CH,"A"		;IS IT UPPER CASE ALPHA?
1)		CAILE	CH,"Z"
1)		JRST	SERCH4		;NO
1)		XORM	D,STAB+40(CH)	;ENABLE MATCH ON CORRESP. LC CHAR.
1)		JRST	SERCH4
1)	SRCH2B:	PUSHJ	P,CASE		;EXACT MODE SEARCH -- ADJUST CASE
1)	SERCH4:	XORM	D,STAB(CH)	;MARK CHARACTER TO MATCH
1)	SERCH5:	SKIPE	SCESQB		;GATHERING DATA FOR A ^E[...]?
1)		POPJ	P,		;YES
1)		TXZN	F2,S.CTLN	;DOES ^N PRECEDE THIS CHAR POSITION?
1)		JRST	SERCH6		;NO
1)		ANDCAM	D,STAB+BEGPAG	;YES, CLEAR ALL FAKE BITS
1)		ANDCAM	D,STAB+ENDPAG
1)		ANDCAM	D,STAB+SPCTAB
1)	SERCH6:	LSH	D,-1		;MOVE TO NEXT CHAR. POSITION IN MATRIX
1)		SETZM	SCESQB		;(BASE IS 0)
1)		JUMPN	D,SERCH2	;36 CHARS SEEN YET? IF NOT CONTINUE.
1)		JUMPE	B,SERCHI	;TOO MUCH IF STILL ANOTHER CHAR WAITING
1)		ERROR	E.STL
1)	SUBTTL	SCAN INSERT ARGUMENT IF F-SEARCH
1)	SERCHI:	SKIPE	CTGLEV		;ARE WE IN A Q-REG NEST?
1)		JRST	CNTRG2		;YES, GO RESTORE PREV. LEVEL
1)		TXNN	FF,F.SRCH	;F-SEARCHING?
1)		JRST	SERCH1		;NO
1)		TXZ	F2,S.NCCT	;REFRESH ^T FLAG
1)		MOVE	CH,ARGTRM	;GET TERMINATOR TO WATCH FOR
1)		TXZ	FF,F.NNUL	;RESET NON-NULL STRING FLAG
1)		JRST	INSERA		;SCAN INSERT ARGUMENT
1)	SERCHJ:	POP	P,COMBAK	;SAVE COMCNT & CPTR FOR THE INSERTION
1)		POP	P,CPTBAK
1)					;THEN FALL INTO SERCH1
1)	SUBTTL	ACTUAL SEARCH
1)	SERCH1:	MOVE	AA,D		;END OF SEARCH MARKER
1)		MOVE	I,PT		;START SEARCHING AT PT
****
2)141	;Determine whether we can use the previous pattern
2)	SERCHB:	MOVEM	CH,B		;B:=Pattern source string delimiter
2)		MOVEM	CH,ARGTRM	;Save delimiter for FS insertion
2)		SETZM	SCNEST		;Search nest level is zero
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		PUSHJ	P,SKRCH		;Look ahead 1 character
2)		ERROR	E.USR
2)		CAIE	CH,(B)		;Is it the delimiter?
2)		JRST	SERCHT		;No, an argument is given
2)		SKIPL	SRHCTR		;Yes, use previous pattern string
2)					; unless there was none or last had error
2)		ERROR	E.SNA
2)		SKIPN	SCTLGA		; but not if remembered pattern source used ^Gi
2)		JRST	SCH.E		;OK, use previous matrices
2)142	;Move a new pattern source to storage
2)	SERCHT:	TXZ	F2,S.XMAT	;[344] Clear exact match flag
2)		STORE	A,SMATRX,SMATRX+SCLRLN-1,0 ;Clear previous matrices
2)		SETZM	SRHCTR		;Clear source pattern length counter
2)		SETZM	SCTLGA		;Assume pattern source doesn't use ^Gi
2)		MOVE	AA,[POINT 7,SRHARG] ;Point to start of storage area
2)		JRST	SERCHD		;1st character already in
2)	SERCHC:	PUSHJ	P,SKRCH		;Get next character of pattern source
2)		ERROR	E.USR
2)	SERCHD:	CHKEO	EO21,SERCHE	;If EO=1, ^R is just text
2)		CAIE	CH,.CHCNR	;^R?
2)	SERCHE:	CAIN	CH,.CHCNQ	;^Q?
2)		JRST	SERCHG		;Yes, next character is text
2)		CAIN	CH,(B)		;The delimiter?
2)		JRST	SERCH0		;Yes
2)		CAIN	CH,.CHCNT	;^T?
2)		JRST	SERCHU		;Yes
2)		TXNE	F2,S.NCCT	;^T flag on?
2)		JRST	SERCHF		;Yes, ^V and ^W are just text
2)		CAIE	CH,.CHCNV	;^V?
2)		CAIN	CH,.CHCNW	;^W?
2)		TXO	F2,S.XMAT	;Yes, set exact match flag
2)	SERCHF:	AOS	A,SRHCTR	;Bump string counter
2)		CAILE	A,^D80		;Still fit in store?
2)		ERROR	E.STC
2)		IDPB	CH,AA		;Yes, store character
2)		JRST	SERCHC		; and go back for more
2)	SERCHG:	AOS	A,SRHCTR	;Count the ^R (^Q)
2)		CAILE	A,^D80		;Will it fit?
2)		ERROR	E.STC
2)		IDPB	CH,AA		;Yes, store it
2)		PUSHJ	P,SKRCH		;Get next character
2)		ERROR	E.USR
2)		JRST	SERCHF		; and store it as text
2)	SERCHU:	TXC	F2,S.NCCT	;^T, complement control command switch
2)		JRST	SERCHF
2)143		SUBTTL	Searches -- set up search matrix
2)	SERCH0:	TXZ	F2,S.NCCT	;Refresh ^T flag
2)		MOVE	B,SRHCTR	;Set source pattern length counter
2)		MOVE	AA,[POINT 7,SRHARG] ; and pointer
2)		MOVEI	D,0		;Start at beginning of pattern
2)	;Set up a 131 by 36 bit table based on the pattern source.
2)	;The table is implemented as a four word by 36 table, with the first
2)	; 32 bits of the words used for the four portions of the ASCII character
2)	; set (i.e. 0-37, 40-77, 100-137, 140-177) and three of the bits left over
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)	; in the last word used for the "bogus" characters BEGPAG, ENDPAG, and
2)	; SPCTAB.  This is a little harder to set up for single letters in the
2)	; pattern source, but is much easier for ranges and makes the fast search
2)	; algorithm setup much faster.  The table is then rotated into the old
2)	; TECO 36 by 131 bit table for the actual search matrix.
2)	SCH.1:	ILDB	CH,AA		;CH:=Next pattern source character
2)		SOJL	B,SCH.8		;End of string?
2)		MOVEI	T,S2TABL	;Check for control character in string
2)		TXNE	F2,S.NCCT	;^T flag on?
2)		MOVEI	T,S3TABL	;Yes, use restricted table
2)		PUSHJ	P,DISP1		;Go search table, don't return if found
2)		CHKEO	EO21,SCH.4	;Not control, if EO=1, force exact mode
2)		TXNN	F2,S.NCCT	;If ^T flag on, all control characters are legal
2)		PUSHJ	P,CKNCC		;Off, all other control characters are illegal
2)					; (Don't return if any)
2)	SCH.2:	TXNE	F2,S.EMAT	;Forced either match on?
2)		JRST	SCH.3		;Yes, match either
2)		TXNN	F2,S.XMAT	;No, want an exact match?
2)		TXNE	FF,F.PMAT	;No, want global exact match?
2)		JRST	SCH.4		;Asked for exact match
2)	SCH.3:	CAIL	CH,"a"		;Match either, is it lower case?
2)		CAILE	CH,"z"
2)		JRST	.+2		;No
2)		SUBI	CH,"a"-"A"	;Yes, make it upper case
2)		CAIL	CH,"A"		;Is it upper case?
2)		CAILE	CH,"Z"
2)		JRST	SCH.5		;No
2)		MOVSI	TT1,400000	;Yes, convert character to bit of 131
2)		MOVNI	TT,-"@"(CH)	; want - (<ch>-100) for LSH
2)		LSH	TT1,0(TT)	;Position bit to letter range
2)		IORM	TT1,BITMAT+2(D)	;Set match on upper case
2)		IORM	TT1,BITMAT+3(D)	; and lower case characters
2)		JRST	SCH.6
2)144	SCH.4:	PUSHJ	P,CASE		;Exact mode, adjust pattern character case
2)	SCH.5:	MOVSI	T,400000	;Convert character to bit of 131
2)		MOVE	TT,CH		;Copy of character
2)		IDIVI	TT,^D32		;Using 32 bits per word, figure word and bit
2)		ADDI	TT,0(D)		; Word plus current pattern position
2)		MOVNS	TT1		;Negative of remainder for bit shift
2)		LSH	T,0(TT1)	;Position bit within 32 bit range for each word
2)		IORM	T,BITMAT(TT)	; and include it in appropriate word
2)	SCH.6:	SKIPE	SCNEST		;Nested? (^N, ^E[], ^Gi)
2)		POPJ	P,		;Yes, return to caller
2)		ADDI	D,4		;End of a pattern position, on to next
2)		JUMPE	B,SCH.8		;Done if no more characters in pattern source
2)		CAILE	D,^D36*4	; and error if more than 36 positions in pattern
2)		ERROR	E.STL
2)		JRST	SCH.1		;More pattern source, get some
2)	;Finished building the 131 by 36 bit search table
2)	SCH.8:	SKIPE	SCNEST		;In a nest (^E[ with no ] or ^Gi)
2)		POPJ	P,		;Yes, let caller carry on
2)		LSH	D,-2		;Really finished, convert index to pattern length
2)		MOVEM	D,PATLEN	; and save it
2)		MOVNS	SRHCTR		;Flag source pattern length as being legal
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		JRST	ROTATE		;Skip 131 by 36 build subroutines to ROTATE
2)145	;Control character dispatch table for second scan of pattern source
2)	S2TABL:	XWD	CNTLE,.CHCNE	;^E
2)		XWD	CNTLG,.CHBEL	;^G
2)		XWD	CNTLX,.CHCNX	;^X
2)		XWD	CNTLN,.CHCNN	;^N
2)		XWD	CNTLS,.CHCNS	;^S
2)		XWD	CNTLV,.CHCNV	;^V
2)		XWD	CNTLW,.CHCNW	;^W
2)		XWD	CNTLBS,.CHCBS	;^\
2)		XWD	CNTLCF,.CHCCF	;^^
2)	;Shorter table used for ^T on mode starts here
2)	S3TABL:	XWD	CNTLT,.CHCNT	;^T
2)		XWD	CNTLQ,.CHCNQ	;^Q
2)		XWD	CNTLR,.CHCNR	;^R
2)		XWD	CNTLLB,.CHESC	;ESCape
2)		XWD	0,0		;End of list
2)	;Control S matches any separator character (i.e., any character not
2)	; a letter, number, period, dollar, or percent)
2)	CNTLS:	MOVX	T,<XWD	377777,777760> ;All control characters but null (?)
2)		IORM	T,BITMAT(D)	; on
2)		MOVX	T,<XWD	747764,001760> ;All non-symbol special characters
2)		IORM	T,BITMAT+1(D)	; on
2)		MOVX	T,<XWD	400000,000760> ;Upper case range specials
2)		IORM	T,BITMAT+2(D)	; on
2)		MOVX	T,<XWD	400000,000774> ;Lower case range specials + ends of page
2)		IORM	T,BITMAT+3(D)	; on
2)		JRST	SCH.6		;To next character
2)	;Control X matches any single character
2)	CNTLX:	MOVX	T,<XWD	377777,777760> ;All control characters except null (?)
2)		IORM	T,BITMAT(D)	; on
2)		TLO	T,400000	;Plus space @ grave
2)		IORM	T,BITMAT+1(D)	; all specials and numbers
2)		IORM	T,BITMAT+2(D)	; all upper case
2)		IORM	T,BITMAT+3(D)	; all lower case
2)		JRST	SCH.6		;To next character
2)146	;Control R is the same as Control Q (Provided EO > 1)
2)	; except it doesn't cause rubout problems
2)	CNTLR:	CHKEO	EO21,SCH.5	;If EO=1, ^R is just text
2)	;Control Q causes the next character to be taken as text, even if it is
2)	; a control character or the delimiter
2)	CNTLQ:	ILDB	CH,AA		;Get the next character
2)		SOJA	B,SCH.2		; and process it as ordinary text
2)	;Control V causes the next character to be made lower case
2)	;Two Control V's set lower case mode until further notice
2)	CNTLV:	CHKEO	EO21,SCH.5	;If EO=1, ^V is just text
2)		PUSHJ	P,C.V		;Set ^V flags
2)		JRST	SCH.1		; and on to next character
2)	;Control W causes the next character to be taken without case conversion
2)	;Two Control W's set standard case mode until further notice
2)	CNTLW:	CHKEO	EO21,SCH.5	;If EO=1, ^W is just text
2)		PUSHJ	P,C.W		;Set ^W flags
2)		JRST	SCH.1		; and on to next character
2)	;Control \ inverts case match mode, starting at accept either
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)	CNTLBS:	CHKEO	EO21,SCH.5	;If EO=1, ^\ is just text
2)		TXC	F2,S.EMAT	;Complement accept either flag
2)		JRST	SCH.1		; and on to next character
2)	;When searching for ALTmode under EO=1, both ESCape and ALTmode match
2)	CNTLLB:	CHKEO	EO21,.+2	;EO=1?
2)		JRST	SCH.5		;No, accept ESCape only
2)		MOVEI	T,000040	;Yes, mark ALTmode as an acceptable character
2)		IORM	T,BITMAT+3(D)
2)		JRST	SCH.5		; and ESCape
2)	;Control circumflex causes immediately following @[\]^_ to be converted to
2)	; the appropriate character in the lower case range
2)	CNTLCF:	CHKEO	EO21,SCH.5	;If EO=1, ^^ is just text
2)		JUMPE	B,SCH.1		;[344] If no next character, ignore
2)		ILDB	CH,AA		;Get the next character
2)		PUSHJ	P,CVTSPC	;Convert it to lower case if appropriate
2)		SOJA	B,SCH.2		; and go process it
2)147	;Control T inverts the control character interpretation switch
2)	; The initial setting is that all control character commands are active
2)	; With the switch on, only ^Q, ^R, and ^T commands exist, but all other
2)	;  control characters are legal
2)	CNTLT:	CHKEO	EO21,SCH.5	;If EO=1, ^T is just text
2)		TXC	F2,S.NCCT	;Complement current setting
2)		JRST	SCH.1		; and on to next character
2)	;Control N - invert the sense of the following "character", i.e. accept
2)	; anything but the specified character
2)	CNTLN:	MOVSI	T,-4		;Set AOBJN count for the 4 words of this position
2)		HRR	T,D		; of the pattern
2)		PUSH	P,BITMAT(T)	;Save the current status of the pattern (in case
2)					; of ^E[A,^N^EW] for example)
2)		SETZM	BITMAT(T)	;Start over again
2)		AOBJN	T,.-2		;Loop through this position
2)		AOS	SCNEST		;Go up a level in complexity
2)		PUSHJ	P,SCH.1		;Build the table for the character
2)		SOS	SCNEST		;Now less complex
2)		MOVEI	T,4		;Now go back through the 4 words
2)		MOVEI	TT,BITMAT+3(D)	;[341] starting at the high end 'cause of stack
2)	CTLN.1:	SETCM	TT1,0(TT)	; complementing the resulting setting
2)		TRZ	TT1,17		;  (remembering only using 32 bits per word)
2)		POP	P,0(TT)		;Get back the original bits
2)		IORM	TT1,0(TT)	;Include the new bits wanted
2)		SUBI	TT,1		;Back up to previous word (need a ASOBJN)
2)		SOJG	T,CTLN.1	; and loop through all 4 words
2)		JRST	SCH.6		;Done this "character" position
2)148	;Control Gi causes the text in Q register i to be substituted into
2)	; the search string at this point
2)	CNTLG:	CHKEO	EO21,SCH.5	;If EO=1, ^G is just text
2)		ILDB	CH,AA		;Get name of Q register
2)		SOJL	B,CNTLGR	;If none there, error
2)		PUSH	PF,AA		;Save source pointer (using Q stack)
2)		PUSH	PF,B		; and count
2)		AOS	SCNEST		;Bump search nest level
2)		PUSH	P,CPTR		;Set up CPTR in case of error (PAIN!)
2)		MOVEM	AA,CPTR		; so that error will get the right Q name
2)		PUSHJ	P,QREGV2	;Figure out which Q register
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		PUSHJ	P,QTEXEI	;Set up to read from it
2)		PUSHJ	P,GTQCNT	;Set how long it is
2)		POP	P,CPTR		;Restore CPTR
2)		MOVE	TT,I		;Set up new byte pointer from bogus PT
2)		IDIVI	TT,5
2)		HLLZ	AA,BTAB-1(TT1)	;Get byte pointer value
2)		HRR	AA,TT		; and quotient is address
2)		MOVE	B,C		;Copy the string length from GTQCNT
2)	CTLG.1:	PUSHJ	P,SCH.1		;Go process the string as pattern source
2)		JUMPLE	B,CTLG.2	;Done yet?
2)		ADDI	D,4		;No, on to next character position
2)		CAILE	D,^D36*4	;Full?   (see SCH.6)
2)		ERROR	E.STL
2)		JRST	CTLG.1		;No, get next
2)	CTLG.2:	POP	PF,B		;Restore to scan after the ^Gi
2)		POP	PF,AA
2)		SOS	SCNEST		;Nesting is back down one
2)		JRST	SCH.6		; and go do next character
2)	CNTLGR:	ERROR	E.ICG
2)149	;Control E commands all go through here
2)	CNTLE:	CHKEO	EO21,SCH.5	;If EO=1, ^E is just text
2)		ILDB	CH,AA		;Get character after the ^E
2)		SOJL	B,CNTLER	;If none, an error
2)		MOVEI	T,S4TABL	;Set to search for ^E command characters
2)		PUSHJ	P,DISPAT	; and look for legal commands (no return if good)
2)	CNTLER:	ERROR	E.ICE
2)	;Dispatch table for ^E commands
2)	S4TABL:	XWD	CNTLEA,"A"	;^EA	accept any alpha
2)		XWD	CNTLEV,"V"	;^EV	accept any lower case alpha
2)		XWD	CNTLEW,"W"	;^EW	accept any upper case alpha
2)		XWD	CNTLED,"D"	;^ED	accept any digit
2)		XWD	CNTLEL,"L"	;^EL	accept any end of line character
2)		XWD	CNTLES,"S"	;^ES	accept a string of spaces and/or TABs
2)		XWD	CNTLEN,74	;^E<NNN> accept the ACSII character represented by <nnn>
2)		XWD	CNTLEB,133	;^E[A,B,C] accept A or B or C or ...
2)		XWD	0,0		;End of list
2)	;Control EA - accept any alphabetic character
2)	CNTLEA:	MOVX	T,<XWD	377777,777000> ;All letters
2)		IORM	T,BITMAT+2(D)	; upper case on
2)	;Control EV - accept any lower case alphabetic character
2)	CNTLEV:	MOVX	T,<XWD	377777,777000> ;All letters
2)		IORM	T,BITMAT+3(D)	; lower case on
2)		JRST	SCH.6		; and on to next character
2)	;Control EW - accept any upper case alphabetic character
2)	CNTLEW:	MOVX	T,<XWD	377777,777000> ;All letters
2)		IORM	T,BITMAT+2(D)	; upper case on
2)		JRST	SCH.6		; and on to next character
2)	;Control ED - accept any digit
2)	CNTLED:	MOVX	T,<XWD	000003,776000> ;All digits
2)		IORM	T,BITMAT+1(D)	; on
2)		JRST	SCH.6		; and on to next character
2)	;Control EL - accept any end of line character (including buffer end)
2)	CNTLEL:	MOVX	T,<XWD	000340,000000>	;LF, VT, and FF
2)		IORM	T,BITMAT(D)	; on
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		MOVX	T,<XWD	000000,000004> ; end of page
2)		IORM	T,BITMAT+3(D)	; on
2)		JRST	SCH.6		; and on to next character
2)150	;Control ES - accept any string of spaces and/or TABs
2)	CNTLES:	MOVX	T,<XWD	000400,000000> ;A TAB
2)		IORM	T,BITMAT(D)	; on
2)		MOVX	T,<XWD	400000,000000> ;A space
2)		IORM	T,BITMAT+1(D)	; on
2)		MOVX	T,<XWD	000000,000002> ;The special space/tab bit
2)		IORM	T,BITMAT+3(D)	; on
2)		JRST	SCH.6		; and on to next character
2)	;Control E[a,b,c,...] - accept any of "characters" a or b or c
2)	CNTLEB:	AOS	SCNEST		;Up one nest level (down?)
2)	CTEB.1:	PUSHJ	P,SCH.1		;Process the next "character"
2)		ILDB	CH,AA		;Get the next pattern source (if already off end
2)					; of string, will catch that anyway at .+1)
2)		SOJL	B,CNTLER	;Error if off end of string
2)		CAIN	CH,","		;Another "character" to come?
2)		JRST	CTEB.1		;Yes, go include it too
2)		CAIE	CH,"]"		;No, correct ending to ^E command?
2)		ERROR	E.ICE
2)		SOS	SCNEST		;Yes, one fewer level of nesting now
2)		JRST	SCH.6		; and have finished a "character" position
2)	;Control E<nnn> - accept the ASCII character whose octal representation is nnn
2)	CNTLEN:	MOVEI	A,0		;Clear number accumulator
2)	CTEN.1:	ILDB	CH,AA		;Get an oit
2)		SOJL	B,CNTLER	;Error if run out
2)		CAIN	CH,">"		;The other end of the number?
2)		JRST	CTEN.2		;Yes, done
2)		CAIL	CH,"0"		;Is it an oit?
2)		CAILE	CH,"7"
2)		ERROR	E.ICE
2)		LSH	A,3		;Yes, scale up the previous value
2)		ADDI	A,-60(CH)	; and add in the new oit
2)		JRST	CTEN.1		; then go try for more
2)	CTEN.2:	CAILE	A,177		;Make sure it's legitimate
2)		ERROR	E.ICE
2)		MOVE	CH,A		;Copy the result as the character
2)		JRST	SCH.5		; and go set the appropriate bit
2)151	;Now we need to build up TECO's standard search table, a 36 bit by 131. word
2)	; table with each pattern position being a slice of the 131 words, with all of
2)	; the acceptable characters for each position marked by a bit on in the word
2)	; reached by using the character directly as an index into the table (the extra
2)	; 3 words are for "beginning of page", "end of page", and "this position matches
2)	; strings of spaces and/or TABs").  At the same time we will set up the two
2)	; simple tables for the fast search algorithm (DELTA0 and DELTA1), since it is
2)	; much quicker to do this now if we use the fast one.
2)	;Since DELTA0 and DELTA1 are the same at all points except for entries which
2)	; are not needed in DELTA1, we will build them as one.
2)	;The conversion is done by rotating the 131. bit by 36 word table 90 degrees.
2)	;Since that table was built first (instead of the normal TECO table as in
2)	; standard TECO), the loop is only needed for as many times as there were
2)	; pattern characters (doing it in the other order requires a loop through all
2)	; 131 characters with no possibility for less).
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)	;AC usage: (Other than poor, I want P1-P4)
2)	;D	AOBJN pointer with "virtual" index into 131 by 36 table (word index/4)
2)	;I	actual word index into 131 by 36 table
2)	;A	bit mask specifying pattern position we're currently doing
2)	;AA	AOBJN pointer into the 131 bits of an entry of the 131 by 36 table
2)	;TT+TT1	current words worth of the 131 bits and the JFFO result
2)	SLARGE==10777777		;A special large number for DELTA0 used for
2)					; the characters defining the rightmost pattern
2)					; position
2)	ROTATE:	MOVN	D,PATLEN	;Get the number of pattern positions used
2)		HRLZS	D		; as an AOBJN pointer
2)		MOVEI	I,0		;Clear the actual index
2)		MOVE	A,PATLEN	;Initialize DELTA0 and DELTA1 to the number
2)		MOVEM	A,DELTA0	; of positions in the pattern
2)		MOVE	AA,[XWD	DELTA0,DELTA0+1]
2)		BLT	AA,DELTA0+SPCTAB
2)		SUBI	A,1		;Pattern length - 1 is the distance we are from
2)		MOVEM	A,ROTLEN	; the end of the pattern at the moment
2)		MOVSI	A,400000	;Start mask at first pattern position
2)152	ROTA.1:	MOVSI	AA,-BITMLN	;Set AOBJN pointer into the 131 bits
2)	ROTA.2:	SKIPE	TT,BITMAT(I)	;Get 32 of those, seeing if any are on
2)	ROTA.3:	JFFO	TT,[		; and if any are, see which the first one is
2)			MOVSI	CH,400000	;Got one, make a mask to turn it off
2)			MOVN	T,TT1
2)			LSH	CH,0(T)
2)			ANDCM	TT,CH		; and do so
2)			ADDI	TT1,0(AA)	;Add 0, 32, 64, or 96 to the bit number
2)			IORM	A,SMATRX(TT1)	; and turn on the position bit for the character
2)			SKIPN	CH,ROTLEN	;Get the current distance from the right end of the pattern
2)			MOVX	CH,SLARGE	;At the right, change to the special number
2)			MOVEM	CH,DELTA0(TT1)	;Set that in fast loop table
2)			JRST	ROTA.3		;On to next bit
2)			]
2)		ADDI	I,1		;Finished a word of the 131 bit string
2)		ADDI	AA,^D31		;Next word is 32 farther into the 36 by 131 table
2)		AOBJN	AA,ROTA.2	;Loop until all 131 bits done
2)		LSH	A,-1		;On to the next pattern mask position
2)		SOS	ROTLEN		; and distance from the end
2)		AOBJN	D,ROTA.1	; and loop through all used pattern position
2)153	;Now determine which search method we will use.  If ^ES appeared we have to use
2)	; the old slow method.  Initially if we need to match BEGPAG or ENDPAG, we will
2)	; use the old method.  Also we will arbitrarily select 3 as the shortest string
2)	; which will benefit from using the new search.  As an aid, turn off the BEGPAG
2)	; and ENDPAG bits which don't appear at the appropriate end of the pattern,
2)	; since they obviously won't match except there.
2)	FIGSCH:	SETZB	A,SCHTYP	;Assume an old style search
2)		MOVN	D,PATLEN	;Generate a bit mask for the last pattern
2)		MOVSI	AA,400000	; position used in this search
2)		ANDM	AA,SMATRX+BEGPAG; (with a side effect of clearing extra begin page bits)
2)		LSH	AA,1(D)
2)		MOVE	D,PATLEN	;Now see how long the pattern is
2)		CAILE	D,2		;If it is fewer than 3 positions long,
2)		SKIPE	SMATRX+SPCTAB	; or if there were any ^ES positions,
2)		JRST	SCH.E		; just go use the old search
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		ANDM	AA,SMATRX+ENDPAG;We know pattern is longer than 1, so clear extra end page bits
2)		SKIPN	SMATRX+BEGPAG	;If either end of buffer will match,
2)		SKIPE	SMATRX+ENDPAG	; ...
2)		JRST	SCH.E		; go use old search
2)		SETOM	SCHTYP		;We win with the new one, remember that in case
2)					; this was an nSFOO$ type
2)154	;We are going to use the new search, set up the more costly DELTA2 table.
2)	;This table is based on the arrangement of characters in the pattern.
2)	;It uses the existence (or non-existance) of matching substrings in the
2)	; pattern to be able to shift the pattern farther than would be indicated by
2)	; DELTA1, e.g. if the pattern is ACACACACACAABC and the part of the searched
2)	; string being examined is CABC, DELTA1 will only shift the pattern right 3
2)	; positions, while "looking" at the pattern will tell a human observer that
2)	; the pattern can be shifted its whole length without missing any possible
2)	; matches.
2)	;A few bits in B for use during the DELTA2 setup
2)	NEDSET==1B35		;This position of DELTA2 still needs setting up
2)	WNTOFF==1B34		;We shifted off the end of the pattern this pass
2)	FSTIME==1B33		;This is the first pass - use a special value instead of
2)				; having to initialize the index matrix (INDMAT)
2)	;AC usage (see comment at ROTATE)
2)	;A	the highest entry currently being used in INDMAT
2)	;AA	a number used to indicate how far the pattern can be shifted when we
2)	;	 find a mismatch between sub-pattern strings
2)	;B	used for the above flag bits
2)	;C	index into INDMAT for updates to it as matches occur in sub-patterns
2)	;CH	index into INDMAT for loop
2)	;I	index into pattern (*4 since 4 words per pattern position)
2)	;J	temporary index into pattern (also *4)
2)	;We want to look for sub-strings in the pattern matching rightmost sub-strings
2)	; of the pattern.  If none are found, then as in the above example when more than
2)	; one pattern position has been matched we know we can shift farther than to
2)	; the next occurance of single pattern characters.  If some matches are found
2)	; then we can try them next immediately.
2)	;The examination is implemented by using an array of pointers (indices into
2)	; the pattern) (INDMAT), stored in decreasing order and overwritten each pass
2)	; by the pointers for the next pass.  When I points to the beginning of the
2)	; rightmost n characters of the pattern, then each pointer in INDMAT points
2)	; to the beginning of a sub-string which matches those n characters.  When
2)	; INDMAT has been emptied, all of these sub-strings have been matched and the
2)	; rest of DELTA2 can be set to shift the pattern its entire length.  The
2)	; initial setting of INDMAT (implemented by FSTIME) is such that every pattern
2)	; position is examined on the first pass.
2)		MOVEI	A,-1(D)		;Start the top of INDMAT at pattern length - 1
2)		MOVEI	AA,-1(D)	;Start the non-match shift at pattern length
2)					; (adjusted because a 0-index is subtracted from it)
2)		MOVX	B,NEDSET!FSTIME	;The first setting is needs setting, first pass,
2)					; and haven't gone off the end
2)		MOVEI	I,-1(D)		;Start at right end of pattern (0-indexed)
2)		LSH	I,2		; adjusted for being 4 word bit strings
2)		MOVEI	D,0(I)		;Set initial INDMAT value to shift all less 1
2)					; remembering the first SUBI 4
2)155	SET2.2:	MOVEI	C,0		;Start used INDMAT entry index off at none
2)		MOVN	CH,A		;Make an AOBJN pointer for loop through INDMAT
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		HRLZS	CH
2)	SET2.3:	TXNN	B,FSTIME	;Get the appropriate INDMAT entry
2)		SKIPA	D,INDMAT(CH)	;Not the first time, use the real array
2)		SUBI	D,4		;The first pass, use our fake value
2)		MOVE	TT,BITMAT(I)	;Figure out if any of the characters matched
2)		AND	TT,BITMAT(D)	; by the position we are looking at at highest
2)		MOVE	TT1,BITMAT+1(I)	; level (I) also match at the position indicated
2)		AND	TT1,BITMAT+1(D)	; by the substring table (INDMAT - D)
2)		OR	TT,TT1
2)		MOVE	TT1,BITMAT+2(I)	;(AND the strings together, if result is zero
2)		AND	TT1,BITMAT+2(D)	; then no characters match)
2)		OR	TT,TT1
2)		MOVE	TT1,BITMAT+3(I)
2)		AND	TT1,BITMAT+3(D)
2)		OR	TT,TT1
2)		JUMPE	TT,SET2.5	;If zero, no matches here
2)		JUMPE	D,SET2.4	;Did we just match with the leftmost position?
2)		MOVEI	T,-4(D)		;No, update the index matrix to check the position
2)		MOVEM	T,INDMAT(C)	; in front of this for finding substrings
2)		AOSA	C		;Remember we used another element of INDMAT
2)	SET2.4:	TXO	B,WNTOFF	;We matched at the left end, that goes off the end
2)	SET2.5:	TXNN	B,NEDSET	;Do we still need to set up this position?
2)		JRST	SET2.6		;No, skip all the logical stuff
2)		MOVE	TT,BITMAT(D)	;Yes, then we need to figure out if the substring
2)		ANDCM	TT,BITMAT(I)	; indicated position (D) character set is a
2)		MOVE	TT1,BITMAT+1(D)	; subset of the high level (I) character set
2)		ANDCM	TT1,BITMAT+1(I)	; (Done by D .AND. .NOT. I .NE. 0)
2)		OR	TT,TT1
2)		MOVE	TT1,BITMAT+2(D)
2)		ANDCM	TT1,BITMAT+2(I)
2)		OR	TT,TT1
2)		MOVE	TT1,BITMAT+3(D)
2)		ANDCM	TT1,BITMAT+3(I)
2)		OR	TT,TT1
2)		JUMPE	TT,SET2.6	;Skip out if it's not
2)		TXZ	B,NEDSET	;It is, don't do this again
2)		MOVNI	T,4(D)		;We now know that we can shift at least as much
2)		ASH	T,-2		; as the distance from here to the right end
2)		ADD	T,PATLEN	; since no substrings matched from here to there
2)		MOVE	TT1,I		;Figure out where to put it with
2)		LSH	TT1,-2		; a word table
2)		MOVEM	T,DELTA2(TT1)	;Put it there
2)156	SET2.6:	AOBJN	CH,SET2.3	;Loop through current index matrix
2)		TXZ	B,FSTIME	;Finished the first pass
2)		MOVE	A,C		;Remember the highest index matrix element used
2)		TXOE	B,NEDSET	;Do we still need to set this position?
2)		JRST	[			;Yes, then we can shift it based on how
2)			MOVE	T,AA		; far the highest level loop is from
2)			MOVE	TT,I		; the right end of the pattern
2)			LSH	TT,-2
2)			SUB	T,TT
2)			ADD	T,PATLEN
2)			MOVEM	T,DELTA2(TT)
2)			JRST	.+1
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)			]
2)		TXZE	B,WNTOFF	;Did this pass go off the end of the pattern
2)		JRST	[			;Yes, need to adjust the amount we
2)			MOVEI	AA,-4(I)	; can shift when NEDSET is used
2)			LSH	AA,-2		; immediately above
2)			JRST	.+1
2)			]
2)		SUBI	I,4		;Now look a position to the left of last loop
2)		SKIPE	A		; unless there is no need to cause no matches
2)		JUMPGE	I,SET2.2	; or because we looked at all  of them
2)		JUMPL	I,SET2.E	;Did we look at all of them?
2)		ADD	AA,PATLEN	;No, need to fill in the rest with the largest
2)		LSH	I,-2		; possible number based on how far we are from
2)		SUB	AA,I		; the right end of the pattern and how far the
2)					; setup got
2)		MOVEM	AA,DELTA2(I)
2)		ADDI	AA,1		;Each position to the left can shift one farther
2)		SOJGE	I,.-2
2)	SET2.E:
2)157	;Now, if F search, scan insert argument
2)	SCH.E:	TXNN	FF,F.SRCH	;F? search?
2)		JRST	WCHSCH		;No, go start search
2)		TXZ	F2,S.NCCT	;Refresh ^T flag
2)		MOVE	CH,ARGTRM	;Get delimiter back
2)		TXZ	FF,F.NNUL	;Reset non-null string flag
2)		JRST	INSERA		;Go scan insert argument
2)	SERCHJ:	POP	P,COMBAK	;Save pointers for the insertion (COMCNT)
2)		POP	P,CPTBAK	; (CPTR)
2)					; and fall into search
2)	;Here to call the appropriate search
2)	WCHSCH:	TXNN	F2,S.MINS	;If this time is minus search, force old search
2)		SKIPN	SCHTYP		;Which one are we using?
2)		JRST	SLOSCH		;The old one
2)	;	JRST	FSTSCH		;The new one, fall into it
2)158		SUBTTL	Searches -- New fast search routine
2)	;This is an implementation of the algorithm of Boyer and Moore, published
2)	; in the Communications of the ACM, October 1977, Vol. 20 Number 10, page 762.
2)	; This article serves as the primary documentation for this routine (and the
2)	; DELTA? table setup routines).
2)	;This is the actual search, which uses the numbers in DELTA0, DELTA1, and
2)	; DELTA2 for determining where in the searched string to look.  The actual
2)	; character comparisons are done in the tried and true TECO way, with TECO's
2)	; original bit map (there can't be a better way).
2)	;AC usage (ditto)
2)	;A	During the slow loop, counts down through the pattern
2)	;AA	Contains the bit mask for the last pattern position
2)	;B	The base register into the byte pointer table, including (C)
2)	;C	A negative index into the byte pointer table
2)	;D	The length of the string to be searched
2)	;T	During the slow loop, shifts the bit mask through the pattern
2)	;TT	The word address of the first byte of the portion of the searched
2)	;	 string currently being examined
2)	;TT1	The value of C at the start of the current FAST and SLOW loop execution
2)	;The bytes in the searched string are obtained through a window by a table of
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)	; constant byte pointers indexed into by B, C, and TT.
2)	FSTSCH:	MOVN	T,PATLEN	;Generate the bit mask for the rightmost
2)		MOVSI	AA,400000	; pattern position
2)		LSH	AA,1(T)
2)		MOVE	I,PT		;Start searching at .
2)		MOVE	D,UPPERB	;Figure out how many characters are to be searched
2)		SUB	D,I		; i.e. the length of the searched string
2)		ADDI	D,1		;*Note that all this code must use full word
2)					; arithmetic when referring to I, since its
2)					; maximum value is 128K * 5 characters*
2)		TXNE	FF,F.ARG	;Is this an nSFOO$$?
2)		JUMPLE	E,FND		;Yes, done if we've found that many
2)		MOVX	B,<0(C)>	;Start the byte pointer base at 0(C)
2)	FSTS.1:	MOVE	TT,I		;Convert I into a word and byte address
2)		IDIVI	TT,5
2)		MOVE	T,D		;Figure the current byte pointer window length
2)		CAILE	T,SCHBPL	; the length of string left
2)		MOVEI	T,SCHBPL	; or the window size, whichever is less
2)					;Fall through to next page...
2)159		MOVN	C,T		;Copy that as negative index into table
2)		ADD	T,TT1		;Add the byte in word offset
2)		ADDI	T,SCHBPT-1	; plus the address of the start of the table
2)		HRR	B,T		; equals the base address to be negatively
2)					; indexed from
2)		ADD	C,PATLEN	;This search starts at the right end of the pattern
2)		JUMPG	C,NOFND3	;If that is to the right of the last character
2)					; of the string, then we didn't find it
2)		MOVE	TT1,C		;Save C at the start of the loop, so we can
2)					; tell how many characters we've skipped
2)	;FAST:				;The fast loop in the ACM article
2)	FSTS.3:	LDB	CH,@B		;Get a character from the searched string
2)		ADD	C,DELTA0(CH)	;Shift down based on its existance in the pattern
2)		JUMPLE	C,FSTS.3	; and loop unless it is in the rightmost position
2)					; i.e. if we just had a match (see LARGE)
2)		TLON	C,-1		;Did it match (SLARGE makes the left half 7)
2)		JRST	FSTS.5		;No, we used up our window (left half is zero)
2)		MOVE	T,AA		;Start at right end of pattern bit mask
2)		MOVE	A,PATLEN	; for that many characters
2)	;SLOW:				;SLOW loop in ACM article
2)	FSTS.4:	SOJLE	A,FSTS.6	;If we run out of pattern characters, it matched
2)		LSH	T,1		;Set bit mask to previous pattern position
2)		LDB	CH,@B		;Get the next searched string character
2)		TDNE	T,SMATRX(CH)	;Does it match?
2)		SOJA	C,FSTS.4	;Yes, back up byte pointer index one and loop
2)		MOVE	T,DELTA0(CH)	;No, figure which table shift us the most
2)		TLNN	T,-1		;If we just got SLARGE, use DELTA2 always
2)		CAMGE	T,DELTA2-1(A)
2)		MOVE	T,DELTA2-1(A)
2)		ADD	C,T		;Update our current position by that much
2)		JUMPL	C,FSTS.3	; and go back to FAST unless we exceeded window
2)160	;Search failed in this window, see what to do
2)	FSTS.5:	JUMPLE	D,NOFND3	;Not found if there is no searched string left
2)		SUB	C,TT1		;See how many characters we skipped
2)		ADDI	I,0(C)		;Update current position by that much
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		SUBI	D,0(C)		; and amount left by that much
2)		JRST	FSTS.1		; and try again
2)	;Here when string found, decide where the right end of the pattern is
2)	FSTS.6:	SUB	C,TT1		;How much we moved
2)		ADD	I,C		;Adjust pointer by that much
2)		ADD	I,PATLEN	; but we scanned back by that much too
2)		MOVEM	I,PT		;Update . to that point
2)		ADD	I,PATLEN	;Now get to right end of pattern
2)		JRST	FND		;We did it
2)	;Build the fixed byte pointer table.  The following code is done again
2)	; under an XLIST
2)	SCHBPL==^D200			;Length of window of byte pointers
2)	$A==0				;Start the base address at zero
2)	;SCHBPT:REPEAT	SCHBPL/5+1,<	;Build 5 for each word of bytes, plus extra for
2)	;				; the fact that the first byte may be one of 5
2)	;	$M==177B6		;A mask for the current character of the word
2)	;		REPEAT	5,<		;For each word of bytes
2)	;			POINTR	$A(TT),$M	;Build 5 pointers
2)	;		$M==$M_-7			;Moving mask each time
2)	;		>
2)	;	$A==$A+1		;To next word
2)	;	>
2)		XLIST
2)	SCHBPT:
2)	IF1,<
2)		BLOCK	SCHBPL+5
2)	>
2)	IF2,<
2)		REPEAT	SCHBPL/5+1,<
2)	$M==177B6
2)		REPEAT	5,<
2)		POINTR	$A(TT),$M
2)	$M==$M_-7
2)	>
2)	$A==$A+1
2)	>
2)	>
2)		LIST
2)161		SUBTTL	Searches -- Old slow but sure routine
2)	SLOSCH:
2)	SERCH1:	MOVN	T,PATLEN	;Figure old end of search comparator
2)		MOVSI	AA,400000
2)		LSH	AA,0(T)		;Which is bit one past end of pattern
2)		MOVE	I,PT		;START SEARCHING AT PT
**************
1)1		SKIPL	STAB+BEGPAG	;& 1ST SERCH CHAR = BEG OF BUFR CHAR?
1)		JRST	S3		;NO
****
2)161		SKIPL	SMATRX+BEGPAG	;& 1ST SERCH CHAR = BEG OF BUFR CHAR?
2)		JRST	S3		;NO
**************
1)1	S3:	CAML	I,LOWERB
1)		CAMLE	I,UPPERB	;NO. REACHED TOP OF BUFFER?
1)		JRST	NOFND		;YES.
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		MOVSI	D,400000	;START SEEKING MATCH FOR 1ST CHAR
1)		MOVE	TT1,TT		;SET DYNAMIC PTR=STATIC PTR
1)		JRST	S4A
1)	S4:	TDNE	D,STAB+SPCTAB	;IS SPACE/TAB STRING BIT SET?
1)		JRST	SPTB		;YES
1)		CAML	I,UPPERB	;DONT ALLOW I OUTSIDE BOUNDS
1)		JRST	S4D		;...
****
2)161	S3:	MOVSI	D,400000	;START SEEKING MATCH FOR 1ST CHAR
2)		MOVE	TT1,TT		;SET DYNAMIC PTR=STATIC PTR
2)		JRST	S4A
2)	S4:	TDNE	D,SMATRX+SPCTAB	;IS SPACE/TAB STRING BIT SET?
2)		JRST	SPTB		;YES
2)	S4E:	CAML	I,UPPERB	;DON'T ALLOW I OUTSIDE BOUNDS
2)		JRST	S4D		;...
**************
1)1		TDNE	D,STAB(CH)	;IS IT A MATCH?
1)		JRST	S4		;YES, GO TO NEXT TABLE ENTRY.
****
2)161		TDNE	D,SMATRX(CH)	;IS IT A MATCH?
2)		JRST	S4		;YES, GO TO NEXT TABLE ENTRY.
**************
1)1		TXNN	F2,S.MINS	;BACKWARDS SEARCH
1)		AOSA	I,PT		;NO MATCH. PT:=PT+1
1)		JRST	SR4A
1)		CAML	I,UPPERB	;TOO FAR?
1)		JRST	NOFND3
1)		IBP	TT		;MOVE STATIC BYTE PTR
****
2)161		TXNE	F2,S.MINS	;BACKWARDS SEARCH
2)		JRST	SR4A
2)		CAML	I,UPPERB	;TOO FAR?
2)		JRST	NOFND
2)		AOS	I,PT
2)		IBP	TT		;MOVE STATIC BYTE PTR
**************
1)1		JRST	NOFND3
1)		ADD	TT,[7B5]	;PREVIOUS BYTE (MAYBE)
****
2)161		JRST	NOFND
2)		ADD	TT,[7B5]	;PREVIOUS BYTE (MAYBE)
**************
1)1	SUBTTL	SEARCH STRING FOUND
1)	FND:	SETOM	SFINDF		;NO. SFINDF:=-1
****
2)162	;Skip over a string of spaces and/or TABs while searching
2)	SPTB:	CAIE	CH," "		;But was the character we matched a space
2)		CAIN	CH,.CHTAB	; or a TAB?
2)		JRST	SPTB.1		;Yes, then accept more
2)		JRST	S4E		;No, look at next pattern position
2)	SPTB.1:	ADDI	I,1		;Advance to next buffer location
2)		CAML	I,UPPERB	;End of buffer?
2)		JRST	S4C		;Yes, no more then
2)		MOVEM	TT1,ERR1	;Save current byte pointer (using ERR1 as temp)
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		ILDB	CH,TT1		;Look at next character
2)		CAIE	CH," "		;Is it a space?
2)		CAIN	CH,.CHTAB	; or a TAB?
2)		JRST	SPTB.1		;Yes, keep on trucking
2)		MOVE	TT1,ERR1	;No, end of string, restore pointer to last space/tab
2)		JRST	S4C		; and continue search
2)163		SUBTTL	Searches -- pattern found
2)	FND:	SETOM	SFINDF		;NO. SFINDF:=-1
**************
1)1		CAMLE	I,SAVEAC	;LEGAL FIND?
1)		SOSA	I,PT
1)		SOSA	I,PT
1)		JRST	S1
1)	NOTMIN:	MOVEM	I,PT		;ELSE GO FORWARD
1)		SOJG	E,S1		;FIND IT N TIMES?
1)		MOVEM	B,PT
****
2)163	;[342] Test removed since upper-bound was set to PT at the start.
2)	;[342]	CAMLE	I,SAVEAC	;LEGAL FIND?
2)	;[342]	SOSA	I,PT
2)		SOSA	I,PT
2)		JRST	WCHSCH		;No, continue search
2)	NOTMIN:	MOVEM	I,PT		;ELSE GO FORWARD
2)		SOJG	E,WCHSCH	;Try again if haven't found it n times
2)		MOVEM	B,PT
**************
1)1		SUBI	C,(A)		;INSERT MINUS DELETE
1)		MOVNS	A		;SET PT TO BEGINNING OF STRING FOUND
****
2)163		SUB	C,A		;[321]INSERT MINUS DELETE
2)		MOVNS	A		;SET PT TO BEGINNING OF STRING FOUND
**************
1)1		SKIPL	(P)		;IN AN ITERATION?
1)		JRST	RET		;NO, RETURN NO VALUE
****
2)163		CHKEO	EODEC,FND4	;[344] IF old TECO, must check for < ... >
2)		JRST	RET		;[344] Don't return a value
2)	FND4:	SKIPL	(P)		;IN AN ITERATION?
2)		JRST	RET		;NO, RETURN NO VALUE
**************
1)1	SUBTTL	AUTOTYPE AFTER SUCCESSFUL SEARCHES
1)	;IF AUTOF IS NON-ZERO
****
2)164		SUBTTL	Searches -- Autotype after succesful searches
2)	;IF AUTOF IS NON-ZERO
**************
1)1	NOFND:	TDNN	D,STAB+ENDPAG	;ENDPAG GOOD FOR A MATCH HERE?
1)		JRST	NOFND3		;NO
1)		LSH	D,-1		;YES, BUT ONLY IF THIS IS LAST SRH CHAR
1)		CAMN	D,AA
1)		JRST	FND		;ENDPAG MATCHES!
****
2)165		SUBTTL	Searches -- Pattern not found in this buffer
2)	NOFND:	TDNN	D,SMATRX+ENDPAG	;[344] ENDPAG GOOD FOR A MATCH HERE?
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)		JRST	NOFND3		;NO
2)		CAMN	I,Z		;[344] Yes, but only if we're at Z
2)		JRST	FND		;ENDPAG MATCHES!
**************
1)1		TXNE	F2,S.MINS	;THIS IS ALWAYS S SEARCH
1)		JRST	RESTPT
1)		TXNE	FF,F.NSRH+F.LARW	;S SEARCH?
1)		JRST	NOFND1		;NO.
1)	RESTPT:	MOVE	A,SAVEAC	;GET OLD PT
1)		MOVEM	A,PT		;RESTORE IT
1)	BEGIN1:	TXZN	FF,F.COLN	;YES. COLON MODIFIER?
1)		JRST	NOFND2		;NO
1)	BEGIN2:	TXZ	FF,F.NSRH+F.LARW	;YES.
1)		TXNN	FF,F.SRCH	;F-SEARCH?
1)		JRST	BEGIN		;NO, RETURN VALUE OF 0
1)		MOVE	CH,ARGTRM	;GET INSERT TERMINATOR
1)		TXZN	FF,F.NNUL	;WAS IT A NULL INSERT?
1)		CAIE	CH,.CHESC	;YES, WAS IT AN ALTMODE TERMINATOR?
1)		JRST	BEGIN		;NO, RETURN 0 VALUE
1)		JRST	ALTM1		;YES, FS...$$ TERMINATES EXECUTION
1)	NOFND1:	MOVEM	E,SRHCNT	;YES. SAVE SEARCH COUNT
1)		MOVEM	AA,SRHAA	;& SAVE END OF MATRIX MARKER
1)		MOVEI	B,1		;PUNCH 1 PAGE ONLY
1)		SETZ	T,		;TELL PUNCHER TO APPEND FORM FEED
1)		TXNE	FF,F.NSRH	;N SEARCH?
1)		PUSHJ	P,PUN1		;YES. PUNCH THIS BUFFER AND REFILL IT.
1)		TXNN	FF,F.IOPN	;ANY INPUT FILE?
****
2)165		TXNN	F2,S.MINS	;See if this needs to look at a new buffer
2)		TXNN	FF,F.NSRH!F.LARW; Minus searches never do, but N and _ do
2)		JRST	RESTPT		;No new buffer, the search lost
2)		MOVEM	E,SRHCNT	;YES. SAVE SEARCH COUNT
2)		MOVEI	B,1		;PUNCH 1 PAGE ONLY
2)		TXNE	FF,F.NSRH	;N SEARCH?
2)		PUSHJ	P,PUNCHA	;YES. PUNCH THIS BUFFER AND REFILL IT.
2)		TXNN	FF,F.IOPN	;ANY INPUT FILE?
**************
1)1		MOVE	D,SRHAA		;RESTORE END OF STRING MARKER
1)		JRST	SERCH1		;RESUME SEARCH
1)	NOFND2:	SKIPGE	(P)		;IN AN ITERATION?
1)		JRST	BEGIN2		;YES. RETURN VALUE OF 0
1)		ERROR	E.SRH
1)	SRHMOD:	EXP	SRCHSW		;DEFAULT SEARCH MODE
1)	;CNTR S MATCHES ANY SEPARATOR CHARACTER (I.E., ANY CHARACTER NOT
1)	;A LETTER, NUMBER, PERIOD, DOLLAR SIGN OR PER CENT SYMBOL)
1)	CNTRS:	MOVE	T,[-STABLN+3,,1]	;SET ALL CURRENT BITS EXCEPT NULL & SPCTAB
1)		PUSHJ	P,SETSTB	;& ENDPAG, BUT DO INCLUDE BEGPAG
1)		XORM	D,STAB+"."	;NOW, SCRATCH ALL SYMBOL CHARS
1)		XORM	D,STAB+"%"
1)		XORM	D,STAB+"$"
1)		MOVE	T,[-^D10,,"0"]	;DIGITS
1)		PUSHJ	P,SETSTB
1)	CNTLEA:	MOVE	T,[-^D26,,"A"]	;UC CHARS (ENTRY FOR ^EA)
1)		PUSHJ	P,SETSTB
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)	CNTLEV:	MOVE	T,[-^D26,,"A"+" "]	;LC CHARS (ENTRY FOR ^EV)
1)		JRST	CNTRXX
1)	;CNTR X MATCHES ANY ARBITRARY CHARACTER
1)	CNTRX:	MOVE	T,[-STABLN+4,,1]	;WANT TO ACCEPT ANYTHING AS A MATCH
1)	CNTRXX:	PUSHJ	P,SETSTB	;EXCEPT NULL & SPCTAB & BEGPAG & ENDPAG
1)		JRST	SERCH5
1)	;CNTR N REVERSES THE SENSE OF THE SEARCH FOR THE NEXT CHARACTER
1)	CNTRN:	MOVE	T,[-STABLN+4,,1]	;STAB CTR & PTR
1)		PUSHJ	P,SETSTB	;SET CURRENT POSITION BIT FOR ALL CHARS
1)		TXO	F2,S.CTLN	;SET ^N FLAG
1)		JRST	SERCH2
1)	;SET STAB BITS AS INDICATED BY T & D
1)	SETSTB:	XORM	D,STAB(T)
1)		AOBJN	T,.-1
1)		POPJ	P,
1)	;DISPATCH TABLE FOR 2ND SCAN OF SEARCH STRING
1)	S2TABL:	XWD	CNTRE,.CHCNE	;^E
1)		XWD	CNTRG,.CHBEL	;^G
1)		XWD	CNTRX,.CHCNX	;^X
1)		XWD	CNTRN,.CHCNN	;^N
1)		XWD	CNTRS,.CHCNS	;^S
1)		XWD	CNTRV,.CHCNV	;^V
1)		XWD	CNTRW,.CHCNW	;^W
1)		XWD	CNTRL,.CHCBS	;^\
1)		XWD	CNTRU,.CHCCF	;^^
1)	S3TABL:	XWD	CNTRT,.CHCNT	;^T
1)		XWD	CNTRQ,.CHCNQ	;^Q
1)		XWD	CNTRR,.CHCNR	;^R
1)		XWD	CNTR33,.CHESC	;ALTMODE
1)		XWD	0,0		;END OF LIST
1)	IFN	FTNCM1,<
1)		SUBTTL	VERIFY COMMAND  "V"
1)	VERIFY:	TXNE	FF,F.ARG2		; 2 ARGS ARE ILLEGAL
1)		ERROR	E.TAV			; TOLD YOU SO
1)		PUSHJ	P,CHK2			; FIND OUT THE 1 ARG
1)		PUSH	P,B			; SAVE IT ON THE STACK
1)		MOVNS	B,B			; NEGATE IT
1)		ADDI	B,1			; MAKE IT 1-(B)
1)		TXO	FF,F.ARG		; FLAG THAT WE HAVE ONE ARG
1)		PUSHJ	P,TYPE			; TYPE THE LINE
1)		POP	P,B			; GET THIS ARG
1)		PUSHJ	P,TYPE			; TYPE (B) LINES
1)		TXZ	FF,F.ARG		; TURN THIS OFF
1)		JRST	RET			; AND RETURN
1)	>
1)	SUBTTL	^E COMMANDS
1)	CNTRE:	CHKEO	EO21,SERCH4	;IF EO=1, ^E IS JUST TEXT
1)		ILDB	CH,AA		;GET CHAR. AFTER ^E
1)		SOJL	B,CNTREE	;NONE THERE
1)		MOVEI	T,S4TABL	;GO TO PROPER ^E COMMAND
1)		PUSHJ	P,DISPAT	;TO SET SPECIFIED CHARACTER BITS
1)	CNTREE:	ERROR	E.ICE
1)	;DISPATCH TABLE FOR ^E COMMANDS
1)	S4TABL:	XWD	CNTLEA,"A"	;^EA	ACCEPT ANY ALPHA
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		XWD	CNTLEV,"V"	;^EV	ACCEPT ANY L.C. ALPHA
1)		XWD	CNTLEW,"W"	;^EW	ACCEPT ANY U.C. ALPHA
1)		XWD	CNTLED,"D"	;^ED	ACCEPT ANY DIGIT
1)		XWD	CNTLEL,"L"	;^EL	ACCEPT ANY E-O-L CHAR.
1)		XWD	CNTLES,"S"	;^ES	ACCEPT A STRING OF SPACES OR TABS
1)		XWD	CNTLEN,74	;^E<NNN>	ACCEPT ASCII <NNN>
1)		XWD	CNTLEB,133	;^E[A,B,C]	ACCEPT A OR B OR C
1)		XWD	0,0		;END OF LIST
1)	SUBTTL	^EW, ^ED, ^EL, ^ES COMMANDS
1)	;^EW
1)	CNTLEW:	MOVE	T,[-^D26,,"A"]	;UPPER CASE ALPHABETIC CHARS.
1)		JRST	CNTRXX
1)	;^ED
1)	CNTLED:	MOVE	T,[-^D10,,"0"]	;DIGITS
1)		JRST	CNTRXX
1)	;^EL
1)	CNTLEL:	MOVE	I,Z		;IS LAST CHAR IN BUFR AN EOL?
1)		CAMG	I,BEG
1)		JRST	CNTLE3		;NO
1)		SUBI	I,1
1)		PUSHJ	P,GET
1)		CAIL	CH,.CHLFD
1)		CAILE	CH,.CHFFD
1)	CNTLE3:	XORM	D,STAB+ENDPAG	;NO, ENDPAG IS GOOD FOR A MATCH
1)		MOVE	T,[-3,,.CHLFD]	;LF, VT, FF
1)		JRST	CNTRXX
1)	;^ES
1)	CNTLES:	XORM	D,STAB+40	;SPACE
1)		XORM	D,STAB+11	;TAB
1)		XORM	D,STAB+SPCTAB	;& SPACE/TAB STRING BIT
1)		JRST	SERCH5
1)	;SKIP OVER A STRING OF SPACES AND/OR TABS WHILE SEARCHING
1)	SPTB:	ADDI	I,1		;ADVANCE TO NEXT BUFFER LOCATION
1)		CAML	I,UPPERB	;END-OF BUFFER?
1)		JRST	S4C		;YES, NO MORE SPACE/TABS
1)		MOVEM	TT1,ERR1	;SAVE CURRENT BYTE PTR (USING ERR1 AS TMP)
1)		ILDB	CH,TT1		;LOOK AT NEXT CHAR
1)		CAIE	CH," "		;IS IT A SPACE?
1)		CAIN	CH,.CHTAB	;OR TAB?
1)		JRST	SPTB		;YES, KEEP SKIPPING
1)		MOVE	TT1,ERR1	;NO, END OF SPACE/TAB STRING
1)		JRST	S4C		;RESTORE BYTE-POINTER & CONTINUE SEARCH
1)	SUBTTL	^E[A,B,C,...]
1)	CNTLEB:	AOS	SCESQB		;BUMP ^E[...] NEST CTR
1)	CNTLE0:	PUSHJ	P,SERCH2	;GET CHAR FROM OR-STRING
1)		ILDB	CH,AA		;GET SEPARATOR
1)		SOJL	B,CNTREE
1)		CAIN	CH,","		;MORE TO GO?
1)		JRST	CNTLE0		;COMMA IMPLIES YES
1)		CAIE	CH,"]"		;END OF OR-STRING?
1)		ERROR	E.ICE
1)		SOS	SCESQB		;DECREMENT ^E[...] NEST CTR
1)		JRST	SERCH5		;YES
1)	;^E<NNN>	(NNN IS OCTAL FOR A SINGLE ASCII CHAR)
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)	CNTLEN:	MOVEI	A,0		;CLR NUMBER ACCUMULATOR
1)	CNTLE1:	ILDB	CH,AA		;GET A DIGIT
1)		SOJL	B,CNTREE	;SHOULDN'T RUN OUT
1)		CAIN	CH,">"		;RIGHT ANGLE-BRACKET?
1)		JRST	CNTLE2		;YES, END OF NUMBER
1)		CAIL	CH,"0"		;IS IT A DIGIT?
1)		CAILE	CH,"7"
1)		ERROR	E.ICE
1)		LSH	A,3		;YES, SCALE UP THE PREVIOUS VALUE
1)		ADDI	A,-60(CH)	;AND ADD IN THE NEW DIGIT
1)		JRST	CNTLE1		;TRY FOR MORE
1)	CNTLE2:	ANDI	A,177		;EXTRACT AN ASCII CHAR.
1)		XORM	D,STAB(A)	;AND SET THE CORRESP. BIT
1)		JRST	SERCH5
1)	SUBTTL	RANDOM ^<CHAR> PROCESSORS
1)	;^R IS SAME AS ^Q (PROVIDED EO NOT = 1)
1)	;EXCEPT IT DOESN'T CAUSE RUBOUT PROBLEMS
1)	CNTRR:	CHKEO	EO21,SERCH4	;IF EO=1, ^R IS JUST TEXT
1)	;^Q CAUSES NEXT CHAR TO BE TAKEN AS TEXT EVEN IF IT IS
1)	;A CTRL CHAR. OR THE TERMINATOR
1)	CNTRQ:	ILDB	CH,AA		;GET NEXT CHAR
1)		SOJA	B,SRCH2E	;& PROCESS AS ORDINARY TEXT
1)	;^V CAUSES NEXT CHAR TO BE TAKEN AS LOWER CASE
1)	;^V^V SETS LOWER CASE MODE UNTIL FURTHER NOTICE
1)	CNTRV:	CHKEO	EO21,SERCH4	;IF EO=1, ^V IS JUST TEXT
1)		PUSHJ	P,C.V		;SET ^V FLAGS
1)		JRST	SERCH2
1)	;^W CAUSES NEXT CHAR TO BE TAKEN WITHOUT CONVERSION
1)	;^W^W SETS STANDARD CASE MODE UNTIL FURTHER NOTICE
1)	CNTRW:	CHKEO	EO21,SERCH4	;IF EO=1, ^W IS JUST TEXT
1)		PUSHJ	P,C.W		;SET ^W FLAGS
1)		JRST	SERCH2
1)	;FIRST ^\ CHANGES MATCH MODE TO ACCEPT EITHER UC OR LC
1)	;SECOND ONE TURNS ACCEPT EITHER FLAG OFF
1)	CNTRL:	CHKEO	EO21,SERCH4	;IF EO=1, ^\ IS JUST TEXT
1)		TXC	F2,S.EMAT	;COMPLEMENT ACCEPT EITHER FLAG
1)		JRST	SERCH2
1)	;IF SEARCHING FOR ALTMODE, AND IF EO=1, 033 & 175 ARE MATCHES
1)	CNTR33:	CHKEO	EO21,.+2	;EO=1?
1)		JRST	SERCH4		;NO, ACCEPT 033 ONLY
1)		XORM	D,STAB+175	;YES, MARK 175 AS ACCEPTABLE MATCH
1)		JRST	SERCH4		;& 033
1)	;^^ CAUSES IMMEDIATELY FOLLOWING @,[,\,],^,_ TO BE CONVERTED TO LC RANGE
1)	CNTRU:	CHKEO	EO21,SERCH4	;IF EO=1, ^^ IS TEXT
1)		ILDB	CH,AA		;GET NEXT CHAR
1)		PUSHJ	P,CVTSPC	;CONVERT TO LC IF @, ETC
1)		SOJA	B,SRCH2E
1)	;^T DISABLES ALL CNTRL COMMANDS EXCEPT ^Q,^R,^T AND ALLOWS ALL OTHER
1)	;CNTRL CHARS AS TEXT.  THE NEXT ^T TURNS THE ^T SWITCH BACK OFF.
1)	CNTRT:	CHKEO	EO21,SERCH4	;IF EO=1, ^T IS TEXT
1)		TXC	F2,S.NCCT
1)		JRST	SERCH2
1)	;^GI CAUSES THE TEXT IN Q REGISTER I TO BE SUBSTITUTED INTO THE
1)	;SEARCH STRING AT THIS POINT.
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)	CNTRG:	CHKEO	EO21,SERCH4	;IF EO=1, ^G IS PLAIN TEXT
1)		ILDB	CH,AA		;GET NAME OF Q-REG
1)		SOJL	B,CNTRGE	;IF NO MORE, THEN ERROR
1)		SKIPE	SCESQB		;CANT BE IN THE MIDDLE OF A ^E[...]
1)		JRST	CNTRGE		;...
1)		PUSH	PF,AA		;SAVE POINTER  (MUST USE Q-REG STACK)
1)		PUSH	PF,B		;AND COUNT
1)		AOS	CTGLEV		;INCREMENT Q-REG NEST COUNTER
1)		PUSH	P,CPTR		;SET UP CPTR IN CASE OF ERROR (PAIN!)
1)		MOVEM	AA,CPTR		;NOW Q REG ERROR WILL GET THE RIGHT CHAR
1)		PUSHJ	P,QREGV2	;INIT Q-REG ACCESS
1)		PUSHJ	P,QTEXEI
1)		PUSHJ	P,GTQCNT	;NUMBER OF CHARACTERS IN C
1)		POP	P,CPTR		;RESTORE CPTR
1)		MOVE	AA,I		;SET UP NEW CHARACTER POINTER
1)		IDIVI	AA,5
1)		HLL	AA,BTAB-1(AA+1)
1)		MOVE	B,C		;SET UP NEW COUNT
1)		JRST	SERCH2		;RESUME SCANNING SEARCH STRING
1)	CNTRG2:	POP	PF,B		;END OF Q-REG TEXT--RESTORE PREV LEVEL
1)		POP	PF,AA
1)		SOS	CTGLEV		;DECREMENT NEST COUNTER
1)		JRST	SERCH2
1)	CNTRGE:	ERROR	E.ICG		;ERROR IN ^G TEXT ARGUMENT
1)	SUBTTL	F SEARCHES
1)	FCMD:	PUSHJ	P,SKRCH		;GET CHAR AFTER F
1)		ERROR	E.MEF
1)		TXO	FF,F.SRCH	;SET F-SEARCH FLAG
1)		TRZ	CH,40		;UPPER OR lower CASE
1)		CAIN	CH,"S"		;FS?
1)		JRST	SERCH		;YES
1)		CAIN	CH,"N"		;FN?
1)		JRST	SERCHP		;YES
1)		TXZ	FF,F.SRCH	;MUST NOT BE ON
1)		CAIE	CH,"D"		;SEARCH AND DESTROY
1)		ERROR	E.IFC
1)		TXO	F2,S.DELS	;TO DELETE
1)		JRST	SERCH		;S SEARCH ONLY
1)	SUBTTL	<>	ITERATION BRACKETS.  COMMAND INTERPRETATION IS SENT
****
2)165		JRST	WCHSCH		;Go do search with this buffer full
2)166	RESTPT:	CHKEO	EODEC,BEGIN1	;[335] Leave pointer at top for EO of 2 or less
2)		MOVE	A,SAVEAC	;GET OLD PT
2)		MOVEM	A,PT		;RESTORE IT
2)	BEGIN1:	TXZ	FF,F.NSRH+F.LARW ;[344] Clear N and _ flags.
2)		TXNN	FF,F.SRCH	;F-SEARCH?
2)		JRST	NOFND5		;[344] No
2)		MOVE	CH,ARGTRM	;GET INSERT TERMINATOR
2)		TXZN	FF,F.NNUL	;WAS IT A NULL INSERT?
2)		CAIE	CH,.CHESC	;YES, WAS IT AN ALTMODE TERMINATOR?
2)		JRST	NOFND5		;[344] No
2)		TXO	F2,S.NRAD	;[344] Flag so second altmode gets put in *i
2)	NOFND5:	TXZE	FF,F.COLN	;[344] Colon modified?
2)		JRST	NOFND6		;[344] Yes, return a 0
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)	NOFND2:	SKIPL	(P)		;[344] IN AN ITERATION?
2)		ERROR	E.SRH		;[344] No, give error message
2)		CHKEO	EODEC,NOFND6	;[344] If old TECO, return 0
2)		TXNN	F2,S.NRAD	;[344] Null insert?
2)		JRST	RET		;[344] No, new TECO returns nothing
2)		JRST	ALTM1		;[344] Yes, end the command
2)	NOFND6:	TXNE	F2,S.NRAD	;[344] Was it a null insert?
2)		JRST	ALTM1		;[344] Yes, that terminates execution
2)		JRST	BEGIN		;[344] No, return a 0
2)	SRHMOD:	EXP	SRCHSW		;DEFAULT SEARCH MODE
2)167	SUBTTL	<>	ITERATION BRACKETS.  COMMAND INTERPRETATION IS SENT
**************
1)1	ERRP0:	INIT	ERRCHN,IO.SYN	;INIT INPUT FROM SYS:
1)	IFE BUGSW<	SIXBIT	/DSK/>
1)	IFN BUGSW<	SIXBIT	/DSK/>		;IF DEBUGGING THEN GET TECO.ERR FROM DSK
1)		XWD	0,ERRHDR
1)		JRST	NOERRS		;CAN'T
1)		MOVE	TT,Z		;GET ACTUAL FIRST FREE LOC
1)		IDIVI	TT,5
****
2)175	ERRP0:	SKIPN	TT,ERRDEV	;[337] Get device TECO was run from
2)		MOVSI	TT,'DSK'	;[337] If 0, we're probably debugging: use DSK
2)		DEVCHR	TT,		;[337] Legal device?
2)		  JUMPE	TT,ERRPSY	;[337] Nope, go use SYS:
2)		TXNN	TT,DV.DIR	;[337] Had better be a directory device
2)		  JRST	ERRPSY		;[337] Strange...
2)		SKIPN	TT,ERRDEV	;[337] Retrieve name again
2)		MOVSI	TT,'DSK'	;[337]
2)		MOVEM	TT,ERRBLK+1	;[337] Store in OPEN block
2)		MOVEI	TT,IO.SYN	;[337] Set status
2)		MOVEM	TT,ERRBLK	;[337]
2)		MOVEI	TT,ERRHDR	;[337] Set input buffer header
2)		MOVEM	TT,ERRBLK+.OPBUF;[337]
2)		OPEN	ERRCHN,ERRBLK	;[337] Open TECO.ERR device
2)		  JRST	ERRPSY		;[337] Failed
2)		JRST	ERRP00		;[337] Success
2)	ERRPSY:	MOVE	TT,ERRDEV	;[337] Get device
2)		CAMN	TT,[SIXBIT/SYS/] ;[337] Equal to SYS:?
2)		JRST	NOERRS		;[337] Yes, give up
2)		MOVSI	TT,'SYS'	;[337] No, try SYS:
2)		MOVEM	TT,ERRDEV	;[337] Remember for next time
2)		JRST	ERRP0		;[337] Try again
2)	;Here when OPEN succeeds
2)	ERRP00:	MOVE	TT,Z		;[337] GET ACTUAL FIRST FREE LOC
2)		IDIVI	TT,5
**************
1)1		SETZM	TECERR+3
1)		HRL	A,JOBN		;GET JOBNUMBER
****
2)175		MOVE	TT,ERRPPN	;[337] Get PPN used in RUN
2)		MOVEM	TT,TECERR+3	;[337] Store
2)		HRL	A,JOBN		;GET JOBNUMBER
**************
1)1		HRROI	A,-25		;(.GTFPN)
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)		GETTAB	A,
1)		JRST	NOERRS
1)		MOVEM	A,TECERR+3	;READ FROM TECO'S HOME DIRECTORY
1)		LOOKUP	ERRCHN,TECERR	;FIND TECO.ERR
1)		JRST	NOERRS		;NOT ON SYS:
1)	ERRP1:	HRRZ	D,.JBUUO	;GET ERROR CODE AGAIN
****
2)176		MOVEM	TT,TECERR+3	;[337] Store PPN again
2)		LOOKUP	ERRCHN,TECERR	;FIND TECO.ERR
2)		JRST	ERRPSY		;[337] Lookup failed
2)	ERRP1:	HRRZ	D,.JBUUO	;GET ERROR CODE AGAIN
**************
1)1		PUSHJ	P,ECORE		;GARBAGE COLLECT AND SMALLIFY
1)		MOVE	B,.JBREL	;.JBREL NOW
****
2)178		PUSHJ	P,ECORE1	;[354] GARBAGE COLLECT AND SMALLIFY
2)		MOVE	B,.JBREL	;.JBREL NOW
**************
1)1	EDEVNM:	MOVE	TT,FILDEV	;GET DEVICE NAME
1)		JRST	EOUTF3
1)	EPROJN:	HLRZ	B,FILPPN	;TYPE PROJECT NUMBER
1)		PUSHJ	P,OCTMS
****
2)182	EDEVNM:	SKIPN	TT,FILDEV	;[337] GET DEVICE NAME
2)		JRST	ERRPRN		;[337] No device to be typed.
2)		PUSHJ	P,SIXBMS	;[337] Type it
2)		MOVEI	CH,":"		;[337] Get colon
2)		PUSHJ	P,TYOM		;[337] Type it
2)		JRST	ERRPRN		;[337] Continue
2)	EPROJN:	SKIPN	FILPPN		;[337] Is there a PPN?
2)		JRST	ERRPRN		;[337] No, skip this.
2)		MOVEI	CH,"["		;[337] Get a bracket
2)		PUSHJ	P,TYOM		;[337] Type it
2)		HLRZ	B,FILPPN	;TYPE PROJECT NUMBER
2)		PUSHJ	P,OCTMS
**************
1)1		JRST	ERRPRN		;IF ZERO, WE'RE DONE
1)		MOVEI	CH,","
****
2)182		JRST	EPROJ2		;[337] IF ZERO, WE'RE DONE
2)		MOVEI	CH,","
**************
1)1		JRST	ERRPRN
****
2)182	EPROJ2:	MOVEI	CH,"]"		;[337] Close the brackets
2)		PUSHJ	P,TYOM		;[337]
2)		JRST	ERRPRN
**************
1)1		MOVE	TT1,[IOWD NUMCRT,CRTTAB+1]	;TYPE OUT VALID CRT TYPES
****
2)182		MOVE	CH,"["		;[337] Make it look good
2)		PUSHJ	P,TYOM		;[337]
2)		MOVE	TT1,[IOWD NUMCRT,CRTTAB+1]	;TYPE OUT VALID CRT TYPES
**************
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

1)1		JRST	EERNU1
****
2)182		MOVEI	CH,"0"		;[337] Possible leading 0
2)		CAIGE	B,100		;[337] 3 digit protection?
2)		PUSHJ	P,TYOM		;[337] No, type a leading 0
2)		MOVEI	CH,"0"		;[337] Once again...
2)		CAIGE	B,10		;[337] 2 digit protection?
2)		PUSHJ	P,TYOM		;[337] No, type another leading 0
2)		JRST	EERNU1
**************
1)1		MOVE	B,SRHCTR	;& STRING CTR
1)	EESRH2:	ILDB	CH,TT		;GET STRING CHAR
****
2)183		MOVM	B,SRHCTR	;& STRING CTR
2)	EESRH2:	ILDB	CH,TT		;GET STRING CHAR
**************
1)1	NROOM:	JUMPE	C,CPOPJ		;IF 0, THERE'S NOTHING TO DO
1)		MOVEM	17,AC2+15	;SAVE 17
****
2)188	NROOM:	SETZM	CRREL		;[317]ZERO THE RELOCATION WORDS
2)		SETZM	RREL		;[317]
2)		JUMPE	C,CPOPJ		;IF 0, THERE'S NOTHING TO DO
2)		MOVEM	17,AC2+15	;SAVE 17
**************
1)1		SETZM	CRREL
1)		SETZM	RREL
1)		MOVE	17,PT
****
2)188		MOVE	17,PT
**************
1)1		CAMG	17,MEMSIZ	;IS THERE ENOUGH?
1)		JRST	.+4		;YES, THEREFORE, UPDATE Z AND EXIT
****
2)189		CAMGE	17,MEMSIZ	;[320] IS THERE ENOUGH?
2)		JRST	.+4		;YES, THEREFORE, UPDATE Z AND EXIT
**************
1)1		CAIN	A,CPTR
1)		ADDM	T,CPTBAK	;ALSO MOVE POINTER FOR FS COMMAND
1)	GCS4:	SOJGE	CH,GCS3		;DONE?
****
2)192	GCS4:	SOJGE	CH,GCS3		;DONE?
**************
1)1	SUBTTL	**********AUTOMATIC MEMORY EXPANSION*********
1)	;MEMORY WILL BE EXPANDED UNDER ONE OF THESE CONDITIONS.
****
2)195	SUBTTL	AUTOMATIC MEMORY EXPANSION
2)	;MEMORY WILL BE EXPANDED UNDER ONE OF THESE CONDITIONS.
**************
1)1	IFN	FTNCM1,<
1)		DSP(MV,VERIFY,JR,MJRST)		;V	W	>
1)	IFE	FTNCM1,<
1)		DSP(JR,ERRA,JR,MJRST)		;V	W	>
1)		DSP(MV,X,HR,YANKER)		;X	Y
****
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)197		DSP(HR,VCMD,JR,MJRST)		;V	W
2)		DSP(MV,X,HR,YANKER)		;X	Y
**************
1)1	SPCDEV:	BLOCK	2		;FOR SAVING DEVICE LAST SPECIFIED (1 EXTRA WD FOR PATH. UUO)
1)	SPCPPN:	BLOCK	7		;FOR SAVING PATH LAST SPECIFIED
****
2)198	SPCDEV:	BLOCK	2		;FOR SAVING DEVICE LAST SPECIFIED
2)					;(1 EXTRA WD FOR PATH. UUO)
2)	SPCPPN:	BLOCK	7		;FOR SAVING PATH LAST SPECIFIED
**************
1)1	ERSPEC:	BLOCK	12		;FOR DEFAULT ER FILE SPEC (SEE EWSPEC FOR FORMAT)
1)	EWSPEC:	BLOCK	12		;FOR DEFAULT EW FILE SPEC (SAME AS XFILNM ABOVE EXCEPT
1)					;EWSPEC=DEVICE, EWSPEC+(4 - 9) = PATH
****
2)198	ERSPEC:	BLOCK	12		;FOR DEFAULT ER FILE SPEC
2)	EWSPEC:	BLOCK	12		;FOR DEFAULT EW FILE SPEC
2)					;(SAME AS XFILNM ABOVE EXCEPT
2)					;EWSPEC=DEVICE, EWSPEC+(4 - 9) = PATH
**************
1)1	SRHAA:	BLOCK	1		;END OF SEARCH MATRIX MARKER
1)	SCESQB:	BLOCK	1		;SEARCH FOR ^E[...] NESTING COUNTER
1)	CTGLEV:	BLOCK	1		;SEARCH FOR TEXT IN Q-REG NEST COUNTER
****
2)199	;Search table stuff
2)	; *** Do not separate vvv
2)	SMATRX:	BLOCK	SMATLN		;The old TECO search bit table
2)	BITMAT:	BLOCK	BITMLN*^D36	;The new rotated search bit table
2)	DELTA2:	BLOCK	^D36		;The table which knows what the pattern looks like
2)	SCLRLN==.-SMATRX
2)	; *** Do not separate ^^^
2)	DELTA0:	BLOCK	SMATLN		;The tables which know where characters are
2)	DELTA1:	BLOCK	SMATLN		; in the pattern
2)	INDMAT:	BLOCK	^D36		;A table of indicies into the pattern
2)	PATLEN:	BLOCK	1		;Number of positions in pattern
2)	ROTLEN:	BLOCK	1		;Current distance from the right end of the pattern
2)	SCNEST:	BLOCK	1		;Nest level counter during searches, 0 if none
2)	SCHTYP:	BLOCK	1		;0 if old TECO search, -1 if new search
2)	SCTLGA:	BLOCK	1		;0 if pattern source has no ^Gi, -1 if it does
2)	CTGLEV:	BLOCK	1		;SEARCH FOR TEXT IN Q-REG NEST COUNTER
**************
1)1	TECERR:	BLOCK	4		;LOOKUP SPECS FOR TECO.ERR
****
2)199	ERRDEV:	BLOCK	1		;[337] Device for TECO.ERR
2)	ERRPPN:	BLOCK	1		;[337] PPN for TECO.ERR
2)	ERRBLK:	BLOCK	3		;[337] OPEN block for TECO.ERR
2)	TECERR:	BLOCK	4		;LOOKUP SPECS FOR TECO.ERR
**************
1)1	SYMS:	BLOCK	22		;LIS+4(0),OG3+1,GC+3(0)
****
2)199	ETVAL:	BLOCK	1		;[331] ET VALUE
2)	EBPROT:	BLOCK	1		;[333] BAK PROTECTION & 2 RENAME SWITCH
2)	FDAEM:	BLOCK	1		;[333] FILE DAEMON PRESENCE IF NON-ZERO
2)	EPISEQ:	BLOCK	1		;[337] Controls EI-EP LOOKUP sequence
2)	LFCNT:	BLOCK	1		;[346] Line feed count for :nA command
File 1)	DSK:TEC124.MAC	created: 1206 13-APR-79
File 2)	DSK:TECO.MAC	created: 0017 24-APR-81

2)	;*********
2)	EXTRAS:	BLOCK	17		;[331] AVAILABLE LOCATIONS SO LOW SEG
2)					;      DOESN'T HAVE TO CHANGE
2)	;*********
2)	SYMS:	BLOCK	22		;LIS+4(0),OG3+1,GC+3(0)
**************
1)1	IFN	FTSWTCH,<
1)	SW.INI:	BLOCK	1
1)	INI.SW:	BLOCK	1
1)	>
1)	IFE BUGSW,<
****
2)199	IFE BUGSW,<
**************
 3@e?