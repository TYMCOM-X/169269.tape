; HOMFIL.CTL 14-Feb-79
; Compile and add module HOMFIL.
;
.path sai:
.com/com homfil
.r maklib
*libary=libary/master:homfil,homfil/replace:homfil
*libary=libary/index

; Now for high-segment version.
.com/com homfih=homfil(h)
.r maklib
*libarh=libarh/master:homfih,homfih/replace:homfih
*libarh=libarh/index
   