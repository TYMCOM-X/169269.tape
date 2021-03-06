COMMENT*******************************************************************
*                                                                        *
*11/SEP/79, pg			TPSIM					*
;
BEGIN "TPMAST"
DEFINE	VERSION "<>" = <"ver-30.7">;
COMMENT
*                                                                        *
**************************************************************************
*                                                                        *
*   Overview                                                             *
*                                                                        *
*       The INTERFACE terminal user simulation program                   *

*                                                                        *
*************************************************************************;
COMMENT******************************************************************
*                                                                         *
*                               MACRO DEFINITIONS                         *
*                                                                         *
**************************************************************************;


    REQUIRE "TYMCAL.DEF" SOURCE!FILE;
    REQUIRE "TYMGET.DEF" SOURCE!FILE;
    REQUIRE "TYMINT.DEF" SOURCE!FILE;
    REQUIRE "TYMIO.DEF"  SOURCE!FILE;
    REQUIRE "MONTYP.DEF" SOURCE!FILE;
    REQUIRE "(SAILIB)EXTEND.REQ" SOURCE!FILE;

    REQUIRE  10000 SYSTEM!PDL;
    REQUIRE  10000 STRING!PDL;
    REQUIRE  10000 STRING!SPACE;

    REQUIRE PROCESSES;


    DEFINE PSTACK(X) = "(X LSH 8)",
           Bit!0     =  "'400000000000",
           DATIO(X)="AUXCLV(X,POINT(7,Out!msg[0],-1),Auxcal!outptr)",
           STRINGSTACK(X) = "(X LSH 14)";

    DEFINE    LF   = "('12&NULL)",
              CR   = "('15&NULL)",
              CRLF = "('15&'12)",
	      tab  = "('11&NULL)",
              CY   = "('31&NULL)",     Comment Control-Y;
comment              Prmpt      = "('56&NULL)"; comment made an string 
						and set at run time;
              msg!prompt = "NULL",         COMMENT start of output msg
                         ='32 for INTERFACE 12/2;
              \    = "COMMENT";
DEFINE	      Request!Prmpt = "('00&NULL)";
\ the following line is set at run time now;
\ DEFINE	      ReqPrmpt!Time = 15000;	\ Time between Request!Prmpt intrpt;
\ the following line is set at run time now;
\ DEFINE	      Cntrollee!Quit "<>" = <"LOG" & CR>;	\ QUIT Cmd to Ctrollee;

DEFINE        TIMER!CHANNEL = 5,
              ZAP!CHANNEL   = 6,
              COMMAND!CHANNEL = 7,
              INTERRUPT!CHANNEL!BASE = 8,

              PORT!LIMIT    =  50,
              CHANNEL!LIMIT    =  5,
              PORTS!CHANNEL    = 15, 
              SCRIPT!LIMIT     = 10,

              DEBUG!INT        = "FALSE",
              DEBUG!CMD        = "FALSE",

              SW!NOTHING       = 0,
              SW!LOGON         = 1,
              SW!SEND!CR       = 2,
              SW!NEXT!LINE     = 3,
              SW!TIME!SEND     = 4,
              SW!TIME!READ     = 5,
              SW!ID!STOP       = 6,
              SW!ID!CONT       = 7,
              SW!DISCONNECT    = 8,
              SW!SEND!CR!PROMPT= 9,
              SW!SEND!CR!TIME= 10,
              SW!TIME!GET= 11,
              SW!TIME!SEND!FCR = 12; \ Do!Next when firstchar recv'd, SEND;
DEFINE	        SW!TIME!READ!FCR = 13; \ Do!Next when firstchar recv'd, READ;
DEFINE		SW!WAIT!DISCONNECT = 14; \ For #4 commands until a zap then
					 Login;
DEFINE		SW!Max = 14; \ The # of switches;

DEFINE        CHARCNT          = 0,
              LN!STARTIME      = 1,
              MSGSIZE          = 120,

              NCMDS            = 40;

REQUIRE "<>%%"	DELIMITERS;

         DEFINE NOW = <CALL(0,"MSTIME")>;

	DEFINE
		S!PRINT(TXT) = < BEGIN
				    IF
					TTY!PRNT
				    THEN
					PRINT(TXT);

				    IF
					CHN!PRNT
				    THEN
					CPRINT(CHN,TXT);
				  END>;
	DEFINE t!print(txt) = <BEGIN
						PRINT(txt);
					IF
						chn!prnt
					THEN
						CPRINT(chn,txt);
				END>;

COMMENT***************************************************************
*                                                                      *
*                            GLOBALS                                   *
*                                                                      *
***********************************************************************;

comment	the following code is for logging in users and sending to
		users;
DEFINE	user!max = 20;

	PRESET!WITH "comtest.aa1","comtest.aa2","comtest.aa3","comtest.aa4",
		"comtest.aa5","comtest.aa6","comtest.aa7","comtest.aa8",
		"comtest.aa9","comtest.aa10","comtest.aa11","comtest.aa12",
		"comtest.aa13","comtest.aa14","comtest.aa15","comtest.aa16",
		"comtest.aa17","comtest.aa18","comtest.aa19","comtest.aa20";
	STRING ARRAY USERS[1:user!max];
	INTEGER User!ptr,Send!ptr;

STRING ARRAY Scriptid[0:Script!Limit],
              Idprefix[0:script!Limit],
              Lastin[0:Port!limit],
              Lastout[0:Port!limit],
             inline[0:Port!limit];

STRING       Instring,Username,Commandline,FileString,Ini!String,
		Prmpt,Cntrollee!Quit;

BOOLEAN ARRAY Channel!Enabled[0:Channel!Limit],
		Prompt!seen[0:Port!Limit],
              User!FCharRecd[0:Port!Limit];     \ For timed SEND/READ;

BOOLEAN       Initialised,        \ Parameters set up ;
              Spin,               \ Eat the processor;
		test!ports,		\ DEBUG global for Interrupts;
              Interrupts!init,    \ Interrupts set up;
              Connected,          \ Circuits connected ;
              Running,            \ Test in progress;
              Flatout,            \ Full speed ahead;
              Debug,              \ True id debug mode;
              Debug!test,         \ see tests happen;
              Debug!norm,         \ : is prompt;
              Debug!wait,         \ Wait for circuit zap;
              Debug!data,         \ see data always ;
	Port!test,		\ when true types out port # with output;
	Line!test,		\ when true types out line # with output;
              Debug!trace,        \ trace interrupt and timer ;
              Timer!attached,     \ Timer interrupt attached;
              Timer!enabled,      \ Timer interupt enabled ;
              Zap!enabled,
		Oloop,		\ Zapped circuit, restart TPSIM ;
		Olog,		  \ Log off sent if TRUE;
              Files!initialized,  \ Disk channels opened ;
              Textmode,           \ Single cct, transparent mode;
	    tty!prnt,		\ must be true to output to tty;
	    chn!prnt,		\ set to true when a log file is used;

	    chn;		\ the log file's channel number;

ITEM          Intproc;

INTEGER ARRAY Timerblock[0:1],
              Commandblock[0:1],
              Zapblock[0:1],
              Interruptblock[0:(3*20)],
              Port#[0:Port!limit],   \ 0 - Command port;
              Post#[0:Port!limit],   
              Channel#[0:Port!limit],
              Channel!inx[0:Port!limit],
              Test!start[0:Port!Limit],
              Test!ready[0:Port!Limit],
              Test!period         [0:Script!Limit],
              Users!conn          [0:Script!Limit],
              No!of!users         [0:Script!Limit],
              Logon!delay         [0:Script!Limit],
              Disk!channel        [0:Script!Limit],
              No!of!loops         [0:Script!Limit],
              User!script         [0:Port!Limit],
              User!XOFF           [0:Port!Limit],
              User!switch         [0:Port!Limit],
              User!prompt         [0:Port!Limit],
              User!loops          [0:Port!Limit],
              User!timecell       [0:Port!Limit],
              User!sendcount      [0:Port!Limit],
              user!bccount        [0:port!limit],
              user!sendtime       [0:Port!Limit],
              User!readcount      [0:Port!Limit],
              user!msgtx          [0:port!limit],
              user!msgrx          [0:port!limit],
              user!msgcount       [0:port!limit],
              User!readtime       [0:Port!Limit],
              user!getcount       [0:Port!Limit],
              user!gettime        [0:Port!Limit],
              User!charsent       [0:Port!Limit],
              User!charrecd       [0:Port!Limit],
              User!Monitor        [0:Port!Limit],
              User!on             [0:Port!Limit],
	      User!LostPrmpt	  [0:Port!Limit], \ Timer for Request!Prmpt;
              Out!msg[0:255],          \ output buffer ;
              Chan!port[0:Channel!limit,0:Ports!channel],
              Chan!line[0:Channel!limit,0:Ports!channel],
              Counts[0:100],
              Statistics[0:Port!limit,0:1],
		\ TIMERS;
		Loop!Prev[0:Port!Limit], \ The last time the end of
					Loop was reached;
		Loop!Last[0:Port!Limit]; \ The Time Period it took to
					complete the Loop;

INTEGER       Max!port,           \ max ports this run;
              Max!Line,           \ Current Max Line #;
              Max!script,         \ cript  this run;
              Rate,               \ Character rate this run;
              Timestarted,        \ in milliseconds;
              Deltime,            \ in milliseconds;
              Timerwait,          \ in milliseconds;
              Monitor!time,       \ in milliseconds;
              Monitor!interval,   \ in milliseconds;
              Testtime,           \ in milliseconds;
              Timenow,            \ in milliseconds;
              Total!Loops,
              Total!send!time,
              Total!read!time,
              Total!reads,
              total!files!read,
              total!gettime,
              Total!Messages!sent,
              Total!chars!sent,   \ Transmitted to slaves;
              Total!chars!recd,   \ Received from slaves;
		Total!LostPrmpt,
              Textline,           \ Line number in textmode;
              Ports!connected,    \ number of ports active;

              Idbase,             \ Used for login ;
              Cmnd,               \ Command index;
              monitor!chan,		\ CHANNEL # OF THE MONITOR FILE FOR
				 RESTIM PROGRAM , THE TIMING RESULT FILE;

              monitor!count,
              monitor!brchar,
              monitor!eof,
		ichan,		\ keep the current channel # from IH;
              ini!chan,		\ THE INIT FILE CHANNEL NUMBER;
              ini!eof,
              ini!brk,
              ini!bt,
              ini!bc,
              Texttab,
              Texteof,
              Waitdelay,
              Seed,
              Brchar,
		ReqPrmpt!Time,		\ Time between request!prmpt intrpt;
              Junk,
	\ Timer for Procedures;

		Sen!Prev,	\ The last time Simple!output was called;
		Sen!last,	\ The time period between the last simple!
					Output calls;

		Tim!Prev,	\ The last time the clock went off;
		Tim!Last,	\ The time period between the last two time
				interrupts;

		Int!Prev,	\ The last time there was in interrupt;
		Int!Last;	\ The time period between the last two time
				Interrupts;

EXTERNAL INTEGER
              !SKIP!;

LABEL         Crash;
LABEL	Rloop;
STRING Datamsg;
RECORD!CLASS Sdata(RECORD!POINTER(Sdata) Sptr;
                   STRING Sstring);
RECORD!POINTER (Sdata)ARRAY Nextline[0:Port!limit];

RECORD!POINTER(Sdata)Array Firstline[0:Script!Limit];

REAL ARRAY bcast!ratio[0:port!limit];

PRELOAD!WITH  
         ".",           \ 0 - "TRANSPARENT MODE";
         "?",           \ 1 ;
         "TEST",        \ 2 ;
         "STATUS",      \ 3 ;
         "CONNECT",     \ 4 ;
         "DISCONNECT",  \ 5 ;
         "LOGON",       \ 6 ;
         "STOP",        \ 7 ;
         "RATE",        \ 8 ;
         "TOTALS",      \ 9 ;
         "SHUTDOWN",    \ 10 ;
         "QUIT",        \ 11 ;
         "INITIALIZE",  \ 12 ;
         "CRASH",       \ 13 ;
         "PERIOD",      \ 14 ;
         "GO",          \ 15 ;
         "FULL",        \ 16 ;
         "RESET",       \ 17;
         "TALK",        \ 18 ;
         "MONITOR",     \ 19 ;
         "READ",        \ 20 ;
         "DEBUG",       \ 21 ;
         "CLEAR",       \ 22 ;
         "SWITCH",      \ 23 ;
         "WRITE",        \ 24 ;
	 "/",		\ 25;
	 "SCRIPT",	\ 26 ;
	 "CLOCK!OFF",	\ 27 ;
	 "LEVDEF",	\ 28 ;
	 "HELP",	\ 29 ;
	 "PORTS",	\ 30 ;
	 "PROMPT",	\ 31;
	 "BUFFER",	\ 32;
	 "POST",	\ 33;
	 "LIST!SCRIPT",	\ 34;
	 "STATE!LIST", \ 35;
         "NULL";

STRING ARRAY COMMAND!VALUE[0:NCMDS];

PRELOAD!WITH
    "unknown       ",
    "nothing       ",
    "logon         ",
    "send!cr       ",
    "next!line     ",
    "time!send    ",
    "time!read     ",
    "id!stop       ",
    "id!cont       ",
    "disconnect    ",
    "send!cr!prompt",
    "send!cr!time  ",
    "time!get      ",
	"time!send!fcr",
	"time!read!fcr",
	"wait!disconnect";

STRING ARRAY switches[-1:Sw!max];

REQUIRE 0 POLLING!INTERVAL;

COMMENT******************************************************************
*                                                                       *
*                         Forwards                                      *
*                                                                       *
************************************************************************;

FORWARD PROCEDURE Ports!cmd;
FORWARD PROCEDURE write!init(STRING object);
FORWARD PROCEDURE Commandport;

FORWARD PROCEDURE Zap!handler; 

FORWARD PROCEDURE Initialize!interrupts;

FORWARD PROCEDURE Timer!handler;

FORWARD PROCEDURE Buildcct(     STRING Loginstring;
                        REFERENCE INTEGER Portnumber;
                        REFERENCE BOOLEAN Success);
FORWARD BOOLEAN PROCEDURE LOGIN(
                        INTEGER Linenumber; STRING User(NULL));

FORWARD PROCEDURE Attach!timer;

FORWARD PROCEDURE Attach!interrupt
                        (INTEGER Channel,Line);

FORWARD PROCEDURE Attach!zap(   INTEGER Line);

FORWARD RECURSIVE PROCEDURE Simple!output(INTEGER Line;
                        STRING Str); 

FORWARD PROCEDURE Disconnect(   INTEGER Line);

FORWARD recursive PROCEDURE Interrupt!handler(
                        INTEGER Channel);

FORWARD  PROCEDURE Read!command;

FORWARD PROCEDURE Docommand(    INTEGER Cmnd;STRING Object);

FORWARD INTEGER PROCEDURE Lookupcommand(
                        STRING Command);

FORWARD INTEGER PROCEDURE Getobject(
                        STRING  Commandline);

REQUIRE 100 POLLING!INTERVAL;

FORWARD PROCEDURE To!be!implemented            ;

FORWARD PROCEDURE SEND!ID         (INTEGER Line);

FORWARD RECURSIVE PROCEDURE DO!NEXT
                                       (INTEGER Line;BOOLEAN Prompt);

FORWARD RECURSIVE PROCEDURE ATTACH!DETACH(
                                       STRING Str;INTEGER Line);

FORWARD RECURSIVE PROCEDURE SEND!NEXT!LINE
                                       (INTEGER Line);

FORWARD PROCEDURE Help!cmd           (STRING Object);

FORWARD PROCEDURE Test!cmd           (STRING Object);

FORWARD PROCEDURE Switch!cmd         (STRING object);

FORWARD PROCEDURE Status!cmd         (STRING Object);

FORWARD PROCEDURE Connect!cmd        (STRING Object);

FORWARD PROCEDURE Disconnect!cmd     (STRING Object);

FORWARD PROCEDURE Logon!cmd          (STRING Object);

FORWARD PROCEDURE Stop!cmd           (STRING Object);

FORWARD PROCEDURE Rate!cmd           (STRING Object);

FORWARD PROCEDURE Totals!cmd         (STRING Object);

FORWARD PROCEDURE Quit!cmd           (STRING Object);

FORWARD PROCEDURE Initialize!cmd     (STRING Object);

FORWARD PROCEDURE Crash!cmd          (STRING Object);

FORWARD PROCEDURE Period!cmd         (STRING Object);

FORWARD PROCEDURE Go!cmd             (STRING Object);

FORWARD PROCEDURE Full!cmd           (STRING Object);

FORWARD PROCEDURE Meter!cmd          (STRING Object);

FORWARD RECURSIVE PROCEDURE Monitor!cmd        (STRING Object);

FORWARD PROCEDURE Setprint!cmd       (STRING Object);

FORWARD PROCEDURE Sendit!cmd         (STRING Object);

FORWARD PROCEDURE Debug!             (STRING Object);

FORWARD STRING PROCEDURE Upper       (STRING Object);

require 0 polling!interval;
STRING PROCEDURE Getdata;
IF
    ini!chan GEQ 0
THEN
    BEGIN		\ READ FROM THE INIT FILE;
    ini!string _ InPut(ini!chan, ini!bt);
    s!print( %ini!string,crlf%);
    RETURN(ini!string);
    END
ELSE
    BEGIN
    s!print( %"}"%);
    RETURN(inchwl);
    END;

PROCEDURE Enablecom;
BEGIN
    INTMAP(TINASS(-1,CAUSE!TTY!BREAK,Command!channel),
                   DFRINT,
                   (-2 LSH 18) LOR LOCATION(Commandblock[0]));
END;
PROCEDURE DISABLECOM;
BEGIN
    INTMAP(TINASS(-1,CAUSE!TTY!BREAK,0),
                   DFRINT,
                   (-2 LSH 18) LOR LOCATION (Commandblock[0]));
END;
SIMPLE PROCEDURE Chan0;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 0),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*0]));
END;
SIMPLE PROCEDURE Chan1;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 1),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*1]));
END;
SIMPLE PROCEDURE Chan2;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 2),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*2]));
END;
SIMPLE PROCEDURE Chan3;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 3),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*3]));
END;
SIMPLE PROCEDURE Chan4;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 4),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*4]));
END;
SIMPLE PROCEDURE Chan5;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 5),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*5]));
END;
SIMPLE PROCEDURE Chan6;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 6),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*6]));
END;
SIMPLE PROCEDURE Chan7;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 7),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*7]));
END;
SIMPLE PROCEDURE Chan8;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 8),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*8]));
END;
SIMPLE PROCEDURE Chan9;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 9),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*9]));
END;
SIMPLE PROCEDURE Chan10;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 10),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*10]));
END;
SIMPLE PROCEDURE Chan11;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 11),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*11]));
END;
SIMPLE PROCEDURE Chan12;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 12),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*12]));
END;
SIMPLE PROCEDURE Chan13;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 13),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*13]));
END;
SIMPLE PROCEDURE Chan14;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 14),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*14]));
END;
SIMPLE PROCEDURE Chan15;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 15),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*15]));
END;
SIMPLE PROCEDURE Chan16;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 16),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*16]));
END;
SIMPLE PROCEDURE Chan17;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 17),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*17]));
END;
SIMPLE PROCEDURE Chan18;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 18),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*18]));
END;
SIMPLE PROCEDURE Chan19;
BEGIN
    CALLI( Bit!0 LSH -(Interrupt!channel!base + 19),-'34);
    DFR1IN((-3 LSH 18) + LOCATION(Interruptblock[3*19]));
END;

REQUIRE 100 POLLING!INTERVAL;


REQUIRE 0 POLLING!INTERVAL;

COMMENT******************************************************************
*                                                                       *
*                              Zap!Handler                              *
*                                                                       *
************************************************************************;

PROCEDURE Zap!handler;

BEGIN "ZAPHANDLER"

OWN INTEGER ARRAY Active!ports[0:Port!Limit];
    INTEGER I,J,Chan,Inx;

    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>Zap!handler entered",CRLF%); ENDC

	COMMENT READ ALL ACTIVE AUX CIRCUIT PORT NUMBERS;

    CALLI(-(Max!port+1) LSH  18 + LOCATION(Active!ports[0]),CALLI!AUXRED);

    FOR I _ 1 STEP 1 UNTIL Max!port
    DO
    BEGIN
         IF
              Port#[I] > 0
         THEN
         BEGIN
              J _ 0;
              WHILE
                   Active!ports[J] neq -1 AND
                   Active!ports[j] NEQ Port#[I]
              DO
                   J _ J + 1;
              IF
                   Active!ports[J] = -1
              THEN
              BEGIN
                   t!print( %"Port ",Port#[i]," (Line ",I,")Zapped",CRLF%);
                   IF
                       user!loops[i] < no!of!loops[user!script[i]]
                       OR
                       no!of!loops[user!script[i]] = 0
                   THEN
\ pg                       user!switch[i] _ SW!disconnect;
			User!Prompt[i] _ User!switch[i] _ Sw!Logon;

                   IF
                       User!switch[I] = SW!Logon
                   THEN
                  BEGIN
                       Post#[I] _ Now + 1000;
                       User!LostPrmpt[I]_0;      \ Clear Lost-ESC timer;
                  END;
                   Disconnect(I);
              END;
         END;
    END;

    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>Zap!handler exit",CRLF%); ENDC

\	Oloop _ TRUE;
	t!print(%"**Test Complete**",crlf%);
	t!print(%"Total # of Lost Prompts = ",Total!LostPrmpt,CRLF%);
	t!print(%"}"%);
\	Connected _ FALSE;
END "ZAPHANDLER";
REQUIRE 100 POLLING!INTERVAL;

COMMENT*******************************************************************
*                                                                        *
*				OPN!IN					*
*                                                                        *
*************************************************************************;

INTERNAL INTEGER PROCEDURE OPN!IN(STRING S; REFERENCE INTEGER EOF);

COMMENT	THIS MODULE OPENS AN INPUT FILE WHOSE NAME IS IN STRING S;

COMMENT 	;

BEGIN "O!IN"

	INTEGER I!CHAN,MODE,IBUF,OBUF,COUNT,BR,FLAGL;

	BOOLEAN T;

	MODE _ 8;
	IBUF _ 2;
	OBUF _ 0;
	T _ TRUE;

	OPEN(I!CHAN _ GETCHAN, "DSK",MODE,IBUF,OBUF,COUNT,BR,EOF);

	IF
	    EOF
	THEN
	    BEGIN "O"
		OUTSTR("OPEN INPUT ERROR");
		T _ FALSE;
		END "O"
	ELSE
	    BEGIN "L"
		FLAGL _ TRUE;
		WHILE
		    FLAGL
		DO
		    BEGIN "LOOP"
			LOOKUP(I!CHAN,S,FLAGL);
			IF
			    FLAGL
			THEN
			    BEGIN "NEW"
				OUTSTR("FILE " & CVOS(S) & " NOT FOUND" & CRLF);
				S _ INCHWL;
			    END "NEW";
		    END "LOOP";
	    END "L";
	IF
	    T
	THEN
	    BEGIN "SUC"
		RETURN(I!CHAN);
	    END "SUC"
	ELSE
	    BEGIN "FAIL"
		RETURN(-1);
	    END "FAIL";
END "O!IN";


COMMENT*******************************************************************
*                                                                        *
*				OPN!OUT					*
*                                                                        *
*************************************************************************;


INTERNAL INTEGER PROCEDURE OPN!OUT(STRING S; REFERENCE INTEGER EOF);


COMMENT	THIS MODULE OPENS AN OUTPUT FILE WHOOSE NAME IS IN STRING S;


BEGIN "oout"

	INTEGER MODE,IBUF,OBUF,O!CHAN,COUNT, BR,FLAG,FLAGE;

	BOOLEAN T;

	MODE _ 0;
	IBUF _ 0;
	OBUF _ 2;
	T _ TRUE;

	OPEN(O!CHAN _ GETCHAN, "DSK", MODE, IBUF, OBUF, COUNT, BR, FLAG);

	IF
	    FLAG
	THEN
	    BEGIN "O"
		OUTSTR("OPEN OUTPUT ERROR");
		T _ FALSE;
	    END "O"
	ELSE
	    BEGIN "E"
		FLAGE _ TRUE;
		WHILE
		    FLAGE
		DO
		    BEGIN "ENT"
			ENTER(O!CHAN,S,FLAGE);
			IF
			    FLAGE
			THEN
			    BEGIN "LOOP"
				OUTSTR("FILE " & CVOS(S) &
					" NOT FOUND" & CRLF);
				OUTSTR("ENTER FILE NAME:");
				S _ INCHWL;
			    END "LOOP";
		    END "ENT";
	    END "E";
	RETURN(o!chan);
END "oout";

REQUIRE 0 POLLING!INTERVAL;
COMMENT*******************************************************************
*                                                                        *
*                            INITIALIZE!INTERRUPTS                       *
*                                                                        *
*************************************************************************;

PROCEDURE Initialize!interrupts;

BEGIN "INITIALIZE"

    INTEGER I;

    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>Interrupt!initialize entered:",
                                      CRLF%);ENDC

Commandblock[0] _ 2;		\ THE NUMBER OF WORDS IN THE BLOCK;
Commandblock[1] _ -1 LSH 18 LOR LOCATION(Read!Command); \ THE ADDRESS 
					OF THE PROCEDURE TO SERVICE THE 
					INTERRUPT;


    Timerblock[0] _2;
    Timerblock[1] _ -1 LSH 18 LOR LOCATION(Timer!handler);

    Zapblock[0] _ 2;
    Zapblock[1] _ -1 LSH 18 LOR LOCATION (Zap!handler);

    FOR I_ 0 STEP 1 UNTIL Channel!Limit-1
    DO
    BEGIN
         Interruptblock[I*3] _ 3;
         Interruptblock[1 + (I*3)] _I;     \ ZERO BASED Channel number;
         Interruptblock[2 + (i*3)] _
                   -1 LSH 18 LOR LOCATION (Interrupt!handler);
    END;


    Attach!timer;



    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>Interrupt!initialize exit",CRLF%);ENDC

END "INITIALIZE";

COMMENT******************************************************************
*                                                                       *
*                            ATTACH!TIMER                               *
*                                                                       *
************************************************************************;

PROCEDURE Attach!timer;

BEGIN "ATTACHTIMER"

    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>Attach!timer entered",CRLF%);ENDC

COMMENT	RESET TIME INTERRUPT;
    CALLI(0,CALLI!SETTIM);

    INTMAP(INTASS(CAUSE!TIMER,Timer!channel),	\ CHANNEL #;
           DFRINT,
           (-2 LSH 18)+LOCATION(Timerblock[0])); \ LENGTH OF BLOCK 
						PLUS THE ADDRESS OF THE BLOCK;

    Timer!attached _ TRUE;
    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>Attach!timer exit",CRLF%);ENDC

END "ATTACHTIMER";

COMMENT*****************************************************************
*                                                                      *
*                          TIMER!HANDLER                               *
*                                                                      *
***********************************************************************;

PROCEDURE TIMER!HANDLER;

BEGIN "TIMERHANDLER"

    INTEGER Line,Savetime,When,Prev;

    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>TIMER!HANDLER ENTERED",CRLF%); ENDC

    Savetime _ Now;
    FOR Line _ 1 STEP 1 UNTIL Max!Line
    DO
    BEGIN
	IF Debug!trace AND (NOT (Port#[line] = -1) 
		OR  User!Switch[Line] = SW!Wait!Disconnect
		OR User!Switch[Line] = SW!Logon)
	THEN
	BEGIN "timelog"
	S!Print(%"post![line]=",Post#[line]," NOW=",now,
		" Diff=",Post#[Line]-now," Since last=",Tim!Last_now-Tim!Prev,
		crlf%);
	Tim!Prev _ now;
	END "timelog";
     IF
	(NOT (Port#[line] = -1)) OR ((User!switch[Line] = SW!Wait!Disconnect)
				OR (User!Switch[Line] = Sw!Logon))
     THEN
     BEGIN "not!zapped"
      IF
         (0 < Post#[Line] < NOW)
	OR (Prompt!seen[Line])
         THEN
         BEGIN
                Post#[Line]_0;
              IF Debug!trace THEN
              s!print( %"L",Line%);
		IF
		    Prompt!seen[Line]
		THEN
		BEGIN "prompt!seen"
		    Prompt!seen[Line] _ FALSE;
		    Do!next(Line,TRUE);
		END "prompt!seen"
		ELSE
				    IF
			user!lostprmpt[line] < now
		    THEN
			\ lost prompt timeout send next line;
			BEGIN "lostprompt"
			    IF debug!trace
			    THEN
				BEGIN "trace!LP"
				S!Print(%"&"%);
				S!Print(%"***Line=",Line," Since last Prmpt=",
				ReqPrmpt!Time+now-User!LostPrmpt[Line],
				" Time out=",ReqPrmpt!Time,
				" # of Timeouts=",Total!LostPrmpt,"***",crlf%);
				END "trace!LP";
					\ Reset time;
			    User!LostPrmpt[Line] _ NOW + ReqPrmpt!Time;
			    Total!lostPrmpt _ Total!LostPrmpt + 1;
			    Prompt!seen[line] _ FALSE;
			    Do!Next(line,TRUE);
			END "lostprompt"
		    ELSE \ no prompt seen;
			Do!next(line,FALSE);
		         END;
	\ do not test for lost prompt unless there's nothing in buffer;
\ pg      IF
         (0 < User!LostPrmpt[Line] < NOW) AND Port#[Line] > 0
         THEN
         BEGIN
	    IF inLIne[line] = NULL THEN
		BEGIN
		    Total!LostPrmpt _ Total!LostPrmpt + 1;
\ pg		    Simple!Output(Line,Request!Prmpt);	\ Prompt for another Prmpt;
\ pg		    User!LostPrmpt[Line] _ NOW + ReqPrmpt!Time;	\ Reset timer;
\ pg		END
	    ELSE
\ pg		BEGIN	\ If inline neq NULL, implement IH Prmpt procedure;
\ pg		    IF debug THEN s!print(%"**Timer>IH call**", crlf%);
\ pg		    ichan _ Channel#[Line];
\ pg		    IF Port#[Line] > 0
		    THEN
		    Interrupt!handler(ichan);
\ pg		END;
\ pg         END;
	DDFINT;
    END "not!zapped";
    END;
    When _ (Timerwait - (Now-Savetime));
    IF
         Timer!enabled
    THEN
         IF
              When>0
         THEN
	COMMENT		SET TIME INTERRUPT;
              CALLI(When,Calli!Settim)
         ELSE
	COMMENT		SET TIME INTERRUPT;
		\ SET THE CLOCK TO GO OFF IN N SECONDS;
              CALLI(Timerwait,Calli!Settim);
    IF
	Oloop
    THEN
    BEGIN
	Running _ FALSE;
	monitor!interval _ 0;		\ overset time for interrupt;
    END;

    IF 
         Savetime >Monitor!time
    THEN
         Monitor!cmd(NULL);
\	REQUIRE 100 POLLING!INTERVAL;
		IF
		    Debug!Trace
		THEN
		    SaveTime _ now;

		IF
		    Connected
		THEN
		CALLI(Calli!Hiber!Sec + Calli!Hiber!Break
			+ 10
			, Calli!Hiber);
		IF
		    Debug!Trace
		THEN
		    s!print(%"Timer slept=",now - SaveTime,crlf%);
\	REQUIRE 0 POLLING!INTERVAL;

    IF Debug!trace THEN
    s!print( %"X"%);
    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>TIMER!HANDLER EXIT",CRLF%); ENDC

END "TIMERHANDLER";

COMMENT******************************************************************
*                                                                       *
*                             ATTACH!INTERRUPT                          *
*                                                                       *
************************************************************************;

PROCEDURE Attach!interrupt(INTEGER Channel,Line);

BEGIN "ATTACHINTERRUPT"

    INTEGER I,Index;

    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>Attach!interrupt entered:",
                                         Channel,":",Line,CRLF%);ENDC

FOR I _ 0 STEP 1 UNTIL 3
DO
BEGIN "for"
CASE I OF
BEGIN "case"
[0]    Index _Tinass(Port#[Line],Cause!TTY!chr,Interrupt!Channel!base+Channel);
[1]    Index _Tinass(Port#[Line],Cause!tty!BREAK,Interrupt!Channel!base+Channel);
[2]    Index _Tinass(Port#[Line],Cause!TTY!Lost,Interrupt!Channel!base+Channel);
[3]    Index _Tinass(Port#[Line],Cause!DEV!ERROR,Interrupt!Channel!base+Channel)
END "case";
CASE Channel OF
BEGIN
INTMAP(Index,Chan0 ,0);
INTMAP(Index,Chan1 ,0);
INTMAP(Index,Chan2 ,0);
INTMAP(Index,Chan3 ,0);
INTMAP(Index,Chan4 ,0);
INTMAP(Index,Chan5 ,0);
INTMAP(Index,Chan6 ,0);
INTMAP(Index,Chan7 ,0);
INTMAP(Index,Chan8 ,0);
INTMAP(Index,Chan9 ,0);
INTMAP(Index,Chan10,0);
INTMAP(Index,Chan11,0);
INTMAP(Index,Chan12,0);
INTMAP(Index,Chan13,0);
INTMAP(Index,Chan14,0);
INTMAP(Index,Chan15,0);
INTMAP(Index,Chan16,0);
INTMAP(Index,Chan17,0);
INTMAP(Index,Chan18,0);
INTMAP(Index,Chan19,0);
END;
END "for";
    
    IF
         NOT Channel!Enabled[Channel]
    THEN
    BEGIN
         ENABLE(NEWENB(Interrupt!Channel!Base+Channel));
         Channel!enabled[Channel]_true;
    END;

    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>Attach!interrupt exit",CRLF%);ENDC

END "ATTACHINTERRUPT";

COMMENT*************************************************************
*                                                                  *
*                               SEND!ID                            *
*                                                                  *
*******************************************************************;

PROCEDURE SEND!ID(INTEGER Line);

BEGIN "SENDID"

    STRING Logonstr;

    INTEGER Script;

    Script _ User!script[Line];
    
    Logonstr _ Idprefix[Script] ;	\ Equ to Project Code, eg., "DD";
	\ project code and login test
						code;
    User!on[Line] _ True;
    IF
	Debug!data
    THEN
	s!print(%">> "%);
     IF Line!test THEN s!print(%"Line " & CVS(Line)%);
     s!print(%Logonstr,CRLF%);
    Logonstr _ Logonstr & CR;

    IF
         Debug!test
    THEN
         s!print( %"**Begin test ",User!Loops[Line]+1," Line "
							,Line," **",CRLF%);
    Simple!output(Line,Logonstr);

END "SENDID";

COMMENT*************************************************************
*                                                                  *
*                               Picksendid                            *
*                                                                  *
*******************************************************************;

STRING PROCEDURE picksendid ( INTEGER line );
BEGIN
    INTEGER i,j;
    STRING id;

	id _ NULL;
	Send!ptr _ Send!ptr + 1;
	IF
		Send!ptr > user!max
	    OR
		Send!ptr < 1
	THEN
		Send!ptr _ 1;
	id _ " " & Users[Send!ptr];
    RETURN(id);
END;

COMMENT **************************************************************
*                                                                    *
*                              INITIALIZE!FILES                      *
*                                                                    *
*********************************************************************;

PROCEDURE INITIALIZE!FILES(INTEGER F);

BEGIN "INITIALIZEFILES"

    BOOLEAN Err,Flag,First,Value;

    STRING Dataline;
    Record!pointer(Sdata) Rectxt,Nxttxt;
    INTEGER Chan,fileno;
    
	First _ FALSE;
    Err _ FALSE;
    Fileno _ 0;
    SETBREAK(Texttab_Getbreak,LF,NULL,"INS");
    WHILE
         Fileno < F
    DO
    BEGIN
	IF
	    Disk!Channel[Fileno] GEQ 0
	THEN
	    RELEASE(Disk!Channel[Fileno]);
         OPEN(Chan _ Getchan,"DSK",0,2,0,132,Brchar,Texteof);
         LOOKUP(Chan,Scriptid[fileno],flag);
         IF
              Flag
         THEN
         BEGIN
              t!print( %"No file: ",Scriptid[fileno],CRLF%);
		RELEASE(DISK!CHANNEL[Fileno]);
		t!print(%"Enter File Name:"%);
		Scriptid[Fileno] _ Getdata;
		Fileno _ Fileno - 1;
         END
         ELSE
              Disk!Channel[Fileno] _ Chan;
         Fileno _ Fileno + 1;
    END;

    BEGIN
         FILENO _ 0;
         WHILE
              Fileno < F
         DO
         BEGIN
              Texteof _ False;
              Rectxt _ New!Record(Sdata);
              Dataline _ INPUT(Disk!Channel[Fileno],Texttab);
              IF
			Texteof
              THEN
                   t!print( %"**Error in Script file - no data",CRLF,
                         "**Script ",Fileno," File ",Scriptid[Fileno],CRLF%);
		IF
                   Texteof AND NOT EQU(Dataline[1 to 2],"#!")
		THEN
		BEGIN
		First _ TRUE;
		Firstline[Fileno] _ rectxt;
              Sdata:Sstring[Rectxt]_ Dataline;
              Sdata:Sptr[Rectxt] _ Null!record;
		END;
              WHILE
                   NOT Texteof
              DO
              BEGIN
                   Nxttxt _ New!record(Sdata);
                   Dataline_Input(Disk!Channel[Fileno],Texttab);
                   IF
		   NOT Texteof AND NOT (Value _ EQU(Dataline[1 to 2],"#!"))
                   THEN
                   BEGIN
                        Sdata:Sptr[Rectxt] _ Nxttxt;
                        Sdata:Sstring[Nxttxt] _ Dataline;
                        Sdata:Sptr[Nxttxt]_Null!record;
                        Rectxt_Nxttxt;
                   END;
		IF NOT First	\ need for IF first line is a comment;
		THEN
		    BEGIN
			Firstline[Fileno] _ rectxt;
			First _ NOT Value;
		    END;
              END;
              Fileno _ Fileno + 1;
         END;
         Files!initialized _ TRUE;
    END;

END "INITIALIZEFILES";

COMMENT***********************************************************************
*                                                                            *
*                                ATTACH!ZAP                                  *
*                                                                            *
*****************************************************************************;

PROCEDURE Attach!zap(INTEGER Line);

BEGIN "ATTACHZAP"

    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>Attach!zap entered:",Line,CRLF%); ENDC

    INTMAP(TINASS(Port#[Line],
                  Cause!TTY!zap,
                  Zap!channel),
           DFRINT,
           (-2 LSH 18) + LOCATION(Zapblock[0]));
    
    IF
         NOT Zap!enabled
    THEN
    BEGIN
         ENABLE(NEWENB(Zap!Channel));	\ THIS IS 1 LSH 9 + CHANNEL;
         Zap!enabled_true;
    END;

    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>Attach!zap exit",CRLF%); ENDC

END "ATTACHZAP";

COMMENT**********************************************************************
*                                                                           *
*                             SIMPLE!OUTPUT                                 *
*                                                                           *
****************************************************************************;

RECURSIVE PROCEDURE Simple!output(INTEGER Line;STRING Str);

BEGIN "SIMPLEOUTPUT"

    INTEGER Portno,I,Logout,Len;
    STRING Temp,Str2;

    INTEGER ARRAY OUT!MSG[0:255];
    IFC DEBUG!CMD
    THENC IF DEBUG  THEN s!print( %">>Simple!output entered:",STR
                                       ,CRLF %); ENDC
	IF Debug!trace
	THEN
	BEGIN "trace"
	S!Print(%"Simple!output: NOW=",now,
		" Since last=",Sen!Last_NOW-Sen!Prev,
		crlf%);
	Sen!Prev _ now;
	END "trace";
    IF
	EQU(str,Cntrollee!Quit)
    THEN
	BEGIN		\ Turn off lost prompt if log off being sent;
	    User!lostPrmpt[Line] _ 0;
\	    Olog _ TRUE;	\ Signal LOG OUT condition;
	    Logout _ TRUE;
	END
    ELSE
	    Logout _ FALSE;

    IF
	STR = CR
    THEN
    BEGIN
	user!msgtx[line] _ user!msgtx[line]+1;	\ MSG OUTPUT stats;
	user!bccount[line] _ user!bccount[line]+1;
    END;
    IF
         (Portno_Port#[Line])LEQ 0
    THEN
         t!print( %"**Bad Port:",Portno,"(Line:",Line,")",CRLF%)
    ELSE
    BEGIN
         FOR I _ 1 STEP 5 UNTIL LENGTH(Str)
         DO
              Out!msg[I%5]_CVASC(Str[I for 5]);
         Out!msg[(I%5)+1] _ 0;
         Auxclv(Portno,POINT(7,Out!msg[0],-1),Auxcal!outptr);
    END;
	IF
	    Logout
	THEN
	    CALLI(Calli!hiber!Sec 
			+ 5,
			Calli!Hiber);
    User!charsent[Line]_User!charsent[line]+(I_Length(Str));
    Total!chars!sent _ Total!chars!sent + I;
\        print ("Simple!output: User!charsent=",User!charsent[Line],
            " I =",I);
    Lastout[Line]_Str;
         IF
		Debug!data or User!Monitor[Line]
	THEN
		    BEGIN
	s!print(%">>"%);
	IF Port!test THEN s!print(%" Port:" & CVS(Portno)," "%);
	IF Line!test THEN s!print(%"(Line:" & CVS(Line) & ") *"%);
	Str2 _ NULL;
	Len _ LENGTH(str);
	FOR I _ 1 STEP 1 UNTIL Len
	DO
	BEGIN "control!search"
	    Temp _ LOP(str);
	    IF
		Temp < '40
	    THEN
		Str2 _ Str2 & "^" & (Temp + '100)
	    ELSE
		Str2 _ Str2 & Temp;
	END "control!search";
	s!print(%Str2,CRLF%);
    END; 

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print(%">>Simple!output exit",CRLF%); ENDC

END "SIMPLEOUTPUT";

COMMENT*********************************************************************
*                                                                          *
*                              INT!TURN!OFF                                  *
*                                                                          *
***************************************************************************;
	PROCEDURE Int!turn!off(INTEGER Line);
BEGIN "intturnoff"
	INTEGER Channel, Portno,Index;
	Portno _ Port#[Line];
	Index _ TINASS(Portno,CAUSE!TTY!CHR,0);
	Channel _ Channel#[Line];
	CASE Channel OF
	BEGIN
[0]		INTMAP(Index,Chan0,0);
[1]		INTMAP(Index,Chan1,0);
[2]		INTMAP(Index,Chan2,0);
[3]		INTMAP(Index,Chan3,0);
[4]		INTMAP(Index,Chan4,0);
[5]		INTMAP(Index,Chan5,0);
[6]		INTMAP(Index,Chan6,0);
[7]		INTMAP(Index,Chan7,0);
[8]		INTMAP(Index,Chan8,0);
[9]		INTMAP(Index,Chan9,0);
[10]		INTMAP(Index,Chan10,0);
[11]		INTMAP(Index,Chan11,0);
[12]		INTMAP(Index,Chan12,0);
[13]		INTMAP(Index,Chan13,0);
[14]		INTMAP(Index,Chan14,0);
[15]		INTMAP(Index,Chan15,0);
[16]		INTMAP(Index,Chan16,0);
[17]		INTMAP(Index,Chan17,0);
[18]		INTMAP(Index,Chan18,0);
[19]		INTMAP(Index,Chan19,0);
		ELSE
		    t!print(%"INVALID Channel no ",Channel," in intturnoff",
				CRLF%)
		END;
END "intturnoff";

COMMENT*********************************************************************
*                                                                          *
*                              ZAP!TURN!OFF                                  *
*                                                                          *
***************************************************************************;
	PROCEDURE ZAP!TURN!OFF(INTEGER Portno);
BEGIN "zapturnoff"
	INTMAP(TINASS(Portno,CAUSE!TTY!ZAP,0),	\ The 0 turns off;
		DFRINT,
		(-2 LSH 18) + LOCATION(Zapblock[0]));
END "zapturnoff";


COMMENT*********************************************************************
*                                                                          *
*                              CLEAN!UP                                  *
*                                                                          *
***************************************************************************;
	Procedure CLEAN!UP( INTEGER Line);
BEGIN "cleanup"
	INTEGER Inx,I,Channel;
	Port#[Line] _ -1;
	Inx _ Channel!Inx[Line];
	Channel _ Channel#[Line];
	Chan!Port[Channel,Inx] _ -1;
	IF
		Ports!connected > 0
	THEN
		Ports!connected _ Ports!connected -1;
	User!on[Line] _ FALSE;
	User!lostPrmpt[Line] _ 0;	\ Turn off lost prmpt timer;
END "cleanup";


COMMENT*********************************************************************
*                                                                          *
*                              DISCONNECT                                  *
*                                                                          *
***************************************************************************;


	PROCEDURE Disconnect(INTEGER Line);
BEGIN "disconnect"
	INTEGER Portno;
	Portno _ Port#[Line];
	IF
		Portno > 0
	THEN
	    BEGIN
		Zap!turn!off(Portno);
		Int!turn!off(Line);
\	zap circuit;
	CALLI(Portno,CALLI!ZAPCIR);
\	clean up globals;
	    END;
	CLEAN!up(Line);
END "disconnect";

COMMENT*********************************************************************
*                                                                          *
*                              DISCONNECT                                  *
*                                                                          *
***************************************************************************;

PROCEDURE DDISCONNECT(INTEGER Line);

BEGIN "DISCONNECT"

    INTEGER Portno,channel,Inx,Index;

    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>Disconnect entered:",Line,CRLF%); ENDC

    Portno _ Port#[Line];
    IF
         PORTNO>0
    THEN
  BEGIN
    Channel _ Channel#[Line];

			\ TURN OF ZAP INTERRUPT;
    INTMAP(TINASS(Portno,
                  Cause!TTY!zap,
                  0),	\ THE 0 TURNS IT OFF;
           DFRINT,
           (-2 LSH 18) + LOCATION(Zapblock[0]));

    Index _ TINASS(Portno,
                  Cause!TTY!Chr,
                  0);
		\ TURN OFF INPUT INTERRUPTS FROM CURCUITS;
    CASE Channel OF
    BEGIN
         INTMAP(Index,Chan0 ,0);
         INTMAP(Index,Chan1 ,0);
         INTMAP(Index,Chan2 ,0);
         INTMAP(Index,Chan3 ,0);
         INTMAP(Index,Chan4 ,0);
         INTMAP(Index,Chan5 ,0);
         INTMAP(Index,Chan6 ,0);
         INTMAP(Index,Chan7 ,0);
         INTMAP(Index,Chan8 ,0);
         INTMAP(Index,Chan9 ,0);
         INTMAP(Index,Chan10,0);
         INTMAP(Index,Chan11,0);
         INTMAP(Index,Chan12,0);
         INTMAP(Index,Chan13,0);
         INTMAP(Index,Chan14,0);
         INTMAP(Index,Chan15,0);
         INTMAP(Index,Chan16,0);
         INTMAP(Index,Chan17,0);
         INTMAP(Index,Chan18,0);
         INTMAP(Index,Chan19,0);
    END;

	COMMENT		ZAP CIRCUIT;
         CALLI(Portno,Calli!Zapcir);


	\ CLEAN UP GLOBALS;
    Port#[Line] _ -1;
    Inx _ Channel!Inx[Line];
    Chan!Port[Channel,Inx] _ -1;
IF
    PORTS!CONNECTED > 0
THEN
    Ports!Connected _ Ports!Connected -1;
    User!on[Line] _ False;
    User!LostPrmpt[Line] _ 0;	\ Turn off LostPrmpt timer;
  END;

    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>Disconnect exit",CRLF%); ENDC

END "DISCONNECT";

COMMENT******************************************************************
*                                                                       *
*                         INTERRUPT!HANDLER                             *
*                                                                       *
************************************************************************;

RECURSIVE PROCEDURE Interrupt!handler(INTEGER Channel);

BEGIN "INTERRUPTHANDLER"

    INTEGER M,Char,Temp,LINE;
	STRING st1,st2;

	IF Debug!trace
	THEN
	BEGIN "trace"
	S!Print(%"Interrupt: NOW=",now,
		" Since last=",Int!Last_NOW-Int!Prev,
		crlf%);
	Int!Prev _ now;
	END "trace";
    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>Interrupt!handler entered:",Channel,CRLF%); ENDC

	IF
		test!ports
	THEN
		Ports!cmd;
    IF ichan NEQ Channel THEN ichan _ Channel;	  \ Lost prompt kludge;
    FOR M _ 1 STEP 1 UNTIL Chan!Port[Channel,0]
    DO
     BEGIN "step"

\	s!print( %"Interrupt!handler: M=",M," Chan!port[Channel,M]=",
	Chan!Port[Channel,M]%);

	IF
	    (Temp _ Chan!Port[Channel,M]) > 0
    	THEN
	    BEGIN "input"
	comment 	pick up char;
            Char_AUXCLV(Temp,0,Auxcal!inchrs);
         IFC
              Debug!int
         THENC
              IF DEBUG THEN
              s!print( %">>",Temp,":",
              IF
                   !SKIP!
              THEN
                   "True'"&Cvos(Char)
              ELSE
                   "False",CRLF%);
         ENDC
         WHILE
              !SKIP!

         DO
         BEGIN "Process"
               LINE _ CHAN!LINE[CHANNEL,M];
              User!charrecd[Line]_User!charrecd[line] +1;
              Total!Chars!recd_Total!chars!recd + 1;
              IF
                   Char NEQ LF
              THEN
              BEGIN "not!lf"
                   IF
                        Char = CR
                   THEN
                   BEGIN "cr"
                             IF
				Textmode OR Debug!data OR User!Monitor[Line]
			     THEN
\ pg
				IF   NOT EQU(InLine[Line],NULL)
			THEN
pg ;
			    BEGIN
				s!print(%"##"%);
				IF Port!test THEN s!print(% " Port:" &
						 CVS(temp)," "%);
				IF Line!test THEN s!print(% "(Line:" &
						 CVS(Line) & ") *" %);
				s!print(
				%InLine[Line],CRLF%);
			    END;
			user!msgrx[Line]_user!msgrx[Line] + 1;
			user!msgcount[Line]_user!msgcount[Line] + 1;
                        Lastin[Line]_Inline[Line];
                        Inline[LINE]_NULL;
			User!FcharRecd[Line] _ FALSE;
                   END "cr"
                   ELSE	\ not cr;
                   IF
                        NOT User!FCharRecd[Line]
                   THEN
                   BEGIN "first!char!received"
			IF
			    debug!trace
			THEN
			s!print(%"!"%);
                        User!FCharRecd[Line] _ TRUE;
			InLine[Line] _ InLine[Line] & Char; \ char to printline;
                        Temp_User!Prompt[Line];
                        IF Temp = SW!Time!Send
                        THEN
                          User!Prompt[Line]_Sw!Time!Send!FCR
                        ELSE
                        IF Temp = SW!Time!Read
                        THEN

                          User!Prompt[Line]_Sw!Time!Read!FCR;
\ pg		    IF (TEMP = SW!TIME!SEND)
			OR
		       (TEMP = SW!TIME!READ)
                      THEN
                          Do!Next(Line,True);
                        User!Prompt[Line]_Temp;
                        IF Char = Prmpt
                        THEN
                        BEGIN "promt"
			IF
			    debug!trace
			THEN
			s!print(%"@"%);
				Prompt!seen[Line] _ TRUE;
				IF
				    Olog = FALSE
				THEN
                              User!LostPrmpt[Line] _ NOW + ReqPrmpt!Time;
                        END "promt";
                   END "first!char!received"
\ pg                   ELSE
 pg ;
\                   IF
                        Char = Prmpt
		   THEN
		   BEGIN "prmt2"
				InLine[line] _ InLine[Line] & Char;
\ pg			    IF
				NOT Debug!norm
			    THEN
				BEGIN
                             Do!next(Line,true);
\ pg			     IF
				Olog = FALSE
			     THEN
                             User!LostPrmpt[Line] _ NOW + ReqPrmpt!Time;
\ pg				END;
\ pg                   END "prmt2"
;
                   ELSE
                   IF
                        Char = '21
                   THEN      \ XON ;
                        User!XOFF[Line] _ False
                   ELSE
                   IF
                        Char = '23
                   THEN      \ XOFF ;
                        User!XOFF[Line] _ True

                   ELSE IF char=msg!prompt THEN
                       BEGIN "msg!prmt"
			InLine[Line] _ InLine[Line] & "^Z";
                       END "msg!prmt"
                   ELSE
			IF CHAR <'40
			THEN
				Inline[line] _ Inline[line] &
					"^" & (Char + '100)
			ELSE
			    IF
				Char < '40
			    THEN
				Inline[line] _ Inline[line] & "^" &
						(Char + '100)
			    ELSE
	                        Inline[LINE]_Inline[LINE]& Char;
              END "not!lf";
              Char _ Auxclv(Temp,0,Auxcal!Inchrs);
              IFC
                   Debug!int
              THENC
                   IF DEBUG THEN
                   s!print( %">>",Temp,":",
                   IF
                        !SKIP!
                   THEN
                        "True'" & Cvos(Char)
                   ELSE
                        "False",CRLF%);
              ENDC
\ pg	IF User!loops[line] = No!of!loops[user!script[line]]
	THEN
		DONE;		\ if the loops are finished, stop;
         END "Process";
         AUXCLV(TEMP,0,AUXCAL!LEVDEF);
    END "input"
 END "step";

    Enable(Newenb(Interrupt!Channel!Base + Channel));
	IF
	    DEBUG!TRACE
	THEN
	S!Print(%"Channel=",Channel,crlf%);

    IFC DEBUG!INT
    THENC IF DEBUG THEN s!print( %">>Interrupt!handler exit",CRLF%); ENDC

IF Debug!trace THEN
t!print( %"I"%);
END "INTERRUPTHANDLER";

COMMENT ***********************************************************
*                                                                 *
*                           ATTACH!DETACH                         *
*                                                                 *
******************************************************************;

RECURSIVE PROCEDURE ATTACH!DETACH(STRING STR;INTEGER LINE);

BEGIN "ATTACHDETACH"

INTEGER Value,Char;

STRING Locstr;

    WHILE
         Length(Str)
    DO
    IF
         "/" < (Char _ LOP(Str)) < ":"
    THEN
         Locstr _ Locstr & Char;
    Locstr _ Locstr & CR;
    Simple!Output(Line,Locstr);

END"ATTACHDETACH";

COMMENT ******************************************************************
*                                                                        *
*                                DO!NEXT                                 *
*                                                                        *
*************************************************************************;

RECURSIVE PROCEDURE DO!NEXT(INTEGER Line;BOOLEAN Prompt);

BEGIN "DONEXT"

    INTEGER Timex,Savepost,CI;

    Savepost _ 0;
    IF
         Prompt
    THEN
	BEGIN "promt!true"
         CI _ User!prompt[Line];
	IF
	    CI = 0
	THEN
	    CI _ User!switch[line];
	END "promt!true"
    ELSE
    BEGIN
         CI _ User!switch[Line];
         Savepost SWAP Post#[Line];
    END;
	IF
		Debug!trace
	THEN
        s!print( %"DO!NEXT:, Prompt=",Prompt,
		" CI=",CI," User!prompt=",User!prompt[Line],
           " User!switch=",User!switch[Line],CRLF%);
\ pg    IF 
                Debug!trace
    THEN
         s!print( %"D",Line,"SW",User!Switch[Line],"T",Now-Savepost%);
    CASE CI OF
    BEGIN "do!case"
         
        [0] BEGIN "noth"                         \ 0 SW!NOTHING;
	REQUIRE 100 POLLING!INTERVAL;

		CALLI(Calli!Hiber!Sec + CALLI!HIBER!BREAK 
			+ 10
			, Calli!Hiber);
	REQUIRE 0 POLLING!INTERVAL;
\ pg              IF
                   Savepost > 0
              THEN
 pg ;
              BEGIN
                   IF
                        Test!Start[Line]
                   THEN
                        IF
                             Test!Ready[Line]
                        THEN
                             Send!next!Line(Line)
                        ELSE
                             Post#[Line] _ Now + 1000
                   ELSE
                        Post#[Line] _ Now + 1000
              END;
         END "noth";

      [1] IF NOT LOGIN(Line) THEN     \ 1 SW!LOGON  ;
             BEGIN "log"
             user!switch[line] _ SW!logon;
             post#[line] _ NOW + 2500;
             END "log"
	  ELSE \ Login has taken place send ID;

		BEGIN "on"
		User!LostPrmpt[Line] _ NOW + ReqPrmpt!Time;
		User!Switch[Line] _ Sw!ID!Cont;
		User!Prompt[Line] _ Sw!ID!Cont;
		post#[line] _ NOW ;
		END "on";

     [2] BEGIN "send"
              SIMPLE!OUTPUT(Line,CR);       \ 2 SW!SEND!CR ;
              Post#[Line] _ Now;
              User!switch[Line] _ Sw!next!line;
		User!FcharRecd[Line] _ FALSE; \ Look for first char flag set pg;
         END "send";

      [3] SEND!NEXT!LINE(Line);         \ 3 SW!NEXT!LINE ;

     [4] BEGIN "time!s"                         \ 4 SW!TIME!SEND ;
              SEnd!next!Line(Line);
         END "time!s";

     [5] BEGIN "time!r"                         \ 5 SW!TIME!READ ;
              Send!Next!Line(Line);
         END "time!r";

     [6] BEGIN "id!stop"                         \ 6 SW!ID!STOP ;
              Send!id(Line);
              User!switch[Line] _ sw!nothing;
         END "id!stop";

     [7] BEGIN "id!cont"                         \ 7 SW!ID!CONT  ;
	      User!switch[Line] _ sw!nothing;	\ So don't send ID twice;
              User!prompt[Line] _ sw!next!line;
		Post#[Line] _ Now;
              Send!id(Line);
         END "id!cont";

     [8] BEGIN "d!conn"                         \ 8 SW!DISCONNECT ;
              IF
                   Port#[Line] > 0
              THEN
              Disconnect(Line);
              Post#[Line]_Now+((Logon!delay[User!script[Line]]*1000)*RAN(0));
              User!switch[Line] _ Sw!logon;
         END "d!conn";

         [9] BEGIN "s!cr!pr"                         \ 9 SW!SEND!CR!PROMPT ;
              Simple!output(Line,CR);
              User!prompt[Line] _ Sw!next!line;
	      User!switch[Line] _ SW!nothing; \ pg;
		User!FcharRecd[Line] _ FALSE; \ Look for first char flag set pg;
		Post#[Line] _ Now;
         END "s!cr!pr";

         [10] BEGIN "s!cr!ti"                         \ 10 SW!SEND!CR!TIME;
              simple!output(line,CR);
              user!prompt[line] _ user!timecell[line];
		user!switch[line] _ sw!nothing;
              user!timecell[line]_NOW;
              User!FCharRecd[Line]_False;   \ Reset when 1st char recvd;
		Post#[Line] _ Now;
         END "s!cr!ti";

         [11] BEGIN "time!g"                                    \ SW!TIME!GET;
              total!files!read_total!files!read+1;
              timex_NOW-user!timecell[line];
              user!gettime[line]_user!gettime[line]+timex;
              total!gettime_total!gettime+timex;
              user!getcount[line]_user!getcount[line]+1;
              IF monitor!chan GEQ 0 THEN
                  BEGIN
                   WORDOUT(MONITOR!CHAN, 18);
                   WORDOUT(MONITOR!CHAN, 3);
                   WORDOUT(MONITOR!CHAN, USER!SCRIPT[LINE]);
                   WORDOUT(MONITOR!CHAN, TIMEX);
                   WORDOUT(monitor!chan,NOW);
                  END ;
		User!Switch[Line] _ SW!next!Line;
		User!Prompt[line] _ SW!nothing;
		Post#[Line] _ now;
         END "time!g";

     [12] BEGIN "s!fcr"                         \ 12 Sw!TIME!SEND!FCR ;

              Total!messages!sent_Total!messages!sent+1;
              Timex _ Now - User!timecell[Line];
              User!sendtime[Line] _ User!sendtime[Line] + Timex;
              Total!send!time _ Total!send!time + Timex;
              User!sendcount[Line] _ User!sendcount[Line] + 1;
              IF monitor!chan GEQ 0 THEN
                  BEGIN
                  WORDOUT(MONITOR!CHAN, mon!sendtmx);
                  WORDOUT(MONITOR!CHAN, 4);
                  WORDOUT(MONITOR!CHAN, USER!SCRIPT[LINE]);
                  WORDOUT(MONITOR!CHAN, TIMEX);
                  WORDOUT(monitor!chan,NOW);
                  WORDOUT(monitor!chan,user!msgtx[line]);
                  END;
		Post#[Line] _ now;
		User!Switch[Line] _ SW!next!Line;
		User!Prompt[line] _ SW!nothing;
         END "s!fcr";
         [13] BEGIN "r!fcr"                         \ 13 SW!TIME!READ!FCR;
              Timex _ Now - User!timecell[Line];
              User!readtime[Line] _ User!readtime[Line] + Timex;
              User!readcount[Line] _ User!readcount[Line] + 1;
              Total!reads _ Total!reads +1;
              Total!read!time _ Total!read!time + Timex;
              IF monitor!chan GEQ 0 THEN
                  BEGIN
                  WORDOUT(MONITOR!CHAN, 17);
                   WORDOUT(MONITOR!CHAN, 4);
                  WORDOUT(MONITOR!CHAN, USER!SCRIPT[LINE]);
                  WORDOUT(MONITOR!CHAN, TIMEX);
                  WORDOUT(monitor!chan,NOW);
                  WORDOUT(monitor!chan,user!msgrx[line]);
                  END;
		Post#[Line] _ now;
		User!Switch[Line] _ SW!next!Line;
		User!Prompt[line] _ SW!nothing;
         END "r!fcr";
	[14] BEGIN "wait!disconnect"
		IF
		    NOT Port#[Line] = -1
		THEN
		    CALLI(CALLI!HIBER!SEC +
			CALLI!HIBER!BREAK
			+ 10,
			CALLI!HIBER)
		ELSE
		    User!Switch[Line] _ SW!Logon;
		END "wait!disconnect"
    END "do!case";

END "DONEXT";

\ REQUIRE 100 POLLING!INTERVAL;

COMMENT*****************************************************************
*                                                                      *
*                            BUILDCCT                                  *
*                                                                      *
***********************************************************************;

PROCEDURE Buildcct(STRING Loginstring;
                   REFERENCE INTEGER Portnumber;
                   REFERENCE BOOLEAN Success);
BEGIN "BUILDCCT"

    INTEGER ARRAY Login[0:5];
    INTEGER I,Devstat;

    IFC Debug!int OR Debug!cmd THENC
                   IF DEBUG THEN
                   s!print( %">>Buildcct entered:",loginstring,":",Portnumber,
                             ":",Success,CRLF%);
    ENDC

    FOR I _1 STEP 5 UNTIL 29 MIN LENGTH(Loginstring)
    DO
         Login[I%5] _ Cvasc(Loginstring[I for 5]);
    
	COMMENT		CREATE AN AUX CIRCUIT;
    Portnumber _ Calli(LOCATION(Login[0]),Calli!Creaux);

    Success _ !SKIP!;

    IF 
         Success
    THEN
    BEGIN
         Ports!connected _ Ports!Connected + 1;
    END;

    IFC Debug!int OR Debug!cmd THENC IF DEBUG THEN s!print( %">>Buildcct exit:",
                                      Portnumber,":",Success,CRLF%); ENDC

END "BUILDCCT";

COMMENT*******************************************************************
*                                                                        *
*                            LOGIN                                       *
*                                                                        *
*************************************************************************;

BOOLEAN PROCEDURE Login(INTEGER Line; STRING User(NULL));

BEGIN "LOGIN"

    STRING Loginstr;
    INTEGER Port;
    BOOLEAN Result;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">>Login entered:",Line,CRLF%);ENDC

    IF
	User = NULL
    THEN
	BEGIN
	    Loginstr _       Username &";;" ;
	    Nextline[Line] _ Firstline[User!script[Line]];
	END
    ELSE
	Loginstr _ User & ";;";

    IFC Debug!cmd THENC IF DEBUG THEN s!print( %Loginstr,CRLF%); ENDC
    User!on[Line] _ False;
    Buildcct(Loginstr,Port,Result);
    If Result
    THEN
    BEGIN
         Port#[Line]_Port;
         IFC DEBUG!CMD
         THENC IF DEBUG THEN s!print( %">>Login good exit",CRLF%); ENDC

         IF
              User!switch[Line] = sw!logon
         THEN
	 BEGIN
	      User!switch[Line] _ sw!id!cont;	\ Type ahead if no prompt recv'd;
              User!prompt[Line] _ sw!id!cont;
	 END;
         Attach!zap(Line);
         Chan!Port[Channel#[Line],Channel!inx[Line]]_Port;
         Attach!Interrupt(Channel#[Line],Line);
    \    Simple!Output(Line,CR);
         RETURN(TRUE);
    END;
    t!print( %"**Bad Logon**, line",Line,CRLF%);
    JUNK _ Port LAND '777777;
    Result _ Port   LSH - 18;
    CASE Result OF
    BEGIN

[0]	BEGIN "superror"
	      t!print( %"ERROR:",JUNK,CRLF%);
		CASE Junk OF
		BEGIN "supcode"
	[0]	t!print(%"UNKNOWN SUP ERROR",CRLF%);
	[1]	t!print(%"Format error in Login string",CRLF%);
	[2]	t!print(%"Invalid Login Name:",Loginstr,CRLF%);
	[3]	t!print(%"MUD unreadable due to disk error",CRLF%);
	[4]	t!print(%"Destination host cannot be reached:
				CIRCUITS BUSY
				OUT OF PORTS
				HOST SHUT
				NOT VALID ON HOST",CRLF%);
	[5]	t!print(%"Error related to dialout request",CRLF%);
	[6]	t!print(%"TIMEOUT",CRLF%);
	ELSE
			t!print(%"UNKNOWN SUP ERROR",CRLF%)
	END "supcode";
	END "superror";
[1]      t!print( %"MAX 2 AUX CIRCUITS",CRLF%);
[2]	 t!print(%"AC License Needed",CRLF%);
[3]      t!print( %"NO ROOM IN MONITOR FOR AUX CIRCUIT",CRLF%);
[4]      t!print( %"SUPERVISOR DID NOT ANSWER",CRLF%);
[5]      t!print( %"SUPERVISOR DID NOT RESPOND TO LOGIN",CRLF%);
[6]      t!print( %"SUPERVISOR:DID NOT SUPPLY A CIRCUIT",CRLF%);
[7]      t!print( %"SUPERVISOR ERROR code ",CRLF%)
    END;

    t!print( %"**Sup code ",Junk,"**",CRLF%);
    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">>logon bad exit",CRLF%); ENDC

        PORT_0;         \ CLEAR PREVIOUS BAD RESULT;
    RETURN(FALSE);

END "LOGIN";
REQUIRE 100 POLLING!INTERVAL;

COMMENT **************************************************************
*                                                                    *
*                           SEND!NEXT!LINE                           *
*                                                                    *
*********************************************************************;

RECURSIVE PROCEDURE SEND!NEXT!LINE(INTEGER Line);

BEGIN "SENDNEXTLINE"

    INTEGER Script,Firstchar,I,Char,brchr,numb,junk;
    RECORD!POINTER(Sdata) Recptr;
    STRING Dataline,Savedata;

    IF
         User!Xoff[Line]
    THEN
    BEGIN
         Post#[Line] _ Now + 1000;
         User!switch[Line] _ sw!next!line;
         RETURN;
    END;
    
    Script _ User!script[Line];
    Recptr _ Nextline[Line];
    IF
         Recptr = Null!record
    THEN
         t!print( %"**Error in script file - eof reached, #8 or #4 forgotten",CRLF,
               "**Line ",Line," Script ",Script," File: ",Scriptid[script],CRLF%)
    ELSE
    BEGIN "firstchar"
         Dataline _ Sdata:Sstring[Recptr];
         Nextline[Line]_Sdata:Sptr[Recptr];
         Firstchar _ Dataline;
	IF
		Debug!trace
	THEN
        s!print( %"SEND!NEXT!LINE: Firstchar='",CVOS(Firstchar)," ",
                "Lenght=",Length(DataLine) ,CRLF%);
	IF
		Firstchar = "#"
	THEN
	BEGIN "control"
		Junk _ LOP(Dataline);
              Firstchar _ LOP(Dataline);
		Firstchar _ Upper(Firstchar);
		IF Debug!trace
		THEN
			S!print(%"Send!Next!Line: SecondChar='",
				CVOS(Firstchar),CRLF%);
			Post#[Line] _ Now;
	CASE Firstchar  OF
	BEGIN "sendcase"
["#"]              BEGIN          \ Real data ;
                   I _ Length(Dataline);
                   Simple!output(Line,Dataline[1 to INF -1]);
                   Post#[Line] _ Now + (I*Deltime);
                   User!Prompt[Line] _ Sw!nothing;
                   User!switch[Line] _ SW!send!cr;
              END;
["1"]              BEGIN     \ TIME THE SEND LINE ;
              user!msgtx[line] _ 0;
                   User!prompt[Line] _ SW!nothing;
                   user!timecell[line] _ SW!time!send!fcr;
                   User!switch[Line] _ Sw!SEND!CR!TIME;
\ OLD ONTYME CODE
                  Dataline _ Dataline [1 to INF -1]& Picksendid(Line);
                   post#[line]_NOW+(deltime*LENGTH(dataline));
\ PG	          Simple!Output(Line,Dataline);
                   Simple!Output(Line,dataline[1 TO INF-1]);
              END;
["2"]              BEGIN     \ TIME THE READ LINE ;
              user!msgrx[line] _ 0;
                   User!Prompt[Line] _ SW!nothing;
                   user!timecell[line] _ SW!time!read!fcr;
                   User!switch[Line] _ SW!SEND!CR!TIME;
                   post#[line]_NOW+(deltime*LENGTH(dataline));
                   Simple!Output(Line,dataline[1 TO INF-1]);
              END;
["3"]              BEGIN     \ wait for prompt;
                   I _ Length(Dataline);
\ pg                   IF
                        I > 1
                   THEN
                   BEGIN
; \ pg;
                        Simple!output(Line,Dataline[1 to INF-1]);
                        Post#[Line] _ Now + (I*Deltime);
                        User!prompt[Line] _ sw!nothing;
                        User!switch[Line] _ SW!send!cr!prompt;
                        User!charsent[Line] _ User!charsent[Line]+I;
\ pg                   END
                   ELSE
                   BEGIN
; \ pg;
\ pg                        User!Prompt[Line]_Sw!next!line;
\ pg                        User!Switch[Line]_sw!nothing;
\ pg                   END;
              END;
["4"]              BEGIN     \ END OF LOOP;
                   Total!loops _ Total!loops + 1;
                   I _  (user!loops[Line]_User!loops[Line] + 1);
                   IF
                        No!of!loops[Script] = 0
                   OR
                        I       < No!of!loops[script]
                   THEN
                   BEGIN
                        Simple!Output(Line,Cntrollee!Quit);
			Post#[Line] _ now + ((Logon!Delay[Script] * 1000)*RAN(0));
                        User!prompt[Line] _ Sw!nothing;
                        User!switch[Line] _ SW!Wait!Disconnect;
                        IF Debug!test THEN s!print( %"**End test line ",Line," **",
                               CRLF%);
                   END
                   ELSE
                   BEGIN
                        Test!start[Line] _ false;
                        test!ready[Line] _ false;
                        Simple!output(Line,Cntrollee!Quit);
                        User!prompt[Line] _ Sw!nothing;
                        User!switch[Line] _ Sw!nothing;
                        t!print( %"**end of all tests, Line ",Line,"**",CRLF%);
                   END;
              END;
["5"]              BEGIN          \ SEND Cntrl - N ;
                   IF Length(Dataline) > 1
                   THEN
                   BEGIN
                        Char _LOP(Dataline)-'100;
                   END ELSE
                        Char _ '16;
                   Simple!output(Line,Char&Null);
                   User!prompt[Line] _ Sw!next!Line;
              END;
["6"]              BEGIN          \ NON-timed send ;
                   Dataline _ Dataline[1 to INF-1]&Picksendid(Line);
                   Simple!Output(Line,Dataline);
                   User!Prompt[Line] _ SW!next!line;
                   User!switch[Line] _ SW!nothing;
                   Total!Messages!sent_Total!messages!sent+1;
              END;
["7"]              BEGIN	\ search for @ in line and replace with counter;
                   Savedata _ NULL;
                   WHILE
                        (CHAR_LOP(dataline)) NEQ "@" AND Length(Dataline)
                   DO
                        Savedata_Savedata & Char;
                   I_CVD(dataline);
                   Savedata_Savedata & CVS(Counts[I])&CR;
                   Simple!Output(line,Savedata);
                   User!switch[Line] _SW!next!line;
                   User!Prompt[Line]_SW!nothing;
                   Post#[Line]_Now;
              END;
["8"]              BEGIN  \ start at the top of script file;
                   Total!loops_Total!loops+1;
                   I _ (User!loops[Line]_User!Loops[Line]+1);
                   IF
                        NO!of!Loops[Script] = 0
                   OR
                        I < No!Of!Loops[Script]
                   THEN
                   BEGIN
                        Nextline[Line]_Firstline[Script];
                        Post#[Line]_Now+((Logon!delay[Script]*1000)*RAN(0));
                        User!switch[Line]_Sw!next!line;
                        IF
                             Debug!Trace
                        THEN
			BEGIN "trace"
                             s!print( %"**End loop ",I,", Line ",Line," **",CRLF%);
			    s!print(%"Time thru Loop=",Loop!Last[Line] _
			now - Loop!Prev[Line],crlf%);
			END "trace";
                   END
                   ELSE
                   BEGIN
                        User!Prompt[Line]_sw!nothing;
                        User!switch[Line]_sw!nothing;
                        Simple!Output(Line,Cntrollee!Quit);
			IF DEBUG THEN
                        s!print( %"**End of all loops, line ",LIne," **",CRLF%);
\ PG			monitor!interval _ 0;	\ slow down the
								timer;
                   END;
		Loop!Prev[Line] _ now;
              END;
["9"]              BEGIN  \ modify counter;
                   WHILE
                        Dataline NEQ "@" AND Length(Dataline)
                   DO
			Junk _ LOP(Dataline);
                   Junk _ LOP(Dataline); \ pick off @ ;
                   I _ INTSCAN(DATALINE,JUNK);
                   WHILE
                        Dataline = " "
                   DO
                        Junk _ LOP(Dataline);
                   Char _ LOP(Dataline);
                   IF
                        Char = "="
                   THEN
                        Counts[I]_CVD(Dataline)
                   ELSE
                   IF
                        Char =  "+"
                   THEN
                        Counts[I]_Counts[I]+CVD(Dataline)
                   ELSE
                   IF
                        Char = "-"
                   THEN
                        Counts[I] _ Counts[I] - CVD(DATALINE);
                   User!Prompt[Line] _ SW!nothing;
                   User!Switch[Line] _ SW!next!line;
                   Post#[Line] _ Now;
              END;
["A"]                 BEGIN
                     numb _ INTSCAN(Dataline,brchr);
                     IF brchr THEN
                     BEGIN
                         t!print( %"**ERROR IN TIMEOUT FOR SCRIPT ",
                               SCRIPTID[SCRIPT],CRLF%);
                     END ELSE
                     BEGIN
                         User!switch[Line] := sw!next!line;
                         Post#[Line] := now + (numb*1000);
			 User!LostPrmpt[Line] _ Post#[Line] + 1000;
                     END;
              END;
["B"]                    BEGIN
                   user!prompt[line]_SW!nothing;
                   user!timecell[line] _ SW!time!get;
                   user!switch[line]_SW!SEND!CR!TIME;
                   post#[line]_NOW+(deltime*LENGTH(dataline));
                    Simple!Output(line,dataline[1 TO INF-1]);

               END;
	
["'"]		BEGIN \ send a control character;

			numb _ INTSCAN(Dataline,brchr);
			IF brchr THEN
				t!print(%"** ERROR in control char from script",
				Scriptid[script],crlf%)
				ELSE
				BEGIN
					User!Prompt[Line]_Sw!Next!Line;
					User!Switch[Line]_Sw!Nothing;
					Simple!output(Line,numb & CR);
				END;
		END;
["L"]		BEGIN \ Log off and Logon New User;
REQUIRE 0 POLLING!INTERVAL;
			Disconnect(Line);
			DO
			    Junk _ NULL	\ dummy line;
			UNTIL
			    Login(Line,Dataline);

			Simple!Output(line,CR);
			User!Prompt[Line] _ SW!Next!Line;
			User!Switch[Line] _SW!Next!Line;
		END;
["Y"]		BEGIN  \ Turn on interrupts;
		Attach!Zap(Line);
	END;
["P"]		BEGIN	\ Change the Prmpt;
			Prmpt _ LOP(DataLine) & NULL;
			User!switch[Line] _ Sw!Next!Line;
		END;
["Q"]		BEGIN  \ Change the Log off string;
		    Cntrollee!Quit _ Dataline[1 to INF-1];
			User!switch[Line] _ SW!Next!Line;
		END;
["Z"]		BEGIN  \ Turn off zaps;
		    Zap!turn!off(Port#[Line]);
			User!switch[Line] _ Sw!Next!Line;
REQUIRE 100 POLLING!INTERVAL;
		END;
	ELSE
		t!print(%"**Error in Script file - ?#",CVS(Firstchar),"?",CRLF,
			"**Line ",Line," Script ",Script," Script file:",
			Scriptid[Script],CRLF%)
	END "sendcase";
	END "control"
         ELSE
         BEGIN
              I _ Length(dataline);
              Simple!output(Line,Dataline[1 to INF -1]);
              Post#[Line] _ Now +(I*deltime);
              User!prompt[Line] _ Sw!nothing;
              user!switch[Line] _ sw!send!cr;
         END
   END "firstchar";
END"SENDNEXTLINE";

COMMENT**********************************************************************
*                                                                           *
*                                 READ!COMMAND                             *
*                                                                           *
****************************************************************************;

PROCEDURE READ!COMMAND;

BEGIN "READCOMMAND"

    INTEGER Char;

    Char _ Auxclv(-1,0,Auxcal!inchrs);
    WHILE
         !SKIP!
    DO
    BEGIN
    IF
         Char NEQ LF
    THEN
    BEGIN
         IF Char = CR
         THEN
         BEGIN
              Commandport;
              Instring _ NULL;
         END
         ELSE
              Instring _ Instring & Char;
    END;
    Char _ Auxclv(-1,0,Auxcal!Inchrs);
    END;

END "READCOMMAND";

COMMENT****************************************************************
*                                                                     *
*                             Help!cmd                                *
*                                                                     *
**********************************************************************;

PROCEDURE Help!cmd(STRING Object("1"));

BEGIN "HELPCMD"
     INTEGER I;
    STRING TEXT;
    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Help Command entered:",Object,CRLF%);
    ENDC

	IF
		EQU(Object,NULL)
	THEN
		Object _ "1";
    I _ CVD(Object);
    IF
         0 < I < Port!Limit
    THEN
         IF
              Port#[I] > 0
         THEN
         BEGIN
              t!print( %"*"%);
	WHILE
		NOT
              EQU(Text _ Getdata,".")
		DO
		BEGIN
		IF
			!SKIP! NEQ CR
		THEN
			text _ text & !SKIP!;
              Simple!Output(I,Text & CR);
              Auxclv(Port#[I],0,Auxcal!Levdef);
		URSCHD;
		CALLI(CALLI!HIBER!MIN
			+ CALLI!HIBER!BREAK
\			+ CALLI!HIBER!YELLOW
;
			+ 10
			,CALLI!HIBER);
		URSCHD;
		DDFINT;
		CALLI(CALLI!HIBER!MIN
			+ CALLI!HIBER!BREAK
\			+ CALLI!HIBER!YELLOW
;
			+ 10
			,CALLI!HIBER);
		URSCHD;
		DDFINT;
		URSCHD;
		DDFINT;
		CALLI(CALLI!HIBER!min
			+ CALLI!HIBER!BREAK
\			+ CALLI!HIBER!YELLOW
;

			+ 10
			,CALLI!HIBER);
		DDFINT;
		URSCHD;
		t!print(%"*"%);
		END;
         END
         ELSE
              t!print( %"**Port not connected**",CRLF%)
    ELSE
         t!print( %"?",Object,"?",CRLF%);

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Help  Command exit",CRLF%); ENDC

END "HELPCMD";

COMMENT****************************************************************
*                                                                     *
*                             TEST!CMD                                *
*                                                                     *
**********************************************************************;

PROCEDURE Test!cmd(STRING Object);

BEGIN "TESTCMD"

    INTEGER Line;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Test Command entered:",Object,CRLF%);
    ENDC
    Sen!Prev _ Int!Prev _ Tim!Prev _ now;

    IF
         NOT (Flatout OR Rate > 0)
    THEN
    BEGIN
         t!print( %"**No rate specified**",CRLF%);
         RETURN;
    END;

    IF
         Running
    THEN
    BEGIN
         t!print( %"**Test in Progress**",CRLF%);
         t!print( %"**Adding morecircuits**",CRLF%);
         FOR Line _ Max!Line step 1 until Max!port
         DO
              User!prompt[Line] _ sw!id!cont;
		User!Switch[Line] _ sw!next!line;
         Connect!cmd(Object);
    END;
    IF
         NOT Connected
    THEN
    BEGIN
         t!print( %"**Connecting circuits**",CRLF%);
         FOR Line _ 1 step 1 until Max!Port
         DO
	    BEGIN "connect"
              User!prompt[Line] _ sw!id!cont;
		User!Switch[Line] _ sw!next!line;
         Connect!cmd(Object);
	    END "connect";
    END;
    FOR Line _ 1 STEP 1 UNTIL Max!Line
    DO
    IF
         Port#[Line] >0
    THEN
         IF
              NOT Test!start[Line]
         THEN
         BEGIN
              Post#[Line] _ Now + 1000;
              Test!start[Line] _ true;
              Statistics[Line,Ln!startime] _ Now;
              Statistics[Line,charcnt] _ 0;
              User!prompt[Line] _ SW!NEXT!LINE;
		User!Switch[Line] _ sw!nothing;
              User!FCharRecd[Line]_FALSE;  \ Don't time when 1st char recvd;
		User!LostPrmpt[Line] _ now + ReqPrmpt!Time; \ Init lost 
								prompt timeout;
	      SEND!ID(LINE);		\ SEND AGENT-ID;
	     Loop!Prev[Line] _ now;
         END;
    Running _ true;
    Timestarted _ now;
    t!print( %"**Tests Initiated**",CRLF%);

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Test  Command exit",CRLF%); ENDC

END "TESTCMD";

COMMENT**************************************************************
*                                                                   *
*                                 SW!CMD                         *
*                                                                   *
********************************************************************;

	PROCEDURE SW!CMD (STRING Object);

BEGIN "swcmd"

	STRING Switch;
	INTEGER Line;
REQUIRE 0 POLLING!INTERVAL;

	Line _ CVD(Object);
	s!print(%"Enter Switch S(User!Switch), F(FCharRecd) or P(User!Prompt):", 
								CRLF%);
	Switch _ Upper(Getdata);
	
	IF
	    Line = 0
	THEN
	    Line _ 1;
	IF
		Switch = NULL
	THEN
		RETURN;

	IF
	    Switch = "P"
	THEN
	    BEGIN "user!prompt"
		s!print(%"Enter User!Prompt", CRLF%);
		User!prompt[Line] _ CVD(Getdata);
	    END "user!prompt"
	ELSE
	IF
	    Switch = "S"
	THEN
	    BEGIN "user!switch"
		s!print(%"Enter User!switch",CRLF%);
		User!switch[Line] _ CVD(Getdata);
	    END "user!switch"
	ELSE
	    IF
		Switch ="F"
	    THEN
	    BEGIN "fcharRecd"
		S!print(%"FcharRecd TRUE?(Y or N):",CRLF%);
		IF
		    Upper(Getdata) = "Y"
		THEN
			User!FcharRecd[Line] _ -1
		ELSE
			User!FcharRecd[Line] _ 0;
	    END "fcharRecd";
REQUIRE 90 POLLING!INTERVAL;
END "swcmd";

COMMENT******************************************************************
*                                                                       *
*                              SWITCH!CMD                               *
*                                                                       *
************************************************************************;

PROCEDURE switch!cmd (STRING object);

BEGIN "switchcmd"

    INTEGER minl,maxl,line;

    IF object = NULL THEN
        BEGIN
        minl _ 1;
        maxl _ max!port
        END
    ELSE
        minl _ maxl _ CVD(object);
    t!print( %"     LINE# PROMPT            SWITCH",crlf,lf%);

    REQUIRE 0 POLLING!INTERVAL;

    FOR line _ minl STEP 1 UNTIL maxl DO
	BEGIN
        t!print( %line,		".)  (",user!prompt[line],")",
		" SW!",switches[user!prompt[line]],
		"(",user!switch[line],")",
          " SW!",switches[user!switch[line]],
	"FcharRecd=",User!FcharRecd[Line],
		crlf%);
	t!print(%"User!Prompt=",User!Prompt[line]," User!switch=",
		User!switch[line],crlf%);
	END;

    REQUIRE 100 POLLING!INTERVAL;

END "switchcmd";

COMMENT****************************************************************
*                                                                     *
*                             STATUS!CMD                              *
*                                                                     *
**********************************************************************;

PROCEDURE Status!cmd(STRING Object("ALL"));

BEGIN "STATUSCMD"

    INTEGER Line,Channel,Script,width,digits;

REQUIRE 0 POLLING!INTERVAL;
PROCEDURE PRINTIT(INTEGER Line);
BEGIN
    INTEGER J,K;
    Getformat(Width,digits);
    Setformat(6,7);
    J _ (NOW- Statistics[Line,ln!startime]) div 1000;
    t!print( %Line," ",
    IF Port#[Line] = -1 THEN "ZAPPED" ELSE CVS(Port#[Line] )," ",
    User!script[Line]," ",
    User!loops[Line]," ",
    User!sendcount[Line]," ",
    CVS(User!sendtime[Line]/User!sendcount[Line])," ",
    User!readcount[Line]," ",
    CVS(User!readtime[Line]/User!readcount[Line])," ",
    CVS(K_User!charsent[Line]+User!charrecd[Line])," ",
    CVS(K div J)," ",j,CRLF %);
    t!print(%"Lost Prompt Time = ",User!lostPrmpt[Line],CRLF%);
   t!print(%"No. of Loops made thru Script File =",
		user!loops[line]," of ",
		no!of!loops[user!script[line]]," loops",CRLF%);
    Setformat(Width,digits);
END;
    Require 100 POLLING!INTERVAL;
    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Stat  Command entered:",Object,CRLF%);
    ENDC

    Line _ 0;
    IF
	Object = NULL
    THEN
	Object _ "LINE";
    Line _ CVD(Object);
    Object _ Upper(Object);
    
    IF
         EQU("ALL",Object[1 for 3])
    THEN
    BEGIN
    t!print( %"Limits:Ports ",Port!Limit,": Channels ",Channel!limit,": Scripts ",
                         Script!Limit,CRLF%);
    t!print( %"Max   :Ports ",Max!Port,": Scripts ",Max!script,CRLF%);
    t!print( %"Actual:Ports ",Ports!Connected,CRLF%);
    IF Initialised THEN t!print( %"Parameters set up",CRLF%);
    IF Interrupts!init THEN  t!print( %"Interrupts Initialised",CRLF%);
    IF Connected   THEN t!print( %"Circuits Connected",CRLF%);
    IF Textmode    THEN t!print( %"Textmode, Textline: ",Textline,CRLF%);
    IF Running     THEN t!print( %"Running",CRLF%);
    IF Flatout     THEN t!print( %"Flatout",CRLF%)
                   ELSE t!print( %"Rate =",Rate," Chars/Sec.",CRLF%);
    IF Timer!attached THEN t!print( %"Timer attached",CRLF%);
    IF Timer!enabled  THEN t!print( %"Timer enabled",crlf%);
    END;
    IF
         EQU("LINE",Object) OR 0<Line<Port!Limit
    THEN
    BEGIN
         t!print( %" Line#  Port#  Script Loops  Sends ",
               "Rate-ms Reads Rate-ms Chars  Rate  Time",CRLF,LF%);
         IF
              EQU("LINE",Object)
         THEN
         FOR Line _ 1 step 1 Until Max!port
         DO
              IF
                   Port#[Line] NEQ 0
              THEN
                   Printit(Line)
              ELSE
         ELSE
              Printit(Line);
    END;
    IF
         EQU("CHAN",OBJECT[1 FOR 4]) 
    THEN
    BEGIN
    Channel_ 0;       
    t!print( %CRLF%);
    WHILE
         Channel < Channel!Limit
    DO
    BEGIN
         t!print( %"Channel",Channel,CRLF,"Port"%);
         FOR Line _ 0 STEP 1 UNTIL Ports!Channel
         DO
              t!print( %CVS(Chan!Port[Channel,Line]) %);
         t!print( %CRLF,"Line"%);
         FOR Line _ 0 STEP 1 UNTIL Ports!Channel
         DO
              t!print( %CVS(Chan!Line[Channel,Line]) %);
         t!print( %CRLF%);
         Channel _ Channel + 1;
    END;
    END;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Stat   Command exit",CRLF%); ENDC

END "STATUSCMD";

COMMENT****************************************************************
*                                                                     *
*                             CONNECT!CMD                             *
*                                                                     *
**********************************************************************;

PROCEDURE Connect!cmd(STRING Object);

BEGIN "CONNECTCMD"

    INTEGER Ports!required,Line#,Script,retrycount,I,Channel;
    INTEGER Nextime;
    INTEGER PROCEDURE Pick!channel(INTEGER Line);
    BEGIN
         RETURN(Line MOD Channel!Limit);
    END;

    INTEGER PROCEDURE Pick!Script(INTEGER Line);
    BEGIN
         INTEGER tempX;

         Tempx _ (Line MOD Max!Script);
         WHILE
              No!of!users[Tempx] =  Users!conn[tempx]
         DO
              TempX _ (TempX+1) MOD Max!Script;
         Users!conn[TempX]_Users!conn[TempX]+1;
         RETURN(TempX);
    END;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Connect Command entered:",Object,CRLF%);
    ENDC

    Retrycount _ Max!Line;
    Object _ Upper(Object);
    IF
         NOT Initialised
    THEN
    BEGIN
         t!print( %"**Parameters uninialised, use INIT Command**",CRLF%);
         RETURN;
    END;
    IF
         Object = NULL or EQU(Object[1 for 3],"ALL")
    THEN
         Ports!required _ (Max!Port-Max!Line)
    ELSE
         Ports!required _ Getobject(Object);
    IF
         NOT 0<Ports!required < (Max!port+1)
    THEN
    BEGIN
         t!print( %"?",Object,"?",CRLF%);
         RETURN;
    END;
    IF
         (Max!line+Ports!required) > Max!Port
    THEN
    BEGIN
         t!print( %"**Not enough Ports remaining**",CRLF%);
         RETURN;
    END;
    FOR Line# _(Max!Line +1) STEP 1 until (Max!line+Ports!required)
    DO
    BEGIN
         User!on[Line#] _ False;
         Channel#[Line#] _ Channel _ Pick!channel(Line#);
         I _ Chan!Port[channel,0];
         I _ I + 1;
         Chan!port[Channel,0] _ I;
         Channel!Inx[Line#] _ I;
         Chan!Line[Channel,I] _ Line#;
         User!script[Line#] _ Pick!script(Line#);


\		WAIT LOGIC	FOR BETWEEN LOGINS;
         Nextime _ Now + Waitdelay;
\         while Nextime > Now do
	COMMENT		SLEEP FOR 3 SECONDS;
\         CALLI(3,'31);
         IF
              User!prompt[Line#] = sw!nothing
         THEN
              User!prompt[Line#] _ sw!id!stop
         ELSE
              User!prompt[Line#] _ sw!id!cont;


         DO
         BEGIN
              Retrycount _ Retrycount + 1;
         END
         UNTIL
              Retrycount > Max!port * 1.25
         OR
              Login(Line#);


         IF
              Retrycount  > Max!port *1.25
         THEN
         BEGIN
              user!switch[line#] _ SW!logon;
              post#[line#] _ NOW + 2500;
         END;
    END;
    Max!line _ Line#-1;
    Timerwait_ 300 Max ( 500 Min (Deltime/Max!Line));
    t!print( %"**Ports Connected**",CRLF%);
    Connected _ TRUE;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Connect  Command exit",CRLF%); ENDC

END "CONNECTCMD";

COMMENT****************************************************************
*                                                                     *
*                             DISCONNECT!CMD                          *
*                                                                     *
**********************************************************************;

PROCEDURE Disconnect!cmd(STRING Object);

BEGIN "DISCONNECTCMD"

    INTEGER Line#,Count;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Disconnect Command entered:",Object,CRLF%);
    ENDC

    IF
         Object = NULL
    THEN
         IF
              Textmode
         THEN    \ Just one line ;
         BEGIN
              Disconnect(Textline);
              Textline_Textline-1;
              IF
                   Textline = 0
              THEN
                   Textmode _ False;
         END
         ELSE
         BEGIN  \ Disconnect all lines;
              FOR Line# _ 1 STEP 1 UNTIL Max!Line
              DO
              BEGIN
                   IF
                        Port#[Line#] > 0
                   THEN
                        Simple!Output(Line#,Cntrollee!Quit);
                   Disconnect(Line#);
              END;
              t!print( %"**All Lines Disconnected**",CRLF%);
         END
    ELSE
    BEGIN
         Count_ Getobject(Upper(Object));
         IF
              0 < Count < Max!line
         THEN
         BEGIN
              FOR
                   Line#_Max!Line STEP -1 UNTIL (Max!Line+1-Count)
              DO
              BEGIN
                   IF
                        Port#[Line#]>0
                   THEN
                        Simple!Output(Line#,Cntrollee!Quit);
                   Disconnect(Line#);
              END;
              Max!Line_Max!line-Count;
         END
         ELSE
              t!print( %"?",Object,"?",CRLF%);
    END;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Disconnect  Command exit",CRLF%); ENDC

END "DISCONNECTCMD";

COMMENT****************************************************************
*                                                                     *
*                             LOGON!CMD                               *
*                                                                     *
**********************************************************************;

PROCEDURE Logon!cmd(STRING Object);

REQUIRE 0 POLLING!INTERVAL;
BEGIN "LOGONCMD"
REQUIRE 0 POLLING!INTERVAL;

    INTEGER Port,Success;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Logon Command entered:",Object,CRLF%);
    ENDC
    IF 
         Textmode
    THEN
    BEGIN
         t!print( %"**Already Logged on",CRLF%);
         Max!port_Max!port+1;
         IF
              Max!Port>Port!Limit
         THEN
              Crash!cmd("Logoncmd:Max!Port");
    END;
    IF
         Connected
    THEN
    BEGIN
         t!print( %"**Circuits already built",CRLF%);
         RETURN;
    END;
    IF
         Object = NULL
    THEN
    BEGIN
         t!print( %"**Logon String Required",CRLF%);
         RETURN;
    END;

    Textmode_TRUE;

    Buildcct(Object,Port,Success);

    IF
         NOT Success
    THEN
    BEGIN
         t!print( %"**Bad Logon",CRLF%);
         IF
              Textline = 0
         THEN
              TEXTMODE_FALSE;
         RETURN;
    END;
    IF
         NOT INITIALISED
    THEN
    BEGIN
         Max!port_1;
         Textline_0;
    END;
    Textline _ Textline +1;
    PORT#[Textline]_PORT;
    ATTACH!ZAP(Textline);
    ATTACH!INTERRUPT(0,Textline);


    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Logon  Command exit",CRLF%); ENDC

REQUIRE 100 POLLING!INTERVAL;
REQUIRE 100 POLLING!INTERVAL;
END "LOGONCMD";

COMMENT****************************************************************
*                                                                     *
*                             STOP!CMD                                *
*                                                                     *
**********************************************************************;

PROCEDURE Stop!cmd(STRING Object);

BEGIN "STOPCMD"

    INTEGER Line;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Stop Command entered:",Object,CRLF%);
    ENDC

    IF
         Running
    THEN
    BEGIN
    Running_ FALSE;
    FOR Line _ 1 STEP 1 UNTIL max!Line
    DO
    IF
         Port#[Line]> 0
    THEN
         Test!Ready[Line] _ false;
    Monitor!time_99999999;
    t!print( %"**TOTAL CHARS = ",Total!Chars!recd*2,CRLF,
          "**TEST PERIOD = ",(NOW-Timestarted )/1000," secs",CRLF,
          "**CHAR RATE   = ",(TOTAL!Chars!recd*2000)/(now-Timestarted),
                        " chars/sec for system",CRLF %);
    END
    ELSE
         t!print( %"**No Test Running**",CRLF%);

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Stop  Command exit",CRLF%); ENDC

END "STOPCMD";

COMMENT****************************************************************
*                                                                     *
*                             RATE!CMD                                *
*                                                                     *
**********************************************************************;

PROCEDURE Rate!cmd(STRING Object);

BEGIN "RATECMD"

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Rate Command entered:",Object,CRLF%);
    ENDC

    Object _ Upper(object);
    IF
         Running
    THEN
    BEGIN
         t!print( %"**Test in Progress**",CRLF%);
         t!print( %"**You are changing the rate**",CRLF%);
    END;
    Deltime _ 0;
        
    BEGIN
         IF
              Object = NULL
         THEN
              t!print( %"**Rate required, FULL or Integer**",CRLF%)
         ELSE
         IF
              EQU("FULL",Object[1 for 4]) or EQU("F",Object[1 for 1])
         THEN
         BEGIN
              Rate _ 0;
              Flatout _ TRUE;
         END
         ELSE
         BEGIN
              Rate_ Getobject(Object);
              IF
                   0 < Rate < 60
              THEN
              BEGIN
                   Deltime _ 1000 / rate ;      \ Milliseconds ;
              END
              ELSE
                   t!print( %"?",Object,"? Rate range is 0< Rate < 60",CRLF%);
         END;
     Timerwait _ 300 Max (500 min (Deltime/Max!Line));
     t!print( %"Del Time =",deltime,",timer wait =",Timerwait,CRLF%);
    IF
         NOT Timer!attached
    THEN
         Attach!timer;
    IF
         NOT Timer!enabled
    THEN
    BEGIN
         IF
              Timerwait = 0
         THEN
              Timerwait _ 500;
         Enable(Newenb(Timer!channel));
COMMENT		SET TIME GET TIME;
         CALLI(Timerwait,Calli!Settim);
         Timer!enabled _ true;
    END;
    END;


    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Rate  Command exit",CRLF%); ENDC

END "RATECMD";

COMMENT****************************************************************
*                                                                     *
*                             TOTALS!CMD                              *
*                                                                     *
**********************************************************************;

PROCEDURE Totals!cmd(STRING Object);

BEGIN "TOTALSCMD"

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Totals Command entered:",Object,CRLF%);
    ENDC

    t!print( %"** to be implemented **",CRLF%);

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Totals  Command exit",CRLF%); ENDC

END "TOTALSCMD";
COMMENT****************************************************************
*                                                                     *
*                             QUIT!CMD                                *
*                                                                     *
**********************************************************************;

PROCEDURE Quit!cmd(STRING Object);

BEGIN "QUITCMD"

REQUIRE 0 POLLING!INTERVAL;

    PROCEDURE Clearports;
    BEGIN
         INTEGER Channel,Inx,Line;

	t!print(%"Total # of lost Prompts=",Total!LostPrmpt,CRLF%);
         Channel _ -1;
         
	IF
	    chn GEQ 0
	THEN
	RELEASE(chn);	\ close trace file;
	chn _ -1;
	IF
	    monitor!chan GEQ 0
	THEN
	RELEASE(monitor!chan);		\ close the monitor file for restim 
								program;
	monitor!chan _ -1;
         WHILE 
              Ports!connected > 0
         DO
              WHILE
                   (Channel _ Channel + 1) < Channel!Limit
              DO
              BEGIN
                   FOR Inx_1 step 1 until Chan!Port[Channel,0]
                   DO
                   IF
                        Chan!port[Channel,Inx]>0
                   THEN
			BEGIN
			Line _ Chan!Line[Channel,Inx];
			IF
			    Port#[Line] > 0
			THEN
			    Simple!output(Line,Cntrollee!Quit);	\ Force logoff;
			Disconnect(Line);
			user!switch[Line]_Sw!Logon;
			END;
                   
              END;
    END;


    INTEGER Inx;

    IFC Debug!cmd
    THENC IF DEBUG THEN s!print( %">> Quit Command entered:",Object,CRLF%);
    ENDC

    Object_Upper(Object);
    IF
         Object = NULL
    THEN
         Clearports
    ELSE
    IF
         EQU("C",Object[1 for 1]) OR EQU("CLEAR",Object[1 for 5])
    THEN
    BEGIN
         Clearports;
         ARRCLR(Port#);
         ARRCLR(Test!ready);
         ARRCLR(Test!start);
         ARRCLR(Post#);
         ARRCLR(Channel#);
         ARRCLR(Channel!inx);
         ARRCLR(Chan!port);
         ARRCLR(Chan!line);
         ARRCLR(user!bccount);
         ARRCLR(user!msgcount);
         ARRCLR(user!getcount);
         ARRCLR(user!gettime);
         ARRCLR(Statistics);
         Max!Script _ 0;
         ARRCLR(Test!Period);
         ARRCLR(User!Script);
         ARRCLR(User!Switch);
         ARRCLR(User!Loops);
         ARRCLR(User!Prompt);
         ARRCLR(User!Timecell);
         ARRCLR(User!Sendcount);
         ARRCLR(User!Sendtime);
         ARRCLR(User!Readcount);
         ARRCLR(User!Readtime);
         ARRCLR(User!Charsent);
         ARRCLR(User!Charrecd);
         ARRCLR(user!on);
         Max!Line _ 0;

         Connected_Running_FALSE;
         IF
              Textmode
         THEN
         BEGIN
              Textline_0;
              Textmode_FALSE;
         END;
         FOR Inx _ 0 step 1 until Script!Limit - 1
         DO
              Release(Inx,0);
         Relbreak(Texttab);
         Files!Initialized _ False;
    END
    ELSE
    IF
         EQU("QUIT",Object[1 for 4])
    THEN
    BEGIN
	CALLI(0,CALLI!SETTIM);	\ turn off the clock;
         Clearports;
	CALLI(-1,CALLI!ZAPCIR);
         GOTO Crash;
    END
    ELSE
         t!print( %"?",Object,"?",CRLF%);


    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Quit  Command exit",CRLF%); ENDC

REQUIRE 100 POLLING!INTERVAL;
END "QUITCMD";

COMMENT****************************************************************
*                                                                     *
*                             INITIALIZE!CMD                         *
*                                                                     *
**********************************************************************;

PROCEDURE Initialize!cmd(STRING Object);

BEGIN "INITIALIZECMD"
    INTEGER Value,Script,width,digits;
    STRING Instring;

    Quit!cmd("CLEAR");
    IF
         LENGTH(object) > 0
    THEN
         BEGIN "init!file"
	IF
	    ini!chan GEQ 0
	THEN
	     RELEASE(ini!chan);
         ini!chan _ getchan;
         open(ini!chan, "DSK", 0, 1, 1, 128, ini!brk, ini!eof);
         lookup(ini!chan, object, ini!brk);
         IF
              ini!brk OR ini!eof
         THEN
              BEGIN "nofile"
              t!print( %"No file ",object,crlf%);
              Release(ini!chan);
              ini!chan _ -1;
              RETURN;
              END "nofile";
         ini!bt _ getbreak;
         setbreak(ini!bt,",;"&'15,'12 & '40,"INS");
         END "init!file";

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Init Command entered:",Object,CRLF%);
    ENDC

    Getformat(Width,digits);
    Setformat( 2   ,digits);
    IF
         Connected
    THEN
    BEGIN
         t!print( %"**Circuits Connected**",CRLF%);
         RETURN;
    END;
    IF
         Textmode
    THEN
    BEGIN
         t!print( %"**Textmode**",CRLF%);
         RETURN;
    END;


	t!print(%"Enter Lost Prompt Timeout Limit, Default=15 sec :"%);
	Instring _ Upper(getdata);
	IF
		Instring = NULL
	THEN
		ReqPrmpt!Time _ 15000
	ELSE
		ReqPrmpt!Time _ CVD(Instring) * 1000;
    t!print(%"Enter Prmpt, default is ':' :"%);
	Instring _ Upper(Getdata);
	IF
		Instring = NULL
	THEN
		Prmpt _ ":"
	ELSE
		Prmpt _ Instring;

    t!print(%"Enter Cntrollee!quit, default is 'LOG'  :"%);
	Instring _ Upper(getdata);
	IF
		Instring = NULL
	THEN
		Cntrollee!quit _ "LOG" & CR
	ELSE
		Cntrollee!quit _ Instring & CR;

    t!print( %"Enter Username, Default is '--------------':"%);
    Instring _ Upper(Getdata);
    IF
         Instring = NULL
    THEN
         Username _ "------------"
    ELSE
         Username _ Instring;
    t!print( %"Enter initialize delay, Default is 0 seconds: "%);
    Instring _ Upper(Getdata);
    IF
         Instring = NULL
    THEN
         Waitdelay _ 0
    ELSE
         Waitdelay _  Getobject(Instring)*1000;
\    t!print( %"Enter id base no , default is 1: "%);
\    Instring _ Upper(Getdata);
\    IF
         Instring = NULL
    THEN
         Idbase _ 1
    ELSE
         Idbase _  Getobject(Instring);
	Idbase _ 1;	\ pg;
    t!print( %"Enter Max!Script, Limit is ",Script!Limit,", default is 1: "%);
    Instring_Upper(Getdata);
    IF
         Instring = NULL
    THEN
         Max!script _ 1
    ELSE
         Max!Script _Getobject(Instring);
    Max!port_0;
    Script _ 0;
    WHILE
         Script<Max!script
    DO
    BEGIN
	 t!print(%crlf%);
         Instring _ NULL;
         t!print( %"Script ",Script,",Enter Script file, Default is TESTF: "%);
         Instring_ Upper(Getdata);
         IF
              Instring = NULL
         THEN
              Instring _ "TESTF";
         Scriptid[script] _ Instring;
         Instring _ Null;
         t!print( %"Script ",Script,",Enter ID prefix, Default is ""."": "%);
         Instring_ Upper(Getdata);
         IF
              Instring = NULL
         THEN
              Instring _ ".";
         Idprefix [Script] _ Instring;
         t!print( %"Script ",Script,",Enter No of Users, Default is 1: "%);
         Instring _ Upper(Getdata);
         IF
              Instring = NULL
         THEN
              No!of!users[Script] _ 1
         ELSE
              No!of!users[Script] _ Getobject(Instring);
         Max!port _ Max!port + No!of!users[script];
         t!print( %"Script ",Script,",Enter Logon delay, units - (seconds):"%);
         Instring _ Upper(Getdata);
         IF
              Instring = NULL
         THEN
              Logon!delay[Script] _ 0
         ELSE
              Logon!Delay[Script] _ Getobject(Instring) * 1000;
         t!print( %"Script ",Script,",Enter No of Loops, default is 1: "%);
         Instring _ Upper(Getdata);
         IF
              Instring = NULL
         THEN
              No!of!Loops[script] _ 1
         ELSE
              No!of!loops[Script] _ Getobject(Instring);

\	broad cast ratio logic;
\         t!print( %"Script ",script,", Enter broadcast ratio, default 1: "%);
\         instring _ upper(getdata);
\         IF instring = NULL THEN
\             bcast!ratio[script] _ 1.0
\         ELSE
\\             bcast!ratio[script] _ REALSCAN(instring,junk);
         IF bcast!ratio[script] < 1.0 THEN bcast!ratio[script] _ 1.0;

         Script _ Script + 1;
    END;

    Initialize!Files(Max!Script);
    IF
         Files!Initialized
    THEN
         Initialised _ true;
    
    Setformat(width,digits);

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Init  Command exit",CRLF%); ENDC

    IF ini!chan GEQ 0 THEN release(ini!chan);
    ini!chan _ -1;
END "INITIALIZECMD";

COMMENT****************************************************************
*                                                                     *
*                             CRASH!CMDX                              *
*                                                                     *
**********************************************************************;

PROCEDURE Crash!cmd(STRING Object);

BEGIN "CRASHCMD"

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Crash Command entered:",Object,CRLF%);
    ENDC

    t!print( %"!!!!!!!!!!!!! CRASH - ",OBJECT,CRLF%);
	CALLI(-1,CALLI!ZAPCIR);		\ zap the line;

    GOTO CRASH;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Crash  Command exit",CRLF%); ENDC

END "CRASHCMD";

COMMENT****************************************************************
*                                                                     *
*                             PERIOD!CMD                              *
*                                                                     *
**********************************************************************;

PROCEDURE Period!cmd(STRING Object);

BEGIN "PERIODCMD"

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Period Command entered:",Object,CRLF%);
    ENDC
	ifc compiler!switch("B") thenc begin
	external procedure BAIL;
	BAIL;
end endc;

    t!print( %"** to be implemented **",CRLF%);

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Period  Command exit",CRLF%); ENDC

END "PERIODCMD";

COMMENT****************************************************************
*                                                                     *
*                             GO!CMD                                  *
*                                                                     *
**********************************************************************;

PROCEDURE Go!cmd(STRING Object);

BEGIN "GOCMD"

    INTEGER Line,When;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Go Command entered:",Object,CRLF%);
    ENDC
    IF
         NOT (Flatout OR Rate > 0)
    THEN
    BEGIN
         t!print( %"**No rate specified**",CRLF%);
         RETURN;
    END;

    IF
         Running
    THEN
    BEGIN
         t!print( %"**Test already in progress**",CRLF%);
         t!print( %"**Adding more circuits**",CRLF%);
    END;
    IF
         NOT Running
    THEN
    BEGIN
         IF
              EQU(Upper(Object),"RESET") OR EQU(Object,"R")
         THEN
         BEGIN
              ARRCLR(Statistics);
              ARRCLR(User!loops);
              ARRCLR(User!timecell);
              ARRCLR(User!sendcount);
              ARRCLR(User!readcount);
              ARRCLR(User!sendtime);
              ARRCLR(User!readtime);
              ARRCLR(User!charsent);
              ARRCLR(User!charrecd);
              Total!chars!recd _ 0;
              Total!chars!sent _ 0;
         END;
         Running _ true;
         Timestarted _ Now;
    END;
    FOR Line _ 1 step 1 until Max!port 
    DO
    IF
         Port#[Line] > 0
    THEN
         IF
              NOT Test!start[Line]     \ may have added circuits ;
         THEN
         BEGIN
              Post#[Line] _ Now + 1000;
              Test!start[Line] _ true;
              Statistics[Line,Ln!startime] _ Now;
              Statistics[Line,charcnt] _ 0;
         END;

    t!print( %"**All Circuits started**",CRLF%);
    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Go  Command exit",CRLF%); ENDC

END "GOCMD";

COMMENT****************************************************************
*                                                                     *
*                             FULL!CMD                                *
*                                                                     *
**********************************************************************;

PROCEDURE Full!cmd(STRING Object);

BEGIN "FULLCMD"

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Full Command entered:",Object,CRLF%);
    ENDC

    IF
         Running
    THEN
    BEGIN
         t!print( %"**Test in Progress**",CRLF%);
         RETURN;
    END
    ELSE
         Flatout _ TRUE;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Full  Command exit",CRLF%); ENDC

END "FULLCMD";

COMMENT****************************************************************
*		          METER!CMD                               *
*                                                                     *
**********************************************************************;

PROCEDURE Meter!cmd(STRING Object);

BEGIN "METERCMD"


    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Meter Command entered:",Object,CRLF%);
    ENDC
     Total!send!time_Total!read!time_Total!reads_Total!messages!sent_0;
    Timestarted_Now;


    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Meter  Command exit",CRLF%); ENDC

END "METERCMD";

COMMENT****************************************************************
*                                                                     *
*                             MONITOR!CMD                             *
*                                                                     *
**********************************************************************;

RECURSIVE PROCEDURE Monitor!cmd(STRING Object);

BEGIN "MONITORCMD"

    INTEGER Temp,Period;

     STRING mon!file;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Monitor Command entered:",Object,CRLF%);
    ENDC

    IF
         Object = NULL OR EQU(object[ 1 FOR 3],"off") OR EQU(object[1 FOR 3],"OFF")
	AND
	    monitor!chan GEQ 0
    THEN
    BEGIN
         REQUIRE 0 POLLING!INTERVAL;
         WORDOUT(monitor!chan,1);WORDOUT(monitor!chan,17);
         WORDOUT(monitor!chan,max!script);
         WORDOUT(monitor!chan,max!port);
         WORDOUT(monitor!chan,max!line);
         WORDOUT(monitor!chan,ports!connected);
         WORDOUT(monitor!chan,connected);
         WORDOUT(monitor!chan,running);
         WORDOUT(monitor!chan,NOW);
         WORDOUT(monitor!chan,timestarted);
         WORDOUT(monitor!chan,total!loops);
         WORDOUT(monitor!chan,total!messages!sent);
         WORDOUT(monitor!chan,total!send!time);
          WORDOUT(monitor!chan,total!reads);
         WORDOUT(monitor!chan,total!read!time);
         WORDOUT(monitor!chan,total!files!read);
         WORDOUT(monitor!chan,total!gettime);
         WORDOUT(monitor!chan,total!chars!recd);
         WORDOUT(monitor!chan,total!chars!sent);
         WORDOUT(monitor!chan,2);WORDOUT(monitor!chan,2*(temp_max!line+1));
         ARRYout(monitor!chan,statistics[0,0],2*temp);
         WORDOUT(monitor!chan,3);WORDOUT(monitor!chan,temp);
         ARRYOUT(monitor!chan,port#[0],temp);
         WORDOUT(monitor!chan,4);WORDOUT(monitor!chan,temp);
         ARRYOUT(monitor!chan,user!script[0],temp);
         WORDOUT(monitor!chan,5);WORDOUT(monitor!chan,temp);
         ARRYOUT(monitor!chan,user!loops[0],temp);
         WORDOUT(monitor!chan,6);WORDOUT(monitor!chan,temp);
         ARRYOUT(monitor!chan,user!sendcount[0],temp);
          WORDOUT(monitor!chan,7);WORDOUT(monitor!chan,temp);
         ARRYOUT(monitor!chan,user!sendtime[0],temp);
         WORDOUT(monitor!chan,8);WORDOUT(monitor!chan,temp);
         ARRYOUT(monitor!chan,user!readcount[0],temp);
         WORDOUT(monitor!chan,9);WORDOUT(monitor!chan,temp);
         ARRYOUT(monitor!chan,user!readtime[0],temp);
         WORDOUT(monitor!chan,10);WORDOUT(monitor!chan,temp);
         ARRYOUT(monitor!chan,user!getcount[0],temp);
         WORDOUT(monitor!chan,11);WORDOUT(monitor!chan,temp);
         ARRYOUT(monitor!chan,user!gettime[0],temp);
         WORDOUT(monitor!chan,12);WORDOUT(monitor!chan,temp);
         ARRYOUT(monitor!chan,user!charsent[0],temp);
         WORDOUT(monitor!chan,13);WORDOUT(monitor!chan,temp);
         ARRYOUT(monitor!chan,user!charrecd[0],temp);
         WORDOUT(monitor!chan,14);WORDOUT(monitor!chan,temp);
         ARRYOUT(monitor!chan,user!msgcount[0],temp);
         WORDOUT(monitor!chan,15);wordout(monitor!chan,temp);
         ARRYOUT(monitor!chan,user!bccount[0],temp);
         REQUIRE 100 POLLING!INTERVAL;

         IF
              Monitor!interval = 0
              OR EQU(object[1 FOR 3],"OFF")
              OR EQU(object[1 FOR 3],"off")
         THEN
              BEGIN
              monitor!time _ 99999999;
		IF Debug THEN
			t!print(%"Closing monitor channel ",monitor!chan,CRLF%);
              CLOSE(monitor!chan);
              monitor!chan _ -1;
              END
        ELSE
              Monitor!time_Monitor!time + Monitor!interval
    END
    ELSE
    IF
         Object = "L" or Object = "l"
    THEN
    BEGIN
         Outstr( "Enter line number ");
         Temp _ GetObject(Getdata);
         IF
              0<Temp<Port!Limit
         THEN
         BEGIN
              Outstr("Enter ON or NULL for Off");
              IF
                   Getdata = NULL
              THEN
                   User!Monitor[Temp] _ False
              ELSE
                   User!monitor[Temp] _ True;
         END;
    END
    ELSE
    BEGIN
         Object _ Upper(Object);
         temp_Getobject(Object);
         IF
              0 < Temp < 600
         THEN
         BEGIN
         if monitor!chan=-1 then monitor!chan_GETCHAN;
              monitor!eof_FALSE;
             OPEN(monitor!chan,"DSK",8,0,10,monitor!count,monitor!brchar,monitor!eof);
               IF monitor!eof THEN
                   BEGIN
                   t!print( %"failed to open disk channel",monitor!eof%);
                   RETURN;
                   END
                   
             ELSE
                   BEGIN
                   OUTSTR("Enter monitor file name");
                    ENTER(monitor!chan,mon!file_upper(getdata),monitor!eof);
                   IF monitor!eof THEN
                       BEGIN
                       t!print( %"failed to enter file:",mon!file," ",monitor!eof%);
                       RETURN
                       END
                   
                   ELSE
                       BEGIN
                       temp_temp*1000;
                       monitor!interval_temp;
                       monitor!time_NOW+monitor!interval;
                       END;
                   END;

         END
         ELSE
              t!print( %"?",Object,"? Rate not in range of 0< Rate <600",CRLF%);
    END;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Monitor  Command exit",CRLF%); ENDC

END "MONITORCMD";

COMMENT****************************************************************
*                                                                     *
*                             SETPRINT!CMD                            *
*                                                                     *
**********************************************************************;

PROCEDURE Setprint!cmd(STRING Object);

BEGIN "SETPRINTCMD"

    INTEGER I;
    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Set Command entered:",Object,CRLF%);
    ENDC

    I _ CVD(Object);
    IF
        0 < I < PORT!Limit
    THEN
    BEGIN
         t!print( %"**Text Buffers, Line ",I,CRLF%);
         t!print( %"Last send: ",Lastout[I],CRLF%);
         t!print( %"Last read: ",Lastin[I],CRLF%);
         t!print( %"Curr read: ",Inline[I],CRLF%);
    END;
    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Set  Command exit",CRLF%); ENDC

END "SETPRINTCMD";

COMMENT**************************************************************
*                                                                   *
*                           O!OUT                                  *
*                                                                   *
********************************************************************;

INTERNAL    INTEGER PROCEDURE O!OUT(STRING S);
COMMENT	THIS MODULE OPENS AN OUTPUT FILE WHOSE NAME IS IN STRING S;

BEGIN "O!OUT"

	INTEGER O!CHAN,MODE,IBUF,OBUF,COUNT,BR,FLAG,FLAGE;
	BOOLEAN T;

	MODE_0;
	IBUF_0;
	OBUF_2;
	T_TRUE;
	flag _ 0;
	flage _ 0;
	OPEN(O!CHAN_GETCHAN,"DSK",MODE,IBUF,OBUF,COUNT,BR,FLAG);
	IF
		FLAG
	THEN
		BEGIN "O"
			OUTSTR("OPEN OUTPUT ERROR");
			T_FALSE;
		END "O"
	ELSE
		BEGIN "E"
			ENTER(O!CHAN,S,FLAGE);
			IF
				FLAGE
			THEN
				BEGIN
					OUTSTR("OUTPUT ENTER FAILED FOR FILE: " 
					& S
					& crlf);
					RELEASE(O!CHAN);
					T_FALSE;
				END;
		END "E";
	IF
		T
	THEN
			BEGIN
				chn _ o!chan;
				RETURN(O!CHAN);
			END
	ELSE
			RETURN(-1);
END "O!OUT";

COMMENT**************************************************************
*                                                                   *
*                           LOP!COM                                  *
*                                                                   *
********************************************************************;

	STRING PROCEDURE LOP!COM(REFERENCE STRING STR);

BEGIN "lop!com"
	STRING ret;

	INTEGER brtab,brchar;

	IF
		brtab = 0
	THEN
		SETBREAK(brtab_getbreak,",",null,"KINS");
		ret _ scan(str,brtab,brchar);
	RETURN(ret);

END "lop!com";


COMMENT**************************************************************
*                                                                   *
*                           lop!sign                                  *
*                                                                   *
********************************************************************;

	BOOLEAN PROCEDURE lop!sign(REFERENCE STRING obj,pre,suf);

BEGIN "lop!sign"

	INTEGER brtab,brchar;
	BOOLEAN ret;
	STRING sv;

	sv _ obj;

	IF
		brtab = 0
	THEN
		SETBREAK(brtab_getbreak,"=",null,"kins");

	pre _ SCAN(sv,brtab,brchar);

	IF
		EQU(pre,"FILE")
	THEN
		BEGIN
			ret _ TRUE;
			obj _ sv;
		END
	ELSE
		ret _ false;

	RETURN(ret);
END "lop!sign";


COMMENT**************************************************************
*                                                                   *
*                           DEBUG!                                  *
*                                                                   *
********************************************************************;

PROCEDURE DEBUG!   (STRING OBJECT);

BEGIN "DEBUGCMD"

	STRING obj,pre,suf,temp;

	temp _ object;
	IF
		temp = NULL
	THEN
		debug _ TRUE
	ELSE	\ has an object;
		WHILE
		    LENGTH(temp) > 0
		DO
		BEGIN "loop"

		\ lops off to first comman, throw comma away;
		\ temp has the remaining value;
		    obj _ lop!com(temp);

		    IF
			lop!sign(obj,pre,suf)
			\ If string contains FILES=<FILENAME>, put
files= into pre for completness, put everything up to the next comma into
suf, the reamining string(there should be none) into obj;

		    THEN
		    BEGIN "file"

			IF
			    chn NEQ -1
			THEN
			    RELEASE(chn);

			chn _ -1;

			WHILE
			    chn = -1
			DO
			BEGIN "loop2"
			    chn _ O!OUT(obj);
			    IF
				chn = -1	\ error ;
			    THEN
				BEGIN
				    OUTSTR(" Enter trace output FileName:");
				    obj _ UPPER(Getdata);
				END
			    ELSE
				BEGIN
				chn!prnt _ TRUE;
				tty!prnt _ FALSE;
				IF
				     Debug!data
				THEN
				    tty!prnt _ TRUE;
				Debug!data _ TRUE;
				t!print(%"Trace output file ",
					obj," opened",crlf%);
				END;
			END "loop2";

		    END "file"
		    ELSE
		    BEGIN "case"
			CASE obj OF
			BEGIN

			    ["T"]	debug _ TRUE;
			    ["F"]	BEGIN  \ false ;
					    debug!norm _FALSE;
					    debug_FALSE;
					    debug!data_FALSE;
					    debug!test_FALSE;
					    debug!trace_FALSE;
					    debug!wait_FALSE;
						tty!prnt _ TRUE;
					END;  \ FALSE ;

			    ["L"]	Line!test _ NOT Line!test;

			    ["P"]	Port!test _ NOT Port!test;

			    ["I"]	Test!ports _ NOT Test!ports;
			    ["X"]	debug!test_ NOT debug!test;
			    ["N"]	debug!norm_ NOT debug!norm;
			    ["M"]	debug!trace_ NOT debug!trace;
			    ["D"]	debug!data_ NOT debug!data;
			    ["W"]	debug!wait_ NOT debug!wait;

			    ELSE
					t!print(%"DEBUG command only takes the " 
					, "following objects:" , crlf ,
			"TRUE,FALSE, X, N, M, " ,
					"D, W, or FILE=<filename>" , crlf%)
			    END;
		END "case";

		END "loop";


END "DEBUGCMD";

COMMENT****************************************************************
*                                                                     *
*                             To!be!implemented                       *
*                                                                     *
**********************************************************************;

PROCEDURE To!be!implemented;

BEGIN "TOBEIMPLEMENTED"

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> To!be!impl entered",CRLF%);
    ENDC

    t!print( %"** to be implemented **",CRLF%);

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> To!be!impl exit",CRLF%); ENDC

END "TOBEIMPLEMENTED";

COMMENT****************************************************************
*                                                                     *
*                             SENDIT!CMD                              *
*                                                                     *
**********************************************************************;

PROCEDURE Sendit!cmd(STRING Object);

BEGIN "SENDITCMD"

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Sendit Command entered:",Object,CRLF%);
    ENDC

    SIMPLE!OUTPUT(Textline,OBJECT);


    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Sendit  Command exit",CRLF%); ENDC

END "SENDITCMD";

COMMENT**************************************************************
*                                                                   *
*                                 SCRIPT!CMD                         *
*                                                                   *
********************************************************************;

	PROCEDURE Script!cmd(STRING Object);

BEGIN "scriptcmd"
	RECORD!POINTER(sdata)Recptr;
	INTEGER Line,Max,I;

REQUIRE 0 POLLING!INTERVAL;

	IF
	    Upper(Object) = "A"
	THEN
	    BEGIN "all"
		Max _ Max!Port;
		Line _ 1;
	    END "all"
	ELSE
	    BEGIN "one"
		Line _ CVD(Object);
		IF
		    Line = 0
		THEN
		    Line _ 1;
		Max _ Line;
	    END "one";
	IF
		0 < Line < Port!Limit
	THEN
	BEGIN "in!bounds"
	FOR I _ Line STEP 1 UNTIL Max
	DO
	BEGIN "count"
	Recptr _ Nextline[I];
	s!print(%"(",I,")"%);
	IF
		Recptr = NULL!RECORD
	THEN
		s!print(%"**END OF SCRIPT",CRLF%)
	ELSE
		s!print(%sdata:Sstring[Recptr],CRLF%);
	END "count";
	END "in!bounds";
REQUIRE 100 POLLING!INTERVAL;
	END "scriptcmd";

COMMENT**************************************************************
*                                                                   *
*                                 BUFFER!CMD                         *
*                                                                   *
********************************************************************;

	PROCEDURE BUFFER!CMD(STRING Object);
BEGIN "buffercmd"
	INTEGER Max,I,Line,K,Oct;
	STRING Char;
REQUIRE 0 POLLING!INTERVAL;
	IF
		Object = NULL OR
		UPPER(Object) = "A"
	THEN
	    BEGIN "all"
		Max _ Max!port;
		Line _ 1;
	    END "all"
	ELSE
	    BEGIN "one"
		Line _ CVD(Object);
		Max _ Line;
	    END;

	IF
	    0 < Line < Port!Limit + 1
	THEN
	BEGIN "in!bounds"
	FOR I _ Line STEP 1 UNTIL Max
	DO
	BEGIN "count"
		s!print(%"(",I,")",Inline[I]," "%);
		Char _ Inline[I];
		FOR K _ 1 STEP 1 UNTIL LENGTH(Inline[I])
		DO
		BEGIN
		Oct _ LOP(Char);
		s!print(%CVOS(Oct)," "%);
		END;
		s!print(%crlf%);
	END "count";
	END "in!bounds";

REQUIRE 100 POLLING!INTERVAL;

END "buffercmd";
COMMENT**************************************************************
*                                                                   *
*                                 CLOCK!OFF                         *
*                                                                   *
********************************************************************;
PROCEDURE Clock!off;
BEGIN "clockoff"
	CALLI(0,CALLI!SETTIM);
	Timer!enabled _ FALSE;
	Timer!attached _ FALSE;
END "clockoff";

COMMENT**************************************************************
*                                                                   *
*                                 LEVDEF!CMD                         *
*                                                                   *
********************************************************************;

PROCEDURE Levdef!cmd(STRING Object);
BEGIN "levdefcmd"
	INTEGER Line,Chan;
	Line _ CVD(Object);
	IF
	    Line = 0
	THEN
	    Line _ 1;
	IF
		0 < Line < (Max!port + 1)
	THEN
	BEGIN "valid!line"
		AUXCLV(Port#[Line],0,AUXCAL!LEVDEF);
		Print("Port=",Port#[Line],crlf);
\		ENABLE(NEWENB(Interrupt!Channel!Base+Line));
	END "valid!line";
END "levdefcmd";
PROCEDURE Help!lst;
BEGIN "helplst"
	INTEGER I,Len;
	Len _ 0;
	FOR I _ 1 STEP 1 UNTIL Ncmds
	DO
	BEGIN "loop"
		s!print(%Command!value[I]," "%);
		Len _ Len + LENGTH(Command!value[I]) + 1;
		IF
		    Len > 60
		THEN
		BEGIN 
		    s!print(%CRLF%);
		    Len _ 0;
		END;
	END "loop";
	s!print(%CRLF%);
END "helplst";
	


COMMENT**************************************************************
*                                                                   *
*                                 PORTS!CMD                         *
*                                                                   *
********************************************************************;
	PROCEDURE Ports!cmd;
BEGIN "portscmd"
REQUIRE 0 POLLING!INTERVAL;
	OWN INTEGER ARRAY Active!Ports[0:Port!Limit];
	INTEGER I,Max,N;

	ARRCLR(Active!Ports);
	CALLI(-(max!Port+1) LSH 18 + LOCATION(Active!Ports[1]),CALLI!AUXRED);
	Max _ Max!port;
	FOR I _ 1 STEP 1 UNTIL Max
	DO
	BEGIN "for!loop"
		s!print(%I,"="%);
		IF Active!Ports[I] = -1
				THEN s!print(%"ZAPPED"%)
				ELSE s!print(%Active!Ports[I] %);
		s!print(%" "%);
	END "for!loop";
	ARRCLR(Active!ports);

	s!print(%CRLF%);
		Active!ports[0] _ Max + 2;
	CALLI('77 LSH 30 +LOCATION(Active!Ports[0]),Calli!Polprt);
	N _ Active!Ports[0];
	t!print(%"N=",n,CRLF%);
	FOR I _ 1 Step 1 UNTIL N
	DO
	BEGIN "ports"
		t!print(%"Polprt="%);
		t!print(%CVOS(Active!Ports[I]),crlf%);
	END "ports";
	t!print(%crlf%);
	For I _ 1 STEP 1 UNTIL Max
	DO
	BEGIN "gettab"
		t!print(%"(",Port#[I],")"%);
		   t!print(%"Getlog="%);
		   t!print(%CVOS(GETTAB(Port#[I],Getlog)),crlf%);
	END "gettab";
REQUIRE 100 POLLING!INTERVAL;
END "portscmd";


COMMENT**************************************************************
*                                                                   *
*                                 POST!CMD                         *
*                                                                   *
********************************************************************;
PROCEDURE POST!CMD(STRING Object);

BEGIN "Postcmd"

	INTEGER Line,Max,I,Time,Junk;
	STRING First;
REQUIRE 0 POLLING!INTERVAL;

	First _ NULL;
	Junk _ LOP(Object);
	WHILE
	 (NOT Junk = ",")
	AND
	 ( NOT Junk = NULL)

	DO
	BEGIN
	    First _ First & Junk;
	    Junk _ LOP(Object);
	END;
	IF
	    Upper(First) = "A"
	THEN
	    BEGIN "all"
		Max _ Max!Port;
		Line _ 1;
	    END "all"
	ELSE
	    BEGIN "one"
		Line _ CVD(First);
		IF
		    Line = 0
		THEN
		    Line _ 1;
		Max _ Line;
	    END "one";
	Time _ CVD(Object) * 1000;
	IF
	    0 < Line < Port!Limit
	THEN
	BEGIN "in!bounds"
	    FOR I _ Line STEP 1 UNTIL Max
	    DO
	    BEGIN "count"
		Post#[Line] _ NOW + Time;
	    END "count";
	END "in!bounds";
REQUIRE 100 POLLING!INTERVAL;

END "Postcmd";
COMMENT**************************************************************
*                                                                   *
*                                 STATE!LIST                         *
*                                                                   *
********************************************************************;

Procedure State!List;

BEGIN "statelist"

	INTEGER I;
REQUIRE 0 POLLING!INTERVAL;

	s!print(%"	State Switch",crlf%);
	FOR I _ 1 STEP 1 UNTIL Sw!max
	DO
	    s!print(%"	",Switches[I-1]," (",I-1,")",crlf%);
REQUIRE 100 POLLING!INTERVAL;
END "statelist";
COMMENT**************************************************************
*                                                                   *
*                                 LIST!SCRIPT                         *
*                                                                   *
********************************************************************;

PROCEDURE List!Script(STRING Object);
BEGIN "listscript"

	INTEGER Line,Max,I,K;
	RECORD!POINTER(Sdata) Recptr;
REQUIRE 0 POLLING!INTERVAL;

	IF
	    Upper(object) = "A"
	THEN
	    BEGIN "all"
		Max _ Max!Port;
		Line _ 1;
	    END "all"
	ELSE
	    BEGIN "one"
		Line _ CVD(Object);
		IF
		    Line = 0
		THEN
		    Line _ 1;
		Max _ Line;
	    END "one";
	IF
	    0 < Line < Port!Limit
	THEN
	BEGIN "in!bounds"
	    FOR I _ Line STEP 1 UNTIL Max
	    DO
	    BEGIN "count"
		S!Print(%"**SCRIPT FILE  LINE ",I,"**",CRLF%);
		Recptr _ FirstLine[User!Script[Line]];
		K _ 0;
		WHILE
		    Recptr NEQ NULL!RECORD
		DO
		BEGIN "list"
			K _ K + 1;
			S!Print(%"(",K,")"%);
			S!Print(%Sdata:Sstring[Recptr],CRLF%);
			Recptr _ Sdata:sptr[Recptr];
		END "list";

		S!Print(%CRLF%);
	     END "count";
	END "in!bounds";
END "listscript";



COMMENT**************************************************************
*                                                                   *
*                                 PROMPT!CMD                         *
*                                                                   *
********************************************************************;
PROCEDURE PROMPT!CMD(STRING Object);
BEGIN "promptcmd"
	INTEGER Line,Char;

	Char _ LOP(Object);
	IF
	    Char NEQ "^"
	THEN
	BEGIN "num"
	Line _ CVD(Char);
	IF
	    Line = 0
	THEN
	    Line _ 1;

	DO
		Char _ LOP(Object)
	UNTIL
		Char = "^" OR (Char = NULL);
	END "num"
	ELSE
	    Line _ 1;


	IF
		Char = "^"
	THEN
	BEGIN "control"
		Char _ LOP(Object);
		Char _ Char - '100;
	END "control"
	ELSE
		Char _ '03;

	IF
	    0<Line<(Port!Limit + 1)
	THEN
	BEGIN
	    Simple!Output(Line,Char);
	    AUXCLV(Port#[Line],0,AUXCAL!LEVDEF);
	END;
END "promptcmd";


PROCEDURE DOCOMMAND(INTEGER CMND;STRING OBJECT);

BEGIN"DOCOMMAND"

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">>Docommand entered:",Cmnd,":",Object,CRLF%);
    ENDC

    IF Cmnd = -1 
    THEN
         t!print( %"?",CRLF%)
    ELSE
    CASE Cmnd OF
    BEGIN
         Help!cmd            (Object); \ 0;
         Help!lst              		; \ 1;
         Test!cmd              (Object); \ 2;
         Status!cmd            (Object); \ 3;
         Connect!cmd           (Object); \ 4;
         Disconnect!cmd        (Object); \ 5;
         Logon!cmd             (Object); \ 6;
         Stop!cmd              (Object); \ 7;
         Rate!cmd              (Object); \ 8;
         Totals!cmd            (Object); \ 9;
         Quit!cmd              (Object); \ 10;        \ Shutdown ; \ ;
         Quit!cmd              ("QUIT"); \ 11;
         Initialize!cmd        (Object); \ 12;
         Crash!cmd             ("On Command"); \ 13;
         Period!cmd            (Object); \ 14;
         Go!cmd                (Object); \ 15;
         Full!cmd              (Object); \ 16;
         Meter!cmd             (Object); \ 17;
         Help!cmd              (Object); \ 18;
         Monitor!cmd           (Object); \ 19;
         Setprint!cmd          (Object); \ 20;
         Debug!                (Object); \ 21;
         Quit!cmd              ("CLEAR"); \ 22;       \ Clear cmd ; \ ;
         switch!cmd            (object); \ 23;
	 Write!Init		(Object); \ 24;
         SW!cmd			(Object); \ 25;
	 Script!cmd		(Object); \ 26;
	 Clock!off			; \ 27;
	 Levdef!cmd		(Object); \ 28;
	 Help!lst			; \ 29;
	 Ports!cmd			; \ 30;
	 Prompt!cmd			(Object); \ 31;
	 Buffer!cmd			(Object); \ 32;
	 Post!cmd			(Object); \ 33;
	 List!Script			(Object); \ 34;
	State!List				; \ 35;
         To!be!implemented;
         To!be!implemented;
    END;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">>DOCOMMAND EXIT",CRLF%); ENDC

END "DOCOMMAND";

COMMENT*******************************************************************
*                                                                        *
*                           WRITE!INIT                                   *
*                                                                        *
*************************************************************************;
PROCEDURE WRITE!INIT (STRING object);

BEGIN "writeinit"
	INTEGER eof,o!chan,script;
	o!chan _ Opn!Out(object,eof);

\	lost prompt timeout Limit;
	OUT(o!chan,CVS(Reqprmpt!Time DIV 1000) & CRLF);
\	prompt;
	OUT(o!chan,Prmpt & CRLF);
\	Logoff string;
	OUT(o!chan,Cntrollee!quit[1 TO INF -1] & CRLF);
\	user area name;
	OUT(o!chan,Username & CRLF);
\	initialize delay;
	OUT(o!Chan,CVS(Waitdelay DIV 1000) &CRLF);
\	max!script limit;
	OUT(o!chan,CVS(Max!script) & CRLF);
	script _ 0;
	WHILE
		script < max!script
	DO
	BEGIN
\	script file;
	OUT(o!chan, Scriptid[script] & CRLF);
\	ID prefix;
	OUT(o!chan,Idprefix[script] & CRLF);
\	No of users for this script file;
	OUT(o!chan,CVS(No!of!users[Script]) & CRLF);
\	Logon delay;
	OUT(o!chan,CVS(Logon!delay[script] DIV 1000)  & CRLF);
\	no of loops;
	OUT(o!chan, CVS(No!of!Loops[script]) & CRLF);
	script _ script + 1;
	END;
	RELEASE(o!chan);
END "writeinit";

COMMENT*******************************************************************
*                                                                        *
*                           LOOKUPCOMMAND                                *
*                                                                        *
*************************************************************************;

INTEGER PROCEDURE Lookupcommand (STRING Command);

BEGIN "LOOKUPCOMMAND"

    INTEGER Matchcount,Cmndno,I,Returnvalue;
    BOOLEAN Exactmatch;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">>Lookupcommand entered:",Command,CRLF%);
    ENDC

    Command _ Upper(command);
    I_ 0;
    Matchcount _ 0;
    WHILE
         I < NCMDS 
         AND NOT(Exactmatch_EQU(Command,Command!value[I]))
    DO
    BEGIN
         IF
              EQU(Command,Command!value[I][1 TO Length(Command)])
         THEN
         BEGIN
              Matchcount _ Matchcount+1;
              Cmndno _ I;
         END;
         I _ I + 1;
    END;
    IF
         Exactmatch
    THEN
         Returnvalue _ I
    ELSE
    IF
         Matchcount = 1
    THEN
         Returnvalue _ Cmndno
    ELSE
         Returnvalue _ -1;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">>Lookupcommand exit:",Returnvalue,CRLF%);
    ENDC

    RETURN(Returnvalue);

END "LOOKUPCOMMAND";

COMMENT****************************************************************
*                                                                     *
*                             UPPER                                   *
*                                                                     *
**********************************************************************;

STRING PROCEDURE Upper(STRING Object);

BEGIN "UPPER"

    INTEGER Brtab,Brchar;

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Upper entered:",Object,CRLF%);
    ENDC

    IF
         Brtab = 0
    THEN
         Setbreak(Brtab _ Getbreak,NULL,NULL,"KIN");

    IFC DEBUG!CMD
    THENC IF DEBUG THEN s!print( %">> Upper exit",CRLF%); ENDC

    RETURN(Scan(Object,Brtab,Brchar));

END "UPPER";

COMMENT****************************************************************
*                                                                     *
*                             GETOBJECT                               *
*                                                                     *
**********************************************************************;

INTEGER PROCEDURE Getobject(STRING Object);

BEGIN "GETOBJECT"

    INTEGER Sign,Value,Junk;

    IFC Debug!cmd
    THENC IF Debug THEN s!print( %">>Getobject entered:",Object,CRLF%); ENDC

    Sign _ 1;
    Value_ 0;
    IF
         Object = "-"
    THEN
    BEGIN
         Sign _ -1;
         Junk _ LOP(Object);
    END;
    WHILE
         "0" LEQ Object LEQ "9"
    DO
         Value _ Value* 10 +(LOP(object)- "0");

    IFC Debug!cmd
    THENC IF Debug THEN s!print( %">>Getobject exit:",Value*Sign,CRLF%); ENDC

    RETURN(Value*Sign);

END "GETOBJECT";

COMMENT********************************************************************
*                                                                         *
*                                  OUTER BLOCK                            *
*                                                                         *
*************************************************************************;

STRING PROCEDURE hms(INTEGER sec);

BEGIN "hms"

	STRING time;
	INTEGER temp,width,digits;

	GETFORMAT(width,digits);
	SETFORMAT(2,digits);
	sec _ sec/1000;
	IF
	    sec > 3600 
	THEN
	    BEGIN
		TIME _ CVS(sec div 3600) & ":";
		SETFORMAT(-2,digits);
	    END
	ELSE
	    time _ "   ";
	temp _ sec MOD 3600;
	IF
	    sec > 60
	THEN
	    BEGIN
		time _ time & CVS(temp DIV 60) & ":";
		SETFORMAT(-2,digits);
	    END
	ELSE
	    time _ time & "   ";
	time _ time & CVS(temp MOD 60);
	SETFORMAT(width,digits);
	RETURN(time);

END "hms";

PROCEDURE Commandport;
BEGIN
    Commandline _ NULL;
    WHILE
         Length(Instring) >   0
         AND Instring NEQ " "
    DO
    BEGIN
         Commandline _ Commandline & Instring[1 for 1];
         Junk _ LOP(Instring);
    END;

    IF
         Length(CommandLine)=0
    THEN
         t!print( %"?",CRLF%)
    ELSE
    BEGIN
         IF
              Length(Instring)>1
         THEN
              Junk _ LOP(Instring)
         ELSE
              Instring _ NULL;

         Docommand(Lookupcommand(Commandline),Instring);
    END;
    t!print( %"}"%);
END;

ifc compiler!switch("B") thenc begin
	external procedure BAIL;
	BAIL;
end endc;

OLOOP _ FALSE;	\ start normal;
tty!prnt _ TRUE;
Port!test _ TRUE;
Line!test _ TRUE;
Cntrollee!quit _ "QUIT!" & CR;
Prmpt _ ":";
Total!lostPrmpt _ 0;
Olog _ FALSE;
monitor!chan _ -1;
ini!chan _ -1;
ARRCLR(POST#);
Monitor!time_99999999;
Junk_80;
Auxclv(-1,Junk,Auxcal!width);   \ set width to 80 ;
	t!print(%"Simin SIMULATOR",tab%);
	t!print(%hms(CALLI(0,'23)),tab%);	\ time program is run at;
	t!print(%STDATE(CALLI(0,'14),0),crlf%);		\ day program is run at;
t!print(%VERSION,crlf%);

t!print( %"}"%);
INTTBL(1024);
Initialize!Interrupts;
Intset(Intproc,PSTACK(32)+STRINGSTACK(16));
Rate!Cmd("FULL");
Debug!("D,L");


RLOOP:
\ pg IF
     SPIN
THEN
	COMMENT		SET TIMEer interrupt to go off in 10 minutes ;
\ pg    CALLI((2 LSH 18) LOR 10,CALLI!SETTIM)
ELSEpg ;


    WHILE NOT OLOOP  DO
BEGIN
    Instring _ Inchwl;
    Commandport;
END;
IF 
    OLOOP
THEN
BEGIN
    OLOOP _ FALSE;
t!print( %"WOKE UP!",CRLF%);
    GOTO RLOOP;
END;
CRASH:

END "TPMAST"

    $[5Sn$[5Sn