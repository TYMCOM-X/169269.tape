; PARSER.CTL 14-Feb-79
; Compile and add module PARSER.
;
.path sai:
.com/com parser
.r maklib
*libary=libary/master:parser,parser/replace:parser
*libary=libary/index

; Now for high-segment version.
.com/com parseh=parser(h)
.r maklib
*libarh=libarh/master:parseh,parseh/replace:parseh
*libarh=libarh/index
   