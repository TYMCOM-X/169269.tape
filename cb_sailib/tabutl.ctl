; TABUTL.CTL 14-Feb-79
; Compile and add module TABUTL.
;
.path sai:
.com/com tabutl
.r maklib
*libary=libary/master:tabutl,tabutl/replace:tabutl
*libary=libary/index

; Now for high-segment version.
.com/com tabuth=tabutl(h)
.r maklib
*libarh=libarh/master:tabuth,tabuth/replace:tabuth
*libarh=libarh/index
   