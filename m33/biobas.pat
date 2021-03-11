"/BIOBAS.PAT - Check BLOCK-IO errors connected with the Base/

scnser:

pat!patpat:
patpat+0!252525252525
patpat+1!patamt:0
patpat+2!paterr:0
patpat+3!patsam:0
patpat+4!patadr:0
patpat+5!pathld:0
patpat+6!patdat:0
patpat+7!pataun:0
patpat+10!patppn:0
patpat+11!patfpn:0
patpat+12!patprg:0
patpat+13!patcnt:0
patpat+14!patprt:0
patpat+15!patbfs:0
patpat+16!patfre:0
patpat+17!patbuf:0
patpat+20!1
patpat+21!2
patpat+22!3
patpat+23!4

patpat+24!patunl:
patunl+0!push p,t1
patunl+1!pushj p,csunl
patunl+2!camn t1,csucnt
patunl+3!jrst .-1
patunl+4!pushj p,csunl
patunl+5!camn t1,csucnt
patunl+6!jrst .-1
patunl+7!pop p,t1
patunl+10!popj p,

patunl+11!patcpy:
patcpy+0!push p,t1
patcpy+1!hrli t1,biochr(t1)
patcpy+2!hrri t1,patbuf
patcpy+3!movem t1,patadr
patcpy+4!blt t1,patbuf+4
patcpy+5!move t1,jbtaun(j)
patcpy+6!movem t1,pataun
patcpy+7!move t1,jbtppn(j)
patcpy+10!movem t1,patppn
patcpy+11!move t1,jbtfpn(j)
patcpy+12!movem t1,patfpn
patcpy+13!move t1,jbtnam(j)
patcpy+14!movem t1,patprg
patcpy+15!move t1,uptime
patcpy+16!movem t1,patdat
patcpy+17!move t1,biocnt
patcpy+20!movem t1,patcnt
patcpy+21!move t1,bioprt
patcpy+22!movem t1,patprt
patcpy+23!move t1,biobuf
patcpy+24!movem t1,patbfs
patcpy+25!move t1,bbfree
patcpy+26!movem t1,patfre
patcpy+27!pop p,t1
patcpy+30!popj p,

patcpy+31!patset:
patset+0!hrrz t3,ldbbio(u)
patset+1!move t1,patpat
patset+2!movem t1,biodat(t3)
patset+3!hrli t1,biodat(t3)
patset+4!hrri t1,biodat+1(t3)
patset+5!hrrz t3,biochr(t3)
patset+6!caile t3,400.
patset+7!movei t3,400.
patset+10!lsh t3,-2
patset+11!addi t3,-1(t1)
patset+12!blt t1,(t3)
patset+13!pushj p,patunl
patset+14!hrrz t3,ldbbio(u)
patset+15!popj p,

patset+16!move t3,1(m)
patset+17!patgot:
patgot+0!xct 4,.-1
patgot+1!movem t3,pathld
patgot+2!pushj p,patunl
patgot+3!hrli t3,biochr(t1)
patgot+4!popj p,

patgot+5!move t2,1(m)
patgot+6!patblt:
patblt+0!xct 4,.-1
patblt+1!came t2,patpat
patblt+2!jrst patblt+7
patblt+3!camn t2,pathld
patblt+4!aos patsam
patblt+5!aos paterr
patblt+6!pushj p,patcpy
patblt+7!aos patamt
patblt+10!move t2,ldbmod(u)
patblt+11!popj p,

patblt+12!pat:
patsiz!pat

gobin+2/pushj p,patset
gotbuf+6/pushj p,patgot
gotbuf+12/pushj p,patblt

