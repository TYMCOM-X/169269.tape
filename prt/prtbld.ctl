:logfile prtbld.log
;--------------------------------------------------------------------
;                       Build a new version of Prt
;--------------------------------------------------------------------

do da
cte setp sail=(ftsys)sail
com/com Prt
load (ftsys)sailow,Prt
save Prt
do da

;--------------------------------------------------------------------
  