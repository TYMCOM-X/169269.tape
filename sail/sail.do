COMMENT    VALID 00010 PAGES
C REC  PAGE   DESCRIPTION
C00001 00001
C00002 00002			How to make or modify SAIL at Stanford
C00003 00003	COMPILER
C00005 00004	PATCHING THE COMPILER
C00006 00005	LIBRARIES
C00007 00006	SEGMENT
C00008 00007	SELECTIVE LIBRARY UPDATE
C00009 00008	DEBUGGING COMPILER
C00010 00009	BAIL PRODECURE DESCRIPTORS FOR PREDECLARED RUNTIMES
C00011 00010	"UN-LIBRARY" FOR DEBUGGING RUNTIME ROUTINES
C00012 ENDMK
C;
                                                                                                                                                                                          		How to make or modify SAIL at Stanford

This file contains text to use with BATCH to make or modify Stanford SAIL.
The text for each task occupies one page of this file.

Decide what you want to do, create a file containing the appropriate text,
and say

	.BATCH/DO @<file>

Note that selectively updating individual routines on the libraries
requires that the module names be entered at 6 places in the text.
Also, patching the compiler should be done by hand (not through BATCH).
                                                                                                                                              ;COMPILER
;text to make two-segment compiler supporting extended compilation
ALIAS S,AIL		;get onto the right area
COMPILE @ITRENC		;assemble the compiler
COPY/Q SYS:SAIL.DMO_SYS:SAIL.DMP	;backup copies
COPY/Q SYS:SAIL.SEF_SYS:SAIL.SEG
R FRAID	;increment compiler version number so XSAIL users don't get screwed
NCOMVER.RELY7;. 1E
R LOADER 120            ;load it
/SSAIL,COMVER,XTCLOR,SYS:HLBSA8/L,SYS:LIBSA8/L,/V
DD
SAIL:IG
;above copes .JBVER to 400004, write protects, writes out upper on current area
SAVE SAIL		;lower
RENAME SAIL.SEG[1,3]_SAIL.SEG/Q	;transfer upper
RENAME SAIL.DMP[1,3]_SAIL.DMP/Q	;transfer lower
ALIAS
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ;PATCHING THE COMPILER

(do by hand, do not use BATCH)

To patch two-segment compiler which supports extended compilation:
.ALIAS 1,3	;for convenience in writing out upper segment
.GET SAIL	;lower only is gotten
.DDT
$PATCH G	;gets upper and jumps to RAID
<make the patch>
START G	;copies .JBVER to 400004, write protects upper, and
			; writes upper out as SAIL.SEG on current area.
			;You will get a message "SAVE ME!".  If the patch
			;was in the upper only, you are done.  Else type
			;"SAVE SAIL".
                                                                                                                    ;LIBRARIES
;text to create libraries LIBSAn.REL and HLBSAn.REL
ALIAS S,AIL
RESOURCES	;should show at least 250 tracks left for DSK
RU SCISS

Y

N
1
COPY/Q SYS:LIBSA8.OLD_SYS:LIBSA8.REL
R FUDGE2
SYS:LIBSA8_DSK:LIBSA8/X

;now for high library
RU SCISS

N
3,4

N
3
COPY/Q SYS:HLBSA8.OLD_SYS:HLBSA8.REL
R FUDGE2
SYS:HLBSA8_DSK:HLBSA8/X

ALIAS
                                                                                                                                                                                                                                                      ;SEGMENT
;text to create runtime segment SAISGn.SEG
ALIAS S,AIL
EXEC @SGMNT
COPY/Q SYS:SAISG8.OLD_SYS:SAISG8.SEG
COPY/Q SYS:SAILOW.OLD_SYS:SAILOW.REL
RENAME/Q SYS:SAISG8.SEG_DSK:SAISG8.SEG
RENAME/Q SYS:SAILOW.REL_DSK:SAILOW.REL
ALIAS
                                                                                                                                                                                                                                                                                                                                                                                                   ;SELECTIVE LIBRARY UPDATE
;example using SAIREC and SAIPRC
ALIAS S,AIL
RU SCISS

N
6
SAIPRC
SAIREC
DONE

R FUDGE2
SYS:LIBSA8_SYS:LIBSA8<SAIREC>,DSK:SAIREC/R
SYS:LIBSA8_SYS:LIBSA8<SAIPRC>,DSK:SAIPRC/R
SYS:LIBSA8_SYS:LIBSA8/X

RU SCISS

N
3,4,6
SAIPRC
SAIREC
DONE

R FUDGE2
SYS:HLBSA8_SYS:HLBSA8<SAIREC>,DSK:SAIREC/R
SYS:HLBSA8_SYS:HLBSA8<SAIPRC>,DSK:SAIPRC/R
SYS:HLBSA8_SYS:HLBSA8/X

DEL/Q SAIPRC.FAI,SAIPRC.REL
DEL/Q SAIREC.FAI,SAIREC.REL
ALIAS
                                                                                                                                  ;DEBUGGING COMPILER
;text to make compiler with internal debugging aids
ALIAS S,AIL		;get on right area
COMPILE @THAT		;assemble compiler
R LOADER 120            ;load it
/Y/SSAILDD/V
DD
SAIL:E
SAV SAILDD
ALIAS
                                                                                                                                                                                                                                                                                                                                                                                                                     ;BAIL PRODECURE DESCRIPTORS FOR PREDECLARED RUNTIMES
ALIAS S,AIL
COMPILE RESTAB.=PROD+FOO2/processor RTRAN
COMPILE BPDAHD+<BAICLC,BAIIO1,BAIIO2,BAIMSC,BAIPRC>
EXECUTE BAISM1=BSM1HD+BAISM1
ALIAS 1,3
TRANSFER/Q [S,AIL]BAICLC.SM1,BAIIO1.SM1,BAIIO2.SM1,BAIMSC.SM1,BAIPRC.SM1
TRANSFER/Q [S,AIL]BAICLC.REL,BAIIO1.REL,BAIIO2.REL,BAIMSC.REL,BAIPRC.REL
ALIAS
                                                                                                                                                                                                                                                                               ;"UN-LIBRARY" FOR DEBUGGING RUNTIME ROUTINES
ALIAS S,AIL
COMPILE @RUN
ALIAS
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           