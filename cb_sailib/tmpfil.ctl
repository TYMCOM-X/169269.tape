; TMPFIL.CTL 14-Feb-79
; Compile and add module TMPFIL.
;
.path sai:
.com/com tmpfil
.r maklib
*libary=libary/master:tmpfil,tmpfil/replace:tmpfil
*libary=libary/index

; Now for high-segment version.
.com/com tmpfih=tmpfil(h)
.r maklib
*libarh=libarh/master:tmpfih,tmpfih/replace:tmpfih
*libarh=libarh/index
   