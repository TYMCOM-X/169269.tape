;@ STREAM BOTH TO SSL:PURGE.LOG PERMIT 0 ERRORS MAYRESTART 
;
;
;This file purges LOCAL.BBD notices older than N weeks and
;moves them into LOCAL.OLD.  CFE and BZM claim that it is
;robust over machine crashes, ie, that it never loses notices
;although it may miss a purge now and then.  The time constant
;"N" is determined by the frequency of BATCH repitition.
;
;
;Start it with SUBMIT PURGE ON MONDAY AT 04:00 EVERY 2WEEK.
;
;
;BZM   9 Feb 79   Written.  Runs on CMUA only for now.


SET watch all

MOUNT temp/first


;Save the current local.bbd just as it is in local.old
COPY ssl:local.old<155>/x/b = local.bbd/g


;Get all of local.bbd on one SOS page, correctly numbered.
;Search for the last Purge POST, making failure leave us at the end.
;Delete from the Purge POST to the end, or nothing if no such POST.
EDIT local.bbd/f

  d/2
  d/2
  d/2
  d/2
  d/2
  d/2
  d/2
  d/2
  d/2
  d/2
  d/2
  d/2
  d/2
  d/2
  d/2
  d/2
  n1

  b*/*
  fNotices more than two weeks old have been moved to LOCAL.OLD[F100BB00].0/1:*/*,e

  d.-2:*/*

  e,n


;POST the message which we look for above--MUST BE EXACTLY THE SAME!!!
CORE 0	;Get rid of all old open files and things.
R POST
Local
Local BBOARD Purge
Notices more than two weeks old have been moved to LOCAL.OLD[F100BB00].

  e,n
Post


;Check on things.
READ local.bbd
  p
  e
  