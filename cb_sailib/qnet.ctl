; QNET.CTL 14-Feb-79
; Compile and add module QNET.
;
.path sai:
.com/com qnet
.r maklib
*libary=libary/master:qnet,qnet/replace:qnet
*libary=libary/index

; Now for high-segment version.
.com/com qneth=qnet(h)
.r maklib
*libarh=libarh/master:qneth,qneth/replace:qneth
*libarh=libarh/index
 