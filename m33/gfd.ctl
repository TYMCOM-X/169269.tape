:LOGFILE GFD.LOG
;[GFD BUILD INSTRUCTIONS]
;
;	Use the latest MACRO-10 and LINK-10
;
CTEST SETPROC MACRO=(FTSYS)MACRO,LOADER=(SPL)LINKER
;
LOAD/CREF/COMPILE/SAVE:GFD GFD.MAC
;
CROSS
;
DELETE GFD.REL,GFD.CRF
;
R CKSUM
GFD.CTL
GFD.INF
GFD.MAC
GFD.SAV

;
GET GFD
VERSION
;
;  Archive:
;	GFD.CTL, GFD.INF, GFD.MAC, GFD.SCM, GFD.LOG
;	GFD.144, GFD.143  -- old versions --
;  Transmit:
;	GFD.SAV to (SYS) with protection ALL RUN RUN
;			 with license    ST JL RF
;
;
;
TYPE GFD.INF
;
TYPE GFD.SCM
;[END of GFD.CTL]
   