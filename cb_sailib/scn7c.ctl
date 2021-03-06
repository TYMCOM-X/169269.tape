; SCN7C.CTL 15-Feb-79
; Add SCN7C to Sail library.
;
.r MakLib
*libarh=libarh/master:$SCNDC,REL:Scn7C/replace:$SCNDC
*libarh=libarh/master:.SCAN,REL:Scn7C/replace:.SCAN
*libarh=libarh/master:.VERBO,REL:Scn7C/replace:.VERBO
*libarh=libarh/master:.TNEWL,REL:Scn7C/replace:.TNEWL
*libarh=libarh/master:.TOUTS,REL:Scn7C/replace:.TOUTS
*libarh=libarh/master:.STOPB,REL:Scn7C/replace:.STOPB
*libarh=libarh/master:.CNTDT,REL:Scn7C/replace:.CNTDT
*libarh=libarh/master:.GTPUT,REL:Scn7C/replace:.GTPUT
*libarh=libarh/master:.SAVE,REL:Scn7C/replace:.SAVE
*libarh=libarh/index


; Now do low-segment version.
.r teco
*erscn7c.mac[10,7,scan]
*ewscn7c.mac
*eiha
*j<sTWOSEG;0ltk>
*j<sRELOC;0ltk>
*ex

.compile/compile Scn7C.Mac
.r MakLib
*libary=libary/master:$SCNDC,Scn7C/replace:$SCNDC
*libary=libary/master:.SCAN,Scn7C/replace:.SCAN
*libary=libary/master:.VERBO,Scn7C/replace:.VERBO
*libary=libary/master:.TNEWL,Scn7C/replace:.TNEWL
*libary=libary/master:.TOUTS,Scn7C/replace:.TOUTS
*libary=libary/master:.STOPB,Scn7C/replace:.STOPB
*libary=libary/master:.CNTDT,Scn7C/replace:.CNTDT
*libary=libary/master:.GTPUT,Scn7C/replace:.GTPUT
*libary=libary/master:.SAVE,Scn7C/replace:.SAVE
*libary=libary/index

    