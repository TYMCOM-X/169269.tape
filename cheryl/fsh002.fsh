42XFORMAT01:Peak V2(301)   All Other Modules    06-Jun     5 1984       
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 44-2
     Prt: 06-Jun-84  13:56                                          Rtn B!Delete

                     AC2 = 2,
                     AC3 = 3;
                   protect!acs
                     AC1,
                     AC2,
                     AC3;
                   label
                     Loop,
                     GoOn;
     
                     move      AC1, B!Point;
                     movei     AC2, access(Marks[FirstMark]);
                     move      AC3, MarkCnt;
     
                   Loop:
                     sojl      AC3, GoOn;
                     camge     AC1, (AC2);
                     sos       (AC2);
                     aoja      AC2, Loop;
     
                   GoOn:
                 end; |5|
     
                 B!Point := B!Point - 1;
                 B!GapStart := B!GapStart - 1;
                 B!GapSize := B!GapSize + 1;
                 B!Size := B!Size - 1;
               end; |4|
           end; |3|
     
         if ( not B!ModP ) then
           begin |3|
             B!ModP := true;         ! buffer is now modified ;
             W!FixS;
           end; |3|
     
       end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 45-1
     Prt: 06-Jun-84  13:56                                          Rtn B!Insert

     
     ! Insert a character into the buffer.  The character is inserted at the
     !  right of the point, and at the left size of the gap. ;
     
     ! <<  Is this actually true? ;
     
     internal simple procedure B!Insert( integer C );
       begin "insert" |2|
     
         own integer InsertBP;
     
         if ( B!Lock ) then return;
     
         start!code |3|
           define
             AC1 = 1,
             AC2 = 2,
             AC3 = 3;
           protect!acs
             AC1,
             AC2,
             AC3;
           label
             Loop,
             GoOn;
     
             move      AC1, B!Point;
             movei     AC2, access(Marks[FirstMark]);
             move      AC3, MarkCnt;
     
           Loop:
             sojl      AC3, GoOn;
             camge     AC1, (AC2);
             aos       (AC2);
             aoja      AC2, Loop;
     
           GoOn:
         end; |3|
     
         B!ForceGap;
         if ( B!GapSize <= GAPMIN ) then ExpandGap;
         InsertBP := MakeGapStartBP;
         B!GapStart := B!GapStart + 1;
         B!GapSize := B!GapSize - 1;
     
         dpb( C, InsertBP );
         B!Size := B!Size + 1;
         B!Point := B!Point + 1;
         B!BegP := false;
     
         if ( Not B!ModP ) then
           begin |3|
             B!ModP := true; ! buffer is now modified ;
             W!FixS;
           end; |3|
     
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 45-2
     Prt: 06-Jun-84  13:56                                          Rtn B!Insert

       end "insert"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 46-1
     Prt: 06-Jun-84  13:56                                            Rtn B!GetC

     
     ! Return the character to the right of the point.
     ;
     
     internal simple integer procedure B!GetC;
     begin "B!GetC" |2|
       if (B!Point >= B!Size) then
         return(0);
     
       start!code |3|
         define
           Ac1  = {'01},
           Ac13 = {'13},
           Ac14 = {'14},
           Ac15 = {'15};
     
           move      Ac14, B!Point;          ! compute absolute char offset ;
           caml      Ac14, B!GapStart;
             add     Ac14, B!GapSize;
           idivi     Ac14, 5;                ! word pointer in Ac14, offset in |
                                                                       ->|Ac15;|
           add       Ac14, B!Addr;           ! add base ;
           move      Ac14, (Ac14);           ! pick up the word ;
           imuli     Ac15, 7;                ! build a shift count ;
           addi      Ac15, 7;                ! ... ;
           lshc      Ac13, (Ac15);
           andi      Ac13, '177;              ! mask to 7 bits ;
           move      Ac1, Ac13;
       end; |3|
     end "B!GetC"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 47-1
     Prt: 06-Jun-84  13:56                                            Rtn B!Read

     
     ! Routine to slurp a file into memory from disk ;
     
     internal simple procedure B!Read(integer Chan, Words);
     begin |2|
       integer
         Offset, Inc, Bits, TWords;
       boolean
         EmptyFile;
     
       EmptyFile _ (Words = 0);
       B!Pages   _ ceiling(Words, 512) + 2;
       B!GapSize _ 2 * 512 * 5;
     
       if (VClear(BasePage, 512 - BasePage)) then
         usererr(0, 0, "VClear Error in B!Read", "x");
     
       if (VCreate(BasePage, B!Pages)) then
         usererr(0, 0, "VCreate Error in B!Read", "x");
     
       B!Size _ Words * 5;
       Offset _ 2 * 512;             ! start with 2 gap pages ;
       B!NullFlag _ false;
       TWords _ Words;
     
       while (Words) do
       begin |3|
         Inc _ 512 min Words;
         Arryin(Chan, memory[B!Addr + Offset], Inc);
     
         start!code |4|
           label             loop1, loop2;
           skipe             B!NullFlag;
             jrst            loop2;
           move              1, B!Addr;
           add               1, Offset;
           move              2, Inc;
           caie              2, 512;
             soje            2, loop2;
     
         loop1:
           sosg              TWords;         ! examine all but the last word ;
             jrst            loop2;
           move              3, (1);
           trnn              3, '376;                ! '177 lsh 1 ;
             setom           B!NullFlag;
           addi              1, 1;
           sojg              2, loop1;
     
         loop2:
         end; |4|
     
         Words  _ Words - Inc;
         Offset _ Offset + Inc;
       end; |3|
     
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 47-2
     Prt: 06-Jun-84  13:56                                            Rtn B!Read

     
       ! now strip 1 to 4 trailing nulls from the end of the file ;
     
       if (not EmptyFile) then
       begin |3|
         Offset _ OffSet - 1;        ! point to last word of file ;
         Bits _ '177 lsh 1;          ! character mask ;
     
         for Inc _ 1 upto 4 do
         begin |4|
           if (memory[B!Addr + OffSet] land Bits) then
             done
           else
           begin |5|
             Bits _ Bits lsh 7;
             B!Size _ B!Size - 1;
           end; |5|
         end; |4|
       end; |3|
     
       B!BegP _ true;
       B!EndP _ (not B!Size);
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 48-1
     Prt: 06-Jun-84  13:56                                           Rtn B!Write

     
     ! Routine to spit a file out to disk ;
     
     internal simple procedure B!Write( integer Chan );
       begin |2|
         own integer SavePoint, Words, Inc, Offset;
     
         ! Push that gap the the end of the file, and insure that the last
         ! 4 characters are NULL ;
     
         SavePoint := B!Point;
         B!Point := B!Size;
         B!ForceGap;
         Inc := MakeGapStartBP;
         dpb( NULL, Inc );
         idpb( NULL, Inc );
         idpb( NULL, Inc );
         idpb( NULL, Inc );
     
         ! spit out the buffer ;
     
         OffSet := 0;
         Words := ( B!Size + 4 ) div 5;
         while ( Words ) do
           begin |3|
             Inc := Words min 512;
             arryout( Chan, memory[ B!Addr + Offset ], Inc );
             Words := Words - Inc;
             OffSet := OffSet + Inc;
           end; |3|
     
         B!Point := SavePoint;
         B!ModP := false;            ! buffer is again virgin ;
     
       end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 49-1
     Prt: 06-Jun-84  13:56                                            Rtn B!AnyM

     
     ! See if any buffers in the ring are modified ;
     
     internal simple boolean procedure B!AnyM;
     begin "B!AnyM" |2|
       integer
         Ptr;
     
       Ptr _ B!!Head;
     
       while (Ptr) do
       begin |3|
         if ((Ptr = B!!List and B!ModP and length(B!File)) or
             (Ptr neq B!!List and B!!ModP[Ptr] and length(B!!File[Ptr]))) then
           return(true);
     
         Ptr _ B!!Next[Ptr];
       end; |3|
     
       return(false);
     end "B!AnyM"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 50-1
     Prt: 06-Jun-84  13:56                                          Rtn B!ModCnt

     
     ! routine to return the number of buffershe ring that are modified
     ;
     
     internal simple integer procedure B!ModCnt;
     begin "B!ModCnt" |2|
       integer
         Cnt,
         Ptr;
     
       Ptr _ B!!Head;
       Cnt _ 0;
     
       while (Ptr) do
       begin |3|
         if ((Ptr = B!!List and B!ModP and length(B!File)) or
             (Ptr neq B!!List and B!!ModP[Ptr] and length(B!!File[Ptr]))) then
           incr(Cnt);
     
         Ptr _ B!!Next[Ptr];
       end; |3|
     
       return(Cnt);
     end "B!ModCnt"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 51-1
     Prt: 06-Jun-84  13:56                                            Rtn B!Fini

     
     ! B!Fini - walk the ring, optionally writting out modified files
     !  and deleting the checkpoint files.
     ! Note that B!Kill does a B!Restore for the next buffer.
     ;
     
     internal simple boolean procedure B!Fini( boolean WriteFiles );
       begin "fini" |2|
     
         B!!ModP[ B!!List ] := B!ModP;
     
         while ( B!!List ) do
           begin "each buffer" |3|
     
             if ( WriteFiles and
                  B!!ModP[ B!!List ] and
                  length( B!!File[ B!!List ] )) then
               begin |4|
                 if ( not F!Writ( B!!File[ B!!List ] )) then return( false );
                 B!Kill;
               end |4|
             else
               B!Kill;
     
           end "each buffer"; |3|
     
         B!RlChan(B!Chan);
         return( true );
     
       end "fini"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 52-1
     Prt: 06-Jun-84  13:56                                            Rtn B!SeqP

     
     ! Routine to tell if there are sequence number bits on.
     ;
     
     internal simple boolean procedure B!SeqP;
       begin "seq?" |2|
         integer I, W, C;
     
         if ( B!Size = 0 ) then return( false );
         W := memory[ B!Addr + ( B!GapSize div 5 ) ];
     
         if ( not ( W land 1 )) then return( false );
     
         W := W lsh -1;
         for I := 1 upto 5 do
           begin |3|
             C := W land '177;
             if (( C < "0" ) or ( C > "9" )) then return( false );
             W := W lsh -7;
           end; |3|
     
         return( true );
     
       end "seq?"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 53-1
     Prt: 06-Jun-84  13:56                                            Rtn B!NulP

     
     ! Routine to tell if there are NULLs in this buffer ;
     
     internal simple boolean procedure B!NulP;
       begin |2|
         return( B!NullFlag );
       end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 54-1
     Prt: 06-Jun-84  13:56                                            Rtn B!DelN

     
     ! Routine to delete nulls from the buffer. Since it does not adjust Marks
     ! while doing its deletion, this routine should only be invoked before
     ! the buffer is turned over to the user.  Currently, it is only called
     ! by F!Load and B!DelS ;
     
     internal simple procedure B!DelN;
     begin |2|
       B!SetP(0);
     
       while (not B!EndP) do
       begin |3|
         if (B!GetC = null) then
         begin |4|
           B!ForceGap;
           incr(B!GapSize);
           decr(B!Size);
     
           if (B!Point = B!Size) then
             set(B!EndP);
         end |4|
         else
           B!Move(FORWARDS);
       end; |3|
     
       B!SetP(0);
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 55-1
     Prt: 06-Jun-84  13:56                                            Rtn B!DelS

     
     ! Routine to delete sequence numbers from the buffer.
     ! *Must* be called after B!Read before any other mods are made
     ! to the buffer.  Hideous things happen elsewise. ;
     
     internal simple procedure B!DelS;
       begin |2|
         integer idx, count;
     
         idx := B!Addr + ( B!GapSize div 5 );
         count := B!Size div 5;
     
         while ( count ) do
           begin |3|
             if ( memory[ idx ] land '1 ) then
               begin |4|
                 memory[ idx ] := 0;
                 memory[ idx + 1 ] := memory[ idx + 1 ] land '003777777777;
               end; |4|
             idx := idx + 1;
             count := count - 1;
           end; |3|
     
         B!DelN;
       end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 56-1
     Prt: 06-Jun-84  13:56                                         Rtn B!BufStat

     
     ! Routine to throw the list of buffers into the Box ;
     
     internal simple procedure B!BufStat;
     begin "buffer status" |2|
       integer L;
       string S;
     
       ! List starting with B!!Head;
     
       L := B!!Head;
       while ( L ) do
       begin "list buffers" |3|
         if ( L = B!!List ) then
           S := " > " else S := "   ";
     
         if ( B!!Alias[ L ] ) then
           S := S & B!!Alias[ L ]
         else
           S := S & B!!File[ L ];
     
         if ( L = B!!List and B!ModP or
             L neq B!!List and B!!ModP[ L ] ) then
           S := S & " *";
     
         W!BAdd( S );
         L := B!!Next[ L ];
       end "list buffers"; |3|
     end "buffer status"; |2|
     end "DED - buffer manager" |1|
     
     
     ! ***************************  End Xbuff.Sai  ****************************;





                                                            
                                                            
                                                            
                        
                        
                        
                        
                        
                        
                                    
                                    
                                    
                        
                        
                        
                        
                        
                        
                                    
                                    
                                    



                                    
                                    
                                    
            
            
            
            
            
            
                              
                              
                              
            
            
            
            
            
            
                                                            
                                                            
                                                            




                          
          
          
                 
             
            
                           

     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 1-1
     Prt: 06-Jun-84  13:56                              Tymcom-X File I/O Module

     Entry;
     begin "DED - File I/O" |1|
       require "DED.DEF" source!file;
     
     
     ifcr Tops20 thenc
       require "!!! This is the Tymcom-X File I/O module !!!" message;
       TryAgainWithTheTops20Version
     endc
     
     
     ! *************************************************************************
     *                                                                         *
     *        This module handles all disk I/O, and isolates all system        *
     *      dependent file system calls into one file.  The RPG interface      *
     *                            also lives here.                             *
     *                                                                         *
     *                    Dave W. Smith,  October '81 - ...                    *
     *                                                                         *
     **************************************************************************;
     
     
     ! Entry points in other modules that we reference. ;
     
       external integer
         C!Debug;
     
     
     !                         From the Buffer Module
     ;
     
       external string
         B!File;                             ! name of file ;
       external simple procedure
         B!Make( string FileNam, Alias );    ! make a new buffer ;
       external simple procedure
         B!Read( integer Chan, Words );      ! suck in a file ;
       external simple procedure
         B!Write( integer Chan );            ! spit out a file ;
       external simple procedure 
         B!SetP( integer Position );         ! set the point ;
       external simple procedure
         B!Insert( integer C );              ! insert a character ;
       external simple procedure
         B!Delete( integer Dir );            ! delete a chracter ;
       external simple integer procedure
         B!GetP;                             ! get the point ;
       external simple integer procedure
         B!GetC;                             ! get char at point ;
       external integer
         B!Prot;                             ! buffer protection ;
       external simple procedure
         B!Move( integer Dir );              ! move the point ;
       external boolean
         B!BegP,
         B!EndP;                             ! position flags ;
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 1-2
     Prt: 06-Jun-84  13:56                              Tymcom-X File I/O Module

       external boolean
         B!ModP;                             ! buffer modified ;
       external integer
         B!Lock;
       external simple boolean procedure
         B!SeqP;
       external simple boolean procedure
         B!NulP;
       external simple procedure
         B!DelS;
       external simple procedure
         B!DelN;
     
     
     !                         From the Window Module
     ;
     
       external procedure
         W!Disp( boolean PuntIfKeyHit );
       external procedure
         W!Msg( string S );
       external boolean
         W!MsgF;
       external procedure
         W!NewS;                             ! create new status line ;
       external procedure
         W!FixS;
     
     
     !                         From the Command Module
     ;
     
       external boolean
         C!SPMRegion,                        ! Swap Pooint and Mark on
                                             ! region-oriented operations (ie
                                             ! Insert File)
                                             ;
         G!RNulls;                           ! Remove nulls from Text file
                                             ! automatcially if true.
                                             ;
       external boolean procedure
         C!Ask( string Question );
       external safe integer array
         C!Tab['0:'177];
     
     
     !                      From the SAIL Runtime System
     ;
     
       external integer
         RPGSW;                              ! true iff called w/ offset ;
     
     
     !                        From the Redisplay Module
     ;
     
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 1-3
     Prt: 06-Jun-84  13:56                              Tymcom-X File I/O Module

       external procedure
         T!Bell;
       external procedure
         T!Fini;
       external procedure
         T!RSet;
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 2-1
     Prt: 06-Jun-84  13:56                                      Internal Storage

     
     ! Storage internal to this module ;
     
       internal string
         F!Search;                           ! The string for which we want to
                                             ! search upon opening a file for
                                             ! editing.
                                             ;
     
       own integer F!Chan;                   ! channel of current file ;
       own integer F!EOF;                    ! true iff eof reached ;
       own integer F!EOFSeen;
       own integer F!InputCount, F!OutputCount;
       own integer F!Count, F!Break;
       own integer F!Words;                  ! size, in words, of file ;
       internal integer F!Chars;             ! chars yet to be read from file ;
       own integer F!Prot;                   ! file protection ;
     
       own integer F!BP;                     ! byte pointer into F!Buffer ;
       own safe integer array F!Buffer[ 0 : 127 ];
     
     ! stuff scanned from a filename ;
     
       own string F!Name;                    ! file name ;
       own string F!Alias;                   ! r e g n a d   k c i n ;
       own boolean F!Lock;                   ! true iff /read ;
       own integer F!Page, F!Line, F!Char;   ! where to start ;
       internal boolean F!RPGFlag;           ! true iff to exit to RPG ;
       own string TmpCoreString;             ! contents of EDS tmpcore file ;
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 3-1
     Prt: 06-Jun-84  13:56                                            Rtn F!Exit

     
     ! Do system dependent termination stuff ;
     
     internal procedure F!Exit;
       begin |2|
         safe integer array RB[ 0 : 5 ];
     
         if ( F!RPGFlag ) then
           begin |3|
             T!Fini;
             print(crlf);
             RB[ 0 ] := cvsix( "SYS" );
             RB[ 1 ] := cvsix( "RPG" );
             RB[ 2 ] := RB[ 3 ] := RB[ 4 ] := RB[ 5 ] := 0;
             calli( XWD( 1, location( RB[ 0 ] )), '35 );
             Usererr( 0,0,"??? Unable to run RPG - contact SQA","x" );
           end; |3|
       end; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 4-1
     Prt: 06-Jun-84  13:56                                       Rtn F!Decompose

     
     ! Decompose a Tymcom-X/PEAK FileSpec, which must be of the following form:
     !
     ! <FileSpec>    ->      <FS>(<Alias>)(<Switches>)
     ! <FS>          ->      (<UserName>)<FileName> | <FileName>(<PPNSpec>)
     ! <UserName>    ->      '(' repeat(<V1>, 1-12) ')
     ! <FileName>    ->      <FilePart> ('.' <ExtPart>)
     ! <FilePart>    ->      repeat(<V2>, 1-6)
     ! <ExtPart>     ->      repeat(<V2>, 0-3)
     ! <PPNSpec>     ->      '[' <GanSpec> ',' <UunSpec> ']'
     ! <GanSpec>     ->      repeat(<OctNum>, 1-6)
     ! <UunSpec>     ->      repeat(<OctNum>, 1-6)
     ! <Alias>       ->      '"' repeat(<V3>, 1-*) '"'
     ! <Switches>    ->      '/' <Sw> | '%' <Sw>
     ! <Sw>          ->      repeat(ASCII, 1-*)
     ! 
     ! <V1>          ->      <Alpha> | <DecNum> | '*' | '.' | '/' | '-' | ' '
     ! <V2>          ->      <Alpha> | <DecNum>
     ! <V3>          ->      {ASCII - '"'}
     ! 
     ! <Alpha>       ->      'A' - 'Z' | 'a' - 'z' 
     ! <DecNum>      ->      '0' - '9'
     ! <OctNum>      ->      '0' - '7'
     ! 
     ! 
     ! (The function repeat(Item, Minimum-Maximum) is replaced by between
     ! Minimum and Maximum number of occurences of Item.  The special symbol
     ! '*' indicates no limit.)
     !
     ! The symbol 'ASCII' indicates the entire ASCII character set.
     !
     ! Braces ('{' and '}') enclose set specifications - eg, '{ASCII - '"'}'
     ! means all characters except '"'.
     ;
     
     
     internal boolean procedure F!Decompose (string InStr; reference string Use|
                                    ->|rName, File, Ext, PPN, Alias, Switches);|
     begin "F!Decompose" |2|
       label
         S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15,
         S16, SGood, SBad;
       integer
         C;
       string
         LUserName, LFile, LExt, LGanStr, LUunStr, LAlias, LSwitches;
       define
         sp               = {" "},
         IsAlphabetic (X) = {("A" <= UpShift(X) <= "Z")},
         IsNumeric    (X) = {("0" <= X <= "9")},
         IsOctal      (X) = {("0" <= X <= "7")},
         IsWhiteSpace (X) = {(X = sp or X = tab)};
     
     
       LUserName _
       LFile     _
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 4-2
     Prt: 06-Jun-84  13:56                                       Rtn F!Decompose

       LExt      _
       LGanStr   _
       LUunStr   _
       LAlias    _
       LSwitches _
       UserName  _
       File      _
       Ext       _
       PPN       _
       Alias     _
       Switches  _ null;
     
     
       S0:
           ! Nothing seen - Look for username or filename ;
     
         C _ lop(InStr);
         if (IsAlphabetic(C)) then goto S4;
         if (IsNumeric(C))    then goto S4;
         if (C = "(") then goto S1;
         goto SBad;
     
     
       S1:
           ! "(" Seen - Look for username ;
     
         if (not length(InStr)) then goto SBad;
         C _ lop(InStr);
         if ((IsAlphabetic(C)) or
             (IsNumeric(C)) or
             (C = "*") or (C = ".") or
             (C = "/") or (C = "-") or
             (C = sp)) then
           goto S2;
         goto SBad;
     
     
       S2:
           ! Username character seen - Collect more and look for ")" ;
     
         appnd(LUserName, ToUpper(C));
         if (not length(InStr)) then goto SBad;
         C _ lop(InStr);
         if ((IsAlphabetic(C)) or
             (IsNumeric(C)) or
             (C = "*") or (C = ".") or
             (C = "/") or (C = "-") or
             (C = sp)) then
           goto S2;
         if (C = ")") then goto S3;
         goto SBad;
     
     
       S3:
           ! ")" seen - Skip whitespace and look for filename ;
     
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 4-3
     Prt: 06-Jun-84  13:56                                       Rtn F!Decompose

         if (not (length(InStr) and length(LUserName))) then goto SBad;
         C _ lop(InStr);
         if (IsAlphabetic(C)) then goto S4;
         if (IsNumeric(C))    then goto S4;
         if (IsWhiteSpace(C)) then goto S3;
         goto SBad;
     
     
       S4:
           ! Filename character seen - Collect more ;
     
         appnd(LFile, ToUpper(C));
         if (not length(InStr)) then goto SGood;
         C _ lop(InStr);
         if (IsAlphabetic(C)) then goto S4;
         if (IsNumeric(C))    then goto S4;
         if (C = ".")         then goto S6;
         if ((C = "/") or (C = "%")) then goto S16;
         if (C = """")        then goto S14;
         if (C = "[")         then goto S9;
         if (IsWhiteSpace(C)) then goto S5;
         goto SBad;
     
     
       S5:
           ! Whitespace seen - gobble up more and look for dot ;
     
         if (not length(InStr)) then goto SGood;
         C _ lop(InStr);
         if (C = ".") then goto S6;
         if (C = "[") then goto S9;
         if ((C = "/") or (C = "%")) then goto S16;
         if (C = """") then goto S14;
         if (IsWhiteSpace(C)) then goto S5;
         goto SBad;
     
     
       S6:
           ! Dot seen - Look for extension ;
     
         if (not length(InStr)) then goto SGood;
         C _ lop(InStr);
         if (IsAlphabetic(C)) then goto S7;
         if (IsNumeric(C))    then goto S7;
         if (C = "[") then goto S9;
         if ((C = "/") or (C = "%")) then goto S16;
         if (C = """") then goto S14;
         if (IsWhiteSpace(C)) then goto S6;
         goto SBad;
     
     
       S7:
           ! Extension character seen - Look for more ;
     
         appnd(LExt, ToUpper(C));
         if (not length(InStr)) then goto SGood;
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 4-4
     Prt: 06-Jun-84  13:56                                       Rtn F!Decompose

         C _ lop(InStr);
         if (IsAlphabetic(C)) then goto S7;
         if (IsNumeric(C))    then goto S7;
         if (C = "[") then goto S9;
         if ((C = "/") or (C = "%")) then goto S16;
         if (C = """") then goto S14;
         if (IsWhiteSpace(C)) then goto S8;
         goto SBad;
     
     
       S8:
           ! Whitespace seen - gobble up more ;
     
         if (not length(InStr)) then goto SGood;
         C _ lop(InStr);
         if (C = "[") then goto S9;
         if ((C = "/") or (C = "%")) then goto S16;
         if (C = """") then goto S14;
         if (IsWhiteSpace(C)) then goto S8;
         goto SBad;
     
     
       S9:
           ! "[" seen - Look for Gan ;
     
         if (not length(InStr)) then goto SBad;
         C _ lop(InStr);
         if (IsOctal(C)) then goto S10;
         goto SBad;
     
     
       S10:
           ! Gan digit seen - Collect more and look for "," ;
     
         appnd(LGanStr, ToUpper(C));
         if (not length(InStr)) then goto SBad;
         C _ lop(InStr);
         if (IsOctal(C)) then goto S10;
         if (C = ",") then goto S11;
         goto SBad;
     
     
       S11:
           ! "," seen - Look for Uun ;
     
         if (not length(InStr)) then goto SBad;
         C _ lop(InStr);
         if (IsOctal(C)) then goto S12;
         goto SBad;
     
     
       S12:
           ! Uun digit seen - Collect more ;
     
         appnd(LUunStr, ToUpper(C));
         if (not length(InStr)) then goto SBad;
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 4-5
     Prt: 06-Jun-84  13:56                                       Rtn F!Decompose

         C _ lop(InStr);
         if (IsOctal(C)) then goto S12;
         if (C = "]")  then goto S13;
         goto SBad;
     
     
       S13:
           ! "]" seen - Look for Alias ;
     
         if (not length(InStr)) then goto SGood;
         C _ lop(InStr);
         if ((C = "/") or (C = "%")) then goto S16;
         if (C = """") then goto S14;
         goto SBad;
     
     
       S14:
           ! '"' seen - Gobble up everything until the next occurence ;
     
         if (not length(InStr)) then goto SBad;
         appnd(LAlias, ToUpper(C));
         C _ lop(InStr);
         if (C = """") then goto S15;
         goto S14;
     
     
       S15:
           ! '"' terminating Alias seen - Look for switches ;
     
         appnd(LAlias, ToUpper(C));
         if (not length(InStr)) then goto SGood;
         C _ lop(InStr);
         if (C = "/" or C = "%") then goto S16;
         goto SBad;
     
     
       S16:
           ! "/" or "%" seen - Gobble up the rest of the line ;
     
         appnd(LSwitches, ToUpper(C));
         if (not length(InStr)) then goto SGood;
         C _ lop(InStr);
         goto S16;
     
     
       SGood:
           ! Many Happy Returns ;
     
         if (length(LUserName)) then
           UserName _ LUserName[1 for 12]
         else
           PPN _ cvos(xwd(cvo(LGanStr[1 for 6]), cvo(LUunStr[1 for 6])));
     
         File     _ LFile[1 for 6];
         Ext      _ LExt[1 for 3];
         Alias    _ LAlias;
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 4-6
     Prt: 06-Jun-84  13:56                                       Rtn F!Decompose

         Switches _ LSwitches;
     
         return(true);
     
     
       SBad:
           ! Oops - something smells funny ;
     
         UserName _ File _ Ext _ PPN _ Alias _ Switches _ null;
     
         return(false);
     end "F!Decompose"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 5-1
     Prt: 06-Jun-84  13:56                                           Rtn F!Parse

     
     ! Parse and Sanctify a file name ;
     
     internal string procedure F!Parse (string StrIn);
     begin "F!Parse" |2|
       string
         UserName,
         FileName,
         Ext,
         SPPN,
         Alias,
         Switches;
       integer
         PPN;
       define
         OurPPN = {(call(xwd(-1, 2), "gettab"))};
     
     
       if (F!Decompose(StrIn, UserName, FileName, Ext, SPPN,
           Alias, Switches)) then
       begin |3|
         string
           S;
     
         PPN _ cvo(SPPN);
         S   _ null;
     
         if (length(UserName)) then
           appnd(S, ("(" & UserName & ")"));
     
         appnd(S, FileName);
     
         if (length(Ext)) then
           appnd(S, ("." & Ext));
     
         if (PPN and PPN neq OurPPN) then
           appnd(S, xwdstr(PPN));
     
         return(S);
       end |3|
       else
         return(null);
     end "F!Parse"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 6-1
     Prt: 06-Jun-84  13:56                                          Rtn F!Lookup

     
     ! Routine to open a file for input ;
     
     internal boolean procedure F!Lookup( string FileName );
       begin "lookup" |2|
         own boolean Flag;
         own integer array Info[ 0:5 ];
     
         F!Chan := GetChan;
         F!Count := 128;
         F!EOF := 0;
     
         open( F!Chan, "DSK", BIT(23)+'17, 0,0, F!Count, F!Break, F!EOF );
         if ( F!EOF ) then
           begin |3|
             W!Msg( "? Can't open DSK:" );  T!Bell;
             return( false );
           end; |3|
     
         lookup( F!Chan, FileName, Flag );
         FileInfo( Info );
         if ( Flag ) then
           begin |3|
             Flag := Info[ 1 ] land '777777;
             if ( Flag = 0 ) then
               W!Msg( "Nonexistent File"  )
             else if ( Flag = 1 ) then
               W!Msg( "Bad FileSpec" )
             else if ( Flag = 2 ) then
               W!Msg( "File is Protected" )
             else
               W!Msg( "Cannot LOOKUP File, error " & cvos( Flag ) );
             release( F!Chan );
             return( false );
           end; |3|
     
         F!Prot  := Info[2] lsh -27;         ! Protection of file ;
         F!Words := Info[ 5 ];
         F!Chars := F!Words * 5;
     
         F!InputCount := 0;          ! haven't read anything, yet ;
     
         if ( F!Words > MAXFILESIZE ) then
           begin |3|
             W!Msg( "? File is too large to edit with "&DED!Alias );
             T!Bell;
             release( F!Chan );
             return( false );
           end; |3|
     
         return( true );
     
       end "lookup"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 7-1
     Prt: 06-Jun-84  13:56                                            Rtn F!Lkup

     
     ! Routine to open a disk-resident tmpcore file for input.
     ;
     
     boolean procedure F!Lkup (string FileName);
     begin "F!Lkup" |2|
       own boolean
         Flag;
       own integer array
         Info [0:5];
     
       F!Chan  _ GetChan;
       F!Count _ 128;
       F!EOF   _ 0;
     
       open(F!Chan, "DSK", BIT(23)+'17, 0,0, F!Count, F!Break, F!EOF);
     
       if (F!EOF) then
       begin |3|
         print("? Can't open DSK:");
         T!Bell;
         return(false);
       end; |3|
     
       lookup(F!Chan, FileName, Flag);
     
       if (Flag) then
       begin |3|
         release(F!Chan);
         return(false);
       end; |3|
     
       fileinfo(Info);
       F!Words _ Info[5];
       F!Chars _ F!Words * 5;
     
       return(true);
     end "F!Lkup"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 8-1
     Prt: 06-Jun-84  13:56                                            Rtn F!GetC

     
     ! Return the next character input from the file open on F!Chan.
     ! Return -1 at when no more characters remain to be read or at EOF.
     ! The assumption is made that the lookup routine used in conjunction with
     ! this one has set the file character count (F!Chars).
     ;
     
     internal integer procedure F!GetC;
     begin "F!GetC" |2|
       own integer
         Addr,
         C;
     
       if (F!EOF or F!Chars <= 0) then
         return(-1);
     
       if (F!InputCount = 0) then
       begin |3|
         F!BP _ point(7, F!Buffer[0], -1);
         arryin(F!Chan, F!Buffer[0], 128);
         F!InputCount _ 128 * 5;
       end; |3|
     
       C _ ildb(F!BP);
       decr(F!InputCount);
       decr(F!Chars);
       return(C);
     end "F!GetC"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                            Page 9-1
     Prt: 06-Jun-84  13:56                                         Rtn F!Release

     
     ! Routine to release the input file ;
     
     internal simple procedure F!Release;
       begin "release" |2|
     
         release( F!Chan );
     
       end "release"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 10-1
     Prt: 06-Jun-84  13:56                                           Rtn F!Enter

     
     ! Open a file for output ;
     
     internal boolean procedure F!Enter( string FileName );
       begin "enter" |2|
         boolean Flag;
     
         F!Chan := GetChan;
         F!Count := 128;
         F!EOF := 0;
         open( F!Chan, "DSK", BIT(23)+'17, 0,0, F!Count, F!Break, F!EOF );
         if ( F!EOF ) then return( false );
         enter( F!Chan, FileName, Flag );
         if ( Flag ) then
           begin |3|
             release( F!Chan );
             return( false );
           end; |3|
     
         F!OutputCount := 0;
         return( true );
     
       end "enter"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 11-1
     Prt: 06-Jun-84  13:56                                            Rtn F!PutC

     
     ! Put a character into the output buffer ;
     
     internal procedure F!PutC( integer C );
       begin "put c" |2|
         own integer I;
     
         if ( F!OutputCount = 0 ) then
           begin |3|
             own integer Addr;
             arrclr( F!Buffer );
             F!BP := point( 7, F!Buffer[ 0 ], -1 );
           end; |3|
     
         idpb( C, F!BP );
     
         F!OutputCount := F!OutputCount + 1;
     
         if ( F!OutputCount = 128 * 5 ) then
           begin |3|
             own integer Addr;
             arryout( F!Chan, F!Buffer[ 0 ], 128 );
             F!OutputCount := 0;
           end; |3|
     
       end "put c"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 12-1
     Prt: 06-Jun-84  13:56                                           Rtn F!Close

     
     ! Routine to flush output and close the file ;
     
     internal procedure F!Close (string FileName);
       begin "close" |2|
         integer FlushCount, Flag;
     
         FlushCount := ( F!OutputCount + 4 ) div 5;
         if ( FlushCount > 0 ) then
           begin |3|
             integer Addr;
             arryout( F!Chan, F!Buffer[ 0 ], FlushCount );
           end; |3|
     
         rename( F!Chan, FileName, B!Prot, (Flag _ 0) );
     
         if ( Flag ) then
           usererr( 0, 0, "Cannot apply protection to file (" & FileName & ")" |
                                                                          ->|);|
     
         release( F!Chan );
     
       end "close"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 13-1
     Prt: 06-Jun-84  13:56                                            Rtn F!Read

     
     ! Routine to read a file.
     ;
     
     internal boolean procedure F!Read(string FName);
     begin "F!Read" |2|
       integer
         SavePoint;
     
       if (not F!Lookup(FName)) then
         return(false);
     
         ! Refuse if there is a problem.
         ;
     
       SavePoint _ B!GetP;
     
         ! Remember our position.
         ;
     
       if (F!Chars) then
       begin |3|
         integer
           C;
     
         while ((C _ F!GetC) >= 0) do
           B!Insert(C);
     
         ! delete up to 4 nulls from the end of the buffer ;
     
         F!Chars _ (B!GetP - SavePoint) min 4;
     
         while (F!Chars) do
         begin |4|
           B!Move(BACKWARDS);
     
           if (B!GetC) then
           begin |5|
             B!Move(FORWARDS);
             done;
           end |5|
           else
             B!Delete(FORWARDS);
     
           decr(F!Chars);
         end; |4|
       end; |3|
     
       release(F!Chan);
     
       if (not C!SPMRegion) then
         B!SetP(SavePoint);
     
       return(true);
     end "F!Read"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 14-1
     Prt: 06-Jun-84  13:56                                            Rtn F!Load

     
     ! Routine to "load" (i.e. destructive read) a file ;
     
     internal boolean procedure F!Load (string FName; integer P, L, C);
     begin "load a file" |2|
       if (P < 0) then
         P _ F!Page;
     
       if (L < 0) then
         L _ F!Line;
     
       if (C < 0) then
         C _ F!Char;
     
       if (not F!Lookup(FName)) then
         return(false);
     
       B!Prot _ F!Prot;              ! save file protection with buffer ;
     
       B!Read(F!Chan, F!Words);
       release(F!Chan);
       W!NewS;
     
       if (B!SeqP) then
       begin |3|
         W!Msg("Removing sequence numbers");
         W!MsgF _ true;
         W!Disp(true);
         B!DelS;
         W!MsgF _ false;
       end |3|
       else if (B!NulP) then
       begin |3|
         if (G!RNulls) then
         begin |4|
           W!Msg("Removing Nulls");
           B!DelN;
         end |4|
         else
           W!Msg("Nulls Exist");
     
         W!Disp(false);
       end; |3|
     
       ! position to (P, L, C) ;
     
       decr(P);
     
       while (P > 0) do
       begin "page" |3|
         if (B!EndP) then
           done "page";
     
         if (B!GetC = FF) then
           decr(P);
     
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 14-2
     Prt: 06-Jun-84  13:56                                            Rtn F!Load

         B!Move(FORWARDS);
       end "page"; |3|
     
       decr(L);
     
       while (L > 0) do
       begin "line" |3|
         if (B!EndP) then
           done "line";
     
         if (B!GetC = LF) then
           decr(L);
     
         B!Move(FORWARDS);
       end "line"; |3|
     
       decr(C);
     
       while (C > 0) do
       begin "char" |3|
         if (B!EndP) then
           done "char";
     
         decr(C);
         B!Move(FORWARDS);
       end "char"; |3|
     
       B!Lock _ F!Lock;                ! save the lock ;
       return(true);
     end "load a file"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 15-1
     Prt: 06-Jun-84  13:56                                    Rtn MakeBackupName

     
     ! Routine to map a filename into a backup filename ;
     
     simple string procedure MakeBackupName( string FName );
       begin "backup name" |2|
         string BName;
         boolean DotSeen;
     
         BName := NULL;
         DotSeen := false;
     
         if ( FName = "(" ) then
           begin |3|
             while ( FName neq ")" ) do
               begin |4|
                 BName := BName & lop( FName );
               end; |4|
             BName := BName & lop( FName );
           end; |3|
     
         while ( FName ) do
           begin |3|
             if ( ( not DotSeen ) and Fname = "." ) then
               begin |4|
                 BName := BName & ".BAK";
                 DotSeen := true;
                 while ( FName ) do lop( FName );
               end |4|
             else
               BName := BName & Lop( FName );
           end; |3|
         if ( not DotSeen ) then
           BName := BName & ".BAK";
     
         return( BName );
     
       end "backup name"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 16-1
     Prt: 06-Jun-84  13:56                                        Rtn MakeBackup

     
     ! Routine to try to make a backup copy of the current file. ;
     
     simple boolean procedure MakeBackup( string FName );
       begin "make backup" |2|
         string BackupFileName;
         integer BChan, EOF, Flag;
     
         BackupFileName := MakeBackupName( FName );
     
         ! delete the backup file, if it exists ;
     
         open( BChan := getchan, "DSK", BIT(23)+'17, 0,0,0,0,EOF );
         if ( EOF ) then return( false );
     
         lookup( BChan, BackupFileName, Flag );
         if ( Flag = 0 ) then
           begin |3|
             rename( BChan, 0, NULL, Flag );
             release( BChan );
             if ( Flag ) then
               begin |4|
                 W!Msg( "? Couldn't Delete Backup File" );
                 return( false );
               end; |4|
           end |3|
         else if ( Flag and ( RH( Flag ) = 0 ) ) then        ! no backup file. ;
           begin |3|
           end |3|
         else
           begin |3|
             W!Msg( "? Lookup Error " & cvs( RH(Flag) ) & " for BACKUP file" );
             release( BChan );
             return( false );
           end; |3|
     
     
         ! Here with old backup file deleted.  Try to rename the file to backup|
                                                                          ->| ;|
     
         open( BChan := getchan, "DSK", BIT(23)+'17, 0,0,0,0, EOF );
         if ( EOF ) then return( false );
     
         lookup( BChan, FName, Flag );
         if ( Flag = 0 ) then
           begin |3|
             rename( BChan, BackupFileName, '0, Flag );
             release( BChan );
             if ( Flag ) then
               begin |4|
                 if ( RH( Flag ) = 2 ) then
                   W!Msg( "? Protection Failure creating backup file" )
                 else
                   W!Msg( "? Rename Error " & cvos( RH(Flag) ) &
                          " creating Backup file" );
                 T!Bell;
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 16-2
     Prt: 06-Jun-84  13:56                                        Rtn MakeBackup

                 return( false );
               end |4|
             else
               return( true );               ! all is o.k. ;
           end |3|
         else if ( RH( Flag ) = 0 ) then     ! can't find file, must be new ;
           begin |3|
             release( BChan );
             return( true );
           end |3|
         else
           begin |3|
             W!Msg( "? Rename Error " & cvs( RH(Flag) ) );
             release( BChan );
             return( false );
           end; |3|
     
         return( false );  
     
       end "make backup"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 17-1
     Prt: 06-Jun-84  13:56                                            Rtn F!Writ

     
     ! Routine to write the current file out to DSK ;
     
     internal boolean procedure F!Writ (string FName);
     begin "F!Writ" |2|
       if (FName = null) then
         FName _ B!File;
     
       if (not MakeBackup(FName)) then
         return(false);
     
       if (not F!Enter(FName)) then
         return(false);
     
       B!Write(F!Chan);
       F!Close(FName);
     
       W!FixS;
       return(true);
     end "F!Writ"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 18-1
     Prt: 06-Jun-84  13:56                                            Rtn F!Scan

     
     ! Given a string, break it down into a filename, alias, and switches.
     ! This routine sets F!Name, F!Alias, F!Lock, F!Page, F!Line, etc.
     ;
     
     internal integer procedure F!Scan(string CmdLine);
     begin "F!Scan" |2|
       string
         S, UserName, FileName, Ext, SPPN, Switches;
       integer
         C, BC, PPN, Error;
       define
         OurPPN         = {(call(xwd(-1, 2), "gettab"))},
         F.OK           = 0,
         F.BAD.SWITCH   = 1,
         F.BAD.FILESPEC = 2;
     
     
       set(G!RNulls);
     
         ! We remove nulls from the text file by default.
         ;
     
       clear(F!RPGFlag);
     
       F!Lock _ null;
       F!Page _
       F!Line _
       F!Char _ 0;
     
       if (length(CmdLine) = 0) then
         return(F.OK);
     
         ! All is Ok.
         ;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       ! disect the command line ;
     
       if (not F!Decompose(CmdLine, UserName, Filename, Ext, SPPN,
           F!Alias, Switches)) then
         return(F.BAD.FILESPEC);
     
       F!Name _ null;
       PPN    _ cvo(SPPN);
     
       if (length(UserName)) then
         appnd(F!Name, ("(" & UserName & ")"));
     
       appnd(F!Name, FileName);
     
       if (length(Ext)) then
         appnd(F!Name, ("." & Ext));
     
       if (PPN and PPN neq OurPPN) then
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 18-2
     Prt: 06-Jun-84  13:56                                            Rtn F!Scan

         appnd(F!Name, xwdstr(PPN));
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       C _ lop(Switches);
     
       F!Search _ null;
     
         ! We are not searching for anything yet.
         ;
     
       forever do
       begin "get switch" |3|
         if (not (C = "/" or C = "%")) then done "get switch";
     
         if (Switches <= " ") then done "get switch";
         S _ NULL;
         while (length(Switches)) do
         begin "switch" |4|
           if not (C!Tab[ Switches ] land IsAlpha) then done "switch";
           S _ S & lop(Switches);
         end "switch"; |4|
     
         if (kequ (S, "Nulls"[1 to length(S)])) then
           clear(G!RNulls)
         else if (kequ(S, "READ"[1 to length(S)])) then
           F!Lock _ -1
         else if (kequ(S, "RPG"[1 to length(S)])) then
           F!RPGFlag _ true
         else if (kequ(S, "P")) then
         begin |4|
           F!Page _ intscan(Switches, BC);
         end |4|
         else if (kequ(S, "L")) then
           F!Line _ intscan(Switches, BC)
         else if (kequ(S, "C")) then
           F!Char _ intscan(Switches, BC)
         else if (kequ(S, "S")) then
         begin |4|
           integer
             C,
             Delim;
     
           Delim    _ lop(Switches);
     
           while (length(Switches) and ((C _ lop(Switches)) neq Delim)) do
           begin |5|
             appnd(F!Search, C);
     
             if (C = CR) then
               appnd(F!Search, LF);
           end; |5|
         end |4|
         else if (length(S)) then
           return(F.BAD.SWITCH);
     
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 18-3
     Prt: 06-Jun-84  13:56                                            Rtn F!Scan

         C _ lop(Switches);
       end "get switch"; |3|
     
       return(F.OK);
     end "F!Scan"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 19-1
     Prt: 06-Jun-84  13:56                                       Rtn ReadTMPFile

     
     ! Read a tempcore or .tmp file and return the contents.
     ! Return NULL if none.
     ;
     
     string procedure ReadTMPFile;
     begin "tmp" |2|
       string L, TmpFile;
       integer C, Flag;
     
       L := tmpin( "EDT", Flag );
     
       if ( not Flag ) then
       begin |3|
         integer array T [0:1];
     
         T[0] := cvsix( "EDT" );
         T[1] := 0;
         calli( xwd(2, location(T[0])), '44 );       ! delete EDT tmpcore file ;
       end; |3|
     
       L := tmpin( "EDS", Flag );
     
       if ( Flag ) then
         begin "disk" |3|
           TmpFile := cvs( 1000 + call(0,"PJOB"))[2 for 3] & "EDS.TMP";
           if ( not F!Lkup( TmpFile )) then return( NULL );
     
           L := NULL;
           while ( ( C := F!GetC ) >= " " ) do L := L & C;
           F!Release;
         end "disk"; |3|
     
       ! o.k. - save the original contents and get rid of the verb ;
     
       TmpCoreString := L;
       while ( C!Tab[ L ] land IsAlpha ) do lop( L );
       while ( C!Tab[ L ] land IsWhite ) do lop( L );
       while ( L[ inf for 1 ] <= " " ) do L := L[ 1 for inf-1 ];
     
       return( L );
     
     end "tmp"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 20-1
     Prt: 06-Jun-84  13:56                                 Rtn RescanCommandLine

     
     ! Rescan the command line.  Return the line, or NULL if none
     ! available.
     ;
     
     string procedure RescanCommandLine;
       begin "rescan" |2|
         string L, S;
         integer Flag;
     
         start!code |3|
           setob 1,Flag;
           ttcall '6,1;              ! getlch 1 ;
           tlnn 1,'100000;           ! lc.ecs - command lines exists ;
             setzm Flag;
         end; |3|
     
         if ( not Flag ) then return( NULL );
     
         start!code |3|
           ttcall '10,;              ! rescan ;
         end; |3|
     
         L := inchwl;
     
         ! make sure that we were invoked correctly ;
     
         S := NULL;
         TmpCoreString := L;
         while ( C!Tab[ L ] land IsAlpha ) do S := S & lop( L );
         while ( C!Tab[ L ] land IsWhite ) do lop( L );
     
         if ( not kequ( S, DED!Alias[1 for length( S )] )) then
           TmpCoreString := L := NULL;
     
         return( L );
     
       end "rescan"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 21-1
     Prt: 06-Jun-84  13:56                                         Rtn Elsewhere

     
     ! Give the luser somehwere else to go ... ;
     
     simple procedure Elsewhere;
     begin |2|
       define
         exit = {calli(1, '12)};
     
       own integer array
         RnB[0:5];
     
         ! <<  This should also delete all instantiations of the offending
               software ;
     
       calli(cvsix("*PEAK*"), -'63);
     
       RnB[0] _ cvsix("DSK");
       RnB[1] _ cvsix("TECO");
       RnB[2] _ 0;
       RnB[3] _ 0;
       RnB[4] _ xwd(1, 4);
       RnB[5] _ 0;
     
       calli(location(RnB[0]), '35);
       exit;
     end; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 22-1
     Prt: 06-Jun-84  13:56                                      Rtn SanctifyUser

     
     ! Verify the user's rights of passage ;
     
     simple procedure SanctifyUser;
     begin |2|
       integer
         Fpn,
         Aun,
         OurName,
         PrivWrd;
     
       define
         Coees.Gan   = {'7676},
         Unicon.Gan  = {'35525},
         Daddy       = {xwd(3, '35556)},
         Ded         = {xwd(3, '717040)},
         exit        = {calli(1, '12)},
         FtSys       = {xwd(1, '315372)},
         Gan.3       = {3},
         TymshareBit = {bit(21)},
         Sys         = {xwd(1, 4)};
     
       define
         Bptym       = {xwd('40545, '67440)}         ! British Petroleum
                                                     ! customer for version
                                                     ! 1.2
                                                     ;,
         Ucslm       = {xwd('11020, '312331)}        ! British Petroleum
                                                     ! customer for version
                                                     ! 1.2
                                                     ;,
         Phillips    = {xwd('43546, '303644)}        ! Phillips Petroleum
                                                     ! customer for version 1.2
                                                     ;;
     
     
       PrivWrd _ call(xwd(-1, 6), "gettab");
       Aun     _ call(xwd(-1, -'23), "gettab");
     
       if (Aun = Daddy) then
         return;
     
       if (not (PrivWrd land TymShareBit) and lh(Aun) neq Coees.Gan and
           lh(Aun) neq Unicon.Gan and Aun neq Bptym and Aun neq Ucslm and
           Aun neq Phillips) then
         exit;
     
       Fpn _ call(xwd(-1, -'25), "gettab");
     
       if (Fpn neq Sys and Fpn neq FtSys and Fpn neq Ded
           and lh(Aun) neq Gan.3) then
         Elsewhere;
     
       OurName _ call(xwd(-1, 3), "gettab");
     
       if (Ourname neq cvsix(DED!Alias)) then
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 22-2
     Prt: 06-Jun-84  13:56                                      Rtn SanctifyUser

         Elsewhere;
     end; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 23-1
     Prt: 06-Jun-84  13:56                                             Rtn F!RPG

     
     ! Find out what file is meant to be editted.
     ;
     
     internal procedure F!RPG;
     begin "rpg interface" |2|
       string
         L;
       integer
         Flag, Error;
       define
         exit           = {calli(1, '12)},
         F.OK           = 0,
         F.BAD.SWITCH   = 1,
         F.BAD.FILESPEC = 2;
     
     
       if (RPGSW) then
         L  _ ReadTMPFile
       else
       begin |3|
         L _ RescanCommandLine;
     
         if (not length(L)) then
           L _ ReadTMPFile;
       end; |3|
     
       SanctifyUser;
     
       if (length(L) = 0) then
         return;
     
       if ((Error _ F!Scan(L)) neq F.OK) then
       begin |3|
         T!Bell;
     
         if (Error = F.BAD.FILESPEC) then
           print(crlf, L, " [Bad FileSpec]", crlf)
         else
           print(crlf, "? Bad command line: ", L, crlf);
     
         exit;
       end; |3|
     
       if (length(TmpCoreString)) then
         tmpout("EDS", TmpCoreString, Flag);
     
           ! <<  This should handle the error (no-room-in-core) that could
                 occur. ;
     
     end "rpg interface"; |2|
     Cre: 05-Apr-84  10:08  (PEAKX)XFILE.SAI                           Page 24-1
     Prt: 06-Jun-84  13:56                                            Rtn F!Init

     
     ! Initialize the file I/O module.  (This assumes that F!RPG has
     ! already been invoked, and that F!Name & Co. are set up.
     ;
     
     internal procedure F!Init;
     begin "init" |2|
       if ( length( F!Name )) then
       begin |3|
         B!Make( F!Name, F!Alias );
         if ( F!Load( F!Name, F!Page, F!Line, F!Char ) ) then
           B!Lock := F!Lock
         else
           W!Msg( "New File" );
       end |3|
       else
         B!Make( "NONAME.TXT", NULL );
     
       B!ModP := false;
     end "init"; |2|
     end "DED - File I/O"; |1|





                                                
                                                
                                                
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                                
                                                
                                                



                                                                        
                                                                        
                                                                        
                        
                        
                        
                        
                        
                        
                                                            
                                                            
                                                            
                        
                        
                        
                        
                        
                        
                                          
                                          
                                          




                              
              
              
                      
                 
                
                          

     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 1-1
     Prt: 06-Jun-84  13:56                      Tops20 Buffer/Checkpoint Manager

     Entry;
     begin "DED - Buffer / Checkpoint manager" |1|
       require "DED.DEF" source!file;
     
     
       ifcr TymcomX thenc
         require "!!!! You're compiling the wrong buffer module !!!!" message;
         require "!!!! This one is for Tops20 only.             !!!!" message;
         TryAgainWithTheCorrectModule
       endc
     
     
     ! *************************************************************************
     *                                                                         *
     *             The Buffer/Checkpoint manager.  Tops20 version.             *
     *                       Ken Dawson   25-August-1983                       *
     *                                                                         *
     **************************************************************************;
     
     !                  From the Language / Operating System.
     ;
     
       external integer
         !skip!;                             ! Skip-return flag for SAIL/OS
                                             ! operations.
                                             ;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                        From the Utility Module.
     ;
     
       external simple integer procedure
         chsizef (integer Chan);             ! Return the size in characters
                                             ! of the file open on the
                                             ! indicated channel.
                                             ;
       external simple procedure
         Blt (integer SrcStart, DstStart, SrcLen);
                                             ! General block transfer
                                             ! routine.
                                             ;
       external simple integer procedure
         DecrBP (integer BP);                ! Return a decremented byte
                                             ! pointer. 
                                             ;
       external simple procedure
         DoErstr;                            ! Produce an error message
                                             ! corresponding to the last
                                             ! detected error condition.
                                             ;
       external simple integer procedure
         ffffp (integer Jfn, StartPage(0));  ! Find first free file page jsys.
                                             ;
       external simple procedure
         MoveBytes (integer SrcPtr, TgtPtr, BytCnt);
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 1-2
     Prt: 06-Jun-84  13:56                      Tops20 Buffer/Checkpoint Manager

                                             ! Transfer byte strings from one
                                             ! place to another.
                                             ;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                        From the Command Module.
     ;
     
       external safe integer array
         C!Tab ['0:'177];                    ! Character-translation table.
                                             ;
     
       external integer
         C!Debug;                            ! True if we are debugging.
                                             ;
     
       external boolean
         G!TextMode,                         ! True iff we are in Text Mode.
                                             ;
         G!RNulls;                           ! True if we want to remove nulls
                                             ! automatically on startup.
                                             ;
     
       external boolean procedure
         C!Ask (string Question);            ! Ask the user a question through
                                             ! the message line.
                                             ;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                          From the File Module.
     ;
     
       external  simple boolean procedure
         F!FileExists (string FName);        ! True if the named file exists.
                                             ;
       external boolean procedure
         F!Writ (string FileName);           ! ???
                                             ;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                         From the Window Module.
     ;
     
       external procedure
         W!SetB (integer BufNum);            ! ???
                                             ;
       external procedure
         W!Msg (string Msg);                 ! Display a message.
                                             ;
       external procedure
         W!FixS;                             ! To cause update of status line.
                                             ;
       external procedure
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 1-3
     Prt: 06-Jun-84  13:56                      Tops20 Buffer/Checkpoint Manager

         W!NewS;                             ! Set to build new status line.
                                             ;
       external procedure
         W!BClr;                             ! ???
                                             ;
       external procedure
         W!BAdd (string Msg);                ! Add a string to the little
                                             ! display window.
                                             ;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                        From the Redisplay Module.
     ;
       external procedure
         T!Bell;                             ! Do a beep on the terminal.
                                             ;
       external integer
         T!Lines;                            ! Size of physical window.
                                             ;
     
     
     ! ------------------------------------------------------------------------;
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 2-1
     Prt: 06-Jun-84  13:56                                      Internal Storage

     
     
     !                     Storage for buffer descriptors.
     ;
     
       own integer
         B!!Head,                            ! Head of active buffer list.
                                             ;
         B!!List,                            ! Pointer into list.
                                             ;
         B!!Free;                            ! Head of free list.
                                             ;
     
       own trusted string array
         B!!Alias      [1:BUFMAX],
         B!!ChkPntFile [1:BUFMAX],
         B!!File       [1:BUFMAX],
         B!!Mode       [1:BUFMAX];
     
       own trusted integer array
         B!!Last       [1:BUFMAX],
         B!!Next       [1:BUFMAX];
     
       own trusted boolean array
         B!!ModP       [1:BUFMAX];
     
     
       ! Static per-buffer storage.
       ;
     
       internal string
         B!Alias,                            ! "alias" for filename.
                                             ;
         B!ChkPntFile,                       ! Name of the current Checkpoint
                                             ! file.
                                             ;
         B!File,                             ! Filename the buffer came from.
                                             ;
         B!Mode;                             ! Mode(s) that apply to this
                                             ! buffer.
                                             ;
     
       internal boolean
         B!BegP,                             ! True iff point is at 0.
                                             ;
         B!EndP,                             ! True iff point is at B!Size.
                                             ;
         B!ModP;                             ! True iff buffer has been
                                             ! modified.
                                             ;
     
       internal integer
         B!Size,                             ! The number of characters in the
                                             ! buffer at any given time.
                                             ;
         B!Lock,                             ! State of the write-lock on the
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 2-2
     Prt: 06-Jun-84  13:56                                      Internal Storage

                                             ! buffer. 
                                             ;
         InsertLock,                         ! Indicates that the Buffer is
                                             ! locked against character
                                             ! insertions.
                                             ;
         DeleteLock,                         ! Indicates that the Buffer is
                                             ! locked against character
                                             ! deletions.
                                             ;
         B!Prot,                             ! Buffer's protection code.
                                             ;
     
         B!WS0,                              ! Mark Index of the starting point
                                             ! of the first window.
                                             ;
         B!WS1,                              ! Mark Index of the starting point
                                             ! of the second window.
                                             ;
         B!CkPtSer,                          ! Serial number of the checkpoint
                                             ! file.
                                             ;
         B!DedVer;                           ! Version number of the editor
                                             ! that created the checkpoint
                                             ! file. 
                                             ;
     
       own integer
         B!Point,                            ! The Point is the position
                                             ! indicator for the cursor,
                                             ! located between characters in
                                             ! the buffer.  Its value is the
                                             ! number of characters to the
                                             ! left of the cursor.
                                             ;
         B!LastP;                            ! Mark Index of the Last Position
                                             ! indicator. 
                                             ;
     
     
     ! ************************************************************************;
     
     
       ! Storage for things other than buffers.
       ;
     
       preset!with
         hl('350700),
         hl('260700),
         hl('170700),
         hl('100700),
         hl('010700);
     
       own safe integer array
         B!BPLeft [0:4];
     
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 2-3
     Prt: 06-Jun-84  13:56                                      Internal Storage

         ! This magic is used to build byte pointers.  The five numbers point
         ! to the 0th, 1st, ... 4th 7 bit characters in a 36 bit word.
         ;
     
     
     ! ------------------------------------------------------------------------;
     
     !                    Regarding User and Internal Marks
     !
     !
     !       We define two areas in the array which contains all marks
     !       maintained by Peak, the User Marks area (in the range [0,
     !       #UserMarks - 1]) and the Real Marks area ([FirstMark, MaxMarks]).
     !
     !
     !                          --------------------
     !                          |                  | User Marks
     !                          |                  |
     !                          --------------------
     !                          |                  | Real Marks
     !                          |                  |
     !                          |                  |
     !                          |                  |
     !                          |                  |
     !                          --------------------
     !
     !
     !       User Marks are distinguished in the sense that they are finite in
     !       number (determined at compile time), and that they are
     !       pre-allocated to the index range [0, #UserMarks - 1].
     !
     !       When the user sets a mark, a slot in the Real Marks area is
     !       allocated, and its index placed in the appropriate User Mark
     !       slot.
     !
     !       When an internal routine allocates a mark, the index in the Real
     !       Marks range of the allocated mark is returned
     !
     !       Mark-updating procedures in the insert and delete operations deal
     !       only with marks allocated in the Real Marks area, thus minimizing
     !       the amount of work done to what is necessary.
     !
     !
     ;
     
       define
         #UserMarks     = {10},
         FirstMark      = {#UserMarks},
         #InternalMarks = {30},
         MaxMarks       = {((2 * #UserMarks) + #InternalMarks)};
     
       own integer
         MarkCnt;
     
           ! The number of Real Marks allocated at the current time.
           ;
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 2-4
     Prt: 06-Jun-84  13:56                                      Internal Storage

     
       own integer array
         Marks[0 : MaxMarks - 1];
     
           ! The array containing the entire Mark structure.
           ;
     
     
     ! ------------------------------------------------------------------------;
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 3-1
     Prt: 06-Jun-84  13:56                                      Some Definitions

     
     ! <<  Encyphering: Enter with no lookup will allegedly cause the file to
     !     be hidden from the file system until a close is done on it.
     ;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                                Globally
     ;
     
     ! <<  Global Lock variables for (1) Insert    lock
     !                               (2) Delete    lock
     !                               (3) Read-Only lock
     ;
     
       define
         !ChrMask (X) = {!mask(36 - ((X + 1) * 7))};
     
       preset!with
           !ChrMask(0),
           !ChrMask(1),
           !ChrMask(2),
           !ChrMask(3),
           !ChrMask(4);
     
       own safe integer array
         ChrMsk [0:4];                       ! This is a set of character
                                             ! masks for composing a word of
                                             ! bytes from two different
                                             ! source words.  (See MoveTextPL)
                                             ;
     
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                             Process-Related
     ;
     
       define
         !fhslf = {bit(18)};                 ! The Tops-20 designator for the
                                             ! current process.
                                             ;
     
       integer
         B!Chan;                             ! The channel related to the
                                             ! Checkpoint file.
                                             ;
     
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                          Page-Mapping Related
     ;
     
     
       define
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 3-2
     Prt: 06-Jun-84  13:56                                      Some Definitions

         !CPg (X) = {xwd(B!Chan, X)},
         !MPg (X) = {xwd(!fhslf, X)},
         !TPg (X) = {xwd(F!Chan, X)};
     
         ! These define a series of device designators for the pmap calls.
         ;
     
       define
         !Count! (X)  = {(bit(0) lor (X land !mask(18)))}
     
                                             ! A repeat count is specified.
                                             ;,
         !Cow!        = {bit(9)}             ! Copy-on-write acccess.
                                             ;,
         !Rd!         = {bit(2)}             ! Read access.
                                             ;,
         !Wt!         = {bit(3)}             ! Write access.
                                             ;,
         !RdWt!       = {(!Rd! lor !Wt!)}    ! Read-Write access.
                                             ;,
         !PreRef!     = {bit(5)}             ! Pre-Reference the page.
                                             ;;
     
     
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                       Regarding the Virtual File
     ;
     
       internal integer
         B!MaxPgIdx;                         ! Index of the last page in the
                                             ! Virtual File.
                                             ;
     
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                         Regarding the EDT Area
     ;
     
     ! The EDT area contains all checkpointable quantities associated with the
     ! individual buffer.  These are the variables which are remembered when
     ! we return to a buffer after having edited another buffer.
     ;
     
       define
         EDTSize = {1};                      ! Size in pages of the EDT
                                             ! portion of the giant buffer.
                                             ;
     
     
       integer
         EDT;                                ! The location of the base of the
                                             ! EDT portion of the giant array.
                                             ;
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 3-3
     Prt: 06-Jun-84  13:56                                      Some Definitions

     
     
       define
         !B!EdName  = {memory[EDT + 0]},
         !B!DedVer  = {memory[EDT + 1]},
         !B!CkPtSer = {memory[EDT + 2]},
     
         !B!Point   = {memory[EDT + 3]},
         !B!Size    = {memory[EDT + 4]},
         !B!ModP    = {memory[EDT + 5]},
         !B!Lock    = {memory[EDT + 6]},
         !B!Prot    = {memory[EDT + 7]},
         !B!WS0     = {memory[EDT + 8]},
         !B!WS1     = {memory[EDT + 9]},
     
         !B!File1   = {memory[EDT + 10]},
         !B!File2   = {memory[EDT + 11]},
         !B!File3   = {memory[EDT + 12]},
         !B!File4   = {memory[EDT + 13]},
         !B!File5   = {memory[EDT + 14]},
         !B!File6   = {memory[EDT + 15]},
     
         !B!Alias1  = {memory[EDT + 16]},
         !B!Alias2  = {memory[EDT + 17]},
         !B!Alias3  = {memory[EDT + 18]},
         !B!Alias4  = {memory[EDT + 19]},
         !B!Alias5  = {memory[EDT + 20]},
         !B!Alias6  = {memory[EDT + 21]},
         !B!Alias7  = {memory[EDT + 22]},
     
         !B!Mode1   = {memory[EDT + 23]},
         !B!Mode2   = {memory[EDT + 24]},
     
         !B!BufNum  = {memory[EDT + 25]},
         !B!MarkCnt = {memory[EDT + 26]},
         !B!Marks   = {memory[EDT + 27]},
     
         !B!LstWrd  = {memory[EDT + 28 + MaxMarks - 1]};
     
     
         ! These are the offsets used to designate the locations corresponding
         ! to the named objects in the EDT area.
         ;
     
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                      Regarding the Checkpoint file
     ;
     
     
       ! The format of the Checkpoint file is as follows:
     
                       -------------------------     memory[HEAD]
                       |                       |
                       |       Header          |         HEADSize
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 3-4
     Prt: 06-Jun-84  13:56                                      Some Definitions

                       |                       |
                       -------------------------     memory[ICBM]
     ? Should this     |                       |
     ? be here?        |        ICBM           |         ICBMSize
     ?                 |                       |
                       -------------------------     memory[PPM]
                       |                       |
                       |         PPM           |         PPMSize
                       |                       |
                       -------------------------     memory[EDT]
                       |                       |
                       |         EDT           |         EDTSize
                       |                       |
                       -------------------------     memory[ICB]
                       |                       |
                       |                       |         ICBSize
                       |        Data           |
                       |                       |
                       |                       |
                       -------------------------
       ;
     
     
       integer
         HEAD;                               ! The address of the base of the
                                             ! Header portion in the giant
                                             ! array.
                                             ;
     
       define
         HEADSize = {1};                     ! Size in pages of the Header
                                             ! portion of the giant array.
                                             ;
     
       define
         $H$ICBM   = {memory[HEAD + 0]}      ! Page offset of the ICBM Block.
                                             ;,
         $H$PPM    = {memory[HEAD + 1]}      ! Page offset of the PPM Block.
                                             ;,
         $H$EDT    = {memory[HEAD + 2]}      ! Page offset of the EDT Block.
                                             ;,
         $H$Data   = {memory[HEAD + 3]}      ! Page offset of the Data Block.
                                             ;,
         $H$DedVer = {memory[HEAD + 4]}      ! The signature of the editor
                                             ! version that created this
                                             ! CheckPoint file.
                                             ;;
     
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                           Regarding the ICBM
     ;
     
     ! The ICBM currently occupies 1 page of memory.
     ! The ICBM is indexed (=[0, MaxICBMIdx]).
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 3-5
     Prt: 06-Jun-84  13:56                                      Some Definitions

     ! An ICBM entry is empty iff $ICBM.VFPg is < 0.
     ;
     
     
       integer
         ICBM;                               ! Location of the In-Core Buffer
                                             ! Map.
                                             ;
     
       define
         ICBMWordsPerEntry = {4};            ! The number of words which
                                             ! constitute an entry in the ICB
                                             ! map.  This number should be a
                                             ! factor of WordsPerPage.
                                             ;
     
       define
         ICBMSize = {1};                     ! The size in pages of the ICBM
                                             ! portion of the giant array.
                                             ;
     
       define
         ICBMEntries = {((ICBMSize * WordsPerPage) div ICBMWordsPerEntry)};
     
           ! The number if entries in the ICBM.
           ;
     
       define
         MaxICBMIdx = {ICBMEntries - 1};     ! The maximum value which an
                                             ! index into the ICBM can
                                             ! attain.
                                             ;
     
       define
         IWPE              = {ICBMWordsPerEntry};
     
           ! Generally useful substitution.
           ;
     
       define
         $I.MP             = {0},
         $I.VP             = {1},
         $I.MC             = {2};
     
           ! These are the offsets of the various fields within the ICBM
           ! entry.
           ;
     
       define
         $ICBM.Adr   (Pg)    = {ICBM + (Pg * IWPE)},
         $ICBM.MP    (Adr)   = {memory[Adr + $I.MP]},
         $ICBM.VP    (Adr)   = {memory[Adr + $I.VP]},
         $ICBM.MC    (Adr)   = {memory[Adr + $I.MC]};
     
           ! These are primitives for accessing the fields of a ICBM entry,
           ! given that we know the entry's address.
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 3-6
     Prt: 06-Jun-84  13:56                                      Some Definitions

           ;
           ! 
           ;
       define
         $ICBM.MemPg   (I) = {memory[ICBM + (I * IWPE) + 0]},
         $ICBM.VFPg    (I) = {memory[ICBM + (I * IWPE) + 1]},
         $ICBM.MissCnt (I) = {memory[ICBM + (I * IWPE) + 2]};
     
           ! The access-methods for the various fields of an ICBM entry.
           ;
     
           ! We define these fields as follows:
           !
           !   $ICBM.MemPg   (I)
           !     The physical page in memory where the contents of the Ith ICB
           !     page reside.
           !
           !   $ICBM.VFPg    (I)
           !     The index of the Virtual File page mapped to the Ith ICB page.
           !
           !   $ICBM.MissCnt (I)
           !     The number of times which the Ith ICB page has not been
           !     selected, and yet has remained in memory.
           ;
     
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                            Regarding the ICB
     ;
     
       integer
         ICB;                                ! Location of the In-Core Buffer.
                                             ;
     
       define
         ICBSize = {ICBMEntries};            ! The size in pages of the ICB
                                             ! portion of the giant array.
                                             ;
     
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                            Regarding the PPM
     ;
     
         ! ((  Note that this assumes that the PPM consists of only 1
         !     (resident) section.
         ;
     
       integer
         PPM;                                ! The memory address of the PPM
                                             ! buffer.
                                             ;
     
       define
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 3-7
     Prt: 06-Jun-84  13:56                                      Some Definitions

         PPMWordsPerEntry  = {8};            ! The number of words in a single
                                             ! page's entry in the PPM.  This
                                             ! number must be a factor of
                                             ! WordsPerPage.
                                             ;
     
       define
         PPMEntries = {1024};                ! The number of entries in the
                                             ! PPM.
                                             ;
     
       define
         MaxPPMIdx = {PPMEntries - 1};       ! The maximum value that an index
                                             ! into the PPM can attain.
                                             ;
     
       define
         PPMSize = {((PPMWordsPerEntry * PPMEntries) div WordsPerPage)};
     
           ! The size of the portion of the giant buffer occupied by the PPM.
           ;
     
       define
         PWPE               = {PPMWordsPerEntry};
     
           ! Generally useful substitution.
           ;
     
       define
         $V.LG             = {0},
         $V.TL             = {1},
         $V.RG             = {2},
         $V.IX             = {3},
         $V.CP             = {4};
     
           ! These are the offsets of the various fields within the PPM entry.
           ;
     
       define
         $VFPg.Adr   (Pg)  = {PPM + (Pg * PWPE)},
         $VFPg.LG    (Adr) = {memory[Adr + $V.LG]},
         $VFPg.TL    (Adr) = {memory[Adr + $V.TL]},
         $VFPg.RG    (Adr) = {memory[Adr + $V.RG]},
         $VFPg.IX    (Adr) = {memory[Adr + $V.IX]},
         $VFPg.CP    (Adr) = {memory[Adr + $V.CP]};
     
           ! These are primitives for accessing the fields of a PPM entry,
           ! given that we know the entry's address.
           ;
     
       define
         $VFPg.LftGap (Pg) = {memory[PPM + (Pg * PWPE) + $V.LG]},
         $VFPg.TxtLen (Pg) = {memory[PPM + (Pg * PWPE) + $V.TL]},
         $VFPg.RgtGap (Pg) = {memory[PPM + (Pg * PWPE) + $V.RG]},
         $VFPg.ICBIdx (Pg) = {memory[PPM + (Pg * PWPE) + $V.IX]},
         $VFPg.ChkPg  (Pg) = {memory[PPM + (Pg * PWPE) + $V.CP]};
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 3-8
     Prt: 06-Jun-84  13:56                                      Some Definitions

     
           ! These are primitives for accessing the fields of a PPM entry at
           ! random.
           ;
     
           !   We define these fields as follows:
           !
           !     $VFPg.LftGap (I)
           !       The location of the first character after the left gap on
           !       page I.  This is equivalent to saying that it is the length
           !       of the gap preceding the text on this page.
           !
           !         length($VFPg.LftGap(I)) =
           !             $VFPg.LftGap(I)
           !
           !     $VFPg.TxtLen (I)
           !       The length of the text residing on page I.
           !
           !     $VFPg.RgtGap (I)
           !       The location of the first character following the last text
           !       character on page I.  When the text ends at the end of the
           !       page, this value is CharactersPerPage.
           !
           !         length($VFPg.RgtGap(I)) =
           !             CharactersPerPage - $VFPg.RgtGap(I) 
           !
           !     $VFPg.ICBIdx (I)
           !       The index of page I in the In-Core Buffer.
           !
           !     $VFPg.ChkPg  (I)
           !       The index of page I in the Checkpoint file.  This is the
           !       actual file page on which Virtual File page I resides.
           !
           !     In General,
           !       length($VFPg.LftGap(I)) + $VFPg.TxtLen(I) =
           !           CharactersPerPage
           !
           ;
     
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                        Giant page-mapped buffer
     ;
     
     ! Note: We exploit the correspondence in layout between the beginning of
     !       the Checkpoint file and the beginning of the giant array by using
     !       ICBBase to denote the first data page in the Checkpoint file.
     !       This consitutes a mixed metaphor.
     ;
     
       define
         HEADBase    = {0},
         ICBMBase    = {HEADBase  + HEADSize},
         PPMBase     = {ICBMBase  + ICBMSize},
         EDTBase     = {PPMBase   + PPMSize},
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 3-9
     Prt: 06-Jun-84  13:56                                      Some Definitions

         ICBBase     = {EDTBase   + EDTSize},
         EndOfBuffer = {ICBBase   + ICBSize};
     
         ! Define the bases of the various portions of the giant array.
         ;
     
       integer
         GiantBase;                          ! The address of the first page
                                             ! boundry in the giant array.
                                             ;
     
       preload!with
         [((EndOfBuffer + 1) * WordsPerPage + 1)] 0;
     
         ! This incantation is included in order to avoid the fuss Sail would
         ! otherwise go through to initialize the venerable giant.
         ;
     
       safe integer array
         GiantArray[0: (EndOfBuffer + 1) * WordsPerPage];
     
         ! The physical array for holding all the current page-mapped buffers.
         ;
     
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     ifcr false thenc
     require crlf message;
     require "ICBMEntries: " & cvs(ICBMEntries) & crlf message;
     require "MaxICBMIdx:  " & cvs(MaxICBMIdx) & crlf message;
     require "MaxPPMIdx:   " & cvs(MaxPPMIdx) & crlf message;
     require "PPMSize:     " & cvs(PPMSize) & crlf message;
     require "HeadBase:    " & cvs(HeadBase) & crlf message;
     require "ICBMBase:    " & cvs(ICBMBase) & crlf message;
     require "PPMBase:     " & cvs(PPMBase) & crlf message;
     require "EDTBase:     " & cvs(EDTBase) & crlf message;
     require "ICBBase:     " & cvs(ICBBase) & crlf message;
     require "EndOfBuffer: " & cvs(EndOfBuffer) & crlf message;
     require "Length:      " & cvs((EndOfBuffer + 1) * WordsPerPage) message;
     require crlf message; 
     endc
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     Cre: 02-May-84  07:32  (PEAKX)XXBUFF.SAI                           Page 4-1
     Prt: 06-Jun-84  13:56                                       File Inclusions

     
     ! The source is large enough to warrant being split up, especially since
     ! we must edit it on Tops20 with version 0.145, which does file I/O a
     ! character at a time!
     ;
     
       require "xxbuf1.req" source!file;
       require "xxbuf2.req" source!file;
     
     end "DED - Buffer / Checkpoint manager" |1|
     
     
     ! **************************  End XXBuff.Sai  *************************** ;





                                                
                                                
                                                
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                                
                                                
                                                



                                                
                                                
                                                
                              
                              
                              
                        
                        
                        
                                          
                                          
                                          
                        
                        
                        
                        
                        
                        
                                                      
                                                      
                                                      




                            
                
               
                       
                
                 
                             

     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                           Page 1-1
     Prt: 06-Jun-84  13:54                    Part One of Tops-20 Buffer Sources

     
     ! *************************************************************************
     *                                                                         *
     *                               XxBuf1.Req                                *
     *                                                                         *
     *             The Buffer/Checkpoint manager.  Tops20 version.             *
     *                       Ken Dawson   25-August-1983                       *
     *                                                                         *
     **************************************************************************;
     
     ! These routines are not particularly homogeneous, taken as a whole, but
     ! they fit into a smaller space than they did before.
     ;
     
     forward internal simple procedure ShowMap (integer Pg);
     
     
     ! ----------------------------------------------------------------------- ;
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                           Page 2-1
     Prt: 06-Jun-84  13:54                                 Rtn SetupHeaderAndEDT

     
     ! Initialize Buffer-state variables and flush them into the EDT area.
     ;
     
     forward internal simple procedure B!FlushToEDT;
     forward internal simple procedure B!SetM (integer M, P);
     forward internal simple integer procedure B!AllocateMark;
     
     simple procedure SetupHeaderAndEDT (string TName, TAlias);
     begin "SetupHeaderAndEDT" |1|
       integer
         I;
     
       $H$ICBM   _ ICBMBase;
       $H$PPM    _ PPMBase;
       $H$EDT    _ EDTBase;
       $H$Data   _ ICBBase;
       $H$DedVer _ B!DedVer;
     
         ! Setup the Header portion of the giant array.
         ;
     
       B!File  _ TName;
       B!Alias _ TAlias;
     
       if (not length(B!Mode)) then
         B!Mode _ "Normal";
     
       B!Point   _ 0;
       B!ModP    _ false;
       B!Lock    _ 0;
       B!CkPtSer _ 0;
       B!BegP    _
       B!EndP    _ true;
     
       for I _ 0 step 1 until MaxMarks - 1 do
         Marks[I] _ -1;
     
         ! Initialize our Mark Structure.
         ;
     
       B!SetM((B!LastP _ B!AllocateMark), 0);
       B!SetM((B!WS0   _ B!AllocateMark), 0);
       B!SetM((B!WS1   _ B!AllocateMark), -1);
       
         ! Initialize some important Marks.
         ;
     
       B!FlushToEDT;
     end "SetupHeaderAndEDT"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                           Page 3-1
     Prt: 06-Jun-84  13:54                                   Rtn EvictFromMemory

     
     ! Force an ICB-resident page to be written to the Checkpoint file, and
     ! the corresponding ICBM entry to be made ready for reuse.
     ;
     
     simple procedure EvictFromMemory (integer ICBPgIdx);
     begin "EvictFromMemory" |1|
       if ($ICBM.VFPg(ICBPgIdx) >= 0) then
       begin |2|
         ! Only if the page in question is mapped...
         ;
     
         pmap(-1, !MPg($ICBM.MemPg(ICBPgIdx)), 0);
     
           ! Unmap the page from memory.  This causes it to updated in the
           ! Checkpoint file.
           ;
     
         $VFPg.ICBIdx($ICBM.VFPg(ICBPgIdx)) _
         $ICBM.VFPg(ICBPgIdx)               _ -1;
         $ICBM.MissCnt(ICBPgIdx)            _ largeinteger;
     
           ! Sanitize PPM and ICBM entries.
           ;
       end; |2|
     end "EvictFromMemory"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                           Page 4-1
     Prt: 06-Jun-84  13:54                                Rtn EvictICBFromMemory

     
     ! Remove all resident Virtual File pages from the ICB.
     ;
     
     simple procedure EvictICBFromMemory;
     begin "EvictICBFromMemory" |1|
       integer
         I;
     
       for I _ 0 step 1 until MaxICBMIdx do
         EvictFromMemory(I);
     end "EvictICBFromMemory"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                           Page 5-1
     Prt: 06-Jun-84  13:54                                   Rtn MapVFPgToMemory

     
     ! Map the specified Virtual File page into the specified ICB page.  The
     ! physical memory page should already be unmapped.
     ;
     
     simple procedure MapVFPgToMemory (integer VFPg, ICBPgIdx);
     begin "MapVFPgToMemory" |1|
       $VFPg.ICBIdx(VFPg)      _ ICBPgIdx;
       $ICBM.VFPg(ICBPgIdx)    _ VFPg;
       $ICBM.MissCnt(ICBPgIdx) _ 0;
     
       pmap(!CPg($VFPg.ChkPg(VFPg)), !MPg($ICBM.MemPg(ICBPgIdx)),
           (!RdWt! lor !PreRef!));
     
         ! Map the page, with read/write access, pre-referenced.
         ;
     end "MapVFPgToMemory"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                           Page 6-1
     Prt: 06-Jun-84  13:54                                        Rtn GetICBPage

     
     ! Allocate a page of the ICB by locating the next availible or most
     ! eligible page in the ICB, evicting it from memory, if necessary, and
     ! returning its index.
     ;
     
     simple integer procedure GetICBPage;
     begin "GetICBPage" |1|
       own integer
         I,                                  ! ICBM index iterator.
                                             ;
         MaxMissCnt,                         ! The largest number of misses
                                             ! achieved by a single ICB page.
                                             ;
         MaxMissIdx;                         ! The index of the ICB page with
                                             ! the largest number of misses.
                                             ;
     
       MaxMissCnt _ -1;
       MaxMissIdx _ 0;
     
       for I _ 0 step 1 until MaxICBMIdx do
       begin |2|
         ! For each ICB page.
         ;
     
         if ($ICBM.VFPg(I) >= 0) then
         begin |3|
           ! There is a Virtual File page mapped to this ICB page.
           ;
     
           incr($ICBM.MissCnt(I));
     
           if ($ICBM.MissCnt(I) > MaxMissCnt) then
           begin |4|
             MaxMissCnt _ $ICBM.MissCnt(I);
             MaxMissIdx _ I;
           end; |4|
         end |3|
         else
         begin |3|
           ! This ICB page is availible.
           ;
     
           if ($ICBM.MissCnt(I) > MaxMissCnt) then
           begin |4|
             MaxMissIdx _ I;
             MaxMissCnt _ largeinteger;
           end; |4|
     
             ! Note: We do not stop here because we must adjust all MissCnts.
             ;
         end; |3|
       end; |2|
     
       if ($ICBM.VFPg(MaxMissIdx) >= 0) then
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                           Page 6-2
     Prt: 06-Jun-84  13:54                                        Rtn GetICBPage

         ! The selected page is mapped to some page in the Checkpoint file.
         ;
     
         EvictFromMemory(MaxMissIdx);
     
       return(MaxMissIdx);
     end "GetICBPage"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                           Page 7-1
     Prt: 06-Jun-84  13:54                                       Rtn VFPToMemory

     
     ! Map the specified Virtual File page into the ICB, and return the
     ! identity of the memory page in which it resides.
     ;
     
     simple integer procedure VFPToMemory (integer VFPg);
     begin "VFPToMemory" |1|
       integer
         T;                                  ! ICBM index corresponding to
                                             ! VFPg.
                                             ;
     
       if ((T _ $VFPg.ICBIdx(VFPg)) >= 0) then
       begin |2|
         ! The page is already in memory.
         ;
     
         if ($ICBM.MissCnt(T) > 0) then
           decr($ICBM.MissCnt(T));
     
         return($ICBM.MemPg(T));
       end |2|
       else
       begin |2|
         ! The page is not in memory.
         ;
     
         integer
           ICBPg;
     
         MapVFPgToMemory(VFPg, (ICBPg _ GetICBPage));
         return($ICBM.MemPg(ICBPg));
       end; |2|
     end "VFPToMemory"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                           Page 8-1
     Prt: 06-Jun-84  13:54                                       Rtn LocatePoint

     
     ! Given a point specification, return a description of the leftmost
     ! location of the character just to the left of that point, as follows:
     !
     !   Reference Parameters:
     !
     !     ChPg:     The index of the Virtual File page that the character
     !               resides on.
     !                   ([0, B!MaxPgIdx]             - always)
     !
     !     ChChr:    The character index of the first character on the page
     !               that the character resides on.
     !                   ([0, B!Size - 1]             - normally)
     !                   (-1                          - if B!Size = 0)
     !                   (-1                          - if Point  = 0)
     !
     !     ChOfst:   The character index of the location where the character
     !               resides on the page.
     !                   ([0, CharactersPerPage - 1]  - normally)
     !                   (-1                          - if B!Size = 0)
     !                   (-1                          - if Point  = 0)
     !
     ! "(Leftmost" above means that there may be any number of empty pages
     ! which intervene between the current page and the page containing the
     ! next character).
     ;
     
     ! ((  (This uses the safe but inefficient method of counting up
     !     from page 0.  Another approach using a set of variables defining
     !     the location of the current page should be substituted later.)
     ;
     
     ! <<  This process must be as efficient as possible.  It is referenced
     !     every time a character is inserted into, deleted from, or read from
     !     the Buffer.
     ;
     
     simple boolean procedure LocatePoint
         (integer Point; reference integer ChPg, ChChr, ChOfst);
     begin "LocatePoint" |1|
       integer
         Pg,                                 ! Index iterator over Virtual
                                             ! File pages.
                                             ;
         ChrCnt,                             ! The character number of the
                                             ! first character on a given
                                             ! Virtual File page.
                                             ;
         Tl,                                 ! Value of a TxtLen entry in the
                                             ! PPM.
                                             ;
         PPMAdr;                             ! Index of an entry in the PPM.
                                             ;
     
       ChPg   _ 0;
       ChChr  _
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                           Page 8-2
     Prt: 06-Jun-84  13:54                                       Rtn LocatePoint

       ChOfst _ -1;
     
         ! Initially, assume that there is no predceding character.
         ;
     
       if (Point < 0 or Point > B!Size) then
       begin |2|
         ! The specified point doesn't exist.  Return an error indication.
         ;
     
         return(false);
       end |2|
       else if (Point = 0 or B!Size = 0) then
       begin |2|
         ! At the beginning of the Buffer, or there is no text in the Buffer.
         ! The initial assumption stands.
         ;
     
         return(true);
       end; |2|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       ChrCnt _ 0;
     
         ! We know that there is at least one character in the Buffer.
         ;
     
       PPMAdr _ $VFPg.Adr(0);
     
         ! Pick up the location of the first entry in the PPM.
         ;
     
       for Pg _ 0 step 1 until B!MaxPgIdx do
       begin |2|
         Tl _ $VFPg.TL(PPMAdr);
     
           ! Get the TxtLen value for this Virtual File page.
           ;
     
         if (Point <= ChrCnt + Tl) then
           done;
     
         incr(ChrCnt, Tl);
         incr(PPMAdr, PPMWordsPerEntry);
       end; |2|
     
       ChPg    _ Pg;
       ChChr   _ ChrCnt;
       ChOfst  _ Point - ChrCnt + $VFPg.LG(PPMAdr) - 1;
     
       return(true);
     end "LocatePoint"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                           Page 9-1
     Prt: 06-Jun-84  13:54                                         Rtn BldMemPtr

     
     ! Build a byte pointer to the specified byte in memory.  Return 0 if the
     ! page or character position specified is bogus.
     ;
     
     simple integer procedure BldMemPtr (integer ChPage, ChPos);
     begin "BldMemPtr" |1|
       if ((ChPage < 0 or ChPage >= PagesPerAddressSpace) or
           (ChPos < 0 or ChPos >= CharactersPerPage)) then
         return(0);
     
       return(B!BPLeft[ChrNo(ChPos)] lor Addrs(ChPage, WrdNo(ChPos)));
     end "BldMemPtr"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 10-1
     Prt: 06-Jun-84  13:54                                          Rtn BldVFPtr

     
     ! Build a byte pointer to the specified byte.  Insure that the Virtual
     ! File page it resides on is in memory, first.  Return 0 if the  page or
     ! character position specified is bogus.
     ;
     
     simple integer procedure BldVFPtr (integer ChPage, ChPos);
     begin "BldVFPtr" |1|
       if ((ChPage < 0 or ChPage > B!MaxPgIdx) or
           (ChPos < 0 or ChPos >= CharactersPerPage)) then
         return(0);
     
       return(B!BPLeft[ChrNo(ChPos)] lor
           Addrs(VFPToMemory(ChPage), WrdNo(ChPos)));
     end "BldVFPtr"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 11-1
     Prt: 06-Jun-84  13:54                                        Rtn MoveTextPL

     
     ! Perform a page-limited transfer of text from one place to another in
     ! the Virtual File in the most reasonable way possible.
     !
     ! Note:  This is a page-limited transfer!  It is up to the caller to
     !        insure that the text involved will not exceed a page boundry,
     !        on either the source or the destination side.
     ;
     
     ! <<  For the time being, "most reasonable" means the easiest.
     !     (Cop Out!!!)
     ;
     
     simple procedure MoveTextPL
         (integer SrcPg, SrcByte, SrcLen, DstPg, DstByte);
     begin "MoveTextPL" |1|
       integer
         DstPtr,                             ! Pointer to the destination
                                             ! region.
                                             ;
         SrcPtr;                             ! Pointer to the source region.
                                             ;
     
       SrcPtr _ BldVFPtr(SrcPg, SrcByte);
       DstPtr _ BldVFPtr(DstPg, DstByte);
     
       MoveBytes(SrcPtr, DstPtr, SrcLen);
     end "MoveTextPL"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 12-1
     Prt: 06-Jun-84  13:54                                Rtn GarbageCollectGaps

     
     ! Make room for text in the Buffer by removing all the gaps from the
     ! Checkpoint file.
     ;
     
     simple procedure GarbageCollectGaps;
     begin "GarbageCollectGaps" |1|
       integer
         DPg,                                ! Destination file page number.
                                             ;
         Fill1,                              ! The first page of the fill
                                             ! area.
                                             ;
         Fill1Adr,                           ! The address of the same.
                                             ;
         Fill2,                              ! The second page of the fill
                                             ! area.
                                             ;
         Fill2Adr,                           ! The address of the same.
                                             ;
         FillLength,                         ! Length in bytes of the text in
                                             ! the fill area.
                                             ;
         I,                                  ! General index iterator.
                                             ;
         OutPgNo,                            ! Output page number, used to
                                             ! measure the size of the new
                                             ! Virtual File.
                                             ;
         Src,                                ! Memory page into which pages
                                             ! are mapped.
                                             ;
         SrcAdr,                             ! Address of the same.
                                             ;
         SPg;                                ! Source file page number.
                                             ;
     
       EvictICBFromMemory;
     
         ! Flush all memory-resident pages to disk.
         ;
     
       Src        _ $ICBM.MemPg(0);
       Fill1      _ $ICBM.MemPg(1);
       Fill2      _ $ICBM.MemPg(2);
     
       SrcAdr     _ Addrs(Src, 0);
       Fill1Adr   _ Addrs(Fill1, 0);
       Fill2Adr   _ Addrs(Fill2, 0);
     
       FillLength _ 0;
       OutPgNo    _ 0;
     
       for I _ 0 step 1 until B!MaxPgIdx do
       begin |2|
         ! For each page in the existing Virtual File.
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 12-2
     Prt: 06-Jun-84  13:54                                Rtn GarbageCollectGaps

         ! (Only if we can GUARANTEE that I >= OutPgNo will this scheme work.)
         ;
     
         pmap(!CPg(SPg _ $VFPg.ChkPg(I)), !MPg(Src), !Cow!);
     
           ! Map Virtual File page I into memory page Src, copy-on-write.
           ;
     
         memory[SrcAdr] _ memory[SrcAdr];
     
           ! Make the page private.  (Is this necessary, since we delete the
           ! page right after this?)
           ;
     
         pmap(-1, !CPg(SPg), 0);
     
           ! Delete the Virtual File page from the file.
           ;
     
         MoveTextPL
         (
           Src, $VFPg.LftGap(I), $VFPg.TxtLen(I),
           Fill1, FillLength
         );
     
           ! Copy text to the fill area.
           ;
     
         incr(FillLength, $VFPg.LftGap(I));
     
         if (FillLength >= CharactersPerPage) then
         begin |3|
           DPg _ ffffp(B!Chan);
     
           pmap(!MPg(Fill1), !CPg(DPg), !Cow!);
     
             ! Map the compressed page to the Checkpoint file, and delete the
             ! page from memory.
             ;
     
           decr(FillLength, CharactersPerPage);
           Blt(Fill2Adr, Fill1Adr, ceiling(FillLength, CharactersPerWord));
     
           $VFPg.LftGap(OutPgNo) _ 0;
           $VFPg.TxtLen(OutPgNo) _
           $VFPg.RgtGap(OutPgNo) _ CharactersPerPage;
           $VFPg.ICBIdx(OutPgNo) _ -1;
           $VFPg.ChkPg(OutPgNo)  _ DPg;
     
             ! Create PPM entry for new Virtual File page OutPgNo.
             ;
     
           incr(OutPgNo);
         end; |3|
       end; |2|
     
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 12-3
     Prt: 06-Jun-84  13:54                                Rtn GarbageCollectGaps

       if (FillLength) then
       begin |2|
         DPg _ ffffp(B!Chan);
     
         pmap(!MPg(Fill1), !CPg(DPg), !Cow!);
     
           ! Map the compressed page to the Checkpoint file, and delete the
           ! page from memory.
           ;
     
         $VFPg.LftGap(OutPgNo) _ 0;
         $VFPg.TxtLen(OutPgNo) _
         $VFPg.RgtGap(OutPgNo) _ FillLength;
         $VFPg.ICBIdx(OutPgNo) _ -1;
         $VFPg.ChkPg(OutPgNo)  _ DPg;
     
           ! Create PPM entry for new Virtual File page OutPgNo.
           ;
     
         incr(OutPgNo);
       end; |2|
     
       for I _ OutPgNo step 1 until B!MaxPgIdx do
       begin |2|
         $VFPg.TxtLen(I) _
         $VFPg.LftGap(I) _ 0;
         $VFPg.ChkPg(I)  _
         $VFPg.ICBIdx(I) _ -1;
         $VFPg.RgtGap(I) _ CharactersPerPage;
       end; |2|
     
         ! Set all remaining entries in the old Virtual File to the empty
         ! state.
         ;
     
       B!MaxPgIdx _ OutPgNo - 1;
     end "GarbageCollectGaps"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 13-1
     Prt: 06-Jun-84  13:54                                        Rtn InsertPage

     
     ! Insert a new page at the specified page in the Virtual File, and either
     ! map it to an existing ICB page (if ICBPg >= 0 on entry), or allocate an
     ! ICB page and map it to that (otherwise).  Return the success of the
     ! operation. (The insert will fail if we are at the end of the PPM
     ! already.  A garbage-collect of gaps will take place, but the caller
     ! must deal with the fact that the specified Virtual File page reference
     ! may now be meaningless.)
     ;
     
     simple boolean procedure InsertPage (integer VFPg, ICBPg(-1));
     begin "InsertPage" |1|
       if (VFPg >= 0) then
       begin |2|
         ! The specified page number is legitimate.
         ;
     
         if (B!MaxPgIdx = MaxPPMIdx) then
         begin |3|
           ! The PPM is full.
           ;
     
           GarbageCollectGaps;
     
             ! Attempt to make room by removing gaps from the Checkpoint file.
             ;
     
           if (B!MaxPgIdx = MaxPPMIdx) then
           begin |4|
             T!Bell;
             W!Msg("The Buffer is full; " &
                 "You may delete characters but you may not insert them.");
             set(InsertLock);
             clear(DeleteLock);
           end; |4|
     
           return(false);
         end; |3|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
         begin |3|
           ! The PPM is not full.  Move pages [VFPg, B!MaxPgIdx] down one slot
           ! and adjust the ICBM accordingly.
           ;
     
           integer
             ChPg,                             ! Checkpoint file page index.
                                               ;
             Dest,                             ! Address of the destination
                                               ! region.
                                               ;
             I,                                ! ICB iteration index.
                                               ;
             Len,                              ! Length in words of the region
                                               ! of the PPM to be Blted.
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 13-2
     Prt: 06-Jun-84  13:54                                        Rtn InsertPage

                                               ;
             Start;                            ! Address of the source region.
                                               ;
     
     
           if (VFPg <= B!MaxPgIdx) then
           begin |4|
             ! The new page is being inserted into the existing page range.
             ;
     
             Start  _ $VFPg.Adr(VFPg);
             Dest   _ Start + PPMWordsPerEntry;
             Len    _ (B!MaxPgIdx + 1 - VFPg) * PPMWordsPerEntry;
     
             Blt(Start, Dest, Len);
     
               ! Move the entries in the PPM after VFPg down one slot.
               ;
     
             for I _ 0 step 1 until MaxICBMIdx do
               if ($ICBM.VFPg(I) >= VFPg) then
                 incr($ICBM.VFPg(I));
     
               ! Where necessary, bump the Virtual File page number associated
               ! with each ICB page.
               ;
           end; |4|
     
           if (ICBPg < 0) then
             ICBPg              _
             $VFPg.ICBIdx(VFPg) _ GetICBPage
           else
           begin |4|
             $VFPg.ICBIdx(VFPg) _ ICBPg;
           end; |4|
     
             ! Establish which ICB page to associate with the new Virtual File
             ! page.
             ;
     
           ChPg                 _
           $VFPg.ChkPg(VFPg)    _ ffffp(B!Chan);
           $ICBM.VFPg(ICBPg)    _ VFPg;
           $ICBM.MissCnt(ICBPg) _ 0;
     
             ! Allocate a page in the Checkpoint file for the new Virtual File
             ! page.
             ;
     
     !      print("InsertPage: ",
               "ICBPg (", cvos(ICBPg), "q)",
               ", $ICBM.MemPg(ICBPg) (", cvos($ICBM.MemPg(ICBPg)), "q)",
               ", ChPg (", cvos(ChPg), "q)", crlf);
     
           pmap(!MPg($ICBM.MemPg(ICBPg)), !CPg(ChPg), !RdWt!);
           pmap(!CPg(ChPg), !MPg($ICBM.MemPg(ICBPg)), !RdWt!);
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 13-3
     Prt: 06-Jun-84  13:54                                        Rtn InsertPage

     
             ! Map the selected ICB page to the selected Virtual File page,
             ! with read/write access.
             ;
     
           $VFPg.LftGap(VFPg) _
           $VFPg.TxtLen(VFPg) _
           $VFPg.RgtGap(VFPg) _ 0;
     
             ! Initialize the PPM entry for the new page.
             ;
     
           incr(B!MaxPgIdx);
         end; |3|
       end |2|
       else
       begin |2|
         print("InsertPage got a bad page number (", VFPg, ")", crlf);
         exit;
       end; |2|
     
       return(true);
     end "InsertPage"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 14-1
     Prt: 06-Jun-84  13:54                                        Rtn B!ForceGap

     
     ! Force a (possibly empty) gap to appear to the right of the Point in the
     ! Virtual file, and return a description of the location of the character
     ! to the left of the Point.
     ;
     
     forward internal simple integer procedure B!GetP;
     
     simple procedure B!ForceGap (reference integer RPg, ROfst);
     begin "B!ForceGap" |1|
       integer
         Bias,                               ! A charcter offset variable
                                             ! used in conjunction with Blt
                                             ! calls.
                                             ;
         ChOfst,                             ! Character offset of the
                                             ! character preceding the Point
                                             ! on the page. 
                                             ;
         Dummy,                              ! A filler.
                                             ;
         DWrd,                               ! Destination word designator.
                                             ;
         LenLftTxt,                          ! Length of the text to the left
                                             ! of the Point.
                                             ;
         LenRgtTxt,                          ! Length of the text to the right
                                             ! of the Point.
                                             ;
         NxtChOfst,                          ! The charcter offset of the
                                             ! character to the right of the
                                             ! Point.
                                             ;
         NxtPg,                              ! The next page.
                                             ;
         PrvPg,                              ! The previous page.
                                             ;
         SWrd,                               ! Source word designator. 
                                             ;
         ThisPg,                             ! Virtual File page containing
                                             ! the Point.
                                             ;
         WrdCnt,                             ! The number of words to
                                             ! transfer.
                                             ;
         TLG,                                ! This page's left gap.
                                             ;
         TTL,                                ! This page's text length.
                                             ;
         TRG,                                ! This page's right gap.
                                             ;
         TIX,                                ! This page's ICB index.
                                             ;
         TMA,                                ! This page's map address.
                                             ;
         TMP,                                ! This page's memory page.
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 14-2
     Prt: 06-Jun-84  13:54                                        Rtn B!ForceGap

                                             ;
         PLG,                                ! The previous page's left gap.
                                             ;
         PTL,                                ! The previous page's text length.
                                             ;
         PRG,                                ! The previous page's right gap.
                                             ;
         PIX,                                ! The previous page's ICB index.
                                             ;
         PMA,                                ! The previous page's map address.
                                             ;
         PMP,                                ! The previous page's memory page.
                                             ;
         NLG,                                ! The next page's left gap.
                                             ;
         NTL,                                ! The next page's text length.
                                             ;
         NRG,                                ! The next page's right gap.
                                             ;
         NIX,                                ! The next page's ICB index.
                                             ;
         NMA,                                ! The next page's map address.
                                             ;
         NMP;                                ! The next page's memory page.
                                             ;
     
     
       if (not LocatePoint(B!GetP, ThisPg, Dummy, ChOfst)) then
         usererr("B!ForceGap: LocatePoint failed (" & cvs(B!GetP) & ")", 0, 0);
     
       RPg       _ ThisPg;
       ROfst     _ ChOfst;
     
         ! Our first guess is that the located point will abut the right gap.
         ;
     
       NxtChOfst _ ChOfst + 1;
       TMA       _ $VFPg.Adr(ThisPg);
       TRG       _ $VFPg.RG(TMA);
     
       if (B!Size = 0 or (NxtChOfst = TRG)) then
       begin |2|
         ! The Buffer is empty, or we are on the edge of the right gap
         ! already.  Do nothing.
         ;
       end  |2|
       else
       begin |2|
         ! We must move some text off of this page.
         ;
     
         PrvPg _ ThisPg - 1;
         NxtPg _ ThisPg + 1;
     
         TLG   _ $VFPg.LG(TMA);
         TTL   _ $VFPg.TL(TMA);
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 14-3
     Prt: 06-Jun-84  13:54                                        Rtn B!ForceGap

         TIX   _ $VFPg.IX(TMA);
     
         if (TIX < 0) then
         begin |3|
           TMP _ VFPToMemory(ThisPg);
           TIX _ $VFPg.IX(TMA);
         end |3|
         else
           TMP _ $ICBM.MemPg(TIX);
     
         if (PrvPg >= 0) then
         begin |3|
           PMA _ TMA - PPMWordsPerEntry;
           PLG _ $VFPg.LG(PMA);
           PTL _ $VFPg.TL(PMA);
           PRG _ $VFPg.RG(PMA);
           PIX _ $VFPg.IX(PMA);
     
           if (PIX < 0) then
           begin |4|
             PMP _ VFPToMemory(PrvPg);
             PIX _ $VFPg.IX(PMA);
           end |4|
           else
             PMP _ $ICBM.MemPg(PIX);
         end; |3|
     
         if (NxtPg <= MaxPPMIdx) then
         begin |3|
           NMA _ TMA + PPMWordsPerEntry;
     
           if (NxtPg <= B!MaxPgIdx) then
           begin |4|
             NLG _ $VFPg.LG(NMA);
             NTL _ $VFPg.TL(NMA);
             NRG _ $VFPg.RG(NMA);
     
             NIX _ $VFPg.IX(NMA);
     
             if (NIX < 0) then
             begin |5|
               NMP _ VFPToMemory(NxtPg);
               NIX _ $VFPg.IX(NMA);
             end |5|
             else
               NMP _ $ICBM.MemPg(NIX);
           end; |4|
         end; |3|
     
         LenRgtTxt _ TRG - NxtChOfst;
         LenLftTxt _ TTL - LenRgtTxt;
     
         if (NxtPg <= B!MaxPgIdx and NTL = 0) then
         begin |3|
           ! The next page is empty.  Move the right text to it.
           ;
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 14-4
     Prt: 06-Jun-84  13:54                                        Rtn B!ForceGap

     
           SWrd   _ WrdNo(NxtChOfst);
           Bias   _ ChrNo(NxtChOfst);
           WrdCnt _ WrdNo(TRG - 1) - SWrd + 1;
           DWrd   _ 0;
     
           Blt
           (
             Addrs(TMP, SWrd),
             Addrs(NMP, DWrd),
             WrdCnt
           );  
     
           $VFPg.LG(NMA) _ Bias;
           $VFPg.TL(NMA) _ LenRgtTxt;
           $VFPg.RG(NMA) _ LenRgtTxt + Bias;
           decr($VFPg.RG(TMA), LenRgtTxt);
           decr($VFPg.TL(TMA), LenRgtTxt);
         end |3|
         else if (NxtPg <= B!MaxPgIdx and LenRgtTxt <= NLG) then
         begin |3|
           ! Text to the right of the Point fits in the left gap of the next
           ! page.
           ;
     
           MoveTextPL
           (
             ThisPg, NxtChOfst,
             LenRgtTxt,
             NxtPg, (NLG - LenRgtTxt)
           );
     
           decr($VFPg.RG(TMA), LenRgtTxt);
           decr($VFPg.TL(TMA), LenRgtTxt);
           decr($VFPg.LG(NMA), LenRgtTxt);
           incr($VFPg.TL(NMA), LenRgtTxt);
         end |3|
         else if (PrvPg >= 0 and PTL = 0) then
         begin |3|
           ! The previous page is empty.  Move the left text to it.
           ;
     
           SWrd   _ WrdNo(TLG);
           Bias   _ ChrNo(TLG);
           WrdCnt _ WrdNo(ChOfst) - SWrd + 1;
           DWrd   _ 0;
     
           Blt
           (
             Addrs(TMP, SWrd),
             Addrs(PMP, DWrd),
             WrdCnt
           );  
     
           $VFPg.LG(PMA) _ Bias;
           $VFPg.TL(PMA) _ LenLftTxt;
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 14-5
     Prt: 06-Jun-84  13:54                                        Rtn B!ForceGap

           $VFPg.RG(PMA) _ LenLftTxt + Bias;
           incr($VFPg.LG(TMA), LenLftTxt);
           decr($VFPg.TL(TMA), LenLftTxt);
           RPg   _ PrvPg;
           ROfst _ LenLftTxt + Bias - 1;
         end |3|
         else if (PrvPg >= 0 and LenLftTxt <= CharactersPerPage - PRG) then
         begin |3|
           ! Text left of the Point fits in the right gap of the previous
           ! page.
           ;
     
           MoveTextPL
           (
             ThisPg, TLG,
             LenLftTxt,
             PrvPg, PRG
           );
     
           incr($VFPg.RG(PMA), LenLftTxt);
           incr($VFPg.TL(PMA), LenLftTxt);
           incr($VFPg.LG(TMA), LenLftTxt);
           decr($VFPg.TL(TMA), LenLftTxt);
           RPg   _ PrvPg;
           ROfst _ PRG + LenLftTxt - 1;
         end |3|
         else
         begin |3|
           ! Cannot move text backwards or forwards to an existing page.  We
           ! must create a new page and move the right-text to it.  The text
           ! is right-justified within the new page.
           ;
     
           if (not InsertPage(NxtPg)) then
           begin |4|
             ! A garbage-collect of gaps has taken place, because we reached
             ! the capacity of the PPM. We have lost the location of the
             ! Point, and must start over again.
             ;
     
             if (not LocatePoint(B!GetP, ThisPg, Dummy, ChOfst)) then
               usererr("B!ForceGap: LocatePoint failed (" & cvs(B!GetP) & ")",
                   0, 0);
     
             NxtPg _ ThisPg + 1;
     
             TMA   _ $VFPg.Adr(ThisPg);
             TLG   _ $VFPg.LG(TMA);
             TTL   _ $VFPg.TL(TMA);
             TRG   _ $VFPg.RG(TMA);
             TMP   _ $ICBM.MemPg($VFPg.IX(TMA));
     
             if (NxtPg <= MaxPPMIdx) then
             begin |5|
               NMA _ TMA + PPMWordsPerEntry;
     
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 14-6
     Prt: 06-Jun-84  13:54                                        Rtn B!ForceGap

               if (NxtPg <= B!MaxPgIdx) then
               begin |6|
                 NLG _ $VFPg.LG(NMA);
                 NTL _ $VFPg.TL(NMA);
                 NRG _ $VFPg.RG(NMA);
     
                 NIX _ $VFPg.IX(NMA);
     
                 if (NIX < 0) then
                 begin |7|
                   NMP _ VFPToMemory(NxtPg);
                   NIX _ $VFPg.IX(NMA);
                 end |7|
                 else
                   NMP _ $ICBM.MemPg(NIX);
               end; |6|
             end; |5|
     
             LenLftTxt _ TRG - NxtChOfst;
             LenRgtTxt _ TTL - LenLftTxt;
     
             if (not InsertPage(NxtPg)) then
             begin |5|
               B!FlushToEDT;
               cfile(B!Chan);
               usererr("B!ForceGap: PPM full. Checkpoint File is intact.",
                   0, 0);
             end; |5|
           end; |4|
     
           NMP    _ $ICBM.MemPg($VFPg.IX(NMA));
           SWrd   _ WrdNo(NxtChOfst);
           Bias   _ ChrNo(NxtChOfst);
           WrdCnt _ WrdNo(TRG - 1) - SWrd + 1;
           DWrd   _ 0;
     
           Blt
           (
             Addrs(TMP, SWrd),
             Addrs(NMP, DWrd),
             WrdCnt
           );  
     
           $VFPg.LG(NMA) _ Bias;
           $VFPg.TL(NMA) _ LenRgtTxt;
           $VFPg.RG(NMA) _ LenRgtTxt + Bias;
           decr($VFPg.RG(TMA), LenRgtTxt);
           decr($VFPg.TL(TMA), LenRgtTxt);
         end; |3|
       end; |2|
     end "B!ForceGap"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 15-1
     Prt: 06-Jun-84  13:54                                        Rtn DeletePage

     
     ! Delete a page from the Virtual File.
     ;
     
     simple procedure DeletePage (integer Pg);
     begin "DeletePage" |1|
       integer
         DstAdr,                             ! Address of the destination
                                             ! region.
                                             ;
         I,                                  ! Iteration index over ICB
                                             ! entries.
                                             ;
         SrcAdr,                             ! Address of the source region.
                                             ;
         SrcLen,                             ! Length in words of the source
                                             ! region.
                                             ;
         T;                                  ! Temp for keeping the ICB index
                                             ! of Pg.
                                             ;
     
       if (0 <= Pg <= B!MaxPgIdx) then
       begin |2|
         ! Pg is not out of range.
         ;
     
         pmap(-1, !CPg($VFPg.ChkPg(Pg)), 0);
     
           ! Delete the Checkpoint file page corresponding to this Virtual
           ! File page.
           ;
     
         $ICBM.VFPg(T _ $VFPg.ICBIdx(Pg)) _ -1;
         $ICBM.MissCnt(T) _ largeinteger;
     
           ! Mark the page as availible in the ICB.
           ;
     
         DstAdr _ $VFPg.Adr(Pg);
         SrcAdr _ DstAdr + PPMWordsPerEntry;
         SrcLen _ (B!MaxPgIdx - Pg) * PPMWordsPerEntry;
         Blt(SrcAdr, DstAdr, SrcLen);
         decr(B!MaxPgIdx);
     
           ! Remove the entry for Pg by closing the PPM down.
           ;
     
         for I _ 0 step 1 until MaxICBMIdx do
           if ($ICBM.VFPg(I) > Pg) then
             decr($ICBM.VFPg(I));
     
           ! Adjust Virtual File page links in the ICBM.
           ;
       end; |2|
     end "DeletePage"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 16-1
     Prt: 06-Jun-84  13:54                                   Rtn B!WriteTextFile

     
     ! Write the contents of the Buffer to a new incarnation of the specified
     ! Text file.  Return true if successful.  This routine doesn't delete or
     ! close the Checkpoint file.
     ;
     
     forward internal simple procedure B!SetP (integer Pt);
     forward internal simple procedure B!Insert (integer Chr);
     
     internal simple boolean procedure B!WriteTextFile (string FName);
     begin "B!WriteTextFile" |1|
       integer
         DPtr,                               ! Destination byte pointer
                                             ;
         F!Chan,                             ! Text File channel.
                                             ;
         SavePt,                             ! Remember our location.
                                             ;
         SPtr;                               ! Source byte pointer.
                                             ;
     
       SavePt _ B!GetP;
       B!SetP(B!Size);
       B!Insert(null);
       B!Insert(null);
       B!Insert(null);
       B!Insert(null);
     
         ! Put 4 nulls at the end of the file in order to sanitize the last
         ! word.
         ;
     
       F!Chan _ openfile(FName, "WE");
     
       if (!skip!) then
       begin |2|
         DoErStr;
         return(false);
       end; |2|
     
       EvictICBFromMemory;
     
       ! Flush the contents of the ICB to disk.
       ;
     
       begin |2|
         ! Perform the write by garbage collecting gaps on the fly and mapping
         ! packed pages to the Text file.
         ;
     
         integer
           DPg,                              ! Destination (Text) file page
                                             ! number.
                                             ;
           DPgCnt,                           ! The count of actual output file
                                             ! pages. 
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 16-2
     Prt: 06-Jun-84  13:54                                   Rtn B!WriteTextFile

                                             ;
           Fill1,                            ! The first page of the fill
                                             ! area.
                                             ;
           Fill1Adr,                         ! The address of the same.
                                             ;
           Fill2,                            ! The second page of the fill
                                             ! area.
                                             ;
           Fill2Adr,                         ! The address of the same.
                                             ;
           FillLength,                       ! Length in bytes of the text in
                                             ! the fill area.
                                             ;
           I,                                ! Iterates over Virtual File
                                             ! pages.
                                             ;
           Src;                              ! Memory page into which pages
                                             ! are mapped.
                                             ;
     
     
         DPgCnt     _
         FillLength _ 0;
     
         Src        _ $ICBM.MemPg(0);
         Fill1      _ $ICBM.MemPg(1);
         Fill2      _ $ICBM.MemPg(2);
     
         Fill1Adr   _ Addrs(Fill1);
         Fill2Adr   _ Addrs(Fill2);
     
         DPg        _ ffffp(F!Chan);
     
         for I _ 0 step 1 until B!MaxPgIdx do
         begin |3|
           ! For each page in the Virtual File.
           ;
     
           pmap(!CPg($VFPg.ChkPg(I)), !MPg(Src), !Rd!);
     
             ! Map Virtual File page I to memory, with read access.
             ;
     
           SPtr _ BldMemPtr(Src, $VFPg.LftGap(I));
           DPtr _ BldMemPtr(Fill1, FillLength);
     
           MoveBytes(SPtr, DPtr, $VFPg.TxtLen(I));
     
             ! Move text into the fill area.
             ;
     
           pmap(-1, !MPg(Src), 0);
     
             ! Unmap the Checkpoint file page.
             ;
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 16-3
     Prt: 06-Jun-84  13:54                                   Rtn B!WriteTextFile

     
           incr(FillLength, $VFPg.TxtLen(I));
     
           if (FillLength >= CharactersPerPage) then
           begin |4|
             incr(DPgCnt);
     
               ! Bump the output file page count
               ;
     
             pmap(!MPg(Fill1), !TPg(DPg), !RdWt!);
     
               ! Map a packed page to the Text file, and delete the page from
               ! memory.
               ;
     
             decr(FillLength, CharactersPerPage);
             Blt(Fill2Adr, Fill1Adr, ceiling(FillLength, CharactersPerWord));
             DPg _ ffffp(F!Chan);
           end; |4|
         end; |3|
     
         if (FillLength) then
         begin |3|
           incr(DPgCnt);
     
             ! Bump the output file page count.
             ;
     
           pmap(!MPg(Fill1), !TPg(DPg), !RdWt!);
     
             ! Map the last little bit to the Text file.
             ;
         end; |3|
     
         decr(B!Size, 4);
     
           ! Remove the nulls we inserted before from the character count.
           ;
     
         closf(F!Chan);
     
           ! Close the Text file, but do not release the Jfn.
           ;
     
         chfdb(F!Chan, '11, bit(!mask(6), 11), bit(7, 11));
     
           ! Set byte size to 7 bits.
           ;
     
         chfdb(F!Chan, '12, !mask(36), B!Size);
     
           ! Set character count to the appropriate value.
           ! <<  This will have trouble on very large files (for which the
           !     number of pages = 13,421,773).
           ;
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 16-4
     Prt: 06-Jun-84  13:54                                   Rtn B!WriteTextFile

     
         rljfn(F!Chan);
     
           ! Release the Jfn on the Text file.
           ;
       end; |2|
     
       B!SetP(SavePt);
     
         ! Restore the point.
         ;
     
       return(true);
     end "B!WriteTextFile"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 17-1
     Prt: 06-Jun-84  13:54                                    Rtn CheckForSeqNos

     
     ! Check to see if the first word of the specified page is a sequence
     ! number according to the classic SOS convention.
     !
     !     The classic SOS convention defines a line sequence number as a word
     !     with bit 35 set containing 5 ASCII decimal numerals, followed by a
     !     tab as the first character of the next word.  Because of the
     !     word-aligned character of the line sequence number, the previous
     !     word will contain up to 4 nulls.
     ;
     
     simple boolean procedure CheckForSeqNos (integer MemPg);
     begin "CheckForSeqNos" |1|
       integer
         C,                                  ! A character temporary.
                                             ;
         I,                                  ! A character index iterator.
                                             ;
         W;                                  ! A word in which we look for
                                             ! sequence numbers.
                                             ;
       W _ memory[Addrs(MemPg)];
     
       if (W land bit(35)) then
       begin |2|
         W _ W lsh -1;
     
         for I _ 1 step 1 until CharactersPerWord do
         begin |3|
           C _ W land !mask(7);
     
           if (C < "0" or C > "9") then
             return(false);
     
           W _ W lsh -7;
         end; |3|
     
         W _ memory[Addrs(MemPg, 1)];
     
         if (W lsh -((CharactersPerWord - 1) * 7 + 1) neq TAB) then
           return(false);
     
         return(true);
       end |2|
       else
         return(false);
     end "CheckForSeqNos"; |1|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 18-1
     Prt: 06-Jun-84  13:54                                     Rtn CheckForNulls

     
     ! Check to see if the specified text page contains any nulls.
     ;
     
     simple boolean procedure CheckForNulls (integer MemPg, ByteCnt);
     begin "CheckForNulls" |1|
       integer
         BC,                                 ! A byte-count variable.
                                             ;
         I,                                  ! A fun variable.
                                             ;
         W,                                  ! A word in which we look for
                                             ! nulls.
                                             ;
         WC,                                 ! A word-count variable.
                                             ;
         Wrd;                                ! A word index iterator.
                                             ;
     
       define
         IsNull (W, X) =
             {(not ((!mask(7) lsh |2|
             ((CharactersPerWord - 1 - X) * 7 + 1)) land W))};
     
           ! This thing selects the Xth byte (in [0, 4]) from a word of ASCII
           ! characters, but does not bother to right-justify it.
           ;
     
     
       if (ByteCnt <= 0) then
         return(false);
     
       WC  _ WrdNo(ByteCnt - 1);
       BC  _ ChrNo(ByteCnt - 1);
       Wrd _ Addrs(MemPg);
     
       for I _ 0 step 1 until (WC - 1) do
       begin |3|
         W _ memory[Wrd];
     
         if (IsNull(W, 0) or IsNull(W, 1) or IsNull(W, 2) or IsNull(W, 3) or
             IsNull(W, 4)) then
           return(true);
     
         incr(Wrd);
       end; |3|
     
       W _ memory[Wrd];
     
       for I _ 0 step 1 until BC do
       begin |3|
         if (IsNull(W, I)) then
           return(true);
       end; |3|
     
       return(false);
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 18-2
     Prt: 06-Jun-84  13:54                                     Rtn CheckForNulls

     end "CheckForNulls"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 19-1
     Prt: 06-Jun-84  13:54                                    Rtn InitPPMandICBM

     
     ! Initialize the buffer to virgin condition.  This must take place after
     ! the Checkpoint file has been opened and the pages in question mapped
     ! from the Checkpoint file to the appropriate memory pages.  It is done
     ! (obviously) for each new Buffer that we create.
     ;
     
     simple procedure InitPPMandICBM;
     begin "InitPPMandICBM" |2|
       integer
         I,                                  ! Random iterator.
                                             ;
         ICBBas;                             ! Base address of the In-Core
                                             ! Buffer.
                                             ;
     
       ICBBas _ PgNo(ICB);
     
       for I _ 0 step 1 until MaxPPMIdx do
       begin |3|
         $VFPg.TxtLen(I) _
         $VFPg.LftGap(I) _
         $VFPg.RgtGap(I) _ 0;
         $VFPg.ChkPg(I)  _
         $VFPg.ICBIdx(I) _ -1;
       end; |3|
     
         ! Initialize all PPM entries to an empty state.
         ;
     
       for I _ 0 step 1 until MaxICBMIdx do
       begin |3|
         $ICBM.MemPg(I)   _ ICBBas + I;
         $ICBM.VFPg(I)    _ -1;
         $ICBM.MissCnt(I) _ largeinteger;
       end; |3|
     
         ! Establish the physical memory location and mark the emptiness of
         ! each ICB page.
         ;
     end "InitPPMandICBM"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 20-1
     Prt: 06-Jun-84  13:54                                       Rtn SqueezeText

     
     ! Copy text from the input memory page to the output memory page,
     ! removing sequence numbers and nulls as indicated.  Return the actual
     ! length of the resulting text page.
     ;
     
     simple integer procedure SqueezeText (integer InMemPg, OutMemPg, ChLen;
         boolean RemoveNulls, HasSeqNos);
     begin "SqueezeText" |2|
       integer
         C,                          ! A character temporary.
                                     ;
         InPtr,                      ! Pointer to the character to be
                                     ! read.
                                     ;
         InByteIdx,                  ! Byte index of the character
                                     ! being read.
                                     ;
         OutByteIdx,                 ! Byte index of the character
                                     ! being output.
                                     ;
         OutPtr;                     ! Pointer to the character
                                     ! position to be written.
                                     ;
     
     
       InPtr  _ BldMemPtr(InMemPg, 0);
       OutPtr _ BldMemPtr(OutMemPg, 0);
     
       OutByteIdx _ 
       InByteIdx  _ 0;
     
       while (ChLen) do
       begin |3|
         ! For each character on the page.
         ;
     
         if (HasSeqNos and
             (ChrNo(InByteIdx) = 0) and
             memory[Addrs(InMemPg) + WrdNo(InByteIdx)] land bit(35)) then
         begin |4|
           ! The current input word contains a sequence number.
           ;
     
           ibp(InPtr);
           ibp(InPtr);
           ibp(InPtr);
           ibp(InPtr);
           ibp(InPtr);
           ibp(InPtr);
     
           incr(InByteIdx, 6);
           decr(ChLen, 6);
     
           if (not RemoveNulls and OutByteIdx > 0) then
           begin |5|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 20-2
     Prt: 06-Jun-84  13:54                                       Rtn SqueezeText

             ! We need to remove nulls that preceed the
             ! sequence-number word.
             ;
     
             OutPtr _ DecrBP(OutPtr);
             decr(OutByteIdx);
     
             while (OutByteIdx > 0 and not (C _ ldb(OutPtr))) do
             begin |6|
               OutPtr _ DecrBP(OutPtr);
               decr(OutByteIdx);
             end; |6|
     
             if (C) then
             begin |6|
               ibp(OutPtr);
               incr(OutByteIdx);
             end; |6|
           end; |5|
         end |4|
         else
         begin |4|
           ! Process an individual character.
           ;
     
           if ((C _ ldb(InPtr)) or not RemoveNulls) then
           begin |5|
             dpb(C, OutPtr);
             ibp(OutPtr);
             incr(OutByteIdx);
           end; |5|
     
           ibp(InPtr);
           decr(ChLen);
           incr(InByteIdx);
         end; |4|
       end; |3|
     
       return(OutByteIdx + 1);
     end "SqueezeText"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 21-1
     Prt: 06-Jun-84  13:54                                    Rtn CountSomeNulls

     
     ! Count the number of nulls which may have been applied to the last word
     ! of the input file, to compensate for some filler which may have been
     ! put there by foreign agents.  Return the number of nulls discovered.
     ;
     
     simple integer procedure CountSomeNulls (integer Src, ChLen);
     begin "CountSomeNulls" |2|
       integer
         Ptr,                                ! A byte pointer with which to
                                             ! look around.
                                             ;
         I;                                  ! An index variable.
                                             ;
     
       if (ChrNo(ChLen) <= 0) then
         return(0)
       else
       begin |3|
         Ptr _ BldMemPtr(Src, ChLen);
         I   _ 0;
     
         while (I < CharactersPerWord and not ldb(Ptr)) do
         begin |4|
           Ptr _ DecrBp(Ptr);
           incr(I);
         end; |4|
     
         return(I);
       end; |3|
     end "CountSomeNulls"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 22-1
     Prt: 06-Jun-84  13:54                                             Rtn PgSiz

     
     ! Determine the size of this particular page, based upon whether it is
     ! the last page or not, and the original size in characters.
     ;
     
     simple integer procedure PgSiz (integer Pg, MaxPg, Size);
     begin "PgSiz" |2|
       return
       (
         if (Pg < MaxPg) then
           CharactersPerPage
         else
           ((Size - 1) mod CharactersPerPage + 1)
       );
     end "PgSiz"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 23-1
     Prt: 06-Jun-84  13:54                                Rtn B!CreateChkPntFile

     
     ! Create a new Checkpoint file, by adding a new Buffer to the Chain, and
     ! copying the contents of the specified Text file to the Checkpoint,
     ! removing line sequence numbers and/or nulls in the process, if
     ! necessary. 
     !
     ! Return true if a new Checkpoint was successfully created, and return
     ! false at the slightest hint of trouble.
     !
     ! Further, the caller should insure that a Buffer slot actually is
     ! availible before calling this routine, since it will die if one is
     ! not.
     !
     ! Note: The reason "ICBBase" works throughout this routine is a
     !       correspondence between the layouts of the giant array and the
     !       front section of the Checkpoint file.
     ;
     
     forward simple string procedure NameChkPntFile (integer BufNum);
     forward simple integer procedure GetFreeSlot;
     forward simple procedure PositionTo (integer Page, Line, Char);
     
     internal simple boolean procedure B!CreateChkPntFile
         (string TName, TAlias(null); integer TPage(0), TLine(0), TChar(0));
     begin "B!CreateChkPntFile" |2|
       boolean
         FileEmpty,                          ! True if the Text file is
                                             ! empty, either because it has
                                             ! no text in it, or because it
                                             ! does not exist.
                                             ;
         FileNonExistent;                    ! True iff Text file does not
                                             ! exist.
                                             ;
       integer
         BufNum,                             ! The index of the new Buffer in
                                             ! the Buffer Chain.
                                             ;
         F!Chan,                             ! The channel number of the Text
                                             ! file.
                                             ;
         NextHole,                           ! The page index of the next hole
                                             ! in the Text file.
                                             ;
         InMemAdr,                           ! Address of a memory page we use
                                             ! for moving text from the Text
                                             ! file to the Checkpoint file.
                                             ;
         InMemPg;                            ! Page number of a memory page we
                                             ! use for moving text from the
                                             ! Text file to the Checkpoint
                                             ! file.
                                             ;
     
     
       set(FileNonExistent, (not F!FileExists(TName)));
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 23-2
     Prt: 06-Jun-84  13:54                                Rtn B!CreateChkPntFile

       clear(FileEmpty);
     
       if (length(TName)) then
       begin |3|
         ! There is actually a file that we want to edit.
         ;
     
         integer
           Err;                              ! A copy of the error code
                                             ! returned in !skip!.
                                             ;
     
     
         if (FileNonExistent) then
           set(FileEmpty)
         else
         begin |4|
           F!Chan _ openfile(TName, "RE");
     
           if (Err _ !skip!) then
           begin |5|
             DoErStr;
             print("B!CreateChkPntFile: Open Error (", xwdstr(Err),
                 ") on TName = ", TName, crlf);
             return(false);
           end; |5|
     
           if (sizef(F!Chan) = 0) then
             set(FileEmpty);
     
           begin |5|
             ! Gather interesting information about the file for later use.
             ! Stuff into meaningful globals.
             ;
     
             B!MaxPgIdx _ sizef(F!Chan) - 1;
             B!Size     _ chsizef(F!Chan);
           end; |5|
     
           if ((NextHole _ ffffp(F!Chan, 0)) neq sizef(F!Chan)) then
           begin |5|
             ! Text file has holes (The first free file page should be the
             ! first page beyond the end of the file).
             ;
     
             if (not C!Ask("Text file has holes.  Ignore them? ")) then
               return(false);
           end; |5|
         end; |4|
       end |3|
       else
       begin |3|
         set(FileEmpty);
         B!Size     _
         B!MaxPgIdx _ 0;
     
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 23-3
     Prt: 06-Jun-84  13:54                                Rtn B!CreateChkPntFile

           ! This is the extent of the Checkpoint File.
           ;
       end; |3|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     
       B!ChkPntFile _ NameChkPntFile(BufNum _ GetFreeSlot);
       B!Chan       _ openfile(B!ChkPntFile, "RWNE");
     
         ! <<  Should do "open-close-open" on the same Jfn to establish the
         !     "legitimacy" of the Checkpoint file with the Monitor.
         !     Otherwise, if the system goes down, all is lost.
         ;
     
       if (!skip!) then
       begin |3|
         ! An error was detected while opening the Checkpoint file.
         ;
     
         ! <<  If the error is (file exists), then we should handle it as
         !     follows:
         !
         !       Prompt for
         !         1) Use existing file or
         !         2) Delete existing file
         ;
     
         print("B!CreateChkPntFile: Open Error on B!ChkPntFile = ",
             B!ChkPntFile, crlf);
         exit;
       end; |3|
     
       W!SetB(BufNum);
     
         ! Notify the Window module of the identity of the current buffer.
         ;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       pmap(!CPg(0), !MPg(GiantBase), (!RdWt! lor !Count!(ICBBase)));
     
         ! Map the Header, the ICBM, the PPM, and the EDT pages into the
         ! beginning of the Checkpoint file, with read/write access.
         ;
     
       InitPPMandICBM;
     
         ! Initialize PPM and ICB.
         ;
     
       SetupHeaderAndEDT(TName, TAlias);
     
         ! Instantiate all values in the Header and EDT portions of the giant
         ! array.
         ;
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 23-4
     Prt: 06-Jun-84  13:54                                Rtn B!CreateChkPntFile

     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       InMemPg  _ $ICBM.MemPg(0);
       InMemAdr _ Addrs(InMemPg);
     
       if (FileEmpty) then
       begin |3|
         pmap(!CPg(ICBBase), !MPg(InMemPg), !RdWt!);
         memory[InMemAdr] _ 0;
     
           ! Map the first page in the ICB to the first (empty) data page in
           ! the Checkpoint file.
           ;
     
         $VFPg.LftGap(0) _
         $VFPg.TxtLen(0) _
         $VFPg.RgtGap(0) _
         $VFPg.ICBIdx(0) _ 0;
         $VFPg.ChkPg(0)  _ ICBBase;
     
         B!Size          _
         B!MaxPgIdx      _ 0;
     
           ! Setup the PPM entry for the first Virtual File page.
           ;
       end |3|
       else
       begin |3|
         ! Copy the contents of the Text file to the Checkpoint file, worrying
         ! if necessary about removing line sequence numbers and nulls in the
         ! process.
         ;
     
         boolean
           HasNulls,                         ! Indicate that nulls have been
                                             ! detected in this Text file.
                                             ;
           HasSeqNos;                        ! Indicate that this Text file
                                             ! contains sequence numbers.
                                             ;
     
         integer
           TxtFPg,                           ! Page index into the Text file.
                                             ;
           ChkFPg,                           ! Page index into the Checkpoint
                                             ! file.
                                             ;
           OutMemPg,                         ! Memory page out of which text
                                             ! is mapped to the Checkpoint
                                             ! file.
                                             ;
           ActLen;                           ! The actual length of the
                                             ! current Checkpoint File page.
                                             ;
     
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 23-5
     Prt: 06-Jun-84  13:54                                Rtn B!CreateChkPntFile

     
         ChkFPg _ ICBBase - 1;
     
           ! This is 1 less than the correct value because it is incremented
           ! later on before it is used.
           ;
     
         OutMemPg _ InMemPg;
         clear(HasNulls);
         clear(HasSeqNos);
     
         begin |4|
           ! Map a page and check for sequence numbers.
           ;
     
           pmap(!TPg(0), !MPg(InMemPg), !Rd!);
     
             ! Map the first Text file page, with read-only access.
             ;
     
           HasSeqNos _ CheckForSeqNos(InMemPg);
     
           pmap(-1, !MPg(InMemPg), 0);
     
             ! Remove the page from memory.
             ;
         end; |4|
     
         if (HasSeqNos) then
           OutMemPg _ InMemPg + 1;
     
         for TxtFPg _ 0 step 1 until B!MaxPgIdx do
         begin |4|
           ! For each page TxtFPg in the Text file.
           ;
     
           ActLen _ 0;
     
           if (NextHole neq TxtFPg) then
           begin |5|
             ! The Virtual File page is not empty.
             ;
     
             integer
               ChLen;                        ! Length of the text region to be
                                             ! read.
                                             ;
     
             ChLen _ PgSiz(TxtFPg, B!MaxPgIdx, B!Size);
     
             incr(ChkFPg);
     
               ! Increment the Checkpoint file page index.
               ;
     
             pmap(!TPg(TxtFPg), !MPg(InMemPg), !Cow!);
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 23-6
     Prt: 06-Jun-84  13:54                                Rtn B!CreateChkPntFile

     
               ! Bring Text file page TxtFPg into memory, copy on write.
               ;
     
             if (TxtFPg = B!MaxPgIdx) then
             begin |6|
               integer
                 Cnt;
     
               decr(ChLen, (Cnt _ CountSomeNulls(InMemPg, ChLen - 1)));
               decr(B!Size, Cnt);
     
                 ! Ignore nulls which might have appeared at the end of the
                 ! file to pad the last word.
                 ;
             end; |6|
     
             if (not HasNulls) then
             begin |6|
               HasNulls _ CheckForNulls(InMemPg, ChLen);
     
               if (HasNulls) then
               begin |7|
     ifcr false thenc
       ! This is commented out for the benefit of Magnum hackers who need a
       ! version which runs more than they need nulls removed. 1.11.84
       ;
     
                 if (G!RNulls) then
                 begin |8|
                   print("Removing Nulls", crlf);
                   OutMemPg _ InMemPg + 1;
                 end |8|
                 else
     endc
                   print("Nulls Exist", crlf);
               end; |7|
             end; |6|
     
     ifcr false thenc
       ! This is commented out for the benefit of Magnum hackers who need a
       ! version which runs more than they need nulls removed. 1.11.84
       ;
     
             if (HasSeqNos or (HasNulls and G!RNulls)) then
             begin |6|
               ActLen _ SqueezeText(InMemPg, OutMemPg, ChLen, G!RNulls,
                   HasSeqNos);
     
                 ! Copy from the input page to the output page, removing
                 ! unsightly imperfections.
                 ;
     
               pmap(-1, !MPg(InMemPg), 0);
     
                 ! Remove the input memory page from memory.
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 23-7
     Prt: 06-Jun-84  13:54                                Rtn B!CreateChkPntFile

                 ;
             end |6|
             else
     endc
             begin |6|
               ! No sequence numbers or nulls to remove.
               ;
     
               ActLen _ ChLen;
     
                 ! Actually, we keep all characters.
                 ;
     
               memory[InMemAdr] _ memory[InMemAdr];
     
                 ! Touch the page to force copy-on-write to occur.
                 ;
             end; |6|
     
             pmap(!MPg(OutMemPg), !CPg(ChkFPg), 0);
     
               ! Map the output page to the proper place in the Checkpoint
               ! file, and delete the page from memory.
               ;
     
             $VFPg.TxtLen(TxtFPg) _
             $VFPg.RgtGap(TxtFPg) _ ActLen;
     
             $VFPg.LftGap(TxtFPg) _ 0;
             $VFPg.ChkPg(TxtFPg)  _ ChkFPg;
             $VFPg.ICBIdx(TxtFPg) _ -1;
     
               ! Create the PPM entry for this page.
               ;
           end |5|
           else
             ! The Text file page is empty.
             ;
     
             NextHole _ ffffp(F!Chan, TxtFPg + 1);
     
               ! Find the next hole in the Text file.
               ;
         end; |4|
       end; |3|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       if (FileEmpty) then
         $ICBM.MissCnt(0) _
         $ICBM.VFPg(0)    _ 0
       else
       begin |3|
         ! Text file is non-empty.  Instantiate the ICB with the Text file.
         ;
     
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 23-8
     Prt: 06-Jun-84  13:54                                Rtn B!CreateChkPntFile

         integer
           I;                                ! ICBM index iterator.
                                             ;
     
         for I _ 0 step 1 until MaxICBMIdx do
         begin |4|
           if ($VFPg.TxtLen(I)) then
           begin |5|
              pmap(!CPg($VFPg.ChkPg(I)), !MPg($ICBM.MemPg(I)), !RdWt!);
     
               ! Map the Ith Virtual File page to the Ith ICB Page, read/write
               ! access.
               ;
     
             $VFPg.ICBIdx(I)  _
             $ICBM.VFPg(I)    _ I;
             $ICBM.MissCnt(I) _ 0;
           end |5|
           else
             ! The Virtual File is shorter than the ICB.
             ;
     
             done;
         end; |4|
     
         PositionTo(TPage, TLine, TChar);
     
           ! Move the Point to the proper location.
           ;
       end; |3|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       if (length (TName) and (not FileNonExistent)) then
         cfile(F!Chan);
     
       return(true);
     end "B!CreateChkPntFile"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 24-1
     Prt: 06-Jun-84  13:54                             Rtn InitMappingStructures

     
     ! This is done once at module initialization time in order to establish
     ! our sense of direction.
     ;
     
     simple procedure InitMappingStructures;
     begin "InitMappingStructures" |2|
       integer
         BegOfIt,                            ! The beginning of the Giant Array.
                                             ;
         EndOfIt,                            ! The end of the Giant Array.
                                             ;
         GiantAdr;                           ! The address of the GiantBase.
                                             ;
     
       BegOfIt   _ location(GiantArray[0]);
       EndOfIt   _ location(GiantArray[(EndOfBuffer + 1) * WordsPerPage]);
       GiantBase _ ceiling(BegOfIt, WordsPerPage);
       GiantAdr  _ Addrs(GiantBase, 0);
     
       HEAD      _ GiantAdr + Addrs(HEADBase);
       ICBM      _ GiantAdr + Addrs(ICBMBase);
       PPM       _ GiantAdr + Addrs(PPMBase);
       EDT       _ GiantAdr + Addrs(EDTBase);
       ICB       _ GiantAdr + Addrs(ICBBase);
     
     !  print
       (
         "MaxPPMIdx:   ", MaxPPMIdx, crlf,
         "MaxICBMIdx:  ", MaxICBMIdx, crlf2,
     
         "GiantArray:  ", xwdstr(hl(BegOfIt) lor hr(EndOfIt)), crlf2,
     
         "HEAD:        ", xwdstr(hl(HEAD) lor hr(HEAD + Addrs(HEADSize) - 1)), |
                                                                       ->|crlf,|
         "ICBM:        ", xwdstr(hl(ICBM) lor hr(ICBM + Addrs(ICBMSize) - 1)), |
                                                                       ->|crlf,|
         "PPM:         ", xwdstr(hl(PPM) lor hr(PPM + Addrs(PPMSize) - 1)), crl|
                                                                          ->|f,|
         "EDT:         ", xwdstr(hl(EDT) lor hr(EDT + Addrs(EDTSize) - 1)), crl|
                                                                          ->|f,|
         "ICB:         ", xwdstr(hl(ICB) lor hr(ICB + Addrs(ICBSize) - 1)), crl|
                                                                          ->|f2|
       );
     
       B!MaxPgIdx _
       B!Size     _
       B!Point    _ 0;
     
         ! Initialize critical variables.
         ;
     end "InitMappingStructures"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 25-1
     Prt: 06-Jun-84  13:54                                         Rtn InitChain

     
     ! Initialize the Buffer Chain by grounding the active list pointer and
     ! linking all Buffers into the free list.
     ;
     
     simple procedure InitChain;
     begin "InitChain" |2|
       own integer
         I;
     
       B!!Head  _
       B!!List  _ 0;
     
         ! There are no buffers on the active list.
         ;
     
       B!!Free  _ 1;
     
       for I _ 1 step 1 until BUFMAX - 1 do
         B!!Next[I] _ I + 1;
     
       B!!Next[BUFMAX] _ 0;
     
         ! Link all buffers into the free list.
         ;
     end "InitChain"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 26-1
     Prt: 06-Jun-84  13:54                                            Rtn B!Init

     
     ! Perform a pre-dawn initialization of the Buffer Module.
     ;
     
     simple procedure B!Init;
     begin "B!Init" |2|
       InitChain;
       InitMappingStructures;
     end "B!Init"; |2|
     require B!Init initialization;
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 27-1
     Prt: 06-Jun-84  13:54                                        Rtn PositionTo

     
     ! Move the Point to the specified text page, line and character position.
     ;
     
     forward internal simple integer procedure B!GetC;
     forward internal simple procedure B!Move(integer Dir);
     
     simple procedure PositionTo (integer Page, Line, Char);
     begin "PositionTo" |2|
       B!SetP(0);
     
       decr(Page);
     
       while (Page > 0) do
       begin |3|
         if (B!EndP) then
           done;
     
         if (B!GetC = FF) then
           decr(Page);
     
         B!Move(FORWARDS);
       end; |3|
     
       decr(Line);
     
       while (Line > 0) do
       begin |3|
         if (B!EndP) then
           done;
     
         if (B!GetC = LF) then
           decr(Line);
     
         B!Move(FORWARDS);
       end; |3|
     
       decr(Char);
     
       while (Char > 0) do
       begin |3|
         if (B!EndP) then
           done;
     
         decr(Char);
         B!Move(FORWARDS);
       end; |3|
     end "PositionTo"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 28-1
     Prt: 06-Jun-84  13:54                                       Rtn GetFreeSlot

     
     ! Remove a Buffer slot from the free list, and add it to the Chain.  We
     ! assume that the caller has insured that there is a slot availible.
     ;
     
     simple integer procedure GetFreeSlot;
     begin "GetFreeSlot" |2|
       integer
         Next;                               ! Next free slot
                                             ;
     
       if (B!!Free = 0) then
         ! We are out of slots.  This shouldn't happen at this point, since
         ! the caller should have checked to see if there were any slots
         ! availible before calling.  Hence, we die.
         ;
     
         ! << This is an ugly requirement, a throwback to DWS code. We should
         !     really return -1.
         ;
     
         usererr(0, 0, "Out of Chain slots in GetFreeSlot.");
     
       Next    _ B!!Free;
       B!!Free _ B!!Next[B!!Free];
     
       if (B!!List = 0) then
       begin |3|
         ! Pick up the first Buffer slot.
         ;
     
         B!!List       _
         B!!Head       _ Next;
         B!!Next[Next] _
         B!!Last[Next] _ 0;
       end |3|
       else
       begin |3|
         ! At least 1 Buffer already exists.
         ;
         B!!Next[Next] _ B!!Next[B!!List];
         B!!Last[Next] _ B!!List;
     
         if (B!!Next[B!!List] neq 0) then
           B!!Last[B!!Next[B!!List]] _ Next;
     
         B!!Next[B!!List] _ Next;
         B!!List          _ Next;
       end; |3|
     
       return(B!!List);
     end "GetFreeSlot"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 29-1
     Prt: 06-Jun-84  13:54                                           Rtn B!FreeP

     
     ! Routine to tell us if we have any free buffers left.
     ;
     
       internal simple boolean procedure B!FreeP;
         return(B!!Free neq null);
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 30-1
     Prt: 06-Jun-84  13:54                                    Rtn NameChkPntFile

     
     ! Return the name of the Checkpoint file corresponding to the specified
     ! Buffer. 
     ;
     
     simple string procedure NameChkPntFile (integer BufNum);
     begin "NameChkPntFile" |2|
       return
       (
         cvs(1000 + call(0, "Pjob"))[2 for 3] &
         DED!Alias[1 for 3] &
         "." &
         cvs(1000 + BufNum)[2 for 3]
       );
     end "NameChkPntFile"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 31-1
     Prt: 06-Jun-84  13:54                                      Rtn B!FlushToEDT

     
     ! Flush information that we keep in static locations back into the EDT
     ! area of the Checkpoint file.
     ;
     
     internal simple procedure B!FlushToEDT;
     begin "B!FlushToEDT" |2|
       integer
         I;                          ! Loop variable.
                                     ;
     
       for I _ EDT step 1 until (EDT + (EDTSize * WordsPerPage) - 1) do
         memory[I] _ 0;
     
         ! Zero the EDT area.
         ;
     
       B!!Alias[B!!List]      _ B!Alias;
       B!!ChkPntFile[B!!List] _ B!ChkPntFile;
       B!!File[B!!List]       _ B!File;
       B!!Mode[B!!List]       _ B!Mode;
       B!!ModP[B!!List]       _ B!ModP;
     
         ! Keep the Magnum Alias, Checkpoint file name, Text file name, edit
         ! mode(s) and modification status around constantly as we edit.
         ;
     
       !B!EdName  _ cvasc("Peak!");
       !B!DedVer  _ B!DedVer;
       !B!CkPtSer _ B!CkPtSer _ B!CkPtSer + 1;
       !B!BufNum  _ B!!List;
     
         ! Preserve the name and version number of the current Editor (!), the
         ! new Checkpoint file serial number and location in the Buffer Chain
         ! for posterity.  
         ;
         
       !B!Point _ B!Point;
       !B!WS0   _ B!WS0;
       !B!WS1   _ B!WS1;
     
         ! Preserve our own marks.
         ;
     
       !B!Size  _ B!Size;
       !B!ModP  _ B!ModP;
       !B!Lock  _ B!Lock;
       !B!Prot  _ B!Prot;
     
         ! Preserve miscellaneous quantities of enduring interest to those
         ! who care.
         ;
     
       !B!Mode1 _ cvasc(B!Mode[1 for 5]);
       !B!Mode2 _ cvasc(B!Mode[6 for 5]);
     
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 31-2
     Prt: 06-Jun-84  13:54                                      Rtn B!FlushToEDT

         ! Decompose the mode string and preserve its constituent parts.
         ;
     
       !B!File1  _ cvasc(B!File[1 for 5]);
       !B!File2  _ cvasc(B!File[6 for 5]);
       !B!File3  _ cvasc(B!File[11 for 5]);
       !B!File4  _ cvasc(B!File[16 for 5]);
       !B!File5  _ cvasc(B!File[21 for 5]);
     
         ! Decompose the Text file name and preserve its constituent parts.
         ;
     
       !B!Alias1 _ cvasc(B!Alias[1 for 5]);
       !B!Alias2 _ cvasc(B!Alias[6 for 5]);
       !B!Alias3 _ cvasc(B!Alias[11 for 5]);
       !B!Alias4 _ cvasc(B!Alias[16 for 5]);
       !B!Alias5 _ cvasc(B!Alias[21 for 5]);
       !B!Alias6 _ cvasc(B!Alias[26 for 5]);
       !B!Alias7 _ cvasc(B!Alias[31 for 5]);
     
         ! Decompose the Magnum Alias and preserve its constituent parts.
         ;
     
       !B!MarkCnt _ MarkCnt;
     
       for I _ 0 step 1 until MaxMarks - 1 do
         memory[location(!B!Marks) + I] _ Marks[I];
     
         ! Preserve all Marks.
         ;
     
       !B!LstWrd _ cvasc(">>>>>");
     end "B!FlushToEDT"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 32-1
     Prt: 06-Jun-84  13:54                                  Rtn B!RestoreFromEDT

     
     ! Restore information that we keep in static locations from the EDT area
     ! of the Checkpoint file.
     !
     ! (Note that nothing special is done with !B!BufNum at this point.  Its
     ! significance emerges when we are recovering Checkpoint files on
     ! command, where we expect usurpation of the existing order to take
     ! place.)
     ;
     
     internal simple procedure B!RestoreFromEDT;
     begin "B!RestoreFromEDT" |2|
       integer
         I;
     
       B!CkPtSer _ !B!CkPtSer;
     
         ! Recover the Checkpoint file serial number from the EDT area.
         ;
     
       B!Point _ !B!Point;
       B!WS0   _ !B!WS0;
       B!WS1   _ !B!WS1;
     
         ! Recover our own marks.
         ;
     
       B!Size _ !B!Size;
       B!ModP _ !B!ModP;
       B!Lock _ !B!Lock;
       B!Prot _ !B!Prot;
     
         ! Recover miscellaneous quantities of enduring interest to those
         ! who care.
         ;
     
       B!Mode _ cvastr(!B!Mode1) & cvastr(!B!Mode2);
       
       set(G!TextMode, kequ(B!Mode[1 for 4], "Text"));
     
         ! Recreate the mode string from its constituent parts.
         ;
     
       B!File _
           cvastr(!B!File1) &
           cvastr(!B!File2) &
           cvastr(!B!File3) &
           cvastr(!B!File4) &
           cvastr(!B!File5);
     
         ! Recreate the Text file name from its constituent parts.
         ;
     
       B!Alias _
           cvastr(!B!Alias1) &
           cvastr(!B!Alias2) &
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 32-2
     Prt: 06-Jun-84  13:54                                  Rtn B!RestoreFromEDT

           cvastr(!B!Alias3) &
           cvastr(!B!Alias4) &
           cvastr(!B!Alias5) &
           cvastr(!B!Alias6) &
           cvastr(!B!Alias7);
     
         ! Recreate the Magnum Alias from its constituent parts.
         ;
     
       B!!Alias[B!!List] _ B!Alias;
       B!!File[B!!List]  _ B!File;
       B!!Mode[B!!List]  _ B!Mode;
       B!!ModP[B!!List]  _ B!ModP;
     
         ! Restore the Magnum Alias, Text file name, edit mode(s) and
         ! modification status from the archives.
         ;
     
       MarkCnt _ !B!MarkCnt;
     
       for I _ 0 step 1 until MaxMarks - 1 do
         Marks[I] _ memory[location(!B!Marks) + I];
     
         ! Restore our Marks structure.
         ;
     
       if (!B!DedVer neq B!DedVer) then
       begin |3|
         W!Msg("B!RestoreFromEDT: Editor versions disagree! " &
             "Checkpoint: " & xwdstr(!B!DedVer) & ", " &
             "Editor: " & xwdstr(B!DedVer));
     
         exit;
     
           ! <<  This is a terrible hack!
           ;
       end; |3|
     end "B!RestoreFromEDT"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XXBUF1.REQ                          Page 33-1
     Prt: 06-Jun-84  13:54                                   Rtn B!RestoreChkPnt

     
     ! Routine to reset the static definitions from a descriptor.
     !
     !                       (Formerly called B!Restore.)
     ;
     
     internal simple procedure B!RestoreChkPnt (string Bfr);
     begin "B!RestoreChkPnt" |2|
       B!Chan _ openfile(Bfr, "RWE");
         ! <<  Make sure that B!Chan is not already in use.
         ;
     
       pmap(!CPg(0), !MPg(GiantBase), (!RdWt! lor !Count!(HeadSize)));
     
         ! Map the Header from the Checkpoint file.
         ;
         ;
     
       if ($H$DedVer = B!DedVer) then
       begin |3|
         pmap(!Cpg(HeadSize), !MPg(GiantBase + HeadSize),
             (!RdWt! lor !Count!(EndOfBuffer - (HeadSize + 1))));
     
           ! Map the ICBM, the PPM, the EDT pages and ICB from the beginning
           ! of the Checkpoint file, with read/write access.
     
         B!RestoreFromEDT;
       end |3|
       else
       begin |3|
         T!Bell;
         W!Msg("Editor versions disagree");
       end; |3|
     end "B!RestoreChkPnt"; |2|
     
     
     ! **************************  End XxBuf1.Req  *************************** ;





                                                
                                                
                                                
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                                
                                                
                                                



                                                            
                                                            
                                                            
                              
                              
                              
                        
                        
                        
                                          
                                          
                                          
                        
                        
                        
                        
                        
                        
                                                                  
                                                                  
                                                                  




                              
                
               
                       
                
                 
                               

     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                           Page 1-1
     Prt: 06-Jun-84  13:54                    Part Two of Tops-20 Buffer Sources

     
     ! *************************************************************************
     *                                                                         *
     *                               XxBuf2.Req                                *
     *                                                                         *
     *             The Buffer/Checkpoint manager.  Tops20 version.             *
     *                       Ken Dawson   25-August-1983                       *
     *                                                                         *
     **************************************************************************;
     
     ! These routines are not particularly homogeneous, taken as a whole, but
     ! they fit into a smaller space than they did before.
     ;
     
     ! ----------------------------------------------------------------------- ;
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                           Page 2-1
     Prt: 06-Jun-84  13:54                                          Rtn B!CKFile

     
     ! Recover from a Checkpoint file by hand, destroying the current
     ! Checkpoint in the process.  (This routine is the exclusive province of
     ! the Recover Checkpoint command.)
     ;
     
     forward internal simple procedure B!DelCurrentBuffer;
     
     internal simple procedure B!CKFile (string ChkPntName);
     begin "B!CKFile" |1|
       if (F!FileExists(ChkPntName)) then
       begin |2|
         B!DelCurrentBuffer;
         B!RestoreChkPnt(ChkPntName);
         W!Msg("Restore Complete");
       end |2|
       else
       begin |2|
         W!Msg("Checkpoint File (" & ChkPntName & ") does not exist.");
         T!Bell;
       end; |2|
     end "B!CKFile"; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                           Page 3-1
     Prt: 06-Jun-84  13:54                                Rtn B!DelCurrentBuffer

     
     ! Delete the Checkpoint file, remove the current Buffer from the Chain,
     ! add it to the free list and reset the current Buffer to the next Buffer
     ! to the right if possible (or to the left if not).
     ! Formerly called B!Kill.
     ;
     
     internal simple procedure B!DelCurrentBuffer;
     begin "B!DelCurrentBuffer" |1|
       own integer
         I,
         Next;
     
       for I _ GiantBase step 1 until (GiantBase + (EndOfBuffer - 1)) do
       begin |2|
         ! For each memory page mapped to the Checkpoint file.
         ;
     
         pmap(-1, !MPg(I), 0);
     
           ! Remove the page from memory
           ;
       end; |2|
     
       closf(B!Chan);
       delf(B!Chan);
       rljfn(B!Chan);
     
         ! Close and delete the Checkpoint file.
         ;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       if (B!!Head = B!!List) then B!!Head _ B!!Next[B!!List];
     
       if (B!!Next[B!!List]) then
       begin |2|
         Next _ B!!Next[B!!List];
         B!!Last[Next] _ B!!Last[B!!List];
     
         if (B!!Last[B!!List] neq 0) then
           B!!Next[B!!Last[B!!List]] _ Next;
       end |2|
       else if (B!!Last[B!!List]) then
       begin |2|
         Next _ B!!Last[B!!List];
         B!!Next[Next] _ B!!Next[B!!List];
       end |2|
       else
         Next _ 0;   ! into the void ... ;
     
       B!!Next[B!!List] _ B!!Free;
       B!!Free _ B!!List;
       B!!List _ Next;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                           Page 3-2
     Prt: 06-Jun-84  13:54                                Rtn B!DelCurrentBuffer

     
       if (B!!List) then
         B!RestoreChkPnt(B!!ChkPntFile[B!!List]);
     
       W!SetB(B!!List);
     end "B!DelCurrentBuffer"; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                           Page 4-1
     Prt: 06-Jun-84  13:54                                            Rtn B!SetB

     
     ! Routine to position to a specified buffer ;
     
     forward internal simple procedure B!CheckPoint (boolean Close);
     
     internal simple procedure B!SetB(integer BufNum);
     begin |1|
       define
         Close = {true};                     ! Close the Checkpoint file. 
                                             ;
     
       if (BufNum = B!!List) then
         return;
     
       B!CheckPoint(Close);
       B!!List _ BufNum;
       W!SetB(BufNum);
       B!RestoreChkPnt(B!!ChkPntFile[BufNum]);
       W!NewS;
     end; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                           Page 5-1
     Prt: 06-Jun-84  13:54                                            Rtn B!Step

     
     ! Routine to step forwards or backwards along the buffer chain ;
     
     internal simple procedure B!Step(integer Dir);
     begin |1|
       define
         Close = {true};                     ! Close the Checkpoint file. 
                                             ;
     
       if (Dir = FORWARDS) then
       begin |2|
         if (B!!Next[B!!List] neq null) then
         begin |3|
           B!CheckPoint(Close);
           B!!List _ B!!Next[B!!List];
           W!SetB(B!!List);
           B!RestoreChkPnt(B!!ChkPntFile[B!!List]);
           W!NewS;
         end |3|
         else
           W!Msg("No buffers left >");
       end |2|
       else if (Dir = BACKWARDS) then
       begin |2|
         if (B!!Last[B!!List] neq null) then
         begin |3|
           B!CheckPoint(Close);
           B!!List _ B!!Last[B!!List];
           W!SetB(B!!List);
           B!RestoreChkPnt(B!!ChkPntFile[B!!List]);
           W!NewS;
         end |3|
         else
           W!Msg("No buffers left <");
       end; |2|
     end; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                           Page 6-1
     Prt: 06-Jun-84  13:54                                             Rtn B!Cnt

     
     ! Routine to tell us how many buffers to the left and right of the
     !  current buffer are active. Returns [#left,,#right] ;
     
     internal simple integer procedure B!Cnt;
     begin |1|
       own integer
         Left,
         Right,
         Chain;
     
       Chain _ B!!List;
       Left  _ 0;
     
       while (B!!Last[Chain] neq null) do
       begin |2|
         incr(Left);
         Chain _ B!!Last[Chain];
       end; |2|
     
       Chain _ B!!List;
       Right _ 0;
     
       while (B!!Next[Chain] neq 0) do
       begin |2|
         incr(Right);
         Chain _ B!!Next[Chain];
       end; |2|
     
       return(xwd(Left, Right));
     end; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                           Page 7-1
     Prt: 06-Jun-84  13:54                                            Rtn B!Pcnt

     
     ! Return the percentage that the point is into the buffer ;
     
     internal simple integer procedure B!Pcnt;
       begin |1|
         return((B!Point * 100) div B!Size);
       end; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                           Page 8-1
     Prt: 06-Jun-84  13:54                                            Rtn B!GetP

     
     ! Return the current value of the point. ;
     
     internal simple integer procedure B!GetP;
       return(B!Point);
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                           Page 9-1
     Prt: 06-Jun-84  13:54                                            Rtn B!SetP

     
     ! Set the point to an absolute position in the buffer.  If set to beginning
     !  and/or end, set the appropriate flags. ;
     
     internal simple procedure B!SetP (integer Position);
       begin |1|
         B!BegP _ B!EndP _ false;
         B!Point _ Position;
         if (B!Point <= 0) then
           begin |2|
             B!Point _ 0;
             B!BegP _ true;
           end; |2|
         if (B!Point >= B!Size) then
           begin |2|
             B!Point _ B!Size;
             B!EndP _ true;
           end; |2|
       end; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 10-1
     Prt: 06-Jun-84  13:54                                            Rtn B!GetL

     
     ! Return the "last" point. ;
     
     forward internal simple integer procedure B!GetM (integer M);
     
     internal simple integer procedure B!GetL;
     begin |1|
       return(B!GetM(B!LastP));
     end; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 11-1
     Prt: 06-Jun-84  13:54                                            Rtn B!SetL

     
     ! Set the "Last" point.  (Used by the split window code). ;
     
     internal simple procedure B!SetL( integer Position );
     begin |1|
       B!SetM(B!LastP, Position);
     end; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 12-1
     Prt: 06-Jun-84  13:54                                    Rtn B!AllocateMark

     
     ! Allocate the first availible Real Mark to the caller and return its
     ! index.  A return of -1 indicates that there are no more Marks
     ! availible.
     ;
     
     internal simple integer procedure B!AllocateMark;
     begin "B!AllocateMark" |1|
       integer
         I;
     
       for I _ FirstMark step 1 until MaxMarks - 1 do
         if (Marks[I] = -1) then
         begin |2|
           Marks[I] _ -2;
     
           if (I - FirstMark = MarkCnt) then
             incr(MarkCnt);
     
           return(I);
         end; |2|
     
       return(-1);
     end "B!AllocateMark"; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 13-1
     Prt: 06-Jun-84  13:54                                  Rtn B!DeAllocateMark

     
     ! Remove a given Mark from circulation, and if possible decrease MarkCnt.
     ;
     
     internal simple procedure B!DeAllocateMark (integer M);
     begin "B!DeAllocateMark" |1|
       integer
         I;
     
       if (M < 0 or M >= FirstMark + MarkCnt) then
         usererr(0, 0, "Error in B!DeAllocateMark", "x")
       else if (M < #UserMarks) then
       begin |2|
         if (Marks[M] neq -1) then
         begin |3|
           Marks[Marks[M]] _ -1;
           Marks[M]        _ -1;
         end; |3|
       end |2|
       else
         Marks[M] _ -1;
     
       for I _ FirstMark + MarkCnt - 1 step -1 until FirstMark do
         if (Marks[I] = -1) then
           decr(MarkCnt)
         else
           done;
     end "B!DeAllocateMark"; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 14-1
     Prt: 06-Jun-84  13:54                                            Rtn B!GetM

     
     ! Return the current position of the mark ;
     
     internal simple integer procedure B!GetM (integer M);
     begin |1|
       if (M < 0 or M >= FirstMark + MarkCnt) then
         usererr(0, 0, "Bad call to B!GetM", "x" )
       else
         return
         (
           if (M < #UserMarks) then
             if (Marks[M] = -1) then
               -1
             else
               Marks[Marks[M]]
           else
             Marks[M]
         );
     end; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 15-1
     Prt: 06-Jun-84  13:54                                            Rtn B!SetM

     
     ! Set the mark to some position within the buffer ;
     
     internal simple procedure B!SetM (integer M, P);
     begin |1|
       if (P < 0) then
         P _ 0
       else if (P > B!Size) then
         P _  B!Size;
     
       if (M < 0 or M >= FirstMark + MarkCnt) then
         usererr(0, 0, "Bad call to B!GetM", "x" )
       else
         if (M < #UserMarks) then
         begin |2|
           if (Marks[M] = -1) then
             Marks[M] _ B!AllocateMark;
     
           Marks[Marks[M]] _ P;
         end |2|
         else
           Marks[M] _ P;
     end; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 16-1
     Prt: 06-Jun-84  13:54                                            Rtn B!Move

     
     ! Move forward or backward through the buffer.  If we reach the beginning
     !  and/or reach the end, set appropriate flags.  Note that with an empty
     !  buffer the point will be both at the beginning and the end. ;
     
     internal simple procedure B!Move(integer Dir);
       begin "move" |1|
     
         B!Point _ B!Point + Dir;
         B!BegP _ B!EndP _ false;
     
         if (B!Point <= 0) then
           begin |2|
             B!Point _ 0;
             B!BegP _ true;
           end; |2|
         if (B!Point >= B!Size) then
           begin |2|
             B!Point _ B!Size;
             B!EndP _ true;
           end; |2|
     
       end "move"; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 17-1
     Prt: 06-Jun-84  13:54                                          Rtn B!Delete

     
     ! Delete a character from the buffer.  The side of the point from which
     ! the character is deleted depends on the flag Side.
     ;
     
     internal simple procedure B!Delete (integer Side);
     begin |1|
       own integer
         ChOfst,                             ! The offset of the character
                                             ! preceding the Point.
                                             ;
         PtPg;                               ! Identity of the Virtual Page
                                             ! containing the Point.
                                             ;
     
       if (B!Lock) then
         ! <<  Should be DeleteLock.
         ;
         return;
     
       B!ForceGap(PtPg, ChOfst);
     
       if (Side > 0) then
       begin |2|
         ! Delete from right of the Point.
         ;
     
         if (B!Point < B!Size) then
         begin |3|
           start!code |4|
             define
               AC1 = 1,
               AC2 = 2,
               AC3 = 3;
             protect!acs
               AC1,
               AC2,
               AC3;
             label
               Loop,
               GoOn;
     
               move      AC1, B!Point;
               movei     AC2, access(Marks[FirstMark]);
               move      AC3, MarkCnt;
     
             Loop:
               sojl      AC3, GoOn;
               camge     AC1, (AC2);
               sos       (AC2);
               aoja      AC2, Loop;
     
             GoOn:
           end; |4|
     
           if (ChOfst >= 0) then
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 17-2
     Prt: 06-Jun-84  13:54                                          Rtn B!Delete

             incr(PtPg);
     
           while ($VFPg.TxtLen(PtPg) = 0) do
             incr(PtPg);
     
           incr($VFPg.LftGap(PtPg));
           decr($VFPg.TxtLen(PtPg));
           decr(B!Size);
     
           if (B!Point = B!Size) then
             B!EndP _ true;
         end; |3|
       end |2|
       else
       begin |2|
         ! Delete from left of the Point.
         ;
     
         if (B!Point > 0) then
         begin |3|
           start!code |4|
             define
               AC1 = 1,
               AC2 = 2,
               AC3 = 3;
             protect!acs
               AC1,
               AC2,
               AC3;
             label
               Loop,
               GoOn;
     
               move      AC1, B!Point;
               movei     AC2, access(Marks[FirstMark]);
               move      AC3, MarkCnt;
     
             Loop:
               sojl      AC3, GoOn;
               camge     AC1, (AC2);
               sos       (AC2);
               aoja      AC2, Loop;
     
             GoOn:
           end; |4|
     
           decr($VFPg.TxtLen(PtPg));
           decr($VFPg.RgtGap(PtPg));
           decr(B!Point);
           decr(B!Size);
         end; |3|
       end; |2|
     
       if (not B!ModP) then
       begin |2|
         B!ModP _ true;                      ! Buffer is now modified ;
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 17-3
     Prt: 06-Jun-84  13:54                                          Rtn B!Delete

         W!FixS;
       end; |2|
     end; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 18-1
     Prt: 06-Jun-84  13:54                                          Rtn B!Insert

     
     ! Insert a character into the buffer to the right of the Point and
     ! advance the Point.
     ;
     
     internal simple procedure B!Insert(integer C);
     begin "insert" |1|
       own integer
         PtBP,                               ! Byte pointer to the Point.
                                             ;
         PtPg,                               ! Identity of the Virtual Page
                                             ! containing the Point.
                                             ;
         PtPgCh,                             ! Character address of said
                                             ! Virtual File page.
                                             ;
         PtOfst;                             ! The character offset of the
                                             ! Point in said page
                                             ;
     
     
       if (B!Lock) then
         ! <<  Should be InsertLock.
         ;
         return;
     
       start!code |2|
         define
           AC1 = 1,
           AC2 = 2,
           AC3 = 3;
         protect!acs
           AC1,
           AC2,
           AC3;
         label
           Loop,
           GoOn;
     
           move      AC1, B!Point;
           movei     AC2, access(Marks[FirstMark]);
           move      AC3, MarkCnt;
     
         Loop:
           sojl      AC3, GoOn;
           camge     AC1, (AC2);
           aos       (AC2);
           aoja      AC2, Loop;
     
         GoOn:
       end; |2|
     
       B!ForceGap(PtPg, PtOfst);
     
       if (PtOfst = CharactersPerPage - 1) then
       begin |2|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 18-2
     Prt: 06-Jun-84  13:54                                          Rtn B!Insert

         incr(PtPg);
         if (not InsertPage(PtPg)) then
         begin |3|
           ! A garbage-collect of gaps has occured due to the PPM being full.
           ! The previously acquired values of PtPg and PtOfst are now
           ! invalid.  We must try again.
           ;
           
           B!ForceGap(PtPg, PtOfst);
     
           if (PtOfst = CharactersPerPage - 1) then
           begin |4|
             if (not InsertPage(PtPg)) then
             begin |5|
               B!FlushToEDT;
               cfile(B!Chan);
               usererr("B!Insert: PPM Overflow. CheckPoint File is intact",
                   0, 0);
             end; |5|
     
             PtOfst _ 0;
           end |4|
           else
             incr(PtOfst);
         end |3|
         else
           PtOfst _ 0;
       end |2|
       else
         incr(PtOfst);
     
       if (not (PtBP _ BldVFPtr(PtPg, PtOfst))) then
         usererr("B!Insert: BldVFPtr failed (" &
             cvs(PtPg) & ", " & cvs(PtOfst) & ")", 0, 0);
     
       dpb(C, PtBP);
       incr(B!Size);
       incr(B!Point);
       incr($VFPG.RgtGap(PtPg));
       incr($VFPg.TxtLen(PtPg));
     
       B!BegP _ false;
     
       if (not B!ModP) then
       begin |2|
         B!ModP _ true;                    ! buffer is now modified ;
         W!FixS;
       end; |2|
     end "insert"; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 19-1
     Prt: 06-Jun-84  13:54                                            Rtn B!GetC

     
     ! Return the character on to the right of the point ;
     
     internal simple integer procedure B!GetC;
     begin "B!GetC" |1|
       integer
         ChrOfst,                            ! The byte offset of the Point on
                                             ! the page.
                                             ;
         Dummy,                              ! A dummy variable.
                                             ;
         Pg,                                 ! Virtual File page on which the
                                             ! Point resides.
                                             ;
         PgAdr,                              ! Memory address of said page.
                                             ;
         Pnt,                                ! Local copy of the Point.
                                             ;
         Result;                             ! Resulting character.
                                             ;
     
       if ((Pnt _ B!GetP) >= B!Size) then
         return(0);
     
       if (not LocatePoint(Pnt, Pg, Dummy, ChrOfst)) then
         usererr("B!GetC: LocatePoint failed (" & cvs(Pnt) & ")", 0, 0);
     
       if (ChrOfst = $VFPg.RgtGap(Pg) - 1) then
       begin |2|
         incr(Pg);
     
         while ($VFPg.TxtLen(Pg) = 0) do
           incr(Pg);
     
         ChrOfst _ $VFPg.LftGap(Pg);
       end |2|
       else
         incr(ChrOfst);
     
       PgAdr _ Addrs(VFPtoMemory(Pg));
     
     !  print("B!GetC: Point (", Pnt, "), ");
     
       start!code |2|
         move      2, ChrOfst;
         idivi     2, 5;
         add       2, PgAdr;
         move      2, (2);                   ! pick up the word ;
         imuli     3, 7;                     ! build a shift count ;
         addi      3, 7;
         lshc      1, (3);                   ! shift byte into ac 1 ;
         andi      1, '177;                  ! mask to 7 bits ;
         movem     1, Result;                ! Reclaim the result ;
       end; |2|
     
     !  print("Char (", cvos(Result), "q)", crlf);
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 19-2
     Prt: 06-Jun-84  13:54                                            Rtn B!GetC

       return(Result);
     end "B!GetC"; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 20-1
     Prt: 06-Jun-84  13:54                                            Rtn B!AnyM

     
     ! See if any buffers in the ring are modified ;
     
     internal simple boolean procedure B!AnyM;
     begin "B!AnyM" |1|
       integer
         Ptr;
     
       Ptr _ B!!Head;
     
       while (Ptr) do
       begin |2|
         if ((Ptr = B!!List and B!ModP and length(B!File)) or
             (Ptr neq B!!List and B!!ModP[Ptr] and length(B!!File[Ptr]))) then
           return(true);
     
         Ptr _ B!!Next[Ptr];
       end; |2|
     
       return(false);
     end "B!AnyM"; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 21-1
     Prt: 06-Jun-84  13:54                                          Rtn B!ModCnt

     
     ! routine to return the number of buffers in the ring that are modified
     ;
     
     internal simple integer procedure B!ModCnt;
     begin "B!ModCnt" |1|
       integer
         Cnt,
         Ptr;
     
       Ptr _ B!!Head;
       Cnt _ 0;
     
       while (Ptr) do
       begin |2|
         if ((Ptr = B!!List and B!ModP and length(B!File)) or
             (Ptr neq B!!List and B!!ModP[Ptr] and length(B!!File[Ptr]))) then
           incr(Cnt);
     
         Ptr _ B!!Next[Ptr];
       end; |2|
     
       return(Cnt);
     end "B!ModCnt"; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 22-1
     Prt: 06-Jun-84  13:54                                            Rtn B!Fini

     
     ! B!Fini - walk the ring, optionally writing out modified files
     ! and deleting the checkpoint files.
     ;
     
     internal simple boolean procedure B!Fini(boolean WriteFiles);
     begin "B!Fini" |1|
       B!!ModP[B!!List] _ B!ModP;
     
       while (B!!List) do
       begin "each buffer" |2|
         if (WriteFiles and
              B!!ModP[B!!List] and
              length(B!!File[B!!List])) then
         begin |3|
           if (not F!Writ(B!!File[B!!List])) then
             return(false);
     
           B!DelCurrentBuffer;
         end |3|
         else
           B!DelCurrentBuffer;
       end "each buffer"; |2|
     
       return(true);
     
     end "B!Fini"; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 23-1
     Prt: 06-Jun-84  13:54                                         Rtn B!BufStat

     
     ! Routine to throw the list of buffers into the Box ;
     
     internal simple procedure B!BufStat;
     begin "buffer status" |1|
       integer L;
       string S;
     
       ! List starting with B!!Head;
     
       L _ B!!Head;
       while (L) do
       begin "list buffers" |2|
         if (L = B!!List) then
           S _ " > " else S _ "   ";
     
         if (B!!Alias[L]) then
           S _ S & B!!Alias[L]
         else
           S _ S & B!!File[L];
     
         if (L = B!!List and B!ModP or
             L neq B!!List and B!!ModP[L]) then
           S _ S & " *";
     
         W!BAdd(S);
         L _ B!!Next[L];
       end "list buffers"; |2|
     end "buffer status"; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 24-1
     Prt: 06-Jun-84  13:54                                      Rtn B!FileInsert

     
     ! Insert an external Text file into the current Buffer after the Point.
     ;
     
     internal simple boolean procedure B!FileInsert (string FName);
     begin "B!FileInsert" |1|
       integer
         ChSize,
         Dummy,
         I,
         ICBPg,
         F!Chan,
         MemPg,
         MemPgAdr,
         PgSize,
         SavePoint,
         VFPg;
     
       if (not F!FileExists(FName)) then
       begin |2|
         W!Msg("File doesn't exist: " & FName);
         return(false);
       end; |2|
     
       F!Chan _ openfile(FName, "ORE");
     
       if (!skip!) then
       begin |2|
         DoErstr;
         return(false);
       end; |2|
     
       SavePoint _ B!GetP;
     
       begin |2|
         PgSize _ sizef(F!Chan);
         ChSize _ chsizef(F!Chan);
       end; |2|
     
       B!ForceGap(VFPg, Dummy);
       ICBPg _ GetICBPage;
     
       MemPg    _ $ICBM.MemPg(ICBPg);
       MemPgAdr _ Addrs(MemPg);
     
       for I _ 0 step 1 until PgSize - 1 do
       begin |2|
         pmap(!TPg(I), !MPg(MemPg), !Cow!);
         memory[MemPgAdr] _ memory[MemPgAdr];
     
           ! Map and touch the Text file page.
           ;
     
         incr(VFPg);
     
         if (not InsertPage(VFPg, ICBPg)) then
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 24-2
     Prt: 06-Jun-84  13:54                                      Rtn B!FileInsert

         begin |3|
           B!ForceGap(VFPg, Dummy);
           incr(VFPg);
     
           if (not InsertPage(VFPg, ICBPg)) then
           begin |4|
             B!FlushToEDT;
               ! <<  Unmap ChkPnt file.
               ;
             cfile(B!Chan);
             usererr("B!FileInsert: PPM Overflow. CheckPoint File intact.",
                 0, 0);
           end; |4|
         end; |3|
     
         if (I = PgSize - 1) then
           decr(ChSize, CountSomeNulls(MemPg, PgSiz(I, PgSize - 1, ChSize) - 1)|
                                                                          ->|);|
     
             ! Remove consideration of possible trailing nulls on the last
             ! page.
             ;
     
         pmap(-1, !MPg(MemPg), 0);
     
           ! Remove the page from memory.
           ;
     
         $ICBM.VFPg(ICBPg)    _ -1;
         $ICBM.MissCnt(ICBPg) _ largeinteger;
     
           ! Reset the ICB entry for ICBPg to a null (ie, unallocated) state,
           ! to undo the effect of the InsertPage call.
           ;
     
         $VFPg.LftGap(VFPg) _ 0;
         $VFPg.TxtLen(VFPg) _
         $VFPg.RgtGap(VFPg) _ PgSiz(I, PgSize - 1, ChSize);
         $VFPg.ICBIdx(VFPg) _ -1;
     
           ! Setup the PPM entry to a meaningful value, but do not associate
           ! it with an ICB page.
           ;
       end; |2|
     
       cfile(F!Chan);
       incr(B!Size, ChSize);
       B!SetP(SavePoint);
       set(B!ModP);
       return(true);
     end "B!FileInsert"; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 25-1
     Prt: 06-Jun-84  13:54                                      Rtn B!CheckPoint

     
     ! Force the Checkpoint file to be in harmonious sync with reality, and if
     ! specified, close the checkpoint file.
     ;
     
     internal simple procedure B!CheckPoint (boolean Close);
     begin "B!CheckPoint" |1|
       B!FlushToEDT;
     
       if (Close) then
       begin |2|
         integer
           I;
     
         for I _ GiantBase step 1 until (GiantBase + EndOfBuffer - 1) do
           pmap(-1, !MPg(I), 0);
     
         cfile(B!Chan);
     
           ! Close the Checkpoint file
           ;
       end; |2|
     end "B!CheckPoint"; |1|
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 26-1
     Prt: 06-Jun-84  13:54                                           Rtn ShowMap

     
     ! Show the pertinent features of the specified virtual file page in the
     ! PPM and the ICBM.
     ;
     
     internal simple procedure ShowMap (integer Pg);
     begin "ShowMap" |1|
       integer
         IBas,                               ! The base of the corresponding
                                             ! ICBM entry, if any.
                                             ;
         Idx,                                ! ICB index (if any) of the VF pag|
                                                                          ->|e.|
                                             ;
         PBas;                               ! The base of the specified VF
                                             ! entry in the PPM.
                                             ;
       define
         LG = {0}                            ! LftGap
                                             ;,
         TL = {1}                            ! TxtLen
                                             ;,
         RG = {2}                            ! RgtGap
                                             ;,
         IX = {3}                            ! ICBIdx
                                             ;,
         CP = {4}                            ! ChkPg
                                             ;,
         MP = {0}                            ! MemPg
                                             ;,
         VP = {1}                            ! VFPg
                                             ;,
         MC = {2}                            ! MissCnt
                                             ;;
     
       print("B!MaxPgIdx: ", B!MaxPgIdx, crlf);
       print("B!Size:     ", B!Size, crlf);
       print("B!Point:    ", B!Point, crlf2);
     
       PBas _ location($VFPg.LftGap(Pg));
     
       if (Pg > B!MaxPgIdx or Pg < 0) then
       begin |2|
         print("Page ", cvos(Pg), " does not exist.", crlf);
         return;
       end; |2|
     
       print("LftGap (", cvos(Pg), ")", cvos(memory[PBas + LG]), crlf);
       print("TxtLen (", cvos(Pg), ")", cvos(memory[PBas + TL]), crlf);
       print("RgtGap (", cvos(Pg), ")", cvos(memory[PBas + RG]), crlf);
       print("ICBIdx (", cvos(Pg), ")", cvos(memory[PBas + IX]), crlf);
       print("ChkPg  (", cvos(Pg), ")", cvos(memory[PBas + CP]), crlf);
     
       if (Idx _ memory[PBas + IX] >= 0) then
       begin |2|
         IBas _ location($ICBM.MemPg(memory[PBas + IX]));
     Cre: 03-Apr-84  16:15  (PEAKX)XXBUF2.REQ                          Page 26-2
     Prt: 06-Jun-84  13:54                                           Rtn ShowMap

     
         print(crlf);
         print("MemPg   (", cvos(Idx), ")", cvos(memory[IBas + MP]), crlf);
         print("VFPg    (", cvos(Idx), ")", cvos(memory[IBas + VP]), crlf);
         print("MissCnt (", cvos(Idx), ")", cvos(memory[IBas + MC]), crlf);
       end; |2|
     
       print(crlf);
     end "ShowMap"; |1|
     
     
     ! **************************  End XxBuf2.Req  *************************** ;





                                                      
                                                      
                                                      
                              
                              
                              
                              
                              
                              
                                    
                                    
                                    
                              
                              
                              
                              
                              
                              
                              
                              
                              



                                                      
                                                      
                                                      
                  
                  
                  
                  
                  
                  
                                    
                                    
                                    
                  
                  
                  
                  
                  
                  
                                                                              
                                                                              
                                                                              




                            
            
            
                  
               
              
                             

     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 1-1
     Prt: 06-Jun-84  13:57                               Tops-20 File I/O Module

     Entry;
     begin "DED - File I/O" |1|
       require "DED.DEF" source!file;
     
     
     ifcr TymcomX thenc
       require "!!! This is the Tops-20 File I/O module !!!" message;
       TryAgainWithTheTymcomXVersion
     endc
     
     
     ! *************************************************************************
     *                                                                         *
     *        This module handles all disk I/O, and isolates all system        *
     *      dependent file system calls into one file.  The RPG interface      *
     *                            also lives here.                             *
     *                                                                         *
     *                    Dave W. Smith,  October '81 - ...                    *
     *                                                                         *
     **************************************************************************;
     
     
     !            Entry points in other modules that we reference.
     ;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                      From the SAIL runtime system
     ;
     
       external integer
         !skip!,                             ! Indicates an error occurred in
                                             ! some quadrant of the Runtimes.
                                             ;
         RPGSW,                              ! True iff called w/ offset
                                             ;
         C!Debug;                            ! True if we are doing run-time
                                             ! debugging and performance
                                             ! monitoring.
                                             ;
     
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                         From the Utility Module
     ;
     
       external simple procedure
         DoErStr;                            ! Print out the message of the
                                             ! last error to occur.
                                             ;
     
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                         From the Buffer Module.
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 1-2
     Prt: 06-Jun-84  13:57                               Tops-20 File I/O Module

     ;
     
       external integer
         B!Size,                             ! Total number of characters in
                                             ! the buffer.
                                             ;
         B!MaxPgIdx;                         ! Index of the last page of the
                                             ! Checkpoint file.
                                             ;
     
       external string
         B!File;                             ! Name of the Text file being
                                             ! edited. 
                                             ;
     
       external simple boolean procedure
         B!CreateChkPntFile
             (string TName, TAlias(null); 
             integer TPage(0), TLine(0),
             TChar(0));                      ! Create a new checkpoint file
                                             ! and fill it with the named
                                             ! Text file.
                                             ;
       external simple boolean procedure
         B!WriteTextFile (string FName);     ! Write the Checkpoint file to
                                             ! the named Text file.
                                             ;
       external procedure
         B!SetP (integer Position);          ! Set the point.
                                             ;
       external procedure
         B!Insert (integer C);               ! Insert a character.
                                             ;
     
       external procedure
         B!Delete (integer Dir);             ! Delete a chracter.
                                             ;
     
       external integer procedure
         B!GetP;                             ! Get the point.
                                             ;
     
       external simple integer procedure
         B!GetC;                             ! Get char at point.
                                             ;
     
       external simple procedure
         B!Move (integer Dir);               ! Move the point.
                                             ;
     
     
       external boolean
         B!BegP,                             ! The Point is at the beginning
                                             ! of the Buffer.
                                             ;
         B!EndP,                             ! The Point is at the end of the
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 1-3
     Prt: 06-Jun-84  13:57                               Tops-20 File I/O Module

                                             ! Buffer.
                                             ;
         B!ModP;                             ! The Buffer is modified.
                                             ;
     
       external integer
         B!Prot,                             ! Buffer protection.
                                             ;
         B!Lock;                             ! The current Buffer lock
                                             ! condition.
                                             ;
     
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                         From the Window Module
     ;
     
     
       external procedure
         W!Disp (boolean PuntIfKeyHit);
     
       external procedure
         W!Msg (string S);
     
       external boolean
         W!MsgF;
     
       external procedure
         W!NewS;                             ! Create new status line.
                                             ;
     
       external procedure
         W!FixS;
     
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                         From the Command Module
     ;
     
     
       external boolean
         G!RNulls,                           ! Remove nulls from the Text file
                                             ! automatcially if true.
                                             ;
         G!ShowGens;                         ! Show Generation numbers in file
                                             ! names.
                                             ;
     
       external boolean procedure
         C!Ask (string Question);
     
       external safe integer array
         C!Tab['0:'177];
     
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 1-4
     Prt: 06-Jun-84  13:57                               Tops-20 File I/O Module

     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     !                        From the Redisplay Module
     ; 
     
       external procedure
         T!Bell;
     
       external procedure
         T!Fini;
     
       external procedure
         T!RSet;
     
     
     ! ------------------------------------------------------------------------;
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 2-1
     Prt: 06-Jun-84  13:57                                      Internal Storage

     
     !                    Storage internal to this module.
     ;
     
       internal integer
         F!Chars;                            ! Chars yet to be read from file.
                                             ;
     
       own integer
         F!Chan,                             ! Channel of current file.
                                             ;
         F!EOF,                              ! True iff eof reached.
                                             ;
         F!EOFSeen,
         F!InputCount,
         F!OutputCount,
         F!Prot;                             ! File protection.
                                             ;
     
     
     !                       Stuff scanned from a filename
     ;
     
       internal boolean
         F!RpgFlag;                          ! true iff to exit to RPG.
                                             ;
       own boolean
         F!Lock;                             ! true iff /read.
                                             ;
       own integer
         F!Page,
         F!Line,
         F!Char;                             ! where to start.
                                             ;
       own string
         F!ReScanLine,                       ! Contents of the legendary
                                             ! rescan buffer.
                                             ;
         F!Name,                             ! file name.
                                             ;
         F!Alias,                            ! r e g n a d   k c i n.
                                             ;
         F!String;                           ! String for holding a filespec.
                                             ;
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 3-1
     Prt: 06-Jun-84  13:57                                         Rtn MakeFName

     
     ! Return a filename compiled of the parts supplied.
     ;
     
     simple string procedure MakeFName (string Dev, Usr, Nam, Ext, Gen);
     begin "MakeFName" |2|
       string
         Str;
     
       Str _ null;
     
       if (length(Dev)) then
         appnd(Str, Dev & ":");
     
       if (length(Usr)) then
         appnd(Str, "<" & Usr & ">");
     
       appnd(Str, Nam);
     
       if (length(Ext) or (length(Gen) and G!ShowGens)) then
         appnd(Str, ("." & Ext));
     
       if (G!ShowGens) then
         appnd(Str, ("." & Gen));
     
       return(Str);
     end "MakeFName"; |2|
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 4-1
     Prt: 06-Jun-84  13:57                                            Rtn F!Exit

     
     ! Do system dependent termination stuff.
     ;
     ! <<  In Tymcom-X, this did a run of (Sys)Rpg in order to facilitate
     !     ^X^E.  What should we do here?
     !
     !     Virgil proposes a push-to-compile or push-to-load or
     !     push-to-execute command set, since he does not see that this is
     !     possible with the Tops-20 exec, which does not keep tmpcore files.
     !
     !     Does Tymcom-X presuppose an Exe when no tmpcore exists?
     ;
     
     internal procedure F!Exit;
     begin |2|
       if (F!RPGFlag) then
       begin |3|
         T!Fini;
     
         start!code |4|
           haltf;
         end; |4|
     
           ! ** hack **
           ;
     
         T!RSet;
         T!Bell;
       end; |3|
     end; |2|
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 5-1
     Prt: 06-Jun-84  13:57                                       Rtn F!Decompose

     
     ! Decompose a Tops-20/PEAK FileSpec, which must be of the following form:
     !
     ! <FileSpec>    ->      <Fs>(<Alias>)(<Switches>)
     ! <Fs>          ->      (<Device>)(<UserName>)<FileName>(<Prot>)
     ! <UserName>    ->      '<' <Un> '>' | '[' <Un> ']'
     ! <Un>          ->      repeat(<V0>, 1-39)
     ! <Device>      ->      repeat(<V1>, 1-39) ':'
     ! <FileName>    ->      <FilePart> ('.' <ExtPart>)('.' <GenPart>)
     ! <FilePart>    ->      repeat(<V1>, 1-39)
     ! <ExtPart>     ->      repeat(<V1>, 0-39)
     ! <GenPart>     ->      repeat(<DecNum>, 0-*)
     ! <Prot>        ->      <semicolon> repeat(<OctNum>, 6)
     ! <Alias>       ->      '"' repeat(<V2>, 1-*) '"'
     ! <Switches>    ->      '/' <Sw> | '%' <Sw>
     ! <Sw>          ->      repeat(ASCII, 1-*)
     ! 
     ! <V0>          ->      <V1> | '.'
     ! <V1>          ->      <Alpha> | <DecNum> | '-'
     ! <V2>          ->      {ASCII - '"'}
     ! 
     ! <Alpha>       ->      'A' - 'Z' | 'a' - 'z' 
     ! <DecNum>      ->      '0' - '9'
     ! <OctNum>      ->      '0' - '7'
     !
     ! <semicolon>   ->      (This is literally a semicolon, which cannot be
     !                       included here without being taken personally by
     !                       SAIL.)
     ! 
     ! 
     ! (The function repeat(Item, Minimum-Maximum) is replaced by between
     ! Minimum and Maximum number of occurences of Item, inclusively.  The
     ! special symbol '*' indicates no limit.)
     !
     ! The symbol 'ASCII' indicates the entire ASCII character set.
     !
     ! Braces ('{' and '}') enclose set specifications - eg, "{ASCII - '"'}"
     ! means all characters except '"'.
     ;
     
     
     internal boolean procedure F!Decompose (string InStr; reference string Dev|
                               ->|, UserName, File, Ext, Gen, Alias, Switches);|
     begin "F!Decompose" |2|
       label
         S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, SGood, SBad;
       integer
         C;
       string
         LDev, LUserName, LFile, LExt, LGen, LProt, LAlias, LSwitches,
         Str, Tst;
       define
         sp               = {" "},
         IsAlphabetic (X) = {("A" <= UpShift(X) <= "Z")},
         IsNumeric    (X) = {("0" <= X <= "9")},
         IsOctal      (X) = {("0" <= X <= "7")},
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 5-2
     Prt: 06-Jun-84  13:57                                       Rtn F!Decompose

         IsWhiteSpace (X) = {(X = sp or X = tab)},
         IsV1         (X) = {(IsAlphabetic(X) or IsNumeric(X) or (X = "-"))},
         IsV0         (X) = {(IsV1(X) or (X = "."))};
     
       Str  _
       LDev _ LUserName _ LFile _ LExt _ LGen _ LProt _ LAlias   _ LSwitches _
       Dev  _ UserName  _ File  _ Ext  _ Gen  _ Alias _ Switches _ null;
     
     
       S0:
           ! Nothing seen
           ;
     
         if (not length(InStr)) then goto SBad;
         C _ lop(InStr);
         if (C = "[" or C = "<") then goto S3;
         if (IsV1(C)) then
         begin |3|
           appnd(Str, ToUpper(C));
           goto S1
         end; |3|
         goto SBad;
     
     
       S1:
           ! Picking up Device or Filename
           ;
     
         if (not length(InStr)) then
         begin |3|
           LFile _ Str;
           goto SGood;
         end; |3|
         C _ lop(InStr);
         if (C = ":") then
         begin |3|
           LDev _ Str;
           goto S2;
         end; |3|
         if (C = ".") then
         begin |3|
           LFile _ Str;
           goto S5;
         end; |3|
         if (C = """") then
         begin |3|
           LFile _ Str;
           goto S9;
         end; |3|
         if (C = "/" or C = "%") then
         begin |3|
           LFile _ Str;
           goto S11;
         end; |3|
         if (IsV1(C)) then
         begin |3|
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 5-3
     Prt: 06-Jun-84  13:57                                       Rtn F!Decompose

           appnd(Str, ToUpper(C));
           goto S1;
         end; |3|
         goto SBad;
     
     
       S2:
           ! Colon seen - we just picked up the Device name.
           ;
     
         if (not length(InStr)) then goto SGood;
         C _ lop(InStr);
         if (C = "[" or C = "<") then goto S3;
         if (C = ".") then goto S5;
         if (C = """") then goto S9;
         if (C = "/" or C = "%") then goto S11;
         if (C = ";") then goto S7;
         if (IsV1(C)) then
         begin |3|
           appnd(LFile, ToUpper(C));
           goto S2;
         end; |3|
         goto SBad;
     
     
       S3:
           ! '[' or '<' seen - pick up UserName.
           ;
     
         if (not length(InStr)) then goto SBad;
         C _ lop(InStr);
         if (C = "]" or C = ">") then goto S4;
         if (IsV0(C)) then
         begin |3|
           appnd(LUserName, ToUpper(C));
           goto S3;
         end; |3|
         goto SBad;
     
     
       S4:
           ! "]" or ">" seen - pick up FileName.
           ;
     
         if (not length(InStr)) then goto SGood;
         C _ lop(InStr);
         if (C = ".") then goto S5;
         if (C = """") then goto S9;
         if (C = "/" or C = "%") then goto S11;
         if (C = ";") then goto S7;
         if (IsV1(C)) then
         begin |3|
           appnd(LFile, ToUpper(C));
           goto S4;
         end; |3|
         goto SBad;
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 5-4
     Prt: 06-Jun-84  13:57                                       Rtn F!Decompose

     
     
       S5:
           ! Dot seen - pick up an Ext.
           ;
     
         if (not length(InStr)) then goto SGood;
         C _ lop(InStr);
         if (C = ".") then goto S6;
         if (C = """") then goto S9;
         if (C = "/" or C = "%") then goto S11;
         if (C = ";") then goto S7;
         if (IsV1(C)) then
         begin |3|
           appnd(LExt, ToUpper(C));
           goto S5;
         end; |3|
         goto SBad;
     
     
       S6:
           ! Dot seen - pick up a Generation number.
           ;
     
         if (not length(InStr)) then goto SGood;
         C _ lop(InStr);
         if (C = """") then goto S9;
         if (C = "/" or C = "%") then goto S11;
         if (C = ";") then goto S7;
         if (IsNumeric(C)) then
         begin |3|
           appnd(LGen, C);
           goto S6;
         end; |3|
         goto SBad;
     
     
       S7:
           ! Semicolon seen - pickup Protection field.
           ;
     
         if (not length(Instr)) then goto SBad;
         appnd(LProt, C);
         C _ lop(InStr);
         if (ToUpper(C) = "P") then
         begin |3|
           appnd(LProt, ToUpper(C));
           goto S8;
         end; |3|
         goto SBad;
     
     
       S8:
           ! 'P' seen - pick up Protection expression.
           ;
     
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 5-5
     Prt: 06-Jun-84  13:57                                       Rtn F!Decompose

         if (length(InStr)) then goto SGood;
         C _ lop(InStr);
         if (C = """") then goto S9;
         if (C = "/") then goto S11;
         if (IsOctal(C)) then
         begin |3|
           appnd(LProt, C);
           goto S8;
         end; |3|
         goto SBad;
     
     
       S9:
           ! Quote seen - pick up an Alias.
           ;
     
         if (not length(InStr)) then goto SBad;
         C _ lop(InStr);
         if (C = """") then goto S10;
         appnd(LAlias, ToUpper(C));
         goto S9;
     
     
       S10:
           ! Second quote seen.
           ;
     
         if (not length(InStr)) then goto SGood;
         C _ lop(InStr);
         if (C = "/" or C = "%") then goto S11;
         goto SBad;
     
     
       S11:
           ! '/' or '%' seen - put it on the front of the switch.
           ;
     
         LSwitches _ C;
         goto S12;
     
     
       S12:
           ! Gather the rest of the line as switches.
           ;
     
         if (not length(InStr)) then goto SGood;
         C _ lop(InStr);
         appnd(LSwitches, ToUpper(C));
         goto S12;
     
     
       SGood:
           ! Many Happy Returns ;
     
         Tst _ MakeFName(LDev, LUserName, LFile, LExt, LGen);
     
 {XzF