    string tempName, tempBody;
    boolean err;
	
    do  begin
	tempBody_ TMPIN( "PCO", err );	comment SAIL function;
	if err then begin
	    integer ch,eof, w,d;
	    open(ch_getchan, "DSK",0, 1,0, 200,0,eof);
	    lookup(ch, cvs(call(0,"PJOB")) & tempName &".TMP", err);
	    if not err
	     then do tempBody_ tempBody & input(ch,0) until eof;
	    release( ch );
	  end
      end
 