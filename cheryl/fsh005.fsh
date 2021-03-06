42XFORMAT01:Peak V2(301)    Definition Files    06-Jun     1 1984       




                                                                              
                                                                              
                                                                              
                              
                              
                              
                              
                              
                              
                                                
                                                
                                                
                              
                              
                              
                              
                              
                              
                                                                              
                                                                              
                                                                              




























                           
         
         
                  
         
           
                         

     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 1-1
     Prt: 06-Jun-84  13:53                                  PEAK Definition File

     define ! = "comment", !! = "comment";
     
     ! *************************************************************************
     *                                                                         *
     *                    DED History and Definition File.                     *
     *                   Dave W. Smith, September '81 - ...                    *
     *                                                                         *
     **************************************************************************;
     
     
     require "{}[]" delimiters;
     
     ! Version information and Edit history ;
     
     require "Host.Def" source!file;
     
       ! Get a definition of our host system.
       ;
     
     ifcr Host.Sys = 10 thenc
       define
         TymcomX = true,
         Tops20  = false,
         Debug   = true;
     endc
     
     ifcr Host.Sys = 20 then
       define
         TymcomX = ,
         Tops20  = true,
         Debug   = true;
     endc
     
     define
       appnd  (X, Y) = {X _ X & (Y)},
       xwd    (X, Y) = {(((X) lsh 18) lor ((Y) land '777777))},
       xwdstr (X)    = {("[" &
                           cvos('1000000 + lh(X))[2 to inf] & "," &
                           cvos('1000000 + rh(X))[2 to inf] & "]")
                       }, |0|
       !ver   (X, Y) = {((((X) lsh 9) lor ((Y) land '777)) land '777777)},
       !edit  (X)    = {((X) land '777777)},
       !date  (X)    = {"X"},
     
       !version (X, Y, Z) =
       { |0|
         define
           DED!Date!Version  = cvps(Z);
     
         require (xwd(X, Y)) version
       }; |0|
     
     !               A sample usage of this macro is as follows:
     !
     !       !version(!ver('1, '0), !edit('057), !date(20-January-1983))
     !                means "Version 1.0 (57), 20-January-1983"
     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 1-2
     Prt: 06-Jun-84  13:53                                  PEAK Definition File

     !
     !   (Please note that the invocation of !version requires a semicolon,
     !   but that syntactic discretion prevents its inclusion here.)
     ;
     
     
     !version(!ver('2, '0), !edit('301), !date(23-April-1984));
     
     define
       DED!Version!Word   = {memory['137]},
       DED!Major!Version  = {cvos(memory['137] lsh -27)},
       DED!Minor!Version  = {cvos((memory['137] lsh -18) land '777)},
       DED!Edit!Version   = {cvos(memory['137] land '777777)},
       DED!Alias          = {"PEAK"},
       DED!Version!String = {""};
     
     
     ! ------------------------------------------------------------------------;
     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 2-1
     Prt: 06-Jun-84  13:53                                          PEAK History

     
     ! -------------------------------------------------------------------------
     !
     !                      September-October, '81  /DWS
     !                         DED created from Void.
     !                  Inspired by EMACS, FINE, MINCE, etc.
     !
     ! -------------------------------------------------------------------------
     !
     !  Field test releases:
     !  --------------------
     !  V0.1         8..81           Released for field test in mid-October.
     !  V0.2         11.4.81         Released for field test.  A few random
     !                               bugs fixed.
     !  V0.3         11.11.81        More random bug fixes.
     !  V0.4         11.20.81        Some new commands. (Wipe, copy, safe
     !                               exit).
     !  V0.5         11.24.81        ^G is uniform abort character.
     !  V0.6         12.10.81        Bug fix in kill code (didn't initialize
     !                               Kill!Pnt).
     !                               Add "text" mode with electric space.
     !                               Add commands to switch modes.
     !                               Add "kill whitespace", "center line",
     !                               "right justify line" commands.
     !  V0.7         12.14.81        Add heuristics to redisplay and fix H19
     !                               bug.
     !  V0.10        12.16.81        Add "change" and "query change" commands.
     !  V0.11        1.5.82          Fix terminal input routine to present
     !                               less of a load on the system.  (i.e. no
     !                               spinlock for input).
     !  V0.12        1.12.82         Fix text mode space to kill trailing
     !                               spaces.
     !  V0.13        2.2.82          Some cosmetic changes.
     !  V0.14        2.19.82         New window and redisplay modules.  Major
     !                               changes, including line wrap, hooks for
     !                               split screen, overwriting insert, file
     !                               locking, and more.
     !  V0.15        3.4.82          Buffer all output in ther terminal module
     !                               and flush with one auxcal (.axost).
     !                               *Big* win.  Some other smallish bug
     !                               fixes. (Needed to send Yellow ball to
     !                               make sure chars got out before reseting
     !                               terminal).
     !  V0.16        3.9.82          Parenthesis matching commands, change
     !                               behaviour of ^v, user-friendlier
     !                               searches.
     !  V0.17        3.15.82         Filename "alias" support for MAGNUM.
     !                               Some fixes in the redisplay to speed
     !                               things up.
     !  V0.20        3.18.82         Make DED know about <lf>, instead of
     !                               stripping them out a la FINE.  Support
     !                               for "overstriking" in WINDOW.  Fix
     !                               commands to expect <cr><lf> as
     !                               end-of-line.
     !  V0.21        3.19.82         Big Files!  Fast read & write!  Big win!
     !                               Also a redisplay optimization &
     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 2-2
     Prt: 06-Jun-84  13:53                                          PEAK History

     !                               'QueryKey' command.
     !  V0.22        3.23.82         Patch for imbedded nulls & sequence #'s.
     !  V0.23        3.24.82         Change delimeters on search commands to
     !                               reflect change in philosophy on handling
     !                               <cr><lf> pairs as atomic.
     !  V0.24        3.25.82         Change/Q-Change now issue non-NULL
     !                               message when done.  Access functions to
     !                               bits in C!Tab[].
     !  V0.25        4.2.82          Bug checking empty files for sequence
     !                               numbers.  Make /READ work.
     !  V0.26        4.9.82          ReSearch commands.  Small edits.
     !  V0.27        4.12.82         *CaseMatch* E-Var, more commands.
     !  V0.27        4.14.82         Marks 0..9 and related commands.  Goto
     !                               Mark cmd.
     !  V0.30                        Lost in the shuffle.
     !  V0.31        4.21.82         Implement split window features.
     !                               Date/Time stuff.
     !  V0.32        4.22.82         Optimize search code.
     !  V0.33        4.26.82         Code to run off wrap correctly. Fix /RPG
     !                               support.
     !  V0.34        4.29.82         ReInit the terminal on ^L.
     !  V0.35        5.3.82          Runtime help system (first cut).
     !  V0.36        5.5.82          "Sticky column" fixed.  Various other
     !                               fixes.  Unindent fixed for big args.
     !                               Redisplay fix for right margin.
     !  V0.37        5.25.82         Complete rework of C!ArgV.  Bugx fixes.
     !  V0.40        6.16.82         Checkpoint logic. Multiple file code.
     !  V0.41        6.22.82         0.40 broke MAGNUM interface.  Fix it.
     !  V0.42        6.24.82         Misc bug fixes.
     !  V0.43        7.1.82          B!Kill forgot to B!Restore.  Gak!
     !  V0.44        7..82           Tops-20 first cut.  Slow File I/O.
     !  V0.45        8.2.82          Folded Tops-20 stuff back into Tymcom-X
     !                               stuff. Optimized B!GetC.  Hacked on
     !                               ReDisplay, Term.  C!CmdFile stuff.
     !  V0.46        8.30.82         Tym430 support. Various other stuff.
     !  V0.47        10.5.82         Start of massive cleanup for release.
     !                               Add 'special' character bit.
     !  V0.50                        Internal testing before final release.
     !  V0.51                        Internal " " ".  M-Search.
     !  V0.52                        Internal " " ".  C!Indent now breaks
     !                               lines.  C!Arg fixed.
     !  V0.53                        Internal " " ".  Fixed horrid bug in
     !                               C!GetC that killed macros when executed
     !                               from command files.
     !  V0.54                        Internal " " ". B!Fini now writes out all
     !                               modified buffers.
     !  V0.55                        Internal " " ". No move SYMBOL.  Symbol
     !                               table is build via macro in COMAND.
     !                               Slight win on startup.
     !  V0.56                        Internal " " ".  Added ChrMask to keep
     !                               funny bits in chrtab from screwing up the
     !                               token stuff. Also fixed checkpointing.
     !
     ! -------------------------------------------------------------------------
     !
     !  V1.0         1.12.83         At long last ... (a great many things
     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 2-3
     Prt: 06-Jun-84  13:53                                          PEAK History

     !                               have passed under the bridge since 0.56
     !                               in the way of bug fixes - kmd)
     !  V1.1         3.20.83         Cleaning up bugs in file/buffer systems
     !                               which result in death when manipulating
     !                               many and large buffers.  Also improving
     !                               the Checkpoint facility.  A good many
     !                               other bugs are fixed, as well.
     !  V1.2         9.2.83          Fix of 79th-character wrap-around problem
     !                               (thanks to TJB).  Add British Petroleum
     !                               customer Usernames to the exception list.
     !                               Add VT102 support with jump-scroll-only
     !                               compatible support of insert/delete
     !                               lines (Thanks to Carl).
     !                               Change redisplay module to send a string
     !                               to the display, to fix backpressure
     !                               problem with VT102 fix.
     !
     !  V1.2         9.27.83         Carl Baltrunas's brilliant implementation
     !                               of abbreviation in commands requiring the
     !                               entry of function or variable names.
     !
     !  V1.2         10.4.83         CAB's implementation of comand-echoing of
     !                               Meta and XMeta comands (added environment
     !                               variables to control these.)
     !
     !  V2.0         10.26.83        Tops-20 page-mapping version.
     !
     !  V2.0(210)    11.10.83        Integration of Tymcom-X and Tops-20
     !                               sources to a single directory.
     !
     !  V2.0(216)    12.6.83         Include Host.Def within Ded.Def.
     !                               Redesign null-removal architecture to
     !                               delete nulls by default, but allow
     !                               override by a command line switch.
     !                               Display multiple arrows on the status
     !                               line to reflect the number of buffers to
     !                               each side of the curent buffer.
     !
     !  V2.0(220)    12.16.83        (WRS) Added [CreAux] command to insert an
     !                               aux circuit session in the buffer.
     !
     !  V2.0(222)    12.21.83        Make W!Disp not try to call R!Disp if
     !                               C!ChrP is true.  This means that
     !                               redisplays will not take place inside of
     !                               command files or macros.
     !
     !  V2.0(223)    1.4.84          Add the [Capitalize Token] command.
     !  V2.0(225)    1.9.84          Add Qvt102 terminal support.
     !
     !  V2.0(226)    1.18.84         Fix [Twiddle] to always treat crlf as a
     !                               single character.
     !                               Remove Qvt102 terminal support
     !                               (= Tym425).
     !
     !  V2.0(227)    1.20.84         CAB modified Keyboard Macro structures to
     !                               allow any number of macros to be defined
     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 2-4
     Prt: 06-Jun-84  13:53                                          PEAK History

     !                               and bound to keys or bound to names.  Any
     !                               "named" macros will supersede any "real"
     !                               functions with the same names.  Unbinding
     !                               of keys results in the key getting the
     !                               most previous binding back.  Keys bound to
     !                               functions cannot be unbound, however they
     !                               may be re-bound.  Name completion is also
     !                               fully supported in this version.
     !
     !  V2.0(230)    1.21.84         CAB added MaxMacroDepth = 12 (Safe) and
     !                               C!MacroDepth to prevent runaway recursion
     !                               of user-defined macros.  SAIL only seems
     !                               capable of supporting a recursion depth
     !                               near 18 without extending the system stack.
     !
     !  V2.0(234)    2.7.84          Fix [Capitalize Token] to find the
     !                               beginning of the current token.
     !                               Add [Column Insert] to allow a variable
     !                               number of character insertions.
     !
     !  V2.0(237)    2.8.84          Re-implement Scanset support. (It had
     !                               magically vanished).
     !
     !  V2.0(242)    2.9.84          Unfix [Capitalize Token] to not do the
     !                               above.
     !
     !  V2.0(243)    2.10.84         Add a flag to control the position of the
     !                               cursor after region-oriented commands
     !                               take place (C!SPMRegion).
     !
     !  V2.0(250)    2.17.84         Rewrite (Un)Indent-Region, commands.
     !                               Add Peak's own Marks SPt1, SPt2 and SPt3
     !                               to simplify many commands.
     !
     !  V2.0(251)    2.21.84         Change the internal Mark structure to a
     !                               more general form, allowing a large
     !                               number of internal marks to be availible.
     !
     !  V2.0(253)    2.22.84         Make [Kill Line] understand FF as an end of
     !                               line rather than a silly normal
     !                               character.
     !
     !  V2.0(254)    2.24.84         Rewrite Force Indent logic to improve
     !                               efficiency.  Rewrite Try Column logic to
     !                               fix an error and clarify thinking.
     !
     !  V2.0(255)    2.29.84         [Fill Paragraph]!!!!!  Still stuff to do,
     !                               but the basic method is working.
     !
     !  V2.0(256)    3.5.84          Some fixes to [Fill Paragraph] (more to
     !                               come!).
     !                               Any number of Up and Down movements may
     !                               be made w/o altering the sticky column.
     !                               [Scroll Window Down] now allows the point
     !                               to disappear off the end of the screen, and
     !                               works much more efficiently.
     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 2-5
     Prt: 06-Jun-84  13:53                                          PEAK History

     !
     !  V2.0(257)    3.7.84          Created a method for finding the end of
     !                               the screen without performing a window
     !                               fill operation.  This fixed bugs in
     !                               [Scroll Window Down] and [Bottom of Window]
     !                               having to do with wraparound mode.
     !
     !  V2.0(260)    3.8.84          [Fwd Half Para] and [Bck Half Para] added.
     !
     !  V2.0(261)    3.12.84         Final ^L-related bug in [Fill Paragraph]
     !                               fixed.
     !                               [Fwd Half Para] and [Bck Half Para] changed
     !                               to use new Find EOP/BOP routines.
     !
     !  V2.0(262)    3.12.84         Created [Fill to End Of Paragraph].
     !                               Renamed [Fwd Half Para] and [Bck Half Para]
     !                               to [Down Paragraph] and [Up Paragraph],
     !                               respectively.
     !
     !  V2.0(264)    3.14.84         Fix file-length problem with F!GetC.  (It
     !                               was not paying attention to the number of
     !                               characters in the file, reading beyond
     !                               the end of the file in C!Ini).
     !
     !  V2.0(265)    3.26.84         Redesign ALL charcter-inserting commands,
     !                               to centralize the basic function, and get
     !                               Text and Overwrite Modes to work correctly.
     !                               Modify [Fill Paragraph] logic to accomodate
     !                               the above changes.
     !
     !  V2.0(270)    3.28.84         Implement [Force Left Margin], [Show
     !                               Column], [Show Octal], [Insert Octal], and
     !                               [Set Append Kill].
     !
     !  V2.0(271)    3.28.84         Fix [Center Line] to include the left
     !                               margin.  Add [Set Terminal Type] command to
     !                               recover faulty startups.
     !
     !  V2.0(273)    3.29.84         Add [Go to Column] for going directly a
     !                               particular column on the current line.
     !
     !  V2.0(274)    4.3.84          Add [Fill Line] command.
     !                               Fix problem with Text mode insert which
     !                               prevented correct wraparound from happening
     !                               in some cases.
     !
     !  V2.0(276)    4.11.84         Fix the Text Mode fix in (274) above.
     !
     !  V2.0(277)    4.13.84         Put all relevant variables related to Marks
     !                               into the checkpoint file.  This fixes a bug
     !                               in Text Mode insertion in which B!SetM was
     !                               getting a "Bad Value" error under peculiar
     !                               circumstances.
     !                               Make the default column for [Goto Column]
     !                               the left margin.
     !                               Release for Tymcom-X!!!
     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 2-6
     Prt: 06-Jun-84  13:53                                          PEAK History

     !
     !  V2.0(301)    4.25.84         Fix [Quote] to correctly quote CR and TAB,
     !                               rather than interpreting them.
     !                               Add control capabilities to [CreAux]
     !                               (triggered by the sequence "<esc> <char>",
     !                               in which <esc> is the CreAux escape
     !                               character) to allow the user to:
     !
     !                                   <char>   capability
     !                                   ------   ----------
     !                                   "Q"    - continue editing the buffer
     !                                            without zapping the circuit.
     !                                   "C"    - change the escape character.
     !                                   "Z"      zap the circuit.
     !                                   <esc>  - send the character <esc> to
     !                                            the circuit.
     !
     ! ------------------------------------------------------------------------;
     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 3-1
     Prt: 06-Jun-84  13:53               Operating System dependent definitions.

     
     ! ------------------------------------------------------------------------;
     
     
     ifcr Tops20 thenc
       external simple boolean procedure Kequ (string Str1, Str2);
     
         ! Case-independent string-comparison function
         ;
     endc
     
     ifcr TymcomX thenc
       define
         exit = {calli(0, '12)};
     
           ! An exit call which allows us to get out without SAIL's end-of-job
           ! message sneaking out.
           ;
     endc
     
     ifcr Tops20 thenc
       define
         exit =
         { |0|
           begin!code |1|
             haltf;
           end; |1|
         }; |0|
     
           ! A Tops-20 way out.
           ;
     endc
     
     
     ! ------------------------------------------------------------------------;
     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 4-1
     Prt: 06-Jun-84  13:53                          Global routine redefinitions

     
     ! ------------------------------------------------------------------------;
     
     !                         From the Command Module
     ;
     
     define
       C!RFSearch = {C!A000};
     
     
     !                         From the Buffer Module
     ;
     
     define
       B!WriteTextFile       = {B!A000},
       B!CreateChkPntFile    = {B!A001},
       B!Init                = {B!A002},
       B!FreeP               = {B!A003},
       B!FlushToEDT          = {B!A004},
       B!RestoreFromEDT      = {B!A005},
       B!RestoreChkPnt       = {B!A006},
       B!CKFile              = {B!A007},
       B!DelCurrentBuffer    = {B!A008},
       B!SetB                = {B!A009},
       B!Step                = {B!A00A},
       B!Cnt                 = {B!A00B},
       B!Pcnt                = {B!A00C},
       B!GetP                = {B!A00D},
       B!SetP                = {B!A00E},
       B!GetL                = {B!A00F},
       B!SetL                = {B!A00G},
       B!GetM                = {B!A00H},
       B!SetM                = {B!A00I},
       B!Move                = {B!A00J},
       B!Delete              = {B!A00K},
       B!Insert              = {B!A00L},
       B!GetC                = {B!A00M},
       B!AnyM                = {B!A00N},
       B!ModCnt              = {B!A00O},
       B!Fini                = {B!A00P},
       B!BufStat             = {B!A00Q},
       B!FileInsert          = {B!A00R},
       B!CheckPoint          = {B!A00S},
       B!AllocateMark        = {B!A00T},
       B!DeAllocateMark      = {B!A00U};
     
     
     ! ------------------------------------------------------------------------;
     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 5-1
     Prt: 06-Jun-84  13:53                                      PEAK definitions

     
     ! ------------------------------------------------------------------------;
     
     
     !           Some operations used widely throughout the kingdom
     ;
     
     define
       ceiling (X, Y) = {((X + Y - 1) div Y)};
     
         ! Least integer >= X/Y
         ;
     
     
     define
       incr (X, Y) =
       { |0|
         X _ X +
             ifc (length(cvps(Y))) thenc
               Y
             elsec
               1
             endc
       }; |0|
     
         ! Increment a vairable
         ;
     
     
     define
       decr (X, Y) =
       { |0|
         X _ X -
             ifc (length(cvps(Y))) thenc
               Y
             elsec
               1
             endc
       }; |0|
     
         ! Decrement a variable
         ;
     
     
       define
         set (X, Y) =
         { |0|
           X _
               ifc (length(cvps(Y))) thenc
                 Y
               elsec
                 true
               endc
         }, |0|
     
         clear  (X) = {X _ false},
     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 5-2
     Prt: 06-Jun-84  13:53                                      PEAK definitions

         toggle (X) = {X _ not X};
     
       define
         IsLower   (X) = {("a" <= X <= "z")},
         IsUpper   (X) = {("A" <= X <= "Z")},
         UpShift   (X) = {(X land (lnot bit(30)))},
         ToUpper   (X) = {(if (IsLower(X)) then UpShift(X) else X)},
         DownShift (X) = {(X lor bit(30))},
         ToLower   (X) = {(if (IsUpper(X)) then DownShift(X) else X)};
     
     
     !                        Some Stuff for Debugging
     ;
     
     ifcr Debug thenc
       define
         trusted = {};
     elsec
       define
         trusted = {safe};
     endc
     
     
     !                   Macros to Assist Control Structures
     ;
     
     define
       upto    = {step 1 until},
       downto  = {step -1 until},
       forever = {while true};
     
     define  Begin!Code = {
       Start!Code |0|
         define P='17, SP='16, T1='1, T2='2, T3='3;
     }; |0|
     
     
     define
       lh (word)    = {((word) lsh -18)},
       rh (word)    = {((word) land '777777)},
       hr (word)    = {((word) land '777777)},
       hl (word)    = {((word) lsh 18)},
       !mask (N)    = {((1 lsh N) - 1)},
       MaxInteger   = !mask(35),
       LargeInteger = MaxInteger - 1000000;
     
       ! Word and Bit Access Macros.
       ;
     
     
     define
       fill( arrnam, i1,i2, val ) =
       { |0|
           arrblt( arrnam[i1+1], arrnam[i1]:=(val), (i2)-(i1) )
       }; |0|
     
     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 5-3
     Prt: 06-Jun-84  13:53                                      PEAK definitions

       ! Macro to Fill a Portion of an Array with a Value
       ;
     
     
     define
       bit (X, Y) =
       { |0|
         ifcr (length(cvps(Y))) thenc
           ((X) lsh (35-(Y)))
         elsec
           (1 lsh (35-(X)))
         endc
       }; |0|
     
       ! Bit-field accessing macro.
       ;
     
     
     ! commonly used characters equates ;
     
     define
       NUL   = '0,
       BEL   = '7,
       BS    = '10,
       TAB   = '11,
       LF    = '12,
       FF    = '14,
       CR    = '15,
       CAN   = '30,
       ESC   = '33,
       SP    = '40,
       DEL   = '177,
       Meta  = '200,
       Meta2 = '400,
       crlf  = {('15&'12)},
       crlf2 = {crlf & crlf};
     
     
     ! bit definitions for the character table (C!Tab).  The table has one
     !  entry for each ASCII character, with bits in the left half and
     !  the upshifted character in the right half. ;
     
     define
       IsAlpha   = bit(1),
       IsNum     = bit(2),
       IsToken   = bit(3),
       IsWhite   = bit(4),
       IsEOL     = bit(5),
       IsDelim   = bit(6),
       IsYes     = bit(9),
       IsNo      = bit(10),
       IsAbort   = bit(11),
       IsSpecial = bit(12)
     ;
     
     
     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 5-4
     Prt: 06-Jun-84  13:53                                      PEAK definitions

     ! ..  and a mask to keep extraneous bits from messing stuff up. ;
     
     define
       ChrMask = IsAlpha + IsNum + IsToken + IsDelim + IsSpecial;
     
     ifcr TymcomX thenc
       define
         BasePage = 100;                     ! Base of the Buffer in core
                                             ;
     define
       GAPMIN      = 1 * 512 * 5;            ! Minumum size we want gap to be ;
     define
       GAPMAX      = 3 * 512 * 5;            ! Biggest size we want gap to be ;
     define
       GAPEXPAND   = 512;                    ! words to add to gap ;
     define
       GAPSHRINK   = 512;                    ! words to remove from gap ;
     define
       MAXFILESIZE = 400 * 512;              ! the maximum number of pages we
                                             !  can handle ;
     endc
     
     
     ! Buffer Chain-related stuff.
     ;
     
     define
       BUFMAX = 5;                           ! The maximum number of buffers
                                             ! allowed in the Chain.
                                             ;
     
     ! stuff used by the search code ;
     
     define MAXSEARCHSTRING = 80;    ! largest string size we'll search for ;
     define MAXMSEARCH      = 5;     ! The maximum number of strings we'll
                                     ! search for at once.
                                     ;
     
     
     ! other useful equates ;
     
     define
       FORWARDS  = 1,
       BACKWARDS = -1;
     
       define
         Addrs (Pg, Loc) =
         { |0|
           ifcr length(cvps(Loc)) thenc
             ((((Pg) land !mask(9)) lsh 9) lor ((Loc) land !mask(9)))
           elsec
             ((((Pg) land !mask(9)) lsh 9))
           endc
         }, |0|
     
         CharactersPerWord    = {5},
     Cre: 25-Apr-84  14:04  (PEAKX)DED.DEF                              Page 5-5
     Prt: 06-Jun-84  13:53                                      PEAK definitions

         WordsPerPage         = {512},
         CharactersPerPage    = {(WordsPerPage * CharactersPerWord)},
         PagesPerAddressSpace = {512},
     
         ChrNo (X)            = {((X) mod CharactersPerWord)},
         PgNo  (X)            = {(((X) land !mask(18)) lsh -9)},
         WrdNo (X)            = {((X) div CharactersPerWord)};
     
     
     ! ***************************  end of DED.DEF  ***************************;





                                                      
                                                      
                                                      
                              
                              
                              
                              
                              
                              
                                                            
                                                            
                                                            
                              
                              
                              
                              
                              
                              
                                                      
                                                      
                                                      



                              
                              
                              
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      




                            
          
          
                     
          
            
                      

     Cre: 05-Dec-83  16:27  (PEAKX)HOST.DEF                             Page 1-1
     Prt: 06-Jun-84  13:53                               Our Host System Defined

     
     ! *************************************************************************
     !                                                                         *
     !                                Host.Def                                 *
     !                                                                         *
     !           (In which we define which host we are operating on)           *
     !                                                                         *
     ! ************************************************************************;
     
     
       define
         Host.Sys = 10;
     
         ! Our choices here are:
         !   10 for "TymcomX"
         !   20 for "Tops20".
         ;
     
     
     ! ************************************************************************;

   R@)?