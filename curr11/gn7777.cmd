daytime Command file to create files for base node 7777!
delete ##7777.mac,##7777.cmd -gn7777.cmd
run (11tools)genbas
7777
60
YES
YES
444
11
RSX
YES
6666
4800
1
N
1
1
1
Y
run (11tools)macn11
mc7777.cmd@
run (11tools)link11
lk7777.cmd@/e
run (11tools)nibtrn
SV7777.IMG
SV7777.NIB
del mc7777.*,cg7777.*,ru7777.*,lk7777.*
dir  ##7777.*
    