; TTYSER.CTL 14-Feb-79
; Compile and add module TTYSER.
;
.path sai:
.com/com ttyser
.r maklib
*libary=libary/master:ttyser,ttyser/replace:ttyser
*libary=libary/index

; Now for high-segment version.
.com/com ttyseh=ttyser(h)
.r maklib
*libarh=libarh/master:ttyseh,ttyseh/replace:ttyseh
*libarh=libarh/index
   