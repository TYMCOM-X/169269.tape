; MAKESI.CTL 14-Feb-79
; Compile and add module MAKESI.
;
.path sai:
.com/com makesi
.r maklib
*libary=libary/master:makesi,makesi/replace:makesi
*libary=libary/index

; Now for high-segment version.
.com/com makesh=makesi(h)
.r maklib
*libarh=libarh/master:makesh,makesh/replace:makesh
*libarh=libarh/index
   