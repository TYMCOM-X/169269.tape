"/Patch to wait a few ms before checking to see if pg write complete/

common:
rmpopj-7!jrst pat
712447,,776700
trnn t4,cs1rdy
sojg t3,pat 1
pat!movei t3,100.
movei t4,2000.
sojg t4,.
jrst rmpopj-6
pat:
patsiz!pat
