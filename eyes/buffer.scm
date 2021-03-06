File 1)	DSK:BUFFER.BLI[3,377411]	created: 1909 09-FEB-82
File 2)	DSK:BUFFER.BLI[3,377412]	created: 0721 29-MAR-82

1)1	bind extra=100;
1)	bind MaxBufs=100;
1)	external coresize,relcore,getppn,toprompt,ctrlg;
1)	external open,buffers,enter,close,dmpin,dmpout,munchi,filescan;
****
2)1	machop calli = #047;
2)	bind extra=100;
2)	bind MaxBufs=100;
2)	external coresize,relcore,getppn,toprompt,ctrlg,dotmpcor,quit,cucl;
2)	external open,buffers,enter,close,dmpin,dmpout,munchi,filescan;
**************
1)1	forward addbuf,combuf,existsbuf,gbnum;
1)2	global routine bufnam(request) = begin
****
2)1	global xbuffer[30],tp,xeflag; 			% watch for .tp problems %
2)2	global routine bufnam(request) = begin
**************
1)4	global routine uctrlb = begin local glbuffer [MaxBufs],tp;
1)		muline_1;
1)		scrmod_1;
1)		hitsts_1;
1)		flush_0;
1)		ToPrompt(plit asciz'Select Buffer: ');
1)		bfblk1_.defdsk;
1)		(bfblk1+1)_bufnam(sixbit 'main');
1)		(bfblk1+2)_sixbit 'vue';
1)		(bfblk1+3)_0;
1)		(bfblk1+4)_getppn();
1)		tp_(glbuffer-1)<1,7>;
1)		getstr(.tp);
1)		if not (filescan (tp,bfblk1)) then return ctrlg();
1)		if .flush then return ctrlg();
1)		ToPrompt(plit asciz'');
1)		combuf(0)
1)		end;
1)5	Global Routine Filbuf = Begin
****
2)4	global routine existsbuf (bname) =begin
2)	    incr i from 0 to MaxBufs-1 do begin
2)		if .bname eql .allbufs[.i] then return 1;
2)	    end;
2)	    return 0;
2)	end;
2)5	global routine AddBuf (bname) = begin local seen;
2)	    seen_-1;
2)	    incr i from 0 to MaxBufs-1 do begin
2)		if .bname eql .allbufs[.i] then return 0;
2)		if .allbufs[.i] eql 0 then seen_.i
2)	    end;
2)	    if .seen eql -1 then begin
2)		ToPrompt(plit asciz'Too many buffers');
2)		decr i from MaxBufs-2 to 0 do allbufs[.i+1]_.allbufs[.i];
2)		seen_0
2)	    end;
File 1)	DSK:BUFFER.BLI[3,377411]	created: 1909 09-FEB-82
File 2)	DSK:BUFFER.BLI[3,377412]	created: 0721 29-MAR-82

2)	    allbufs[.seen]_.bname;
2)	    return 1
2)	end;
2)6	global routine ctrlxb = begin local tp,tc;
2)	    ToPrompt(plit asciz'');
2)	    incr i from 0 to MaxBufs-1 do begin
2)		if .allbufs[.i] eql 0 then exitcompound;
2)		if .allmod[.i] neq 0 then writeloss("*");
2)		tp_(allbufs-1+.i)<0,6>;
2)		incr j from 1 to 6 do begin
2)		    tc_scani(tp);
2)		    tc_.tc+#040;
2)		    writeloss(.tc)
2)		end;
2)		writeloss(" ");
2)	    end;
2)	end;
2)7	global routine gbnum (bname) =
2)	    incr i from 0 to MaxBufs-1 do
2)		if .allbufs[.i] eql .bname then return .i;
2)	global routine gbmod(bname) = .allmod[gbnum(.bname)];
2)8	Global Routine Filbuf = Begin
**************
1)6	global routine ctrlxr = begin local glbuffer [100];
1)		local tp;
1)		muline_1;
1)		scrmod_1;
1)		hitsts_1;
1)		flush_0;
1)		ToPrompt(plit asciz'Read File: ');
1)		(filblk+4)_0; !default to our ppn.
1)		filblk_.defdsk;
1)		tp_(glbuffer-1)<1,7>;
1)		getstr(.tp);
1)		if not (filescan (tp,filblk)) then return
1)		    errstr(plit asciz'Illegal File Name');
1)		if .flush then return ctrlg();
1)		Filbuf()
1)	    end;
1)7	global routine ctrlxv = begin local glbuffer [MaxBufs],tp,device,ext;
1)		local tmpblk[6],existed;
1)		muline_1;
1)		scrmod_1;
1)		hitsts_1;
1)		flush_0;
1)		ToPrompt(plit asciz'Visit File: ');
1)		tmpblk_.defdsk;
1)		(tmpblk+4)_0;
1)		tp_(glbuffer-1)<1,7>;
1)		getstr(.tp);
1)		if not (filescan (tp,tmpblk)) then return ctrlg();
1)		if .flush then return ctrlg();
1)		!Now we have the file name in tmpblk, try to find  buffer first.
1)		existed_existsbuf(.(tmpblk+1));
File 1)	DSK:BUFFER.BLI[3,377411]	created: 1909 09-FEB-82
File 2)	DSK:BUFFER.BLI[3,377412]	created: 0721 29-MAR-82

1)		ToPrompt(plit asciz'');
1)		bfblk1_.defdsk;
1)		(bfblk1+1)_.(tmpblk+1);
1)		(bfblk1+2)_sixbit 'vue';
1)		(bfblk1+3)_0;
1)		(bfblk1+4)_getppn();
1)		combuf(0);
1)		if not .existed then begin
1)			filblk_.tmpblk;
1)			(filblk+1)_.(tmpblk+1);
1)			(filblk+2)_.(tmpblk+2);
1)			(filblk+3)_.(tmpblk+3);
1)			(filblk+4)_.(tmpblk+4);
1)			Filbuf();
1)		end;
1)	end;
1)8	global routine UCtrlo = begin local glbuffer [MaxBufs],tp;
1)		muline_1;
1)		scrmod_1;
1)		hitsts_1;
1)		flush_0;
1)		ToPrompt(plit asciz'Buffer Name: ');
1)		bfblk1_.defdsk;
1)		(bfblk1+1)_bufnam(sixbit 'main');
1)		(bfblk1+2)_sixbit 'vue';
1)		(bfblk1+3)_0;
1)		(bfblk1+4)_getppn();
1)		tp_(glbuffer-1)<1,7>;
1)		getstr(.tp);
1)		if not (filescan (tp,bfblk1)) then return ctrlg();
1)		if .flush then return ctrlg();
1)		ToPrompt(plit asciz'');
1)		combuf(2)
1)		end;
1)9	global routine combuf (autop) = begin
****
2)9	Routine setupbuffer(Prompt,Block,Name,Ext,User) = Begin
2)	    local stringspace [Maxbufs], Pnt;
2)	    muline_1;
2)	    scrmod_1;
2)	    hitsts_1;
2)	    flush_0;
2)	    ToPrompt(.Prompt);
2)	    .Block _ .defdsk;
2)	    (.Block+1) _ .Name;
2)	    (.Block+2) _ .Ext;
2)	    (.Block+3) _ 0;
2)	    (.Block+4) _ .User;
2)	    Pnt_(Stringspace-1)<1,7>;
2)	    getstr(.Pnt);
2)	    if not (filescan (Pnt,.Block)) then return 0;
2)	    if .flush then return 0;
2)	    return 1;
2)	end;
File 1)	DSK:BUFFER.BLI[3,377411]	created: 1909 09-FEB-82
File 2)	DSK:BUFFER.BLI[3,377412]	created: 0721 29-MAR-82

2)10	global routine combuf (autop) = begin
**************
1)10	global routine existsbuf (bname) =begin
1)		incr i from 0 to MaxBufs-1 do begin
1)			if .bname eql .allbufs[.i] then return 1;
1)		end;
1)		return 0;
1)	end;
1)11	global routine AddBuf (bname) = begin local seen;
1)		seen_-1;
1)		incr i from 0 to MaxBufs-1 do begin
1)			if .bname eql .allbufs[.i] then return 0;
1)			if .allbufs[.i] eql 0 then seen_.i
1)			end;
1)		if .seen eql -1 then begin
1)			ToPrompt(plit asciz'Too many buffers');
1)			decr i from MaxBufs-2 to 0 do
1)				allbufs[.i+1]_.allbufs[.i];
1)			seen_0
1)			end;
1)		allbufs[.seen]_.bname;
1)		return 1
1)		end;
1)12	global routine ctrlxb = begin local tp,tc;
1)		ToPrompt(plit asciz'');
1)		incr i from 0 to MaxBufs-1 do begin
1)			if .allbufs[.i] eql 0 then exitcompound;
1)			if .allmod[.i] neq 0 then writeloss("*");
1)			tp_(allbufs-1+.i)<0,6>;
1)			incr j from 1 to 6 do begin
1)				tc_scani(tp);
1)				tc_.tc+#040;
1)				writeloss(.tc)
1)				end;
1)			writeloss(" ");
1)			end;
1)		end;
1)13	global routine gbnum (bname) =
1)	    incr i from 0 to MaxBufs-1 do
1)		if .allbufs[.i] eql .bname then return .i;
1)	global routine gbmod(bname) = .allmod[gbnum(.bname)];
1)14	global routine autoloss = begin
****
2)11	global routine uctrlb = begin
2)	    If not Setupbuffer(plit asciz'Select Buffer: ', Bfblk1,
2)			Bufnam(sixbit 'main'), Sixbit 'vue', Getppn()  )
2)		then return Ctrlg();
2)	    ToPrompt(plit asciz'');
2)	    combuf(0)
2)	end;
2)	global routine UCtrlo = begin
2)	    If not Setupbuffer(plit asciz'Buffer Name: ', Bfblk1,
2)			Bufnam(sixbit 'main'), Sixbit 'vue', Getppn() )
2)		then return ctrlg();
File 1)	DSK:BUFFER.BLI[3,377411]	created: 1909 09-FEB-82
File 2)	DSK:BUFFER.BLI[3,377412]	created: 0721 29-MAR-82

2)	    combuf(2);
2)	end;
2)	global routine ctrlxr = begin
2)	    If not Setupbuffer(plit asciz'Read File: ', Filblk, 0, 0, 0)
2)		then return ctrlg();
2)	    Filbuf()
2)	end;
2)	global routine ctrlxv = begin local device,ext,tmpblk[6],existed;
2)	    If not Setupbuffer(plit asciz'Visit File: ', Tmpblk, 0, 0, 0)
2)		then return ctrlg();
2)	    existed_existsbuf(.(tmpblk+1));	! Does .tmpblk buffer exist?
2)	    ToPrompt(plit asciz'');
2)	    bfblk1_.defdsk;
2)	    (bfblk1+1)_.(tmpblk+1);
2)	    (bfblk1+2)_sixbit 'vue';
2)	    (bfblk1+3)_0;
2)	    (bfblk1+4)_getppn();
2)	    combuf(0);
2)	    if not .existed then begin
2)		    filblk_.tmpblk;
2)		    (filblk+1)_.(tmpblk+1);
2)		    (filblk+2)_.(tmpblk+2);
2)		    (filblk+3)_.(tmpblk+3);
2)		    (filblk+4)_.(tmpblk+4);
2)		    Filbuf();
2)	    end;
2)	end;
2)12	global routine autoloss = begin
**************
1)14	end eludom
****
2)13	global routine cclstuff = begin
2)	register foo;
2)	if dotmpcor(sixbit 'EDT',2,xbuffer,30) lss 0 then
2)	   dotmpcor(sixbit 'EDS',2,xbuffer,30);
2)	(filblk+4)_0; !default to our ppn.
2)	filblk_.defdsk;
2)	tp_xbuffer<29,7>;
2)	if not (filescan (tp,filblk)) then return ctrlg();
2)	filbuf();			! do common stuff [located in BUFFER]
2)	scrmod_1;
2)	muline_1;
2)	end;
2)14	global routine cclmultix = begin
2)	machop jrst = #254;
2)	register foo;
2)	local ep;
2)	incp(tp);
2)	ep_.tp; 
2)	while 1 do begin
2)	    if scani(ep) eql "!" then begin
2)		    replacen(ep,"?M");	!bash ! to ?m
2)		    exitloop
2)	    end;
File 1)	DSK:BUFFER.BLI[3,377411]	created: 1909 09-FEB-82
File 2)	DSK:BUFFER.BLI[3,377412]	created: 0721 29-MAR-82

2)	    if scann(ep) eql 0 then if .xeflag then cucl() else quit();
2)	end;
2)	filblk_0;
2)	(filblk+1)_0;
2)	(filblk+2)_0;
2)	(filblk+3)_0;
2)	(filblk+4)_0;
2)	(filblk+5)_0;
2)	if not (filescan (tp,filblk)) then return ctrlg();
2)	if .filblk eql 0 then filblk _ sixbit 'dsk';
2)	if .(filblk+2) eql sixbit'low' then (filblk+2)_0;      !bug in get.shr!
2)	foo_filblk<0,0>;
2)	foo_.foo + 1 ^ 18;
2)	calli (foo,#35);	! Run UUO ???
2)	jrst(4,0);
2)	end;		!for the procedure
2)15	global routine ctrlxi = begin local glbuffer [1
2)	    local tp,lfilblk[6];
2)	    allmod[.curbuf]_1;
2)	    muline_1;
2)	    scrmod_1;
2)	    hitsts_1;
2)	    flush_0;
2)	    ToPrompt(plit asciz'Insert File: ');
2)	    (lfilblk+4)_0; !default to our ppn.
2)	    lfilblk_.defdsk;
2)	    tp_(glbuffer-1)<1,7>;
2)	    getstr(.tp);
2)	    if not (filescan (tp,lfilblk)) then return ctrlg();
2)	    if .flush then return ctrlg();
2)	    open (2,0,.lfilblk,dskbfh<0,0>);
2)	    buffers (2,1,1,dskbuf); !get a disk buffer formatted.
2)	    if realup(lfilblk+1) then begin
2)		tp_(.p-1)<1,7>;	       !pointer to buffer's first.
2)		incr i from 1 to .lowend-1 do incp(tp);
2)		munchi (.tp);
2)	    end
2)	    else ToPrompt(plit asciz'File not found.');
2)	    close (2);
2)	end;
2)	end eludom
**************
  >sJn?