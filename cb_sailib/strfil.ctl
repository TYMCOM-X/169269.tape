; STRFIL.CTL 14-Feb-79
; Compile and add module STRFIL.
;
.path sai:
.com/com strfil
.r maklib
*libary=libary/master:strfil,strfil/replace:strfil
*libary=libary/index

; Now for high-segment version.
.com/com strfih=strfil(h)
.r maklib
*libarh=libarh/master:strfih,strfih/replace:strfih
*libarh=libarh/index
   