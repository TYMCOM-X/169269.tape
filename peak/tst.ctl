:logfile Peak.Log
;---------------------------------------------------------------------
;
;                       Build PEAK.SAV for Tymcom-X
;
;                (SYS)PEAK.SAV has protection ALL RUN RUN.
;                (SYS)PEAK.SAV should have no license.
;
;                (SYS)PEAK.HLP has protection ALL RD RD.
;                (SYS)PEAK.HLP should have no license.
;
;                (SYSNEWS)PEAK.CHT has protection ALL RD RD.
;                (SYSNEWS)PEAK.KEY has protection ALL RD RD.
;                (SYSNEWS)PEAK.NEW has protection ALL RD RD.
;                (SYSNEWS)PEAK.SUM has protection ALL RD RD.
;                (SYSNEWS)PEAK.TUT has protection ALL RD RD.
;                (SYSNEWS)PEAK.TXT has protection ALL RD RD.
;
;       Note that in succeeding releases, the name of the FDM file
;       will change.
;
;---------------------------------------------------------------------


daytime

com warpld
load warpld
save warpld
save peak

r link
ded,comand,xbuff,xfile,window,redisp,util,auxwin
[sys]libsaa/s
peak1/save/u/g

ru peak1


declare all run run peak.sav
daytime


;---------------------------------------------------------------------
 