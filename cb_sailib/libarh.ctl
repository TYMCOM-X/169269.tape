; LIBARH.CTL 15-Feb-79
; Create SAI:LIBARH
;
.path sai:
.r fur
*concatenate
*copy libarh.rel=-
*ALTERH.rel,-
*CORSEH.rel,-
*GRIPEH.rel,-
*CCLH.rel,-
*CURSOH.rel,-
*UDATEH.rel,-
*HOMFIH.rel,-
*WILDGH.rel,-
*EFILEH.rel,-
*SWINIH.rel,-
*PARSEH.rel,-
*TABUTH.rel,-
*XLOOKH.rel,-
*QNETH.rel,-
*TMPFIH.rel,-
*FILDEH.rel,-
*TTYSEH.rel,-
*WILDH.rel,-
*FILEH.rel,-
*MAKESH.rel,-
*REL:scn7C.rel,-
*DSK:DATEH.rel,-
*CHANH.rel,-
*DSKPPH.rel,-
*CMUPPH.rel,-
*FILE2H.rel,-
*STRFIH.rel,-
*MONTOH.rel
*exit
.r maklib
*libarh=libarh/index
*exit
   