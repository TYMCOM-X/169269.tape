global routine forceinput (tp)= begin
	csnum_.csnum+1;
	rstk[.rptr]_.callchar;
	rstk[.rptr+1]_.repcount;
	rptr_.rptr+2;
	cstk[.csnum]_.tp; !start at the right q-register.
	end;

global routine metae = begin
    csnum_.csnum+1;
    rstk[.rptr+1]_1;		       !repcount value.
    rptr_.rptr+2;		       !push on stack.
    cstk[.csnum]_0;		       !means from the tty.
end;

Global Routine myaltm  = begin local tp;
	initdispatch();
	scrmod_1;
	muline_1;
	bfblk1_.defdsk;
	(bfblk1+1)_.dirtemp;
	(bfblk1+2)_sixbit 'vue';
	(bfblk1+3)_0;
	(bfblk1+4)_gppn();
	combuf(0);
	(distbl+MetaValue+"m")_metam;
	tp_metam;
	repcount_2;
	comchar_"m";
	base_#200;
	end;

   