; FILDEF.CTL 14-Feb-79
; Compile and add module FILDEF.
;
.path sai:
.com/com fildef
.r maklib
*libary=libary/master:fildef,fildef/replace:fildef
*libary=libary/index

; Now for high-segment version.
.com/com fildeh=fildef(h)
.r maklib
*libarh=libarh/master:fildeh,fildeh/replace:fildeh
*libarh=libarh/index
   