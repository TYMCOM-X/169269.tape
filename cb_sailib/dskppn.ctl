; DSKPPN.CTL 14-Feb-79
; Compile and add module DSKPPN.
;
.path sai:
.com/com dskppn
.r maklib
*libary=libary/master:dskppn,dskppn/replace:dskppn
*libary=libary/index

; Now for high-segment version.
.com/com dskpph=dskppn(h)
.r maklib
*libarh=libarh/master:dskpph,dskpph/replace:dskpph
*libarh=libarh/index
   