; DATE.CTL 14-Feb-79
; Compile and add module DATE.
;
.path sai:
.com/com date
.r maklib
*libary=libary/master:date,date/replace:date
*libary=libary/index

; Now for high-segment version.
.com/com dateh=date(h)
.r maklib
*libarh=libarh/master:dateh,dateh/replace:dateh
*libarh=libarh/index
 