iocss:
pat/ patopr: "/OPR/
pat+1/ patsys: "/SYS/
pat+3/ pat:
devphy/ jrst pat
pat/ pushj p,tstdsk
pat+1/ jrst cpopj1
pat+2/ push p,t3
pat+3/ setz t3,
pat+4/ came t1,patopr
pat+5/ camn t1,patsys
pat+6/ seto t3,
pat+7/ jrst devphy+2
pat+10/ pat:
devlp1+2/ jrst pat
pat/ jumpe t1,devlp1+3
pat+1/ pop p,t3
pat+2/ jrst devlp2
pat+3/ pat:
devlp1+4/ jrst pat
pat/ jumpn f,devlp1
pat+1/ skipe t3
pat+2/ jsr syscrs
pat+3/ pop p,t3
pat+4/ jrst devlp1+5
pat+5/ pat:
patsiz/ pat
syssiz/ pat
config+2/ "/L02-2/
