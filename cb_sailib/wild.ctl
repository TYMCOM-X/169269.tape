; WILD.CTL 14-Feb-79
; Compile and add module WILD.
;
.path sai:
.com/com wild
.r maklib
*libary=libary/master:wild,wild/replace:wild
*libary=libary/index

; Now for high-segment version.
.com/com wildh=wild(h)
.r maklib
*libarh=libarh/master:wildh,wildh/replace:wildh
*libarh=libarh/index
 