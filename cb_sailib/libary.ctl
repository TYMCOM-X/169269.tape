; LIBARY.CTL 14-Feb-79
; Create SAI:LIBARY
;
.path sai:
.r fur
*concatenate
*copy libary.rel=-
*ALTER.rel,-
*CORSER.rel,-
*GRIPE.rel,-
*CCL.rel,-
*CURSOR.rel,-
*UDATE.rel,-
*HOMFIL.rel,-
*WILDGF.rel,-
*EFILE.rel,-
*SWINI.rel,-
*PARSER.rel,-
*TABUTL.rel,-
*XLOOK.rel,-
*QNET.rel,-
*TMPFIL.rel,-
*FILDEF.rel,-
*TTYSER.rel,-
*WILD.rel,-
*FILE.rel,-
*MAKESI.rel,-
*SCN7C.rel,-
*DATE.rel,-
*CHAN.rel,-
*DSKPPN.rel,-
*CMUPPN.rel,-
*FILE2.rel,-
*STRFIL.rel,-
*MONTOR.rel
*exit
.r maklib
*libary=libary/index
*exit
    