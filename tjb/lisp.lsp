(DEFPROP %DEFIN
	 (LAMBDA (X V F P)
		 (PROG (R)
		       (SETQ R (COND ((GETL X
					    (QUOTE (EXPR FEXPR
							 SUBR
							 FSUBR
							 LSUBR
							 MACRO)))
				      (LIST X (QUOTE Redefined)))
				     (T X)))
		       (PUTPROP X (NCONC (LIST (QUOTE LAMBDA) V) F) P)
		       (RETURN R)))
	 EXPR)

(DEFPROP DF
 (LAMBDA (L) (%DEFIN (CAR L) (CADR L) (CDDR L) (QUOTE FEXPR)))
 FEXPR)

(DF DE (L) (%DEFIN (CAR L) (CADR L) (CDDR L) (QUOTE EXPR)))

(DF DM (L) (%DEFIN (CAR L) (CADR L) (CDDR L) (QUOTE MACRO)))

(DE %DRM (CHAR EXP TYPE)
    (PROG (R)
	  (SETQ R (COND ( (GET CHAR (QUOTE RDMAC))
			  (LIST CHAR (QUOTE Redefined)) )
			( T CHAR )))
	  (PUTPROP CHAR EXP (QUOTE RDMAC))
	  (TYPECH CHAR TYPE)
	  (RETURN R)))

(DF DRM (L) (%DRM (CAR L) (CADR L) 5))

(DF DSM (L) (%DRM (CAR L) (CADR L) 6))

(DM PLUS (L) (*EXPAND L (QUOTE *PLUS)))

(DM DIFFERENCE (L) (*EXPAND L (QUOTE *DIF)))

(DM TIMES (L) (*EXPAND L (QUOTE *TIMES)))

(DM QUOTIENT (L) (*EXPAND L (QUOTE *QUO)))

(DM LESSP (L)
  (LIST	(QUOTE *LESS)
	(*EXPAND1 (CDR (REVERSE (CDR L)))
		  (QUOTE (LAMBDA (X Y)
				 (COND ((AND X (*LESS X Y)) Y)))))
	(CAR (LAST L))))

(DM GREATERP (L)
  (LIST	(QUOTE *GREAT)
	(*EXPAND1 (CDR (REVERSE (CDR L)))
		  (QUOTE (LAMBDA (X Y)
				 (COND ((AND X (*GREAT X Y)) Y)))))
	(CAR (LAST L))))

(DE %DEVP (X)
    (OR (EQ (CAR (LAST (EXPLODE X))) (QUOTE :))
	(AND (NOT (ATOM X)) (NOT (ATOM (CDR X))))))

(DE %READCHAN (%CHAN %TALK)
    (PROG (%OLDCHAN %SEXPR)
	  (SETQ %OLDCHAN (INC %CHAN NIL))
     LOOP (SETQ %SEXPR (ERRSET (READ)))
	  (COND ( (EQ (CAR %SEXPR) (QUOTE COMMENT))
		  (PROG (%XCH)
		      A (SETQ %XCH (READCH))
			(AND (EQ %XCH (QUOTE /;))
			     (RETURN))
			(GO A))
		  (GO LOOP) ))
	  (COND ( (ATOM %SEXPR) (GO END) ))
	  (SETQ %SEXPR (EVAL (CAR %SEXPR)))
	  (COND (%TALK (PRINT %SEXPR)))
	  (GO LOOP)
     END  (INC %OLDCHAN T)
	  (RETURN NIL)))

(DE %READAFILE (%DEV %FNAM %TALK)
    (%READCHAN (EVAL (NCONC (LIST (QUOTE INPUT) (GENSYM) %DEV) %FNAM)) %TALK))

(DE READIN (%DEV %FLIST %TALK)
    (PROG (%FNAM)
     LOOP (COND	((NULL %FLIST) (RETURN (QUOTE Finished-Loading)))
		((%DEVP (SETQ %FNAM (CAR %FLIST)))
		 (SETQ %DEV %FNAM)
		 (SETQ %FLIST (CDR %FLIST))
		 (GO LOOP))
		((AND (NOT (ATOM %FNAM))
		      (NULL (CDR %FNAM))
		      (CDR %FLIST))
		 (SETQ %FNAM (LIST %FNAM (CADR %FLIST)))
		 (SETQ %FLIST (CDR %FLIST)))
		((SETQ %FNAM (NCONS %FNAM))))
	  (%READAFILE %DEV %FNAM %TALK)
	  (SETQ %FLIST (CDR %FLIST))
	  (GO LOOP)))


(DF DSKIN (%L) (READIN (QUOTE DSK:) %L T))

(DF SYSIN (%L) (READIN (QUOTE SYS:) %L NIL))

(DF PUTSYM (L)
  (MAPCAR (FUNCTION (LAMBDA (X)
		     (COND ((ATOM X) (*PUTSYM X X))
			   (T (*PUTSYM (CAR X) (EVAL (CADR X)))))))
	  L))

(DF GETSYM (L)
  (MAPCAR
   (FUNCTION (LAMBDA (X)
	      (PROG (V)
		    (SETQ V (*GETSYM X))
		    (COND (V (PUTPROP X (NUMVAL V) (CAR L)))
			  (T (PRINT (CONS X
					  (QUOTE (Not in Symbol Table))))))
		    (RETURN V))))
   (CDR L)))

(DF BREAK (%LL%)
    (PROG (%EX% %ICH% %OCH%)
	  (SETQ %ICH% (INC NIL NIL))
	  (SETQ %OCH% (OUTC NIL NIL))
	  (PRINT (CONS (QUOTE *Break*) (CAR %LL%)))
     LOOP (TERPRI)
	  (SETQ %EX% (ERRSET (READ)))
	  (COND ((ATOM %EX%) (GO LOOP)))
	  (COND ((EQ (CAR %EX%) *BPROCEED*) (GO END)))
	  (ERRSET (PRIN1 (EVAL (CAR %EX%))))
	  (GO LOOP)
     END  (INC %ICH% NIL)
	  (OUTC %OCH% NIL)
	  (RETURN (EVAL (CADR %LL%)))))

(SETQ *BPROCEED* (QUOTE P))

(PROG (EX)
      (SETQ EX (QUOTE (LAMBDA (L)
		       (PROG2 (SYSIN LAP)
			      (LIST (QUOTE QUOTE) (EVAL L))))))
      (MAPC (FUNCTION (LAMBDA (X) (PUTPROP X EX (QUOTE MACRO))))
	    (QUOTE (DEFSYM LAP OPS))))

!(PROG (EX)
!      (SETQ EX (QUOTE (LAMBDA (L)
!		       (PROG2 (SYSIN (LISP.SOS))
!			      (LIST (QUOTE QUOTE) (EVAL L))))))
!      (MAPC (FUNCTION (LAMBDA (X) (PUTPROP X EX (QUOTE MACRO))))
!	    (QUOTE (EDFUN FILEIN))))

(PROG (EX)
      (SETQ EX (QUOTE (LAMBDA (L)
		       (PROG2 (SYSIN TRACE)
			      (LIST (QUOTE QUOTE) (EVAL L))))))
      (MAPC (FUNCTION (LAMBDA (X) (PUTPROP X EX (QUOTE MACRO))))
	    (QUOTE (TRACE UNTRACE TRACET UNTRACET SLST UNSLST RESET))))

(DF COMMENT (L) NIL)

(DF DECLARE (L) (MAPC (FUNCTION EVAL) L))

(SETQ EIGHT (ADD1 7))

(SETQ TEN (PLUS 2 EIGHT))

(DE OCTAL NIL (SETQ BASE (SETQ IBASE EIGHT)))

(DE DECIMAL NIL (SETQ BASE (SETQ IBASE TEN)))

(DF DEFBLOCK (L)	 L= (BlockProg OutputFile DefiningFile)
 (PROG	(A B)
	(SETQ A BPORG)
	(EVAL (CONS (QUOTE DSKIN) (CDDR L)))	 A Lap file.
	(WRBLK (CADR L) A (SETQ B (SUB1 BPORG))) Name  A:B
	(PUTPROP (CAR L) (CADR L) (QUOTE FILEN))
	(SETQ BLKIN (CAR L))
	(SETQ BPORG A)
	(RETURN (ADD1 B))))

(DF EXECBLOCK (P)	 P= (BlockProg ...Args...)
 (PROG	(FILEN)
	(COND	((EQ (CAR P) BLKIN) (GO L))
		((SETQ FILEN (GET (SETQ BLKIN (CAR P))
				  (QUOTE FILEN))))
		(T (PRINT (QUOTE Block-Not-Def)) (ERR)))
	(RDBLK FILEN NIL)	 NIL- DSK:,  T- SYS:
  L	(RETURN (EVAL P))))

(PROG NIL (INC NIL T)
	  (OUTC NIL T)
	  (DRM /@ (LIST (QUOTE QUOTE) (READ)))
	  (PRINC (QUOTE "
Tymshare Lisp 1.6 15-April-83"))
	  (COND ((ERRSET (INPUT INITCHAN DSK: (LISP . INI)) NIL)
		 (%READCHAN (QUOTE INITCHAN) NIL)))
	  (INC NIL T)
	  (OUTC NIL T)
	  (EXCISE)
	  (CSYM G0000)
	  (BAKGAG T)
	  (NOUUO T)
	  (ERR))
   