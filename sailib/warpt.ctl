:logfile WARPT.LOG

; compile the code
;
COM WARP,WARPLD

; make a loader for WARPT
;
LOAD WARPLD/SAVE:WARPT

; test without high segment
;
EXE WARPT
RUN WARPT

; test with high segment
;
EXE (SYS)SAILOW,WARPT
RUN WARPT
 