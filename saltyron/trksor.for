        COMMON /RKS/INUM(2700),IA1(2700),IA2(2700),IB(2700,17)
        COMMON /RKS1/NCT,NSYS,ID1,ID2
        OPEN (UNIT=25,FILE='TRKXXX',ACCESS='SEQIN')
        READ (25,1001)NCT,NSYS,ID1,ID2
1001    FORMAT(2I5,1X,2A5)
        OPEN (UNIT=26,FILE='TRKXSO',ACCESS='SEQIN')
        DO 10 I=1,NCT
        READ (26,1002)IA1(I),IA2(I)
1002    FORMAT(2A5)
        INUM(I)=I
10      CONTINUE
        N3=1
20      CONTINUE
        N3=N3+1
        IF(N3.GT.NCT)GO TO 120
        NIN3=IA1(N3)
        MIN3=IA2(N3)
        N2=N3
30      CONTINUE
        N1P=INUM(N2-1)
        NIN1=IA1(N1P)
        MIN1=IA2(N1P)
        CALL ALNUM(NVAL,NIN1,NIN3,NB1,NB2)
        GO TO (40,100,51),NVAL
40      CONTINUE
        IF(NB2-NB1)51,41,100
41      CONTINUE
        CALL ALNUM(NVAL,MIN1,MIN3,NB1,NB2)
        GO TO (50,100,51),NVAL
50      CONTINUE
        IF(NB2-NB1)51,100,100
51      CONTINUE
        INUM(N2)=N1P
        N2=N2-1
        IF(N2.GT.1)GO TO 30
100     CONTINUE
        INUM(N2)=N3
        GO TO 20
120     CONTINUE
C       CLOSE(26)
        CALL WSORT
        CALL EXITPE
        END
        SUBROUTINE WSORT
        COMMON /RKS/INUM(2700),IB(2700,19)
        COMMON /RKS1/NCT,NSYS,ID1,ID2
        DIMENSION INAME(9)
        DATA INAME/5H (*6N,5H (FTM,5H (MAG,5H (QAS,5H (SYN,5H (SYS,
     1             5H (UPL,5H (UTL,5H     /
        IABO=INAME(1)
        DO 10 I=1,NCT
        READ (25,1002)(IB(I,J),J=3,19)
1002    FORMAT(11X,16A5,A3)
        DO 5 J=1,8
        IF(IB(I,16).EQ.INAME(J))GO TO 6
5       CONTINUE
        IB(I,16)=IABO
6       CONTINUE
        IABO=IB(I,16)
10      CONTINUE
        OPEN (UNIT=29,FILE='TRKX31',ACCESS='SEQOUT')
        WRITE(29,2001)NCT,NSYS,ID1,ID2
2001    FORMAT(2I5,1X,2A5)
C       CLOSE (25)
C       CLOSE (26)
        DO 200 KK=1,8
        DO 100 I=1,NCT
        J=INUM(I)
        IF(IB(J,16).NE.INAME(KK))GO TO 100
C       TYPE 2222,J,(IB(J,K),K=1,19)
2222    FORMAT(I5,1X,18A5,A3)
        WRITE(29,2002)(IB(J,K),K=1,19)
2002    FORMAT(18A5,A3)
100     CONTINUE
200     CONTINUE
C       CLOSE (29)
        RETURN
        END
        SUBROUTINE ALNUM(NVAL,N1,N2,NB1,NB2)
        NB1=N1
        NB2=N2
        NN1=0
        NN2=0
        IF(N1.LT.0)NN1=1
        IF(N2.LT.0)NN2=1
        NVAL=1
        IF(NN1.EQ.NN2)GO TO 10
        IF(NN1.LT.0)NVAL=2
        IF(NN2.LT.0)NVAL=3
        RETURN
10      CONTINUE
        IF(NN1.GE.0)RETURN
        NB2=N1
        NB1=N2
        RETURN
        END
 