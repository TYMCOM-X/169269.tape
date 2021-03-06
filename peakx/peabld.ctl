:logfile PeaBld.Log
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
delete *.rel

ctest setp sail=(sys)sail

com ded,comand,auxwin,xbuff,xfile,window,redisp,util

r link
ded,comand,xbuff,xfile,window,redisp,util,auxwin
[sys]libsaa/s
peak/save/u/g

declare all run run peak.sav
declare all rd rd peak.cht, peak.hlp, peak.key, peak.sum, peak.tut, peak.txt
declare all rd rd peak.new

dir /ext/alph/prot/lic/time/author/words

do cksum
*.rel

del *.rel

del peakf.301
do fdm
o peakf.301
r peak.bug
r peak.cht
r peafdm.cmd
r peabld.ctl
r ded.def
r host.def
r peak.hlp
r peak.key
r peak.new
r comm1.req
r comm2.req
r comm3.req
r comm4.req
r comm5.req
r comm6.req
r comm7.req
r comm8.req
r xxbuf1.req
r xxbuf2.req
r comsub.req
r auxwin.sai
r comand.sai
r ded.sai
r redisp.sai
r util.sai
r window.sai
r xbuff.sai
r xfile.sai
r xxbuff.sai
r xxfile.sai
r peak.sav
r peak.sum
r peak.tut
r peak.txt
r peak.wsh
q

daytime


;---------------------------------------------------------------------
   