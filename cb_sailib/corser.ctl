; CORSER.CTL 14-Feb-79
; Compile and add module CORSER.
;
.path sai:
.com/com corser
.r maklib
*libary=libary/master:corser,corser/replace:corser
*libary=libary/index

; Now for high-segment version.
.com/com corseh=corser(h)
.r maklib
*libarh=libarh/master:corseh,corseh/replace:corseh
*libarh=libarh/index
   