:logfile movdir

copy (ken)SETRPG.CTL,(peak.b2)same
copy (ken)SPOOL.DEF,(peak.b2)same
copy (ken)DIRIT.INI,(peak.b2)same
copy (ken)LISP.INI,(peak.b2)same
copy (ken)PEAK.INI,(peak.b2)same
copy (ken)RPG.INI,(peak.b2)same
copy (ken)SWITCH.INI,(peak.b2)same
copy (ken)LISP.LSP,(peak.b2)same
copy (ken)ACCESS.MSG,(peak.b2)same
copy (ken)C.SAV,(peak.b2)same
copy (ken)DA.SAV,(peak.b2)same
copy (ken)INIT.SAV,(peak.b2)same
copy (ken)PRT.SAV,(peak.b2)same
copy (ken)SY.SAV,(peak.b2)same

gf peak.b2

do copy
*.*-*.tmp
ken
897
y
  