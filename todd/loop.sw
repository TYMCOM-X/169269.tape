
	SNOOPY-TYM vers.3 MONITOR TIME ANALYSIS C37-P034/B04  12-7-79
listing at 11-DEC-79 12:59:12 sampling began 11-DEC-79 12:56:24
LOOP WITH SW JOB




Sampling MONITOR PC at approx. 520-microsecond intervals.
selecting by job 12
sampling includes uuo level and pi level(s) 2 3 4 5 6 7 
histcnt: 4260	totcnt: 152622
syscnt: 38929	usrcnt: 113693
oorcnt: 0	nulcnt: 0
range: '20 to '777777 by '1000-word steps
percentages of jobs' mws's being swapped:
10 to 20%:	********************
percent total counts caught:
	in user jobs:  74.49%  in nuljob:  .00%  in monitor:  25.51%
out-of-range: oorcnt/histcnt =  .00
% total counts at:   UUO level	pi 2	pi 3	pi 4	pi 5	pi 6	pi 7
			 21.51%	 .00%	 1.07%	 .00%	 .00%	 .00%	 2.93%
symbols from (SYS)SYSTEM.SAV
MONITOR-PC HISTOGRAM BETWEEN 20  and  777777
print threshold: 85 counts
    addr         label     hits    % total counts
COMMOD
   17020      JBTMPC+2       95     .06%**
COMMOD,  .09%
FILUUO
   33020        LOCK+1       86     .06%*
FILUUO,  .06%
 FILIO
   34020      COMFIN+5      487     .32%**********
 FILIO,  .35%
FILRIB
   55020     PRRCHK+13      126     .08%**
FILRIB,  .08%
BPXKON
   56020      ERRCM1+2       92     .06%**
   57020      BPXUPA+4      234     .15%*****
BPXKON,  .21%
 PICON
  107020      INTCLK+3     1343     .88%******************************
 PICON,  .93%
SCHED1
  110020        QCMW+1      327     .21%*******
  111020        SWISW0      134     .09%**
SCHED1,  .31%
SCNSER
  113020         GREEN      465     .30%**********
  116020       SPEUX+4      201     .13%****
  125020     DDBSR1+10      160     .10%***
SCNSER,  .63%   