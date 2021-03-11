42XFORMAT01:Peak V2(301)     Command Module     06-Jun     2 1984       




                                                      
                                                      
                                                      
                                          
                                          
                                          
                                    
                                    
                                    
                              
                              
                              
                              
                              
                              
                              
                              
                              
                                                      
                                                      
                                                      



                  
                  
                  
                                    
                                    
                                    
                        
                        
                        
                  
                  
                  
                  
                  
                  
                  
                  
                  
                              
                              
                              




                        
                  
               
                  
              
               
                          

     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                            Page 1-1
     Prt: 06-Jun-84  13:53                               COMM1 - Simple Commands

     
     ! *************************************************************************
     *                                                                         *
     *                                  COMM1                                  *
     *                             Simple Commands                             *
     *                                                                         *
     ***************************************************************************
     
     
                This file is required as a source!file in COMAND.SAI.
     
     
     **************************************************************************;
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                            Page 2-1
     Prt: 06-Jun-84  13:53                                          Rtn C!Insert

     
     ! Insert some number of the character in C!Cmd into the buffer, obeying
     ! all prevailing modes and devns. (Code duplication is to improve
     ! runtime efficiency.)
     !
     ! Note that the boolean InsertLiterally is usually false, indicating normal
     ! character insertion.  It is only true when the character wants to be
     ! inserted literally.  (This is only a concern when the character is a CR
     ! or a TAB, both of which would noramally be interpreted.)
     !
     ! Note that this routine is called by other insert routines, as well as
     ! by the Command Dispatcher.
     ;
     
     simple procedure C!Insert;
     begin "C!Insert" |1|
       own integer
         Col;                                ! The column number into which
                                             ! the next character will be
                                             ! inserted.  (This must survive
                                             ! between invocations.)
                                             ;
       integer
         I;                                  ! Iteration variable
                                             ;
     
     
       if (B!Lock) then
         PuntCommand;
     
       C!ArgV _ C!ArgV max 1;
     
     ! ------------------------------------------------------------------------;
     
       ! Perform the overwrite mode delete operation.
       ;
     
       if (G!OverWriteP and SP <= C!Cmd < DEL) then
       begin |2|
         for I _ 1 step 1 while (I <= C!ArgV and not AtEOL) do
         begin |3|
           if (B!GetC = TAB) then
           begin |4|
             if (GetColumn mod C!TabWidth = 0) then
               B!Delete(FORWARDS);
           end |4|
           else
             B!Delete(FORWARDS);
         end; |3|
       end; |2|
     
     ! ------------------------------------------------------------------------;
     
       ! Perform character insertion.
       ;
     
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                            Page 2-2
     Prt: 06-Jun-84  13:53                                          Rtn C!Insert

       if (G!TextMode) then
       begin |2|
         ! Do Text Mode insertion.
         ;
     
         if (C!Addr neq C!LastAddr) then
           ! If this command was not the last comand issued.
           ;
     
           Col _ GetColumn;
     
         if (C!Cmd = CR) then
         begin |3|
           Col _ 1;
     
           for I _ 1 step 1 until C!ArgV do
           begin |4|
             B!Insert(CR);
     
             if (not InsertLiterally) then
               B!Insert(LF);
           end; |4|
         end |3|
         else if (C!Cmd = TAB) then
         begin |3|
           for I _ 1 step 1 until C!ArgV do
           begin |4|
             integer
               Width;
     
             incr(Col, (Width _ CharWidth(TAB, Col)));
     
             if (C!UseTabs or InsertLiterally) then
               B!Insert(TAB)
             else
               GenerateWS(Width);
           end; |4|
         end |3|
         else
         begin |3|
           if (C!Cmd = BS) then
             decr(Col, C!ArgV)
           else
             incr(Col, C!ArgV);
     
           for I _ 1 step 1 until C!ArgV do
             B!Insert(C!Cmd);
         end; |3|
     
         if (Col > C!RightMargin + 1) then
         begin |3|
           ! Perform line fill.
           ;
     
           integer
             EndMk,
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                            Page 2-3
     Prt: 06-Jun-84  13:53                                          Rtn C!Insert

             SavMk;
     
           B!SetM((SavMk _ B!AllocateMark), B!GetP);
           MoveToEOL;
           B!SetM((EndMk _ B!AllocateMark), B!GetP);
           B!SetP(B!GetM(SavMk));
     
           if (Col > C!RightMargin + 2) then
             TryColumn(C!RightMargin + 1);
     
           SkipWS(BACKWARDS);
           SkipNWS(BACKWARDS);
           SkipWS(BACKWARDS);
           SkipNWS(BACKWARDS);
     
           Col _ GetColumn;
           DoFill(Col, EndMk, C!LeftMargin, C!RightMargin);
           B!SetP(B!GetM(SavMk));
     
           if ((C!Cmd = SP or C!Cmd = TAB) and AtEol) then
           begin         |4|
             MoveForwards;
             SkipWS(FORWARDS);
           end; |4|
     
           Col _ GetColumn;
           B!DeallocateMark(SavMk);
           B!DeallocateMark(EndMk);
         end; |3|
       end |2|
       else
       begin |2|
         ! Do Normal Mode insertion.
         ;
     
         if (C!Cmd = CR) then
         begin |3|
           for I _ 1 step 1 until C!ArgV do
           begin |4|
             B!Insert(CR);
     
             if (not InsertLiterally) then
               B!Insert(LF);
           end; |4|
         end |3|
         else if (C!Cmd = TAB) then
         begin |3|
           integer
             Col;
     
           Col _ GetColumn;
     
           for I _ 1 step 1 until C!ArgV do
           begin |4|
             integer
               Width;
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                            Page 2-4
     Prt: 06-Jun-84  13:53                                          Rtn C!Insert

     
             incr(Col, (Width _ CharWidth(TAB, Col)));
     
             if (C!UseTabs or InsertLiterally) then
               B!Insert(TAB)
             else
               GenerateWS(Width);
           end; |4|
         end |3|
         else
         begin |3|
           for I _ 1 step 1 until C!ArgV do
             B!Insert(C!Cmd);
         end; |3|
       end; |2|
     
       C!ArgV _ 0;
     end "C!Insert"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                            Page 3-1
     Prt: 06-Jun-84  13:53                                      Rtn C!InsertCRLF

     
     ! Insert a number of <crlf> pairs into the buffer.
     ;
     
     simple procedure C!InsertCRLF;
     begin "C!InsertCRLF" |1|
       integer
         CAddr,
         Cmd;
     
       if (B!Lock) then
         PuntCommand;
     
       CAddr  _ C!Addr;
       C!Addr _ location(C!Insert);
       Cmd    _ C!Cmd;
     
       C!Cmd  _ CR;
       C!Insert;
     
       C!Cmd  _ Cmd;
       C!Addr _ CAddr;
     end "C!InsertCRLF"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                            Page 4-1
     Prt: 06-Jun-84  13:53                                       Rtn C!InsertTAB

     
     ! Insert some number of TAB equivalents into the buffer.
     ;
     
     simple procedure C!InsertTAB;
     begin "C!InsertTab" |1|
       integer
         CAddr,
         Cmd;
     
       if (B!Lock) then
         PuntCommand;
     
       CAddr  _ C!Addr;
       C!Addr _ location(C!Insert);
       Cmd    _ C!Cmd;
     
       C!Cmd  _ TAB;
       C!Insert;
     
       C!Cmd _ Cmd;
       C!Addr _ CAddr;
     end "C!InsertTab"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                            Page 5-1
     Prt: 06-Jun-84  13:53                                       Rtn C!OverWrite

     
     ! Toggle the overwrite flag. ;
     
     simple procedure C!OverWrite;
     begin "C!OverWriteP" |1|
       toggle(G!OverWriteP);
       W!NewS;
       C!ArgV _ 0;
     end "C!OverWriteP"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                            Page 6-1
     Prt: 06-Jun-84  13:53                                           Rtn C!Quote

     
     ! "Quote" the next character typed.
     ;
     
     simple procedure C!Quote;
     begin "C!Quote" |1|
       integer
         CAddr,
         Cmd;
     
       if (B!Lock) then
         PuntCommand;
     
       W!Msg("Quote");
     
         ! A friendly reminder that we're quoting.
         ;
     
       CAddr  _ C!Addr;
       C!Addr _ location(C!Insert);
       Cmd    _ C!Cmd;
       set(InsertLiterally);
     
       C!Cmd  _ C!GetC;
       C!Insert;
     
       clear(InsertLiterally);
       C!Addr _ CAddr;
       C!Cmd  _ Cmd;
       W!Msg(null);
     end "C!Quote"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                            Page 7-1
     Prt: 06-Jun-84  13:53                                            Rtn C!Open

     
     ! "Open" a line by inserting <crlf> and backing up to before it. ;
     
     simple procedure C!Open;
     begin "C!Open" |1|
       integer
         CAddr,
         Cmd,
         SavePt;
     
       if (B!Lock) then
         PuntCommand;
     
       SavePt _ B!GetP;
       CAddr  _ C!Addr;
       C!Addr _ location(C!Insert);
       Cmd    _ C!Cmd;
     
       C!Cmd  _ CR;
       C!Insert;
     
       C!Addr _ CAddr;
       C!Cmd  _ Cmd;
     
       B!SetP(SavePt);
     end "C!Open"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                            Page 8-1
     Prt: 06-Jun-84  13:53                                        Rtn C!IndentUp

     
     ! Break the line at the point and give the new line the same
     ! indentation as the old. ;
     
     procedure C!IndentUp;
     begin "C!IndentUp" |1|
       integer
         I;
     
       if (B!Lock) then
         PuntCommand;
     
       C!ArgV _ C!ArgV max 1;
       I      _ GetIndent;
     
       while (C!ArgV) do
       begin |2|
         UpLine;
         B!Insert(CR);
         B!Insert(LF);
         ForceIndent(I);
         decr(C!ArgV);
       end; |2|
     end "C!IndentUp"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                            Page 9-1
     Prt: 06-Jun-84  13:53                                      Rtn C!IndentDown

     
     ! Break the line at the point and give the new line the same
     ! indentation as the old. ;
     
     procedure C!IndentDown;
     begin "C!IndentDown" |1|
       integer
         I;
     
       if (B!Lock) then
         PuntCommand;
     
       C!ArgV _ C!ArgV max 1;
       I      _ GetIndent;
     
       while (C!ArgV) do
       begin |2|
         B!Insert(CR);
         B!Insert(LF);
         ForceIndent(I);
         decr(C!ArgV);
       end; |2|
     end "C!IndentDown"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 10-1
     Prt: 06-Jun-84  13:53                                      Rtn C!ColumnDown

     
     ! Create a new line indented to the current column ;
     
     procedure C!ColumnDown;
     begin "C!ColumnDown" |1|
       integer
         I;
     
       if (B!Lock) then
         PuntCommand;
     
       C!ArgV _ C!ArgV max 1;
       I      _ GetColumn - 1;
     
       while (C!ArgV) do
       begin |2|
         MoveToEOL;
         B!Insert(CR);
         B!Insert(LF);
         ForceIndent(I);
         decr(C!ArgV);
       end; |2|
     end "C!ColumnDown"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 11-1
     Prt: 06-Jun-84  13:53                                           Rtn C!MoveF

     
     ! *************************  MOVEMENT COMMANDS  *********************** ;
     
     
     ! Move one character forward ;
     
     simple procedure C!MoveF;
     begin "C!MoveF" |1|
       C!ArgV _ C!ArgV max 1;
     
       while (C!ArgV) do
       begin |2|
         if (B!EndP) then
         begin |3|
           set(C!MAbort);
           done;
         end; |3|
     
         MoveForwards;
         decr(C!ArgV);
       end; |2|
     end "C!MoveF"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 12-1
     Prt: 06-Jun-84  13:53                                           Rtn C!MoveB

     
     ! Move one character backward ;
     
     simple procedure C!MoveB;
     begin "C!MoveB" |1|
       C!ArgV _ C!ArgV max 1;
     
       while (C!ArgV) do
       begin |2|
         if (B!BegP) then
         begin |3|
           set(C!MAbort);
           done;
         end; |3|
     
         MoveBackwards;
         decr(C!ArgV);
       end; |2|
     end "C!MoveB"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 13-1
     Prt: 06-Jun-84  13:53                                         Rtn C!MoveBOL

     
     ! Move to beginning of line ;
     
     simple procedure C!MoveBOL;
     begin |1|
       MoveToBOL;
       C!ArgV _ 0;
     end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 14-1
     Prt: 06-Jun-84  13:53                                         Rtn C!MoveEOL

     
     ! Move to the end of a line ;
     
     simple procedure C!MoveEOL;
     begin |1|
       MoveToEOL;
       C!ArgV _ 0;
     end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 15-1
     Prt: 06-Jun-84  13:53                                          Rtn C!MoveUp

     
     ! Move up a line.
     ;
     
     forward simple procedure C!MoveDown;
     
     simple procedure C!MoveUp;
     begin "C!MoveUp" |1|
       C!ArgV _ C!ArgV max 1;
     
       if (C!LastAddr neq location(C!MoveUp) and
           C!LastAddr neq location(C!MoveDown)) then
         C!StickyColumn _ GetColumn;
     
       while (C!ArgV) do
       begin "move" |2|
         MoveToBOL;
     
         if (B!BegP) then
         begin |3|
           set(C!MAbort);
           done "move";
         end; |3|
     
         MoveBackwards;
         MoveToBOL;
         decr(C!ArgV);
       end "move"; |2|
     
       if (C!ArgV = 0) then
         TryColumn(C!StickyColumn);
     
       C!ArgV _ 0;
     end "C!MoveUp"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 16-1
     Prt: 06-Jun-84  13:53                                        Rtn C!MoveDown

     
     ! Move down to the next line.
     ;
     
     simple procedure C!MoveDown;
     begin "down" |1|
       C!ArgV _ C!ArgV max 1;
     
       if (C!LastAddr neq location(C!MoveUp) and
           C!LastAddr neq location(C!MoveDown)) then
         C!StickyColumn _ GetColumn;
     
       while (C!ArgV) do
       begin "move" |2|
         MoveToEOL;
     
         if (B!EndP) then
         begin |3|
           set(C!MAbort);
           done "move";
         end; |3|
     
         MoveForwards;
         decr(C!ArgV);
       end "move"; |2|
     
       if (C!ArgV = 0) then
         TryColumn(C!StickyColumn);
     
       C!ArgV _ 0;
     end "down"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 17-1
     Prt: 06-Jun-84  13:53                                        Rtn C!ScrollUp

     
     ! "Scroll" the screen up a line.
     ;
     
     simple procedure C!ScrollUp;
     begin |1|
       integer
         SavePoint;
     
       C!ArgV    _ C!ArgV max 1;
       SavePoint _ B!GetP;
       B!SetP(W!GetS);
     
       while (C!ArgV) do
       begin |2|
         MoveToEOL;
         MoveForwards;
         decr(C!ArgV);
       end; |2|
     
       W!SetS(B!GetP);
       B!SetP(SavePoint max B!GetP);
       W!Frame;
     end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 18-1
     Prt: 06-Jun-84  13:53                                      Rtn C!ScrollDown

     
     ! "Scroll" the screen down a line.
     ;
     
     simple procedure C!ScrollDown;
     begin |1|
       integer
         SavePoint;
     
       C!ArgV    _ C!ArgV max 1;
       SavePoint _ B!GetP;
       B!SetP(W!GetS);
     
       while (C!ArgV) do
       begin |2|
         MoveBackWards;
         MoveToBOL;
         decr(C!ArgV);
       end; |2|
     
       W!SetS(B!GetP);
     
       if (G!WrapP) then
       begin |2|
         ! <<  This junk is intended to circumvent a sticky window "Fill"
         !     inconsistency having to do with the fact that the cursor cannot
         !     appear under the vertical bar at the end of a wrapped line.
         !     When the end of the screen appears after the end of a line that
         !     wraps around, the current (circa 3.6.84) window fill logic
         !     forces the cursor to appear at the beginning of the next line,
         !     and this causes a reframe to occur, and THIS nicely changes the
         !     beginning (and end) end of screen.
         ;
         integer
           Tmp;
     
         B!SetP(Tmp _ FindEOS);
     
         if (not AtEOL) then
           decr(Tmp);
     
         B!SetP(SavePoint min Tmp);
       end |2|
       else
         B!SetP(SavePoint min FindEOS);
     
       W!Frame;
     end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 19-1
     Prt: 06-Jun-84  13:53                                          Rtn C!MovTOS

     
     ! Move to the top of the current screen ;
     
     simple procedure C!MovTOS;
       begin "top" |1|
     
         W!Frame;
         B!SetP( W!GetS );
         W!FixS;
         C!ArgV := 0;
     
       end "top"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 20-1
     Prt: 06-Jun-84  13:53                                         Rtn C!LineTOS

     
     ! Move the current line to the top of the screen.
     ;
     
     simple procedure C!LineTOS;
     begin "C!LineTOS" |1|
       integer
         SavePoint;
     
       W!Frame;
       SavePoint _ B!GetP;
       MoveToBOL;
       W!SetS(B!GetP);
       B!SetP(SavePoint);
       C!ArgV _ 0;
     end "C!LineTOS"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 21-1
     Prt: 06-Jun-84  13:53                                         Rtn C!LineBOS

     
     ! Move the current line to the end of the screen.
     ;
     
     simple procedure C!LineBOS;
     begin "C!LineBOS" |1|
     end "C!LineBOS"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 22-1
     Prt: 06-Jun-84  13:53                                          Rtn C!MovBOS

     
     ! Move to the bottom of the current screen.
     ;
     
     simple procedure C!MovBOS;
     begin "C!MovBOS" |1|
       W!Frame;
     
       if (G!WrapP) then
       begin |2|
         ! <<  This junk is intended to circumvent a sticky window "Fill"
         !     inconsistency having to do with the fact that the cursor cannot
         !     appear under the vertical bar at the end of a wrapped line.
         !     When the end of the screen appears after the end of a line that
         !     wraps around, the current (circa 3.6.84) window fill logic
         !     forces the cursor to appear at the beginning of the next line,
         !     and this causes a reframe to occur, and THIS nicely changes the
         !     beginning (and end) end of screen.
         ;
         integer
           Tmp;
     
         B!SetP(Tmp _ FindEOS);
     
         if (not AtEOL) then
           decr(Tmp);
     
         B!SetP(Tmp);
       end |2|
       else
         B!SetP(FindEOS);
     
       W!FixS;
       C!ArgV _ 0;
     end "C!MovBOS"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 23-1
     Prt: 06-Jun-84  13:53                                      Rtn C!NextScreen

     
     ! Move to the next "screen" ;
     ! ** This needs a rewrite to allow for wrapped lines ** ;
     
     simple procedure C!NextScreen;
       begin "next screen" |1|
         own integer C, Count;
     
         if ( C!ArgV <= 0 ) then C!ArgV := 1;
     
         W!Frame;
         B!SetP( W!GetS );
         while ( C!ArgV ) do
           begin "argv times" |2|
             Count := W!Size - 1;    ! want to skip this many lines ;
             while ( Count ) do
               begin "count times" |3|
                 if ( B!EndP ) then done "argv times";
                 C := B!GetC;
                 if ( C = FF ) then
                   Count := 0
                 else if ( B!GetC = CR ) then
                   Count := Count - 1;
                 MoveForwards;
               end "count times"; |3|
             if ( B!GetC = FF ) then MoveForwards;
             if ( not B!EndP ) then W!SetS( B!GetP );
             C!ArgV := C!ArgV - 1;
           end "argv times"; |2|
     
         W!FixS;
         C!ArgV := 0;
     
       end "next screen"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 24-1
     Prt: 06-Jun-84  13:53                                     Rtn C!PriorScreen

     
     ! Move to the prior "screen" ;
     ! ** This needs to be rewrittne to allow for wrapped lines ** ;
     
     simple procedure C!PriorScreen;
       begin "prior screen" |1|
         own integer C, Count;
     
         if ( C!ArgV <= 0 ) then C!ArgV := 1;
     
         W!Frame;
         B!SetP( W!GetS );
     
         while ( C!ArgV ) do
           begin "argv times" |2|
             MoveBackwards;
             if ( B!GetC = FF ) then MoveBackwards;
             Count := W!Size;
             C := NULL;
             while ( true ) do
               begin "count times" |3|
                 C := B!GetC;
                 if ( B!BegP ) then done "argv times";
                 if ( C = FF ) then Count := 0
                 else if ( C = CR ) then Count := Count - 1;
                 if ( Count = 0 ) then done "count times";
                 MoveBackwards;
               end "count times"; |3|
             if ( Count = 0 ) then MoveForwards;
             W!SetS( B!GetP );
             C!ArgV := C!ArgV - 1;
           end "argv times"; |2|
     
         W!FixS;
         C!ArgV := 0;
     
       end "prior screen"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 25-1
     Prt: 06-Jun-84  13:53                                          Rtn C!MovBOP

     
     ! Move to the beginning of the current page ;
     
     simple procedure C!MovBOP;
       begin |1|
         integer Temp1;
     
         MoveBackwards;
         if ( not B!BegP ) then
           begin |2|
             forever do
               begin "a page" |3|
                 Temp1 := B!GetC;
                 if ( Temp1 = FF ) then
                   begin |4|
                     MoveForwards;
                     done "a page";
                   end; |4|
                 if ( B!BegP ) then done "a page";
                 MoveBackwards;
               end "a page"; |3|
           end; |2|
         W!FixS;
         C!ArgV := 0;
       end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 26-1
     Prt: 06-Jun-84  13:53                                          Rtn C!MovEOP

     
     ! Move to the end of the current page ;
     
     simple procedure C!MovEOP;
       begin |1|
         integer Temp1;
     
         W!FixS;
     
         forever do
           begin "a page" |2|
             if ( B!EndP ) then done "a page";
             Temp1 := B!GetC;
             if ( Temp1 = FF ) then done "a page";
             MoveForwards;
           end "a page"; |2|
         C!ArgV := 0;
       end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 27-1
     Prt: 06-Jun-84  13:53                                          Rtn C!MovBOB

     
     ! Move to the beginning of the buffer ;
     
     simple procedure C!MovBOB;
       begin |1|
         B!SetP( 0 );
         W!FixS;
         C!ArgV := 0;
       end; |1|
     
     
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 28-1
     Prt: 06-Jun-84  13:53                                          Rtn C!MovEOB

     
     ! Move to the end of the buffer ;
     
     simple procedure C!MovEOB;
       begin |1|
         B!SetP( '377777777777 );    ! this *should* get us to the end ;
         W!FixS;
         C!ArgV := 0;
       end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 29-1
     Prt: 06-Jun-84  13:53                                            Rtn C!DelF

     
     ! **************************  DELETE COMMANDS  ***************************;
     
     ! Delete one character forward ;
     
     simple procedure C!DelF;
     begin |1|
       if (C!ArgV <= 0) then
         C!ArgV _ 1;
     
       while (C!ArgV) do
       begin |2|
         integer
           Char;
     
         Char _ B!GetC;
         B!Delete(FORWARDS);
     
         if (Char = CR and B!GetC = LF) then
           B!Delete(FORWARDS);
     
         decr(C!ArgV);
       end; |2|
     end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 30-1
     Prt: 06-Jun-84  13:53                                            Rtn C!DelB

     
     ! Delete one character backward.  The reason we backup, look at the
     !  character, then move forward and backdelete is to avoid gap shifts. ;
     
     simple procedure C!DelB;
     begin |1|
       boolean
         ReFrameP;
     
       if (C!ArgV <= 0) then
         C!ArgV _ 1;
     
       ReFrameP _ false;
     
       while (C!ArgV) do
       begin |2|
         if (B!BegP) then
         begin |3|
           C!ArgV _ 0;
           return;
         end; |3|
     
         ReFrameP _ W!GetS = B!GetP;
         MoveBackwards;
     
         if (B!GetC = CR) then
         begin |3|
           B!Delete(FORWARDS);
     
           if (B!GetC = LF) then
             B!Delete(FORWARDS);
         end |3|
         else
           B!Delete(FORWARDS);
     
         decr(C!ArgV);
       end; |2|
     
       if (ReFrameP) then
       begin |2|
         MoveBackwards;
         W!Disp(true);
         MoveForwards;
       end; |2|
     
         ! Reframe if the point is at the beginning of the window ;
     end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 31-1
     Prt: 06-Jun-84  13:53                                       Rtn C!DelWhiteF

     
     ! Delete whitespace forwards ;
     
     simple procedure C!DelWhiteF;
     begin |1|
       while (C!IsWhiteP) do
         B!Delete(FORWARDS);
     
       C!ArgV _ 0;
     end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 32-1
     Prt: 06-Jun-84  13:53                                           C!DelWhiteB

     
     ! Delete whitespace backwards ;
     
     simple procedure C!DelWhiteB;
     begin |1|
       while (not B!BegP) do
       begin |2|
         B!Move(BACKWARDS);
     
         if (C!IsWhiteP) then
           B!Delete(FORWARDS)
         else
         begin |3|
           B!Move(FORWARDS);
           done;
         end; |3|
       end; |2|
     
       C!ArgV _ 0;
     end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 33-1
     Prt: 06-Jun-84  13:53                                        Rtn C!DelNULLs

     
     ! delete all nulls in a file ;
     
     procedure C!DelNULLs;
     begin |1|
       integer
         SavePoint;
     
       if (B!Lock) then
       begin |2|
         W!Msg("Buffer must be unlocked to delete nulls.");
         PuntCommand;
       end; |2|
     
       C!ArgV _ 0;
       B!SetM((SavePoint _ B!AllocateMark), B!GetP);
       B!SetP(0);
     
       while (not B!EndP) do
       begin |2|
         if (B!GetC = null) then
           B!Delete(FORWARDS)
         else B!Move(FORWARDS);
       end; |2|
     
       B!SetP(B!GetM(SavePoint));
       B!DeallocateMark(SavePoint);
     end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 34-1
     Prt: 06-Jun-84  13:53                                         Rtn C!SetMark

     
     ! Set a mark at the current point ;
     
     procedure C!SetMark;
     begin |1|
       if (0 <= C!ArgV <= 9) then
       begin |2|
         B!SetM(C!ArgV, B!GetP);
         W!Msg("Mark " & cvs(C!ArgV) & " Set");
       end |2|
       else
       begin |2|
         W!Msg("Bad Mark Number - " & cvs(C!ArgV));
         T!Bell;
       end; |2|
     
       C!ArgV _ 0;
     end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 35-1
     Prt: 06-Jun-84  13:53                                        Rtn C!GotoMark

     
     ! Go to a specified Mark ;
     
     procedure C!GotoMark;
     begin |1|
       integer
         M;
     
       if (0 <= C!ArgV <= 9) then
       begin |2|
         M _ B!GetM(C!ArgV);
     
         if (M < 0) then
           W!Msg("Mark " & cvs(C!ArgV) & " isn't set")
         else
           B!SetP(M);
       end |2|
       else
       begin |2|
         W!Msg("Bad Mark Number - " & cvs(C!ArgV));
         T!Bell;
       end; |2|
     
       C!ArgV _ 0;
     end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 36-1
     Prt: 06-Jun-84  13:53                                       Rtn C!ClearMark

     
     ! Deallocate a user mark.
     ;
     
     simple procedure C!ClearMark;
     begin "C!ClearMark" |1|
       if (0 <= C!ArgV <= 9) then
       begin |2|
         B!DeallocateMark(C!ArgV);
         W!Msg("Mark " & cvs(C!ArgV) & " cleared");
       end |2|
       else
       begin |2|
         W!Msg("Bad Mark Number - " & cvs(C!ArgV));
         T!Bell;
       end; |2|
     
       C!ArgV _ 0;
     end "C!ClearMark"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 37-1
     Prt: 06-Jun-84  13:53                                          Rtn C!SwapPM

     
     ! Swap the point and the mark ;
     
     procedure C!SwapPM;
       begin |1|
         integer T, M;
         if (( C!ArgV < 0 ) or ( C!ArgV > 9 )) then
           begin |2|
             W!Msg( "Bad Mark Number - " & cvs( C!ArgV ));
           end |2|
         else
           begin |2|
             T := B!GetP;
             M := B!GetM( C!ArgV );
             if ( M < 0 ) then
               W!Msg( "Mark " & cvs( C!ArgV )& " isn't set" )
             else
               begin |3|
                 B!SetP( M );
                 B!SetM( C!ArgV, T );
               end; |3|
             W!FixS;
           end; |2|
         C!ArgV := 0;
       end; |1|
     
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 38-1
     Prt: 06-Jun-84  13:53                                         Rtn C!Refresh

     
     ! ************************  MISCELLANEOUS COMMANDS  ********************* ;
     
     
     ! Routine to refresh the screen. ;
     
     simple procedure C!Refresh;
       begin |1|
         C!ArgV := 0;
         T!RSet;             ! reset the terminal (just in case) ;
         R!Init;
         W!NewS;
         W!Disp( false );
       end; |1|
     
     
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 39-1
     Prt: 06-Jun-84  13:53                                       Rtn C!Redislpay

     
     ! Force a non-interruptible redisplay ;
     
     simple procedure C!Redisplay;
       begin |1|
         C!ArgV := 0;
         W!NewS;
         W!Disp( false );
       end; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 40-1
     Prt: 06-Jun-84  13:53                                         Rtn C!Twiddle

     
     ! Routine to "twiddle" the last two characters ;
     ;
     
     simple procedure C!Twiddle;
     begin "C!Twiddle" |1|
       boolean
         CrlfP;
       own integer
         C,
         SavePoint;
     
       if ((SavePoint _ B!GetP) >= 2) then
       begin |2|
         B!Move(BACKWARDS);
     
         C _ B!GetC;
         B!Delete(FORWARDS);
         B!Move(BACKWARDS);
     
         clear(CrlfP);
     
         if (C = LF and B!GetC = CR) then
         begin |3|
           B!Delete(FORWARDS);
           B!Move(BACKWARDS);
           set(CrlfP);
         end; |3|
     
         if (B!GetC = LF) then
         begin |3|
           B!Move(BACKWARDS);
     
           if (B!GetC neq CR) then
             B!Move(FORWARDS);
         end; |3|
     
         if (CrlfP) then
         begin |3|
           B!Insert(CR);
           B!Insert(LF);
           clear(CrlfP);
         end |3|
         else
           B!Insert(C);
     
         B!SetP(SavePoint);
       end; |2|
     
       C!ArgV _ 0;
     end "C!Twiddle"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 41-1
     Prt: 06-Jun-84  13:53                                          Rtn C!Toggle

     
     ! Routine to toggle the case of a character ;
     
     simple procedure C!Toggle;
       begin "toggle" |1|
         own integer C;
     
         if ( C!ArgV <= 0 ) then C!ArgV := 1;
     
         while ( C!ArgV ) do
           begin |2|
             C := B!GetC;
             if ( "A" <= C <= "Z" ) then
               C := C + '40
             else if ( "a" <= C <= "z" ) then
               C := C - '40;
             if ( C neq B!GetC ) then
               begin |3|
                 B!Delete( FORWARDS );
                 B!Insert( C );
               end |3|
             else
               B!Move( FORWARDS );
             C!ArgV := C!ArgV - 1;
           end; |2|
     
       end "toggle"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 42-1
     Prt: 06-Jun-84  13:53                                        Rtn C!IncrChar

     
     ! Increment (modulo 128) the ascii value of the character following the
     point. ;
     
     simple procedure C!IncrChar;
     begin "C!IncrChar" |1|
       integer
         Char;
     
       if (B!EndP) then
         PuntCommand;
     
       if (not C!ArgV) then
         C!ArgV _ 1;
     
       Char _ (B!GetC + C!ArgV) land !mask(7);
       B!Delete(FORWARDS);
       B!Insert(Char);
       B!Move(BACKWARDS);
       C!ArgV _ 0;
     end "C!IncrChar"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 43-1
     Prt: 06-Jun-84  13:53                                        Rtn C!DecrChar

     
     ! Increment (modulo 128) the ascii value of the character following the
     ! point. ;
     
     simple procedure C!DecrChar;
     begin "C!DecrChar" |1|
       integer
         Char;
     
       if (B!EndP) then
         PuntCommand;
     
       if (not C!ArgV) then
         C!ArgV _ 1;
     
       Char _ (B!GetC - C!ArgV) land !mask(7);
       B!Delete(FORWARDS);
       B!Insert(Char);
       B!Move(BACKWARDS);
       C!ArgV _ 0;
     end "C!DecrChar"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 44-1
     Prt: 06-Jun-84  13:53                                 Rtn C!ForceLeftMargin

     
     ! Force the current line to have a specified (or the default) left margin.
     ;
     
     simple procedure C!ForceLeftMargin;
     begin "C!ForceLeftMargin" |1|
       ForceIndent((if (C!ArgV) then C!ArgV else C!LeftMargin) - 1);
       C!ArgV _ 0;
     end "C!ForceLeftMargin"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 45-1
     Prt: 06-Jun-84  13:53                                      Rtn C!ShowColumn

     
     ! Display the indentity of the column to the right of the point.
     ;
     
     simple procedure C!ShowColumn;
     begin "C!ShowColumn" |1|
       W!Msg("Column: " & cvs(GetColumn));
       C!ArgV _ 0;
     end "C!ShowColumn"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 46-1
     Prt: 06-Jun-84  13:53                                       Rtn C!ShowOctal

     
     ! Display the octal for the character following the point.
     ;
     
     simple procedure C!ShowOctal;
     begin "C!ShowOctal" |1|
       W!Msg("Octal of next character: '" & cvos(B!GetC));
       C!ArgV _ 0;
     end "C!ShowOctal"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 47-1
     Prt: 06-Jun-84  13:53                                     Rtn C!InsertOctal

     
     ! Insert the character whose octal value is input.
     ;
     
     simple procedure C!InsertOctal;
     begin "C!InsertOctal" |1|
       integer
         C,
         Oct;
       string
         Prompt;
     
       Prompt _ "Enter Octal of the character to be inserted: '";
     
       while (true) do
       begin |2|
         if (C!ReadString(Prompt, ESC, CR)) then
         begin |3|
           Oct _ cvo(C!String);
           W!Msg(Prompt & C!String);
     
           if (Oct <= DEL and kequ(cvos(Oct), C!String)) then
           begin |4|
             C _ C!Cmd;
             C!Cmd _ Oct;
             C!Insert;
             C!Cmd _ C;
             done;
           end; |4|
         end; |3|
       end; |2|
     
       W!Msg(null);
     end "C!InsertOctal"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 48-1
     Prt: 06-Jun-84  13:53                                   Rtn C!SetAppendKill

     
     ! Make the next kill append to the kill buffer.
     ;
     
     simple procedure C!SetAppendKill;
     begin "C!SetAppendKill" |1|
       set(G!AppendKillP);
       C!ArgV _ 0;
     end "C!SetAppendKill"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 49-1
     Prt: 06-Jun-84  13:53                                        Rtn C!FillLine

     
     ! Force the current line to be filled within the defined margins.
     ;
     
     simple procedure C!FillLine;
     begin "C!FillLine" |1|
       integer
         Col,
         SavMk;
     
       B!SetM((SavMk _ B!AllocateMark), B!GetP);
       MoveToEOL;
     
       if (GetColumn > C!RightMargin + 1) then
       begin |2|
         integer
           EndMk;
     
         B!SetM((EndMk _ B!AllocateMark), B!GetP);
     
         TryColumn(C!RightMargin + 1);
         SkipWS(BACKWARDS);
         SkipNWS(BACKWARDS);
         SkipWS(BACKWARDS);
         SkipNWS(BACKWARDS);
     
         Col _ GetColumn;
         DoFill(Col, EndMk, C!LeftMargin, C!RightMargin);
         B!SetP(B!GetM(SavMk));
         B!DeallocateMark(EndMk);
       end |2|
       else
         B!SetP(B!GetM(SavMk));
     
       B!DeallocateMark(SavMk);
     end "C!FillLine"; |1|
     Cre: 30-Apr-84  09:29  (PEAKX)COMM1.REQ                           Page 50-1
     Prt: 06-Jun-84  13:53                                     Rtn C!InsStrToCol

     
     ! Insert characters from an input string until you reach the right-most
     ! position less than or equal to a specified column, depending upon the
     ! width of the string.  (Remember that the width of a string can vary
     ! contingent upon various factors).
     ;
     
     simple procedure C!InsStrToCol;
     begin "C!InsStrToCol" |1|
       integer
         C,
         CAddr,
         NewCol,
         SavCmd,
         ThisCol,
         Width;
       string
         Prompt,
         Str;
     
       ThisCol _ GetColumn;
       NewCol  _ C!ArgV;
       C!ArgV  _ 0;
       Prompt  _ "String to Insert:";
     
       if (C!ReadString(Prompt, CR, ESC) and NewCol > ThisCol) then
       begin |2|
         SavCmd _ C!Cmd;
         CAddr  _ C!Addr;
         C!Addr _ location(C!Insert);
     
         Str    _ C!String;
     
         while ((ThisCol +
             (Width _ CharWidth((C _ lop(Str)), ThisCol))) <= NewCol) do
         begin |3|
           C!Cmd _ C;
           C!Insert;
     
           incr(ThisCol, Width);
     
           if (not length(Str)) then
             Str _ C!String;
         end; |3|
     
         C!Cmd  _ SavCmd;
         C!Addr _ CAddr;
       end |2|
       else
         W!Msg(null);
     end "C!InsStrToCol"; |1|
     
     
     ! **************************  End of COMM1.REQ **************************;





                                                      
                                                      
                                                      
                                          
                                          
                                          
                                    
                                    
                                    
                              
                              
                              
                              
                              
                              
                              
                              
                              
                                                      
                                                      
                                                      



                              
                              
                              
                                    
                                    
                                    
                        
                        
                        
                  
                  
                  
                  
                  
                  
                  
                  
                  
                                          
                                          
                                          




                          
                  
               
                  
              
               
                            

     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                            Page 1-1
     Prt: 06-Jun-84  13:53               COMM2 - Commands of moderate complexity

     
     ! *************************************************************************
     *                                                                         *
     *                                  COMM2                                  *
     *                     Commands of moderate complexity                     *
     *                                                                         *
     ***************************************************************************
     
     
                This file is required as a source!file in COMAND.SAI.
     
     
     **************************************************************************;
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                            Page 2-1
     Prt: 06-Jun-84  13:53                                       Rtn C!DelTokenF

     
     ! "Token" delete stuff.  This is sort of cute.  We delete grayspace
     !  until non-grayspace is seen.  We take the first non-gray character
     !  and save the descriptive bits from C!Tab which tell what kind of things
     !  this character may be.  This character is deleted.  The descriptive
     !  bits of the next character are ANDed with the bits.  If non-zero, then
     !  the character is of the same token class, and may be deleted.
     !  This idea attributed to Tim Brengle. ;
     
     procedure C!DelTokenF;
       begin "delete token forward" |1|
         integer TokenBits;
     
         if ( B!Lock ) then PuntCommand;
     
         if ( not C!ArgV ) then C!ArgV := 1;
     
         while ( C!ArgV ) do
           begin "do a token" |2|
             forever do
               begin "grayspace" |3|
                 if ( B!EndP ) then PuntCommand;
                 if ( C!IsGrayP ) then
                   B!Delete( FORWARDS )
                 else
                   done "grayspace";
               end "grayspace"; |3|
             TokenBits := C!Tab[ B!GetC ] land ChrMask;
             B!Delete( FORWARDS );
             forever do
               begin "this token" |3|
                 if ( B!EndP ) then PuntCommand;
                 TokenBits := TokenBits land C!Tab[ B!GetC ];
                 if ( LH( TokenBits ) = 0 ) then done "this token";
                 B!Delete( FORWARDS );
               end "this token"; |3|
             C!ArgV := C!ArgV - 1;
           end "do a token"; |2|
     
       end "delete token forward"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                            Page 3-1
     Prt: 06-Jun-84  13:53                                       Rtn C!DelTokenB

     
     ! Delete a token backwards. ;
     
     procedure C!DelTokenB;
     begin "C!DelTokenB" |1|
       integer
         TokenBits;
     
       if (B!Lock) then
         PuntCommand;
     
       if (not C!ArgV) then
         C!ArgV _ 1;
     
       while (C!ArgV) do
       begin "do a token" |2|
         while (true) do
         begin "grayspace" |3|
           if (B!BegP) then
             PuntCommand;
     
           B!Move(BACKWARDS);
     
           if (C!IsGrayP) then
             B!Delete(FORWARDS)
           else
             done "grayspace";
         end "grayspace"; |3|
     
         TokenBits _ C!Tab[B!GetC] land ChrMask;
         B!Delete(FORWARDS);
     
         while (true) do
         begin "this token" |3|
           if(B!BegP) then
             PuntCommand;
     
           B!Move(BACKWARDS);
           TokenBits _ TokenBits land C!Tab[B!GetC];
     
           if (LH(TokenBits) = 0) then
             done "this token";
     
           B!Delete(FORWARDS);
         end "this token"; |3|
     
         B!Move(FORWARDS);
         decr(C!ArgV);
       end "do a token"; |2|
     
       if (W!GetS = B!GetP) then
       begin |2|
         MoveBackwards;
         W!Disp(true);
         MoveForwards;
       end; |2|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                            Page 3-2
     Prt: 06-Jun-84  13:53                                       Rtn C!DelTokenB

     
         ! Reframe if the point is at the beginning of the window ;
     end "C!DelTokenB"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                            Page 4-1
     Prt: 06-Jun-84  13:53                                       Rtn C!MovTokenF

     
     !  Routine to move forward over a token . ;
     
     procedure C!MovTokenF;
     begin "move token forward" |1|
       integer TokenBits;
     
       if ( not C!ArgV ) then
         C!ArgV := 1;
     
       while ( C!ArgV ) do
       begin "do a token" |2|
         SkipGraySpace;
     
         if (B!EndP) then
           PuntCommand;
     
         TokenBits := C!Tab[ B!GetC ] land ChrMask;
     
         forever do
         begin "this token" |3|
           if ( B!EndP ) then
             PuntCommand;
     
           B!Move( FORWARDS );
           TokenBits := TokenBits land C!Tab[ B!GetC ];
     
           if ( LH( TokenBits ) = 0 ) then
             done "this token";
         end "this token"; |3|
     
         C!ArgV := C!ArgV - 1;
       end "do a token"; |2|
     end "move token forward"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                            Page 5-1
     Prt: 06-Jun-84  13:53                                       Rtn C!MovTokenB

     
     ! Move backwards over a token . ;
     
     procedure C!MovTokenB;
     begin "move token backwards" |1|
       integer TokenBits;
     
       if ( not C!ArgV ) then
         C!ArgV := 1;
     
       while ( C!ArgV ) do
       begin "do a token" |2|
         forever do
         begin "grayspace" |3|
           if ( B!BegP ) then
             PuntCommand;
     
           B!Move( BACKWARDS );
     
           if ( not C!IsGrayP ) then
             done "grayspace";
         end "grayspace"; |3|
     
         TokenBits := C!Tab[ B!GetC ] land ChrMask;
     
         forever do
         begin "this token" |3|
           if( B!BegP ) then
             PuntCommand;
     
           B!Move( BACKWARDS );
           TokenBits := TokenBits land C!Tab[ B!GetC ];
     
           if ( LH( TokenBits ) = 0 ) then
             done "this token";
         end "this token"; |3|
     
         B!Move( FORWARDS );
         C!ArgV := C!ArgV - 1;
       end "do a token"; |2|
     end "move token backwards"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                            Page 6-1
     Prt: 06-Jun-84  13:53                                         Rtn C!TokenUC

     
     ! Force a token to upper case ;
     
     procedure C!TokenUC;
     begin "force token UC" |1|
       integer TokenBits, C;
     
       if ( B!Lock ) then
         PuntCommand;
     
       if ( not C!ArgV ) then
         C!ArgV := 1;
     
       while ( C!ArgV ) do
       begin "do a token" |2|
         SkipGraySpace;
     
         if (B!EndP) then
           PuntCommand;
     
         TokenBits := C!Tab[ B!GetC ] land ChrMask;
     
         forever do
         begin "this token" |3|
           if ( B!EndP ) then
             PuntCommand;
     
           C := B!GetC;
           TokenBits := TokenBits land C!Tab[ C ];
     
           if ( LH( TokenBits ) = 0 ) then
             done "this token";
     
           if (( C >= "a" ) and ( C <= "z" )) then
           begin |4|
             B!Delete( FORWARDS );
             B!Insert( C - '40 );
           end |4|
           else
             B!Move( FORWARDS );
         end "this token"; |3|
         C!ArgV := C!ArgV - 1;
       end "do a token"; |2|
     
     end "force token UC"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                            Page 7-1
     Prt: 06-Jun-84  13:53                                         Rtn C!TokenLC

     
     ! Force a token to lower case ;
     
     procedure C!TokenLC;
     begin "force token LC" |1|
       integer TokenBits, C;
     
       if ( B!Lock ) then
         PuntCommand;
     
       if ( not C!ArgV ) then
         C!ArgV := 1;
     
       while ( C!ArgV ) do
       begin "do a token" |2|
         SkipGraySpace;
     
         if (B!EndP) then
           PuntCommand;
     
         TokenBits := C!Tab[ B!GetC ] land ChrMask;
     
         forever do
         begin "this token" |3|
           if ( B!EndP ) then
             PuntCommand;
     
           C := B!GetC;
           TokenBits := TokenBits land C!Tab[ C ];
     
           if ( LH( TokenBits ) = 0 ) then
             done "this token";
     
           if (( C >= "A" ) and ( C <= "Z" )) then
           begin |4|
             B!Delete( FORWARDS );
             B!Insert( C + '40 );
           end |4|
           else
             B!Move( FORWARDS );
         end "this token"; |3|
     
         C!ArgV := C!ArgV - 1;
       end "do a token"; |2|
     end "force token LC"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                            Page 8-1
     Prt: 06-Jun-84  13:53                                     Rtn C!TokenToggle

     
     ! Toggle the case of a token ;
     
     procedure C!TokenToggle;
     begin "toggle case" |1|
       integer TokenBits, C;
     
       if ( B!Lock ) then
         PuntCommand;
     
       if ( not C!ArgV ) then
         C!ArgV := 1;
     
       while ( C!ArgV ) do
       begin "do a token" |2|
         SkipGraySpace;
     
         if (B!EndP) then
           PuntCommand;
     
         TokenBits := C!Tab[ B!GetC ] land ChrMask;
     
         forever do
         begin "this token" |3|
           if ( B!EndP ) then
             PuntCommand;
     
           C := B!GetC;
           TokenBits := TokenBits land C!Tab[ C ];
     
           if ( LH( TokenBits ) = 0 ) then
             done "this token";
     
           if (( C >= "A" ) and ( C <= "Z" )) then
           begin |4|
             B!Delete( FORWARDS );
             B!Insert( C + '40 );
           end |4|
           else if (( C >= "a" ) and ( C <= "z" )) then
           begin |4|
             B!Delete( FORWARDS );
             B!Insert( C - '40 );
           end |4|
           else
             B!Move( FORWARDS );
         end "this token"; |3|
     
         C!ArgV := C!ArgV - 1;
       end "do a token"; |2|
     end "toggle case"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                            Page 9-1
     Prt: 06-Jun-84  13:53                                 Rtn C!CapitalizeToken

     
     ! Force the next token into standard capitalization.
     ;
     
     simple procedure C!CapitalizeToken;
     begin "C!CapitalizeToken" |1|
       integer
         C,
         TokenBits;
     
       if (not C!ArgV) then
         C!ArgV _ 1;
     
       while (C!ArgV) do
       begin |2|
         SkipGraySpace;
     
         if (B!EndP) then
           PuntCommand;
     
         C _ B!GetC;
         TokenBits _ C!Tab[C] land ChrMask;
     
         if (IsLower(C)) then
         begin |3|
           B!Delete(FORWARDS);
           B!Insert(UpShift(C));
         end |3|
         else
           B!Move(FORWARDS);
     
         while (true) do
         begin |3|
           if (B!EndP) then
             PuntCommand;
     
           C _ B!GetC;
           TokenBits _ TokenBits land C!Tab[C];
     
           if (lh(TokenBits) = 0) then
             done;
     
           if (IsUpper(C)) then
           begin |4|
             B!Delete(FORWARDS);
             B!Insert(DownShift(C));
           end |4|
           else
             B!Move(FORWARDS);
         end; |3|
     
         decr(C!ArgV);
       end; |2|
     end "C!CapitalizeToken"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 10-1
     Prt: 06-Jun-84  13:53                                        Rtn C!MovSpecF

     
     ! Move to the next 'special' character.
     ;
     
     simple procedure C!MovSpecF;
     begin  |1|
       if (not C!ArgV) then
         C!ArgV _ 1;
     
       while (C!ArgV) do
       begin |2|
         if (not MoveTo(C!IsSpecial, FORWARDS)) then
           done;
     
         B!Move(FORWARDS);
         decr(C!ArgV);
       end; |2|
     
       C!ArgV _ 0;
     end ; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 11-1
     Prt: 06-Jun-84  13:53                                        Rtn C!MovSpecB

     
     ! Move to the previous 'special' character.
     ;
     
     simple procedure C!MovSpecB;
     begin  |1|
       if (not C!ArgV) then
         C!ArgV _ 1;
     
       while (C!ArgV) do
       begin |2|
         if (not MoveTo(C!IsSpecial, BACKWARDS)) then
           done;
     
         decr(C!ArgV);
       end; |2|
     
       C!ArgV _ 0;
     end; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 12-1
     Prt: 06-Jun-84  13:53                                         Macro KillChr

     
     ! Kill the next logical character, placing it in the Kill Buffer if
     ! possible.  This macro assumes that the following variables exist in the
     ! scope in which it is invoked:
     !
     !       Cont.Flg        Continuation Flag,
     !                         if = 0 we may insert into KB
     !       C!KillBP        Pointer into the KB
     !       C!KillCnt       The number of characters in the KB.
     !
     ! If parameter Parm1 = "EOL", we want to delete a CRLF.
     ! Otherwise, we will insert its value into the KB. ;
     
     
     define
       KillChr (Parm1) =
       { |1|
         assignc Parm1 = scanc(cvps(Parm1), null, null, "IK");
     
         ifcr (equ(cvps(Parm1), "EOL")) thenc
           B!Delete(FORWARDS);
           B!Delete(FORWARDS);
     
          if (not Cont.Flg) then
           begin |2|
             idpb(CR, C!KillBP);
             idpb(LF, C!KillBP);
             incr(C!KillCnt, 2);
           end; |2|
         elsec
           B!Delete(FORWARDS);
     
           if (not Cont.Flg) then
           begin |2|
             idpb(Parm1, C!KillBP);
             incr(C!KillCnt);
           end |2|
         endc
       }; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 13-1
     Prt: 06-Jun-84  13:53                                       Macro AbortKill

     
     ! Abort a text-killing operation, by removing the text killed by this
     ! invocation of the command from the Kill Buffer and replacing it in the
     ! Text Buffer.  Both the parameters
     !
     !       BP              A byte-pointer to the removable section of the KB
     !       Count           The number of characters to remove
     !
     ! need to be variables, for they are manipulated as reference objects ;
     
     
     define
       AbortKill (BP, Count) =
       { |1|
         while (Count) do
         begin |2|
           B!Insert(ildb(BP));
           decr(Count);
         end |2|
       }; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 14-1
     Prt: 06-Jun-84  13:53                                        Macro SaveKill

     
     ! Save a text-killing operation, leaving as many lines as will fit
     ! completely in the Kill Buffer intact, and returning the leading portion
     ! of the line that will not to the Text Buffer.  This macro assumes that
     ! the following variables exist in the scope in which it is invoked:
     !
     !       C!KillBP        Pointer into the KB
     !       C!KillCnt       The number of characters in the KB.
     ;
     
     define
       SaveKill =
       { |1|
         begin |2|
           integer
             Char;
     
           while (C!KillCnt and
               (Char _ ldb(C!KillBP)) neq LF and Char neq FF) do
           begin |3|
             B!Insert(Char);
             B!Move(BACKWARDS);
             C!KillBP _ DecrBP(C!KillBP);
             decr(C!KillCnt);
           end; |3|
         end |2|
       }; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 15-1
     Prt: 06-Jun-84  13:53                                      Rtn KBFullPrompt

     
     ! Ask the user what to do when the kill buffer fills up, and force him to
     ! answer sensibly ;
     
     simple integer procedure KBFullPrompt;
     begin "KBFullPrompt" |1|
       integer
         Char;
       string
         Prompt;
       define
         UpShift (X) = {(X land (lnot '40))},
         ToUpper (X) = {(if ("a" <= X <= "z") then UpShift(X) else X)};
     
     
       Char   _ 0;
       Prompt _ "Kill Buffer Full - Enter (A)bort, (P)roceed or (S)ave: ";
     
       while (not Char) do
       begin |2|
         if (not C!ReadString(Prompt, CR, ESC)) then
           Char _ 0
         else
           Char _ ToUpper(C!String);
     
         if (Char) then
         begin |3|
           W!Msg(
             Prompt & 
               (if (Char = "A") then "Abort"
               else if (Char = "S") then "Save"
               else if (Char = "P") then "Proceed"
               else Char)
           );
     
           W!Disp(true);
     
           if (Char = "A" or Char = "P" or Char = "S") then
             done
           else
             Char _ 0;
         end; |3|
     
         T!Bell;
       end; |2|
     
       return(Char);
     end "KBFullPrompt"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 16-1
     Prt: 06-Jun-84  13:53                               Rtn SearchStrFullPrompt

     
     ! Ask the user what to do when the search string fills up in the process
     of a copy to it ;
     
     simple integer procedure SearchStrFullPrompt;
     begin "SearchStrFullPrompt" |1|
       integer
         Char;
       string
         Prompt;
       define
         UpShift (X) = {(X land (lnot '40))},
         ToUpper (X) = {(if ("a" <= X <= "z") then UpShift(X) else X)};
     
     
       Char   _ 0;
       Prompt _ "Search String Full - Enter (A)bort or (P)roceed: ";
     
       while (not Char) do
       begin |2|
         if (not C!ReadString(Prompt, CR, ESC)) then
           Char _ 0
         else
           Char _ ToUpper(C!String);
     
         if (Char) then
         begin |3|
           W!Msg(
             Prompt & 
               (if (Char = "A") then "Abort"
               else if (Char = "P") then "Proceed"
               else Char)
           );
     
           W!Disp(true);
     
           if (Char = "A" or Char = "P") then
             done
           else
             Char _ 0;
         end; |3|
     
         T!Bell;
       end; |2|
     
       return(Char);
     end "SearchStrFullPrompt"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 17-1
     Prt: 06-Jun-84  13:53                                    Rtn C!CopyToSearch

     
     ! Copy text into the search string.
     ;
     
     simple procedure C!CopyToSearch;
     begin "C!CopyToSearch" |1|
       integer
         Mark,
         HowMany,
         Temp;
     
       Mark   _ C!ArgV;
       C!ArgV _ 0;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       if ((Mark < 0) or (Mark > 9)) then
       begin |2|
         W!Msg("Bad Mark Number - " & cvs(Mark));
         T!Bell;
         return;
       end; |2|
      
       if (B!GetM(Mark) < 0) then
       begin |2|
         W!Msg("Mark " & cvs(Mark) & " not set");
         T!Bell;
         return;
       end; |2|
     
       if (B!GetM(Mark) = B!GetP) then
       begin |2|
         W!Msg("The Point and Mark " & cvs(Mark) & " are in the same place");
         T!Bell;
         return;
       end; |2|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       HowMany _ abs(B!GetP - B!GetM(Mark));
     
       if (HowMany > MAXSEARCHSTRING) then
       begin |2|
         if (SearchStrFullPrompt neq "P") then
           return
         else
           HowMany _ MAXSEARCHSTRING;
       end; |2|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       C!Search _ NULL;
     
       if (B!GetP > B!GetM(Mark)) then
       begin |2|
         Temp _ B!GetP;
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 17-2
     Prt: 06-Jun-84  13:53                                    Rtn C!CopyToSearch

         B!SetP(B!GetM(Mark));
         B!SetM(Mark, Temp);
       end; |2|
     
       while (HowMany > 0) do
       begin |2|
         C!Search _ C!Search & B!GetC;
         B!Move(FORWARDS);
         decr(HowMany);
       end; |2|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       W!Msg("Search String Set");
     end "C!CopyToSearch"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 18-1
     Prt: 06-Jun-84  13:53                                        Rtn C!DelToEOL

     
     ! Delete to the end of the Line, copying text into the kill buffer, if
     !  there's room.  If there is no room in kill buffer, prompt the user for
     !  verification. ;  
     
     forward simple procedure C!DelEOL;
     forward simple procedure C!Wipe;
     
     simple procedure C!DelToEOL;
     begin |1|
       own integer
         Cont.Flg,
         SaveBP,
         SaveCnt,
         SavePt,
         Temp1;
       define
         Eol = {Eol};
     
       if (B!Lock or B!EndP) then
         PuntCommand;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       if (not G!AppendKillP and
           C!LastAddr neq location(C!DelToEOL) and
           C!LastAddr neq location(C!Wipe) and
           C!LastAddr neq location(C!DelEOL)) then
       begin |2|
         C!KillBP  _ point(7, C!KillBuf[0], -1);
         C!KillCnt _ 0;
       end; |2|
     
       clear(G!AppendKillP);
       C!ArgV _ C!ArgV max 1;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       Cont.Flg _ 0;
       SaveBP   _ C!KillBP;
       SaveCnt  _ C!KillCnt;
       SavePt   _ B!GetP;
     
       if (not B!EndP) then
         while (C!ArgV) do
         begin "argv times" |2|
           if (not B!EndP) then
           begin "delete" |3|
             Temp1 _ B!GetC;
     
             if (Temp1 = FF) then
               done "argv times";
     
             if (AtEOL) then
             begin "EOL" |4|
               if (not Cont.Flg and C!KillCnt >= KILLBUFMAX - 1) then
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 18-2
     Prt: 06-Jun-84  13:53                                        Rtn C!DelToEOL

                 if ((Cont.Flg _ KBFullPrompt) = "S") then
                 begin |5|
                   Cont.Flg _ 0;
                   done "argv times";
                 end |5|
                 else if (Cont.Flg = "A") then
                   done "argv times";
     
               KillChr(Eol);
             end "EOL" |4|
             else
             begin "char" |4|
               while (not B!EndP and not AtEOL) do
               begin |5|
                 Temp1 _ B!GetC;
     
                 if ((not Cont.Flg and C!KillCnt >= KILLBUFMAX) and
                     ((Cont.Flg _ KBFullPrompt) = "A" or Cont.Flg = "S")) then 
                   done "argv times";
     
                 KillChr(Temp1);
               end; |5|
             end "char"; |4|
           end "delete" |3|
           else
             done "argv times";
     
           decr(C!ArgV);
         end "argv times"; |2|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       if (Cont.Flg = "A") then
       begin |2|
         integer
           BP,
           Count;
     
         BP    _ SaveBP;
         Count _ C!KillCnt - SaveCnt;
     
         AbortKill(BP, Count);
     
         C!KillBP  _ SaveBP;
         C!KillCnt _ SaveCnt;
     
         W!Msg("Kill Aborted");
       end |2|
       else if (Cont.Flg = "S") then
       begin |2|
         SaveKill;
         W!Msg("Kill Saved");
       end; |2|
     
       B!SetP(SavePt);
     
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 18-3
     Prt: 06-Jun-84  13:53                                        Rtn C!DelToEOL

     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       W!FixS;
       C!ArgV _ 0;
     end; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 19-1
     Prt: 06-Jun-84  13:53                                          Rtn C!DelEOL

     
     ! Delete to and including the end of the Line, copying text into the kill
     !  buffer, if there's room.  If there is no room in kill buffer, prompt
     !  the user for verification. ; 
     
     simple procedure C!DelEOL;
     begin |1|
       own integer
         Cont.Flg,
         SaveBP,
         SaveCnt,
         SavePt,
         Temp1;
       define
         Eol = {Eol};
     
       if (B!Lock or B!EndP) then
         PuntCommand;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       if (not G!AppendKillP and
           C!LastAddr neq location(C!DelToEOL) and
           C!LastAddr neq location(C!Wipe) and
           C!LastAddr neq location(C!DelEOL)) then
       begin |2|
         C!KillBP  _ point(7, C!KillBuf[0], -1);
         C!KillCnt _ 0;
       end; |2|
     
       clear(G!AppendKillP);
       C!ArgV _ C!ArgV max 1;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       Cont.Flg _ 0;
       SaveBP   _ C!KillBP;
       SaveCnt  _ SaveCnt;
       SavePt   _ B!GetP;
     
       if (not B!EndP) then
         while (C!ArgV) do
         begin "argv times" |2|
           while (not B!EndP) do
           begin "delete" |3|
             Temp1 _ B!GetC;
     
             if (AtEOL and Temp1 neq FF) then
             begin "EOL" |4|
               if (not Cont.Flg and C!KillCnt >= KILLBUFMAX - 1 and
                   ((Cont.Flg _ KBFullPrompt) = "A" or Cont.Flg = "S")) then
                 done "argv times";
     
               KillChr(Eol);
               done "delete";
             end "EOL" |4|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 19-2
     Prt: 06-Jun-84  13:53                                          Rtn C!DelEOL

             else
             begin |4|
               if (not Cont.Flg and C!KillCnt >= KILLBUFMAX and
                   ((Cont.Flg _ KBFullPrompt) = "A" or Cont.Flg = "S")) then
                 done "argv times";
     
               KillChr(Temp1);
     
               if (Temp1 = FF) then
                 done "delete";
             end; |4|
           end "delete"; |3|
     
           decr(C!ArgV);
         end "argv times"; |2|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       if (Cont.Flg = "A") then
       begin |2|
         integer
           BP,
           Count;
     
         BP    _ SaveBP;
         Count _ C!KillCnt - SaveCnt;
     
         AbortKill(BP, Count);
     
         C!KillBP  _ SaveBP;
         C!KillCnt _ SaveCnt;
     
         W!Msg("Kill Aborted");
       end |2|
       else if (Cont.Flg = "S") then
       begin |2|
         SaveKill;
         W!Msg("Kill Saved");
       end; |2|
     
       B!SetP(SavePt);
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       W!FixS;
       C!ArgV _ 0;
     end; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 20-1
     Prt: 06-Jun-84  13:53                                            Rtn C!Copy

     
     ! "Copy" text from the point to the mark.  Abort if the copy will overflow
     !  the kill buffer. ;
     
     simple procedure C!Copy;
     begin |1|
       integer
         Mark,
         HowMany,
         Temp,
         SavePt;
     
       Mark   _ C!ArgV;
       C!ArgV _ 0;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       if ((Mark < 0) or (Mark > 9)) then
       begin |2|
         W!Msg("Bad Mark Number - " & cvs(Mark));
         T!Bell;
         return;
       end; |2|
     
       if (B!GetM(Mark) < 0) then
       begin |2|
         W!Msg("Mark " & cvs(Mark) & " not set");
         T!Bell;
         return;
       end; |2|
     
       if (B!GetM(Mark) = B!GetP) then
       begin |2|
         W!Msg("The Point and Mark " & cvs(Mark) & " are in the same place");
         T!Bell;
         return;
       end; |2|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       HowMany _ abs(B!GetP - B!GetM(Mark));
     
       if (HowMany > KILLBUFMAX) then
       begin |2|
         W!Msg("Kill Buffer would overflow by " & cvs(HowMany - KILLBUFMAX) &
             " characters.  Copy Aborted.");
         return;
       end; |2|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       C!KillBP  _ point(7, C!KillBuf[0], -1);
       C!KillCnt _ 0;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 20-2
     Prt: 06-Jun-84  13:53                                            Rtn C!Copy

       SavePt _ B!GetP;                      ! save the point ;
     
       if (B!GetM(Mark) < B!GetP) then       ! set it to mark if needed ;
         B!SetP(B!GetM(Mark));
     
       while (HowMany > 0) do
       begin |2|
         idpb(B!GetC, C!KillBP);
         incr(C!KillCnt);
         B!Move(FORWARDS);
         decr(HowMany);
       end; |2|
     
       B!SetP(SavePt);
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       W!Msg("Copy Complete");
     end; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 21-1
     Prt: 06-Jun-84  13:53                                            Rtn C!Wipe

     
     ! "Wipe" text from between the point and the mark.  The text will be
     !   removed from the lower end of the region forward.  In the case that
     !   the kill buffer will overflow, the user has three options:
     !
     !       (A)bort the command, leaving everything intact,
     !       (P)roceed and lose whatever data cannot be accomodated in the
     !         kill buffer,
     !       (S)ave whatever data will fit and stop there.
     ;
     
     simple procedure C!Wipe;
     begin "C!Wipe" |1|
       integer
         Char,
         Mark,
         HowMany,
         SavePt,
         Temp;
     
     
       if (B!Lock) then
         PuntCommand;
     
       Mark   _ C!ArgV;
       C!ArgV _ 0;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       if ((Mark < 0) or (Mark > 9)) then
       begin |2|
         W!Msg("Bad Mark Number - " & cvs(Mark));
         T!Bell;
         return;
       end; |2|
     
       if (B!GetM(Mark) < 0) then
       begin |2|
         W!Msg("Mark " & cvs(Mark) & " not set");
         T!Bell;
         return;
       end; |2|
     
       if (B!GetM(Mark) = B!GetP) then
       begin |2|
         W!Msg("The Point and Mark " & cvs(Mark) & " are in the same place");
         T!Bell;
         return;
       end; |2|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       if (C!LastAddr neq location(C!DelEOL) and
           C!LastAddr neq location(C!DelToEOL) and
           C!LastAddr neq location(C!Wipe)) then
       begin |2|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 21-2
     Prt: 06-Jun-84  13:53                                            Rtn C!Wipe

         C!KillBP  _ point(7, C!KillBuf[ 0 ], -1);
         C!Killcnt _ 0;
       end; |2|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       HowMany _ abs(B!GetP - B!GetM(Mark));
     
       if (HowMany > KILLBUFMAX - C!KillCnt) then
       begin |2|
         Char _ KBFullPrompt;
     
         if (Char = "S") then
           HowMany _ KILLBUFMAX - C!KillCnt
         else if (Char = "A") then
         begin |3|
           W!Msg("Wipe Aborted");
           return;
         end; |3|
       end; |2|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       SavePt _ B!GetP;
     
       if (SavePt > B!GetM(Mark)) then
       begin |2|
         B!SetP(B!GetM(Mark));
         B!SetM(Mark, SavePt);
       end; |2|
     
       while (HowMany > 0) do
       begin |2|
         if (C!KillCnt < KILLBUFMAX) then
         begin |3|
           idpb(B!GetC, C!KillBP);
           incr(C!KillCnt);
         end; |3|
     
         B!Delete(FORWARDS);
         decr(HowMany);
       end; |2|
     
       if (SavePt neq B!GetP) then
       begin |2|
         Temp _ B!GetM(Mark);
         B!SetM(Mark, B!GetP);
         B!SetP(Temp);
       end; |2|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       W!Msg("Wipe Complete");
     end "C!Wipe"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 22-1
     Prt: 06-Jun-84  13:53                                            Rtn C!Yank

     
     ! "Yank" text out of the kill buffer and insert it at the mark.  Leave
     !  the point at the end of the inserted text.  The kill buffer is not
     !  affected. ;
     
     procedure C!Yank;
     begin "C!Yank" |1|
       integer
         BP,
         Count,
         SavePt;
     
       SavePt _ B!GetP;
     
       if (not C!ArgV) then
         C!ArgV _ 1;
     
       while (C!ArgV) do
       begin  |2|
         Count _ C!KillCnt;
         BP    _ point(7, C!KillBuf[0], -1);
     
         while (Count) do
         begin |3|
           B!Insert(ildb(BP));
           decr(Count);
         end; |3|
     
         decr(C!ArgV);
       end; |2|
     
       if (not C!SPMRegion) then
         B!SetP(SavePt);
     
       W!Msg("Yank Complete");
     end "C!Yank"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 23-1
     Prt: 06-Jun-84  13:53                                          Rtn DoIndent

     
     ! Do the common legwork for region indent commands.
     ;
     
     simple procedure DoIndent (integer Add);
     begin "DoIndent" |1|
       integer
         SPt1,
         SPt2,
         SPt3,
         Point,
         Mark,
         SavPt;
     
       SPt1 _ B!AllocateMark;
       SPt2 _ B!AllocateMark;
       SPt3 _ B!AllocateMark;
     
       B!SetM(SPt3, B!GetP);
     
       if (B!GetP < (Mark _ B!GetM(0))) then
       begin |2|
         MoveToBOL;
         SavPt _ 1;
         B!SetM(SPt1, B!GetP);
     
         B!SetP(Mark);
         MoveToEOL;
         MoveForwards;
         B!SetM(SPt2, B!GetP);
       end |2|
       else
       begin |2|
         MoveToEOL;
         MoveForwards;
         SavPt _ 2;
         B!SetM(SPt2, B!GetP);
     
         B!SetP(Mark);
         MoveToBOL;
         B!SetM(SPt1, B!GetP);
       end; |2|
     
       B!SetP(B!GetM(SPt1));
     
       while (true) do
       begin |2|
         if (not AtEOL) then
           ForceIndent(GetIndent + Add);
     
         MoveToEOL;
         MoveForwards;
     
         if (B!EndP or B!GetP >= B!GetM(SPt2)) then
           done;
       end; |2|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 23-2
     Prt: 06-Jun-84  13:53                                          Rtn DoIndent

     
       B!SetP
       (
         B!GetM
         (
           if (not C!SPMRegion) then
             SPt3
           else if (SavPt = 1) then
             SPt2
           else
             SPt1
         )
       );
     
       B!DeAllocateMark(SPt1);
       B!DeAllocateMark(SPt2);
       B!DeAllocateMark(SPt3);
     end "DoIndent"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 24-1
     Prt: 06-Jun-84  13:53                                       Rtn C!AddIndent

     
     ! Command to indent the current line an additional indentation unit. ;
     
     procedure C!AddIndent;
       begin |1|
         integer Add;
         if ( not C!ArgV ) then C!ArgV := 1;
         Add := C!ArgV * C!IndentUnitWidth;
         ForceIndent( GetIndent + Add );
         C!ArgV := 0;
       end; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 25-1
     Prt: 06-Jun-84  13:53                                    Rtn C!IndentRegion

     
     ! Indent a region of text delimited by the point and User Mark 0.
     ;
     
     procedure C!IndentRegion;
     begin "C!IndentRegion" |1|
       if (B!GetM(0) < 0) then
       begin |2|
         W!Msg("Mark 0 isn't set");
         T!Bell;
         PuntCommand;
       end; |2|
     
       if (not C!ArgV) then
         C!ArgV _ 1;
     
       DoIndent(C!ArgV * C!IndentUnitWidth);
       C!ArgV _ 0;
     end "C!IndentRegion"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 26-1
     Prt: 06-Jun-84  13:53                                        Rtn C!UnIndent

     
     ! Command to "unindent" a line by the specified amount. ;
     
     procedure C!UnIndent;
       begin |1|
         integer Remove;
         if ( not C!ArgV ) then C!ArgV := 1;
         Remove := C!ArgV * C!IndentUnitWidth;
         ForceIndent( GetIndent - Remove );
         C!ArgV := 0;
       end; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 27-1
     Prt: 06-Jun-84  13:53                                  Rtn C!UnIndentRegion

     
     ! Unindent a region of text delimited by the point and User Mark 0.
     ;
     
     procedure C!UnIndentRegion;
     begin |1|
       if (B!GetM(0) < 0) then
       begin |2|
         W!Msg("Mark 0 isn't set");
         T!Bell;
         PuntCommand;
       end; |2|
     
       if (not C!ArgV) then
         C!ArgV _ 1;
     
       DoIndent(-(C!ArgV * C!IndentUnitWidth));
       C!ArgV _ 0;
     end; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 28-1
     Prt: 06-Jun-84  13:53                                          Rtn C!Center

     
     ! "center" a line of text within the current margins. ;
     
     simple procedure C!Center;
     begin |1|
       own integer
         SavePt,
         Width;
     
       C!ArgV _ 0;
       MoveToBOL;
       SavePt _ B!GetP;
     
       while (C!IsWhiteP) do
         B!Delete(FORWARDS);
     
       MoveToEOL;
     
     
       ! Delete trailing whitespace ;
     
       begin |2|
         B!Move(BACKWARDS);
     
         while (B!GetP > SavePt and C!IsWhiteP) do
         begin |3|
           B!Delete(FORWARDS);
           B!Move(BACKWARDS);
         end; |3|
     
         B!Move(FORWARDS);
       end; |2|
     
     
       Width _ B!GetP - SavePt;
     
       if (Width = 0) then
         return;
     
       ForceIndent(C!LeftMargin - 1 +
           (((C!RightMargin - C!LeftMargin + 1) - Width) % 2));
       MoveToEOL;
     end; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 29-1
     Prt: 06-Jun-84  13:53                                    Rtn C!RightJustify

     
     ! Right justify a chunk of text against the current margin ;
     
     simple procedure C!RightJustify;
     begin |1|
       own integer
         SavePt,
         SpacesNeeded;
       
       SavePt _ B!GetP;
       MoveToEOL;
     
       ! Delete trailing whitespace ;
     
       begin |2|
         B!Move(BACKWARDS);
     
         while (B!GetP > SavePt and C!IsWhiteP) do
         begin |3|
           B!Delete(FORWARDS);
           B!Move(BACKWARDS);
         end; |3|
     
         B!Move(FORWARDS);
       end; |2|
     
       SpacesNeeded _ C!RightMargin - GetColumn + 1;
       B!SetP(SavePt);
     
       while (SpacesNeeded > 0) do
       begin |2|
         B!Insert(" ");
         decr(SpacesNeeded);
       end; |2|
     
       C!ArgV _ 0;
     end; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 30-1
     Prt: 06-Jun-84  13:53                                      Rtn C!ShowSearch

     
     ! Display the single- and multiple-search strings ;
     
     procedure C!ShowSearch;
     begin |1|
       string
         TmpStr;
     
     
       TmpStr _ null;
     
       if (C!Search) then
         appnd(TmpStr, "Search: """ & C!Search & """");
     
       if (C!SearchM) then
         appnd(TmpStr, "   M-Search: """ & C!SearchM & """");
     
       if (not length(TmpStr)) then
         appnd(TmpStr, "No Search Strings");
     
       W!Msg(TmpStr);
       C!ArgV _ 0;
     end; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 31-1
     Prt: 06-Jun-84  13:53                                         Rtn C!FSearch

     
     ! Search forward through the buffer for a text string ;
     
     simple procedure C!FSearch;
       begin "search" |1|
         own integer SavePoint;
     
         if ( not C!ReadString( "Search: ", ESC, ESC )) then
           begin |2|
             W!Msg( "Search Aborted" );
             C!ArgV := 0;
             return;
           end; |2|
         if ( length( C!String ) = 0 ) then
           begin |2|
             if ( length( C!Search ) = 0 ) then
               begin |3|
                 W!Msg( "No Search String" );
                 C!ArgV := 0;
                 return;
               end |3|
             else
               W!Msg( "Search: " & C!Search & "$" );
           end |2|
         else
           C!Search := C!String;
     
         W!MsgF := true;
         if ( not C!ChrP ) then W!Disp( true );
         W!MsgF := false;
     
         if ( not C!ArgV ) then C!ArgV := 1;
         while ( C!ArgV > 0 ) do
           begin |2|
             SavePoint := B!GetP;
             ForwardSearch( C!Search );
             if ( SavePoint = B!GetP ) then
               C!ArgV := -1
             else
               C!ArgV := C!ArgV - 1;
           end; |2|
     
         if ( C!ArgV < 0 ) then
           begin |2|
             W!Msg( "Search: " & C!Search & "  [failed]" );
             C!MAbort := true;
           end |2|
         else
           W!Msg( "Search: " & C!Search );
     
         C!ArgV := 0;
     
       end "search"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 32-1
     Prt: 06-Jun-84  13:53                                        Rtn C!RFSearch

     
     ! Repeat a forward search ;
     
     internal simple procedure C!RFSearch;
       begin "repeat search" |1|
         own integer SavePoint;
     
         if ( length( C!Search ) = 0 ) then
           begin |2|
             W!Msg( "No Search String" );
             C!ArgV := 0;
             return;
           end; |2|
     
         W!Msg( "Search: " & C!Search & "$" );
     
         W!MsgF := true;
         if ( not C!ChrP ) then W!Disp( false );
         W!MsgF := false;
     
         if ( not C!ArgV ) then C!ArgV := 1;
         while ( C!ArgV > 0 ) do
           begin |2|
             SavePoint := B!GetP;
             ForwardSearch( C!Search );
             if ( SavePoint = B!GetP ) then
               C!ArgV := -1
             else
               C!ArgV := C!ArgV - 1;
           end; |2|
     
         if ( C!ArgV < 0 ) then
           begin |2|
             W!Msg( "Search: " & C!Search & "  [failed]" );
             C!MAbort := true;
           end |2|
         else
           W!Msg( "Search: " & C!Search );
     
         C!ArgV := 0;
     
       end "repeat search"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 33-1
     Prt: 06-Jun-84  13:53                                         Rtn C!RSearch

     
     ! Search backwards through the buffer for a text string ;
     
     simple procedure C!RSearch;
       begin "reverse search" |1|
         own integer SavePoint;
     
         if ( not C!ReadString( "Reverse Search: ", ESC, ESC )) then
           begin |2|
             W!Msg( "Reverse Search Aborted" );
             C!ArgV := 0;
             return;
           end; |2|
         if ( length( C!String ) = 0 ) then
           begin |2|
             if ( length( C!Search ) = 0 ) then
               begin |3|
                 W!Msg( "No Search String" );
                 C!ArgV := 0;
                 return;
               end |3|
             else
               W!Msg( "Reverse Search: " & C!Search & "$" );
           end |2|
         else
           C!Search := C!String;
     
         W!MsgF := true;
         if ( not C!ChrP ) then W!Disp( true );
         W!MsgF := false;
     
         if ( not C!ArgV ) then C!ArgV := 1;
         while ( C!ArgV > 0 ) do
           begin |2|
             SavePoint := B!GetP;
             BackwardSearch( C!Search );
             if ( SavePoint = B!GetP ) then
               C!ArgV := -1
             else
               C!ArgV := C!ArgV - 1;
           end; |2|
     
         if ( C!ArgV < 0 ) then
           begin |2|
             W!Msg( "Reverse Search: " & C!Search & "  [failed]" );
             C!MAbort := true;
           end |2|
         else
           W!Msg( "Reverse Search: " & C!Search );
     
         C!ArgV := 0;
     
       end "reverse search"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 34-1
     Prt: 06-Jun-84  13:53                                        Rtn C!RRSearch

     
     ! Repeat a backward search ;
     
     simple procedure C!RRSearch;
       begin "repeat reverse search" |1|
         own integer SavePoint;
     
         if ( length( C!Search ) = 0 ) then
           begin |2|
             W!Msg( "No Search String" );
             C!ArgV := 0;
             return;
           end; |2|
     
         W!Msg( "Reverse Search: " & C!Search & "$" );
     
         W!MsgF := true;
         if ( not C!ChrP ) then W!Disp( true );
         W!MsgF := false;
     
         if ( not C!ArgV ) then C!ArgV := 1;
         while ( C!ArgV > 0 ) do
           begin |2|
             SavePoint := B!GetP;
             BackwardSearch( C!Search );
             if ( SavePoint = B!GetP ) then
               C!ArgV := -1
             else
               C!ArgV := C!ArgV - 1;
           end; |2|
     
         if ( C!ArgV < 0 ) then
           begin |2|
             W!Msg( "Reverse Search: " & C!Search & "  [failed]" );
             C!MAbort := true;
           end |2|
         else
           W!Msg( "Reverse Search: " & C!Search );
     
         C!ArgV := 0;
     
       end "repeat reverse search"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 35-1
     Prt: 06-Jun-84  13:53                                         Rtn C!MSearch

     
     ! The shell for a multiple search
     ;
     
     procedure C!MSearch;
     begin "C!MSearch" |1|
       own integer
         SavePoint;
     
       if (not C!ReadESCString("M-Search: ")) then
       begin |2|
         W!Msg("M-Search Aborted");
         C!ArgV _ 0;
         return;
       end; |2|
     
       if (length(C!String) = 0) then
       begin |2|
         if (length(C!SearchM) = 0) then
         begin |3|
           W!Msg("No M-Search String");
           C!ArgV _ 0;
           return;
         end |3|
         else
           W!Msg("M-Search: " & C!SearchM & "$");
       end |2|
       else
         C!SearchM _ C!String;
     
       W!MsgF _ true;
       if (not C!ChrP) then W!Disp(true);
       W!MsgF _ false;
     
       if (not C!ArgV) then C!ArgV _ 1;
       while (C!ArgV > 0) do
       begin |2|
         SavePoint _ B!GetP;
         MultipleSearch(C!SearchM);
         if (SavePoint = B!GetP) then
           C!ArgV _ -1
         else
           C!ArgV _ C!ArgV - 1;
       end; |2|
     
       if (C!ArgV < 0) then
       begin |2|
         W!Msg("M-Search: " & C!SearchM & "  [failed]");
         C!MAbort _ true;
       end |2|
       else
         W!Msg("M-Search: " & C!SearchM);
     
       C!ArgV _ 0;
     end "C!MSearch"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 36-1
     Prt: 06-Jun-84  13:53                                    Rtn C!ChangeString

     
     ! Change one string to another. ;
     
     procedure C!ChangeString;
       begin "change" |1|
         integer I, SavePoint, ChangeCount;
         string OldString, NewString;
     
         if ( not C!ReadString( "Change: ", ESC, ESC )) then
           begin |2|
             W!Msg( "Change Aborted" );  C!ArgV := 0;  return;
           end; |2|
         if ( length( C!String ) = 0 ) then
           begin |2|
             W!Msg( "Change Aborted" );  C!ArgV := 0;  return;
           end; |2|
     
         OldString := C!String;
     
         if ( not ( C!ReadString( "Change: " & OldString & " to: ",ESC,ESC ))) |
                                                                        ->|then|
           begin |2|
             W!Msg( "Change Aborted" );  C!ArgV := 0;  return;
           end; |2|
         NewString := C!String;
     
         W!MsgF := true;
         if ( not C!ChrP ) then W!Disp( true );
         W!MsgF := false;
     
         ChangeCount := 0;
     
         if ( not C!ArgV ) then C!ArgV := '377777777777;
     
         while ( C!ArgV > 0 ) do
           begin "each arg" |2|
             SavePoint := B!GetP;
             ForwardSearch( OldString );
             if ( SavePoint = B!GetP ) then
               C!ArgV := 0
             else
               begin |3|
                 for I := 1 upto length( OldString ) do
                   B!Delete( BACKWARDS );
                 for I := 1 upto length( NewString ) do
                   B!Insert( NewString[ i for 1 ] );
                 ChangeCount := ChangeCount + 1;
                 C!ArgV := C!ArgV - 1;
               end; |3|
           end "each arg"; |2|
     
         W!Msg( "Change: " & OldString & " to: " & NewString &
                "  [" & cvs( ChangeCount ) & "]" );
     
         C!ArgV := 0;
     
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 36-2
     Prt: 06-Jun-84  13:53                                    Rtn C!ChangeString

       end "change"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 37-1
     Prt: 06-Jun-84  13:53                                     Rtn C!QueryChange

     
     ! "Query Change" - user-friendliness in action ;
     
     simple procedure C!QueryChange;
     begin "C!QueryChange" |1|
       string
         Prompt;
       own integer
         I,
         SavePoint,
         Response,
         N;
     
     
       if (not C!ReadString("Q-Change: ", ESC, ESC)) then
       begin |2|
         W!Msg("Q-Change Aborted");
         C!ArgV _ 0;
         return;
       end; |2|
     
       if (length(C!String) = 0) then
       begin |2|
         W!Msg("Q-Change Aborted");
         C!ArgV _ 0;
         return;
       end; |2|
     
       C!QOldStr _ C!String;
     
       if (not C!ReadString("Q-Change: " & C!QOldStr & " to: ", ESC, ESC)) then
       begin |2|
         W!Msg("Q-Change Aborted");
         C!ArgV _ 0;
         return;
       end; |2|
     
       C!QNewStr _ C!String;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       W!MsgF    _ true;
     
       if (not C!ChrP) then
         W!Disp(true);
     
       W!MsgF _ false;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       N _ 0;
     
       if (not C!ArgV) then
         C!ArgV _ MaxInteger;
     
       while (C!ArgV > 0) do
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 37-2
     Prt: 06-Jun-84  13:53                                     Rtn C!QueryChange

       begin |2|
         SavePoint _ B!GetP;
         ForwardSearch(C!QOldStr);
     
         if (SavePoint = B!GetP) then
           C!ArgV _ -1
         else
         begin "query" |3|
           Prompt _ "Q-Change: " & C!QOldStr & " to: " & C!QNewStr;
           W!Msg(Prompt & " ?");
           Response _ C!GetC;
     
           if (C!Tab[Response] land IsYes) then
           begin "change" |4|
             W!Msg(Prompt & " [Yes]");
             incr(N);
     
             for I _ 1 upto length(C!QOldStr) do
               B!Delete(BACKWARDS);
     
             for I _ 1 upto length(C!QNewStr) do
               B!Insert(C!QNewStr[i for 1]);
     
             W!Disp(false);
           end "change" |4|
           else
           begin |4|
             W!Msg(Prompt & " [No]");
             W!Disp(false);
           end; |4|
     
           if (C!Tab[Response] land IsAbort) then
             C!ArgV _ 0
           else
             decr(C!ArgV);
         end "query"; |3|
       end; |2|
     
       W!Msg(Prompt & " [" & cvs(N) & "]");
       C!ArgV _ 0;
     end "C!QueryChange"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 38-1
     Prt: 06-Jun-84  13:53                                   Rtn C!RepeatQChange

     
     ! Repeat "Query Change" ;
     
     simple procedure C!RepeatQChange;
     begin "C!RepeatQChange" |1|
       string
         Prompt;
       own integer
         I,
         SavePoint,
         Response,
         N;
     
     
       if (not length(C!QOldStr)) then
       begin |2|
         W!Msg("No Previous Q-Change Command");
         T!Bell;
         C!ArgV _ 0;
         return;
       end; |2|
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       W!MsgF _ true;
     
       W!Msg("Q-Change: " & C!QOldStr & " to: " & C!QNewStr);
     
       if (not C!ChrP) then
         W!Disp(true);
     
       W!MsgF _ false;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       N _ 0;
     
       if (not C!ArgV) then
         C!ArgV _ MaxInteger;
     
       while (C!ArgV > 0) do
       begin |2|
         SavePoint _ B!GetP;
         ForwardSearch(C!QOldStr);
     
         if (SavePoint = B!GetP) then
           C!ArgV _ -1
         else
         begin "query" |3|
           Prompt _ "Q-Change: " & C!QOldStr & " to: " & C!QNewStr;
           W!Msg(Prompt & " ?");
           Response _ C!GetC;
     
           if (C!Tab[Response] land IsYes) then
           begin "change" |4|
             W!Msg(Prompt & " [Yes]");
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 38-2
     Prt: 06-Jun-84  13:53                                   Rtn C!RepeatQChange

             incr(N);
     
             for I _ 1 upto length(C!QOldStr) do
               B!Delete(BACKWARDS);
     
             for I _ 1 upto length(C!QNewStr) do
               B!Insert(C!QNewStr[i for 1]);
     
             W!Disp(false);
           end "change" |4|
           else
           begin |4|
             W!Msg(Prompt & " [No]");
             W!Disp(false);
           end; |4|
     
           if (C!Tab[Response] land IsAbort) then
             C!ArgV _ 0
           else
             decr(C!ArgV);
         end "query"; |3|
       end; |2|
     
       W!Msg(Prompt & " [" & cvs(N) & "]");
       C!ArgV _ 0;
     end "C!RepeatQChange"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 39-1
     Prt: 06-Jun-84  13:53                                      Rtn C!MatchDelim

     
     ! command to find matching delimiters ;
     
     simple procedure C!MatchDelim;
       begin |1|
         own integer SavePoint;
         own integer Delim, MatchDelim, Dir, DelimCount, C;
     
         if (( C!Cmd land '177 ) = "(" ) then
           begin |2|
             Delim := ")";  MatchDelim := "(";
             Dir := BACKWARDS;
           end |2|
         else if (( C!Cmd land '177 ) = ")" ) then
           begin |2|
             Delim := "(";  MatchDelim := ")";
             Dir := FORWARDS;
           end |2|
         else
           begin |2|
             W!Msg( "Not set up to match that!" );
             return;
           end; |2|
     
         if ( C!ArgV = 0 ) then DelimCount := 1 else DelimCount := C!ArgV;
         C!ArgV := 0;
     
         SavePoint := B!GetP;
         B!Move( Dir );
     
         while ( true ) do
           begin |2|
             if ( Dir = FORWARDS ) and B!EndP then done;
             C := B!GetC;
             if ( C = MatchDelim ) then
               DelimCount := DelimCount - 1
             else if ( C = Delim ) then
               DelimCount := DelimCount + 1;
             if ( DelimCount = 0 ) then done;
             if ( Dir = BACKWARDS ) and B!BegP then done;
             B!Move( Dir );
           end; |2|
     
         if ( DelimCount neq 0 ) then
           begin |2|
             B!SetP( SavePoint );
             W!Msg( "Match Failed" );
             C!MAbort := true;
           end; |2|
       end; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 40-1
     Prt: 06-Jun-84  13:53                                           Rtn FindBOP

     
     ! Find and return the location of the beginning of the current paragraph.
     ! Selects the beginning of the first line following the most recent blank
     ! line.
     ;
     
     simple integer procedure FindBOP;
     begin "FindBOP" |1|
       integer
         BOP,
         OrigPt;
     
       OrigPt _ B!GetP;
       BOP    _ -1;
     
       if (LineEmpty) then
       begin |2|
         while (not B!EndP and C!IsGrayP) do
           MoveForwards;
     
         if (not B!EndP) then
           MoveToBOL;
     
         BOP _ B!GetP;
       end |2|
       else
       begin |2|
         boolean
           CrlfSeen;
         integer
           SavePt;
     
         clear(CrlfSeen);
         SavePt _ -1;
     
         MoveBackwards;
     
         while (not B!BegP) do
         begin |3|
           if (B!GetC = FF) then
           begin |4|
             BOP _ B!GetP + 1;
             done;
           end |4|
           else
           begin |4|
             if (AtEOL) then
             begin |5|
               if (CrlfSeen) then
               begin |6|
                 BOP _ SavePt;
                 done;
               end |6|
               else
               begin |6|
                 set(CrlfSeen);
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 40-2
     Prt: 06-Jun-84  13:53                                           Rtn FindBOP

                 SavePt _ B!GetP + 2;
               end; |6|
             end |5|
             else
             begin |5|
               if (not C!IsWhiteP) then
               begin |6|
                 clear(CrlfSeen);
                 SavePt _ -1;
               end; |6|
             end; |5|
           end; |4|
     
           MoveBackwards;
         end; |3|
     
         BOP _ BOP max 0;
       end; |2|
     
       B!SetP(OrigPt);
       return(BOP);
     end "FindBOP"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 41-1
     Prt: 06-Jun-84  13:53                                           Rtn FindEOP

     
     ! Find and return the location of the end of the current paragraph.
     ! Selects end of the last line in the next block of nonempty lines.
     ;
     
     simple integer procedure FindEOP;
     begin "FindEOP" |1|
       integer
         EOP,
         OrigPt;
     
       OrigPt _ B!GetP;
     
       if (LineEmpty) then
       begin |2|
         while (not B!EndP and C!IsGrayP) do
           MoveForwards;
       end; |2|
     
       if (B!EndP) then
         EOP _ B!GetP
       else
       begin |2|
         boolean
           CrlfSeen;
         integer
           SavePt;
     
         clear(CrlfSeen);
         SavePt _ -1;
     
         while (not B!EndP) do
         begin |3|
           if (B!GetC = FF) then
           begin |4|
             EOP _ 
                 (
                   if (CrlfSeen) then
                     SavePt
                   else
                     B!GetP
                 );
     
             done;
           end |4|
           else
           begin |4|
             if (AtEOL) then
             begin |5|
               if (CrLfSeen) then
               begin |6|
                 EOP _ SavePt;
                 done;
               end |6|
               else
               begin |6|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 41-2
     Prt: 06-Jun-84  13:53                                           Rtn FindEOP

                 set(CrlfSeen);
                 SavePt _ B!GetP;
               end; |6|
             end |5|
             else
             begin |5|
               if (not C!IsWhiteP) then
               begin |6|
                 clear(CrlfSeen);
                 SavePt _ -1;
               end; |6|
             end; |5|
           end; |4|
     
           MoveForwards;
         end; |3|
     
         if (B!EndP) then
           EOP _ B!GetP;
       end; |2|
     
       B!SetP(OrigPt);
       return(EOP);
     end "FindEOP"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 42-1
     Prt: 06-Jun-84  13:53                                     Rtn C!FwdHalfPara

     
     ! Move forward a half a paragraph.
     ;
     
     simple procedure C!FwdHalfPara;
     begin "C!FwdHalfPara" |1|
       C!ArgV _ C!ArgV max 1;
     
       while (C!ArgV) do
       begin |2|
         if (not LineEmpty) then
           MoveForwards;
     
         B!SetP(
             if (LineEmpty) then
               FindBOP
             else
               FindEOP
         );
     
         decr(C!ArgV);
       end; |2|
     end "C!FwdHalfPara"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 43-1
     Prt: 06-Jun-84  13:53                                     Rtn C!BckHalfPara

     
     ! Move backwards a half a paragraph.
     ;
     
     simple procedure C!BckHalfPara;
     begin "C!BckHalfPara" |1|
       C!ArgV _ C!ArgV max 1;
     
       while (C!ArgV) do
       begin |2|
         if (not LineEmpty) then
           MoveBackwards;
     
         if (LineEmpty) then
         begin |3|
           MoveBackwards;
     
           while (not B!BegP and C!IsGrayP) do
             MoveBackwards;
     
           MoveToEOL;
         end |3|
         else
           B!SetP(FindBOP);
     
         decr(C!ArgV);
       end; |2|
     end "C!BckHalfPara"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 44-1
     Prt: 06-Jun-84  13:53                                        Rtn DoParaFill

     
     ! Perform the Fill operation on some number of paragraphs, starting at
     ! the selected point.
     ;
     
     simple procedure DoParaFill (boolean StartAtBeginning);
     begin "DoParaFill" |1|
       integer
         BegPt,                              ! Point corresponding to the
                                             ! beginning of the paragraph.
                                             ;
         Col,                                ! The column number of the
                                             ! current character.
                                             ;
         CrownOfst,                          ! The relative offset of the
                                             ! crown from the rest of the
                                             ! paragraph.
                                             ;
         EndMk,                              ! The mark corresponding to the
                                             ! end of the paragraph.
                                             ;
         LM,                                 ! The value of the left margin
                                             ! for this session.
                                             ;
         RepCnt,                             ! The number of times to perform
                                             ! paragraph fill.
                                             ;
         RM;                                 ! The value of the right margin
                                             ! for this session.
                                             ;
     
       LM _ C!LeftMargin max 1;
     
       if (C!VFMode) then
       begin |2|
         RepCnt _ 1;
         RM     _
             if (C!ArgV) then
               C!ArgV
             else
               C!RightMargin;
       end |2|
       else
       begin |2|
         RepCnt _ C!ArgV max 1;
         RM     _ C!RightMargin;
       end; |2|
     
       if (LM > RM) then
       begin |2|
         T!Bell;
         W!Msg("The Left Margin (" & cvs(LM) &
             ") must be less than or equal to the Right Margin (" &
             cvs(RM) & ")");
         PuntCommand;
       end; |2|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 44-2
     Prt: 06-Jun-84  13:53                                        Rtn DoParaFill

     
       EndMk  _ B!AllocateMark;
     
       while (RepCnt) do
       begin |2|
         BegPt _
             (
               if (StartAtBeginning) then
                 FindBOP
               else
                 B!GetP
             );
     
         B!SetM(EndMk, FindEOP);
         B!SetP(BegPt);
     
         if (StartAtBeginning) then
         begin |3|
           CrownOfst _ GetIndent;
           DownLine;
           decr(CrownOfst, GetIndent);
           B!SetP(BegPt);
           CompressGS(FORWARDS, EndMk);
     
           Col _ (LM + CrownOfst) max 1;
           ForceIndent(Col - 1);
         end |3|
         else
           Col _ GetColumn;
     
         DoFill(Col, EndMk, LM, RM);
         CompressWS(BACKWARDS);
     
         if (not C!VFMode) then
           MoveForwards;
     
         set(StartAtBeginning);
         decr(RepCnt);
       end; |2|
     
       B!DeAllocateMark(EndMk);
       C!ArgV _ 0;
     end "DoParaFill"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 45-1
     Prt: 06-Jun-84  13:53                                        Rtn C!FillPara

     
     ! Fill the current paragraph from beginning to end.
     ;
     
     simple procedure C!FillPara;
     begin "C!FillPara" |1|
       define
         StartAtBeginning = {true};
     
       DoParaFill(StartAtBeginning);
     end "C!FillPara"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 46-1
     Prt: 06-Jun-84  13:53                                       Rtn C!FillToEOP

     
     ! Fill the current paragraph from the point to the end and fill
     ! subsequent paragraphs as usual.
     ;
     
     simple procedure C!FillToEOP;
     begin "C!FillToEOP" |1|
       define
         DontStartAtBeginning = {false};
     
       DoParaFill(DontStartAtBeginning);
     end "C!FillToEOP"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 47-1
     Prt: 06-Jun-84  13:53                                           Rtn C!SetLM

     
     ! Set the value of the Left Margin.
     ;
     
     simple procedure C!SetLM;
     begin "C!SetLM" |1|
       C!LeftMargin _
           (
             if (C!ArgV > 0) then
               C!ArgV
             else
               GetColumn
           );
     
       W!Msg("Left Margin: " & cvs(C!LeftMargin));
       C!ArgV _ 0;
     end "C!SetLM"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 48-1
     Prt: 06-Jun-84  13:53                                           Rtn C!SetRM

     
     ! Set the value of the Right Margin.
     ;
     
     simple procedure C!SetRM;
     begin "C!SetRM" |1|
       C!RightMargin _
           (
             if (C!ArgV > 0) then
               C!ArgV
             else
               GetColumn
           );
     
       W!Msg("Right Margin: " & cvs(C!RightMargin));
       C!ArgV _ 0;
     end "C!SetRM"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 49-1
     Prt: 06-Jun-84  13:53                                     Rtn C!SetTermType

     
     ! Set the Terminal type to be something other than what the monitor says.
     ! (Note the clever call of the "Refresh Window" command in our endgame.)
     ;
     
     simple procedure C!SetTermType;
     begin "C!SetTermType" |1|
       define
         DontAskTheMonitor = {false};
     
       set(W!MsgF);
       W!Msg(null);
       W!Disp(false);
       T!GetTermType(DontAskTheMonitor);
       clear(W!MsgF);
       C!Refresh;
     end "C!SetTermType"; |1|
     Cre: 13-Apr-84  15:04  (PEAKX)COMM2.REQ                           Page 50-1
     Prt: 06-Jun-84  13:53                                      Rtn C!GotoColumn

     
     ! Try to wind up in the specified column of the current line.
     ;
     
     simple procedure C!GotoColumn;
     begin "C!GotoColumn" |1|
       TryColumn
       (
         if (C!ArgV) then
           C!ArgV
         else
           C!LeftMargin
       );
     
       C!ArgV _ 0;
     end "C!GotoColumn"; |1|
     
     
     ! ************************** End of COMM2.REQ ****************************;





                                                      
                                                      
                                                      
                                          
                                          
                                          
                                    
                                    
                                    
                              
                              
                              
                              
                              
                              
                              
                              
                              
                                                      
                                                      
                                                      



                              
                              
                              
                                    
                                    
                                    
                        
                        
                        
                  
                  
                  
                  
                  
                  
                        
                        
                        
                              
                              
                              




                          
                  
               
                  
              
                
                          

     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                            Page 1-1
     Prt: 06-Jun-84  13:53                COMM3 - Macro and Key Binding routines

     
     ! *************************************************************************
     *                                                                         *
     *                                  COMM3                                  *
     *                     Macro and Key Binding routines                      *
     *                                                                         *
     ***************************************************************************
     
     
                This file is required as a source!file in COMAND.SAI.
     
     
     **************************************************************************;
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                            Page 2-1
     Prt: 06-Jun-84  13:53                                       Rtn C!AssignVar

     
     ! Routine to assign to an "environment variable" the value of the
     !  argument.  These variables live in the same symbol table as the
     !  other symbolic stuff, but are differentiated by having a leading
     !  asterisks.  Such a hack!, but it saves having to have special
     !  bits on in the symbol table. ;
     
     simple procedure C!AssignVar;
       begin "var" |1|
         integer Addr, LastVal;
     
         if ( not C!ReadString( "Variable: ", ESC, CR )) then
           begin |2|
             W!Msg( "Aborted" );
             C!ArgV := 0;
             return;
           end; |2|
     
         Addr := SymVarAddr( C!String );
         if ( Addr <= 0 ) then
           Case ( -Addr ) of
             begin |2|
               [0] W!Msg( "Variable: "& C!String &" is unknown" );
               [1] W!Msg( "Variable: "& C!String &" is ambigious" )
             end |2|
         else
           begin |2|
             LastVal := C!ArgV;
             memory[ Addr, integer ] swap LastVal;
             W!Msg( "Variable: " & SymVarName( Addr ) & " is " & cvs( C!ArgV ) &
                     ", was " & cvs( LastVal ) );
           end; |2|
     
         C!ArgV := 0;
     
       end "var"; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                            Page 3-1
     Prt: 06-Jun-84  13:53                                        Rtn C!QueryVar

     
     ! Routine to query the value of an environment variable ;
     
     simple procedure C!QueryVar;
       begin "query" |1|
         integer Addr;
     
         C!ArgV := 0;
     
         if ( not  C!ReadString( "Variable: ", CR, ESC )) then
           begin |2|
             W!Msg( "Aborted" );
             return;
           end; |2|
     
         Addr := SymVarAddr( C!String );
         if ( Addr <= 0 ) then
           Case ( -Addr ) of
             begin |2|
               [0] W!Msg( "Variable: "& C!String &" is unknown" );
               [1] W!Msg( "Variable: "& C!String &" is ambigious" )
             end |2|
         else
           W!Msg( "Variable: " & SymVarName( Addr ) &
                  " is " & cvs( memory[ Addr, integer ] ) );
     
       end "query"; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                            Page 4-1
     Prt: 06-Jun-84  13:53                                    Rtn C!NewNameMacro

     
     ! Routine to create and insert a macro-record on the macro name stack. ;
     !  This routine is necessary because SAIL is "very" "very" picky
     !  about where you can create record!pointer temps while calling
     !  routines, doing arithmetic, etc.  You can't do these kind of
     !  things in a SIMPLE routine.
     ;
     
     record!pointer (Macro) procedure C!NewNameMacro;
       begin "new name macro" |1|
         record!pointer (Macro) This;
     
           !
           !  Head: < C!MacroNames >
           !    +----------------+----------------+
           !    |   Previous: 0  |   Next: List   |
           !    +----------------+----------------+
           !    |        0       |       New      |
           !    +----------------+----------------+
           !
           !           New: < This _ New!Record( Macro ) >
           !            +----------------+----------------+
           !            |    Previous:   |      Next:     |
           !            +----------------+----------------+
           !            |      Head      |      List      |
           !            +----------------+----------------+
           !
           !                 List: < Macro:Next[ C!MacroNames ] >
           !                    +----------------+----------------+
           !                    | Previous: Head |     Next: 0    |
           !                    +----------------+----------------+
           !                    |       New      |        0       |
           !                    +----------------+----------------+
           ;
     
         This_ new!record( Macro );
         Macro:Next[ This ]_ Macro:Next[ C!MacroNames ];
         Macro:Last[ This ]_ Macro:Last[ Macro:Next[ C!MacroNames ] ];
         Macro:Last[ Macro:Next[ C!MacroNames ] ]_ This;
         Macro:Next[ C!MacroNames ]_ This;
     
         Macro:Id[ This ]_ xwd( C!MacroPointer, C!PointerToInteger( This ) );
     
           !  Always insert "new" name bindings at the head of the list.
           !  This way, new bindings replace old ones, and un-binding
           !  will restore the most previous binding.  SAIL will take
           !  care of garbage collecting strings and record space.
           ;
     
         return( This );
     
       end "new name macro"; |1|
     
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                            Page 5-1
     Prt: 06-Jun-84  13:53                                   Rtn C!NewStackMacro

     
     ! Routine to create and insert a macro-record on the macro key stack. ;
     !  This routine is necessary because SAIL is "very" "very" picky
     !  about where you can create record!pointer temps while calling
     !  routines, doing arithmetic, etc.  You can't do these kind of
     !  things in a SIMPLE routine.
     ;
     
     record!pointer (Macro) procedure C!NewStackMacro;
       begin "new stack macro" |1|
         record!pointer (Macro) This;
     
           !
           !  Head: < C!MacroStack >
           !    +----------------+----------------+
           !    |   Previous: 0  |   Next: List   |
           !    +----------------+----------------+
           !    |        0       |       New      |
           !    +----------------+----------------+
           !
           !           New: < This _ New!Record( Macro ) >
           !            +----------------+----------------+
           !            |    Previous:   |      Next:     |
           !            +----------------+----------------+
           !            |      Head      |      List      |
           !            +----------------+----------------+
           !
           !                 List: < Macro:Next[ C!MacroStack ] >
           !                    +----------------+----------------+
           !                    | Previous: Head |     Next: 0    |
           !                    +----------------+----------------+
           !                    |       New      |        0       |
           !                    +----------------+----------------+
           ;
     
         This_ new!record( Macro );
         Macro:Next[ This ]_ Macro:Next[ C!MacroStack ];
         Macro:Last[ This ]_ Macro:Last[ Macro:Next[ C!MacroStack ] ];
         Macro:Last[ Macro:Next[ C!MacroStack ] ]_ This;
         Macro:Next[ C!MacroStack ]_ This;
     
         Macro:Id[ This ]_ xwd( C!MacroPointer, C!PointerToInteger( This ) );
     
           !  Always insert "new" stack macros at the head of the list.
           !  This way, new key bindings replace old ones, and un-binding
           !  the keys will restore the most previous binding.  SAIL will
           !  take care of garbage collecting strings and record space.
           ;
     
         return( This );
     
       end "new stack macro"; |1|
     
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                            Page 6-1
     Prt: 06-Jun-84  13:53                                          Rtn C!ReBind

     
     ! Routine to bind a key to a function symbolically. ;
     !  Prompt for the function and the key.  Some keys may not be
     !  rebound, although this is not obvious from this routine.
     !  The keys which cannot be re-bound are hardcoded elsewhere.
     ;
     
     simple procedure C!ReBind;
       begin "rebind" |1|
         own integer Addr, Key;
         own record!pointer (Macro) Ptr, Copy;
         own string Text;
     
         C!ArgV_ 0;
     
         Text_ "Bind Function: ";
         if ( not C!ReadString( Text, ESC, CR )) then
           begin |2|
             W!Msg( "Aborted" );
             return;
           end; |2|
     
         Addr_ SymCmdAddr( C!String );
         if ( Addr <= 0 ) then
           Case ( -Addr ) of
             begin |2|
               [0] W!Msg( Text & C!String &" is unknown" );
               [1] W!Msg( Text & C!String &" is ambigious" )
             end |2|
         else
           begin "assign to key" |2|
     
             set(W!MsgF);
             W!Msg( Text_ Text & SymCmdName( Addr ) &"$ To Key: " );
             Key_ C!GetCMD;
             clear( W!MsgF );
     
             if ( lh( Addr ) = C!MacroPointer ) then
             begin "copy macro record" |3|
     
               Ptr_ C!NewStackMacro;
     
                 !  Create a macro record for this key binding.
                 ;
     
               Copy_ C!IntegerToPointer( Addr );
               Macro:Name[ Ptr ]_ Macro:Name[ Copy ];
               Macro:Body[ Ptr ]_ Macro:Body[ Copy ];
     
                 !  Copy the pertinent information from the "named" macro
                 !  into the newly created macro-record on the stack.
                 ;
     
               Macro:Key[ Ptr ]_ C!Dispatch[ Key ];
               Addr_ Macro:Id[ Ptr ];
     
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                            Page 6-2
     Prt: 06-Jun-84  13:53                                          Rtn C!ReBind

                 !  Remember the old dispatch table value for this key.
                 !  Also make sure Addr is updated for the Stack Macro
                 !  instead of the "named" Macro.
                 ;
     
             end "copy macro record"; |3|
     
             C!Dispatch[ Key ]_ Addr;
             W!Msg( Text & CvCmdChr( Key ) &" [Ok]" );
     
           end "assign to key"; |2|
     
       end "rebind"; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                            Page 7-1
     Prt: 06-Jun-84  13:53                                        Rtn C!QueryKey

     
     ! Query a key binding ;
     
     simple procedure C!QueryKey;
       begin "key" |1|
         string F;
         integer Cmd, Key;
         own record!pointer (Macro) Ptr;
     
         W!Msg( "Key:" );
         set( W!MsgF );
         Key_ C!GetCMD;
         clear( W!MsgF );
     
         F := SymCmdName( Cmd_ C!Dispatch[ Key ] );
         if ( not F ) then
           W!Msg( "Key "& CvCmdChr( Key ) &" isn't bound" )
         else
           if ( lh( Cmd ) neq C!MacroPointer ) then
             W!Msg( "Key "& CvCmdChr( Key ) &" is: "& F )
           else
             W!Msg( "Key "& CvCmdChr( Key ) &" is: "& F &
                     " "& CvCmdStr(Macro:Body[C!IntegerToPointer(Cmd)]) );
     
         C!ArgV_ 0;
     
       end "key"; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                            Page 8-1
     Prt: 06-Jun-84  13:53                   Rtn C!MacroDispatch( MacroPointer )

     
     ! Routine to execute the macro body contained in the specified record. ;
     !  This routine is called by C!SymDispatch and by Dispatch whenever a
     !  valid MacroPointer is found.  Here, we "ASSUME" the checking work
     !  has already been completed by the appropriate routines.
     !  Note however, that this routine keeps track of the calling depth
     !  and attempts to recover gracefully when the user goes into a loop.
     ;
     
     recursive procedure C!MacroDispatch( Integer MacroPointer );
       begin "macro dispatch" |1|
         integer OldLength, OurArgV, Cmd;
         record!pointer (Macro) Ptr;
     
         
         if ( C!MacroDepth < MaxMacroDepth ) then
           incr( C!MacroDepth )
     
         else
           begin "depth overflow" |2|
     
             set( C!MAbort );
             W!Msg( "Macro depth overflow - macro aborted." );
             T!Bell;
             return;
     
           end "depth overflow"; |2|
     
         OurArgV_ C!ArgV;
         C!ArgV_ 0;
     
         if ( OurArgV leq 0 ) then OurArgV_ 1;
     
         clear( C!MAbort );
     
         Ptr_ C!IntegerToPointer( MacroPointer );
     
         while ( OurArgV ) do
           begin "exec" |2|
     
             OldLength_ length( C!Macro );
             C!Macro_ Macro:Body[ Ptr ] & C!Macro;
     
             while ( length( C!Macro ) > OldLength ) do
               begin "one time" |3|
     
                 Dispatch( Cmd_ C!GetCMD );
     
                 if ( C!MAbort ) then
                   begin |4|
                     C!Macro_ C!Macro[ (Inf-OldLength+1) to Inf ];
                     done "exec";
                   end; |4|
               end "one time"; |3|
     
             decr( OurArgV );
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                            Page 8-2
     Prt: 06-Jun-84  13:53                   Rtn C!MacroDispatch( MacroPointer )

     
           end "exec"; |2|
     
         decr( C!MacroDepth );
     
         C!ArgV_ 0;
     
       end "macro dispatch"; |1|
     
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                            Page 9-1
     Prt: 06-Jun-84  13:53                                     Rtn C!SymDispatch

     
     ! Dispatch a command symbolically by looking its address up in the
     !  symbol table and pushj'ing off to it.  Note that if the dispatch
     !  is successful the function dispatched to is responsible for C!ArgV ;
     
     simple procedure C!SymDispatch;
       begin "dispatch" |1|
         integer Addr;
     
         if ( not C!ReadString( "Execute Function: ", ESC, CR )) then
           begin |2|
             W!Msg( "Aborted" );
             C!ArgV_ 0;
             return;
           end; |2|
     
         Addr := SymCmdAddr( C!String );
         if ( Addr <= 0 ) then
           begin |2|
             Case ( -Addr ) of
               begin |3|
                 [0] W!Msg( "Execute Function: "& C!String &" is unknown" );
                 [1] W!Msg( "Execute Function: "& C!String &" is ambigious" )
               end; |3|
     
             set( C!MAbort );
             C!ArgV_ 0;
             return;
     
           end; |2|
     
           W!Msg( "Execute Function: "& SymCmdName( Addr ) &"$" );
           W!Disp( True );
     
           if ( lh( Addr ) = C!MacroPointer ) then
     
             C!MacroDispatch( Addr )
     
           else
     
             begin!code |2|
               pushj p,@Addr;        ! go do it! ;
             end; |2|
     
       end "dispatch"; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 10-1
     Prt: 06-Jun-84  13:53                                  Rtn C!MacroByExample

     
     ! Turn on 'macro by definition' ;
     
     simple procedure C!MacroByExample;
       begin "by example" |1|
     
         C!ArgV := 0;
         C!DefiningMacro := true;
         C!LastMacro := NULL;
         W!Msg( "Defining Macro by example.  ^G to end definition." );
     
       end "by example"; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 11-1
     Prt: 06-Jun-84  13:53                                       Rtn C!ReadMacro

     
     ! Read a delimited macro.  Delimiters allow just about any characters to
     !  be used in the macro body (including the delimiter itself, if preceeded
     !  by a ^Q.  For this reason, ^Q MAY NOT be used as a delimiter.  ;
     
     procedure C!ReadMacro;
       begin "macro" |1|
         string Prompt;
         integer C;
     
         C!ArgV := 0;
     
         Prompt := "Delimited Macro";
         W!Msg( Prompt );
     
         C := C!GetC;
         Prompt := Prompt & " <" & C & ">: ";
     
         if ( not C!ReadLitString( Prompt, C, C )) then
           begin |2|
             W!Msg( "Aborted" );
             return;
           end; |2|
     
         C!LastMacro := C!String;
         W!Msg( NULL );
     
       end "macro"; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 12-1
     Prt: 06-Jun-84  13:53                                       Rtn C!BindMacro

     
     ! Routine to bind the last macro defined to a key. ;
     
     simple procedure C!BindMacro;
       begin "bind macro" |1|
         own integer Key;
         own record!pointer (Macro) Ptr;
     
         C!ArgV_ 0;
     
         if ( length( C!LastMacro ) = 0 ) then
           begin |2|
             W!Msg( "Keyboard macro empty." );
             return;
           end; |2|
     
         W!Msg( "Bind Macro to Key: " );
         set( W!MsgF );
         Key_ C!GetCMD;
         clear( W!MsgF );
     
         W!Msg( "Bind Macro to Key: "& CvCmdChr( Key ) &"[ok]" );
     
         Ptr_ C!NewStackMacro;
     
           !  Create a macro record for this key binding.
           ;
     
         Macro:Name[ Ptr ]_ Null;
         Macro:Body[ Ptr ]_ C!LastMacro;
     
           !  Copy the pertinent information from the "named" macro
           !  into the newly created macro-record on the stack.
           ;
     
         Macro:Key[ Ptr ]_ C!Dispatch[ Key ];
         C!Dispatch[ Key ]_ Macro:Id[ Ptr ];
     
           !  Remember the old dispatch table value for this key
           !  and reset the entry for macro execution.
           ;
     
         W!Msg( NULL );
     
         if ( B!Mode[ inf for 1 ] neq "+" ) then
           begin |2|
             B!Mode_ B!Mode & "+";
             W!NewS;
           end; |2|
         return;
     
       end "bind macro"; |1|
     
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 13-1
     Prt: 06-Jun-84  13:53                                       Rtn C!UnBindKey

     
     ! Routine to unbind the most recent definition of a key. ;
     
     simple procedure C!UnBindKey;
       begin "unbind key" |1|
         own integer Key, Cmd;
         own record!pointer ( Macro ) This, Last, Next;
     
         C!ArgV_ 0;
     
         W!Msg( "Key: " );
         set( W!MsgF );
         Cmd_ C!Dispatch[ Key_ C!GetCMD ];
         clear( W!MsgF );
     
         if ( lh( Cmd ) = C!MacroPointer ) then
         begin "look for entry" |2|
     
           This_ C!IntegerToPointer( Cmd );
           C!Dispatch[ Key ]_ Macro:Key[ This ];
     
           Last_ Macro:Last[ This ];
           Next_ Macro:Next[ This ];
           Macro:Next[ Last ]_ Next;
           Macro:Last[ Next ]_ Last;
     
           W!Msg( "Key: "& CVCmdChr( Key ) &" [ok]" );
     
             !  Simply reset the key binding to the "remembered" key
             !  binding and the remove the record from the linked list.
             ;
     
         end "look for entry" |2|
         else
           begin "can't unbind function" |2|
     
             W!Msg( "Key: "& CVCmdChr( Key ) &
                     " cannot be un-bound from a function." );
             set( C!MAbort );
             T!Bell;
     
           end "can't unbind function"; |2|
     
         return;
     
       end "unbind key"; |1|
     
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 14-1
     Prt: 06-Jun-84  13:53                                       Rtn C!NameMacro

     
     ! Routine to bind a function name to the last keyboard macro defined. ;
     !  The given name and a pointer to the current macro text is placed
     !  on a record structure similar to the macro-key binding structure.
     !  These macro can be later executed via the M-X "function-name" call
     !  or bound to keys using "Bind Function".
     ;
     
     simple procedure C!NameMacro;
       begin "name macro" |1|
         own record!pointer (Macro) Ptr;
     
         C!ArgV_ 0;
     
         if ( length( C!LastMacro ) = 0 ) then
           begin |2|
             W!Msg( "Keyboard macro empty." );
             return;
           end; |2|
     
         if ( not C!ReadString( "Name for Macro: ", ESC, CR )) then
           begin |2|
             W!Msg( "Aborted" );
             return;
           end; |2|
     
         Ptr_ C!NewNameMacro;
     
           !  Create a macro record for this named macrov.
           ;
     
         Macro:Name[ Ptr ]_ C!String;
         Macro:Body[ Ptr ]_ C!LastMacro;
         W!Msg( "Macro named: """& C!String &""" [ok]" );
     
         if ( B!Mode[ inf for 1 ] neq "+" ) then
           begin |2|
             B!Mode_ B!Mode & "+";
             W!NewS;
           end; |2|
         return;
     
       end "name macro"; |1|
     
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 15-1
     Prt: 06-Jun-84  13:53                                     Rtn C!UnNameMacro

     
     ! Routine to forget the most recent definition of a "named" macro. ;
     
     simple procedure C!UnNameMacro;
       begin "unname macro" |1|
         own record!pointer (Macro) This, Next, Last;
         own integer Addr;
         own string Text;
     
         C!ArgV_ 0;
     
         Text_ "Macro Name: ";
         if ( not C!ReadString( Text, ESC, CR )) then
           begin |2|
             W!Msg( "Aborted" );
             return;
           end; |2|
     
         Addr_ SymCmdAddr( C!String );
     
         if (( Addr > 0 ) and ( lh( Addr ) neq C!MacroPointer )) then
           Addr_ 0;
     
         if ( Addr leq 0 ) then
           begin "unknown or ambigious" |2|
     
             Case ( -Addr ) of
               begin |3|
                 [0] W!Msg( Text & C!String &" is unknown" );
                 [1] W!Msg( Text & C!String &" is ambigious" )
               end; |3|
     
               set( C!MAbort );
               T!Bell;
     
           end "unknown or ambigious" |2|
         else
           begin "delete macro entry" |2|
     
             W!Msg( "Macro: """& SymCmdName( Addr ) &""" removed [ok]" );
     
             This_ C!IntegerToPointer( Addr );
             Last_ Macro:Last[ This ];
             Next_ Macro:Next[ This ];
             Macro:Next[ Last ]_ Next;
             Macro:Last[ Next ]_ Last;
     
           end "delete macro entry"; |2|
     
         return;
     
       end "unname macro"; |1|
     
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 16-1
     Prt: 06-Jun-84  13:53                                   Rtn C!ExecLastMacro

     
     ! Routine to execute the last keyboard macro ;
     
     recursive procedure C!ExecLastMacro;
       begin "execute macro" |1|
         integer SaveLength, OurArgV, Cmd;
     
         OurArgV_ C!ArgV;
         C!ArgV_ 0;
         if ( OurArgV leq 0 ) then
           OurArgV_ 1;
     
         if ( length( C!LastMacro ) = 0 ) then
           begin |2|
             W!Msg( "Keyboard macro empty." );
             set( C!MAbort );
             return;
           end; |2|
     
         SaveLength := length( C!Macro );
     
         clear( C!MAbort );
     
         while ( OurArgV > 0 ) do
           begin "exec macro" |2|
     
             C!Macro := C!LastMacro & C!Macro;
     
             while ( length( C!Macro ) > SaveLength ) do
               begin |3|
     
                 Dispatch( Cmd_ C!GetCMD );
     
                 if ( C!MAbort ) then
                   begin |4|
                     C!Macro_ C!Macro[ (Inf - SaveLength + 1) to Inf ];
                     done "exec macro";
                   end; |4|
     
               end; |3|
     
             decr( OurArgV );
     
           end "exec macro"; |2|
     
         C!ArgV_ 0;
     
       end "execute macro"; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 17-1
     Prt: 06-Jun-84  13:53                                         Rtn C!Comment

     
     ! Implement comments by ignoring all characters seen until one that matches
     !  the low order seven bits of the command that invokes us. ;
     
     simple procedure C!Comment;
       begin |1|
         own integer Comment!Char, C;
         C!ArgV := 0;
         Comment!Char := C!Cmd land '177;
         W!Msg( "Defining comment.  End with " & Comment!Char );
     
         while ( ( C := C!GetC ) neq Comment!Char ) do
           if ( C!Dispatch[C] = location( C!Quote ) ) then
             C!GetC
           else if ( C!Dispatch[C] = location( C!Err ) ) then
           begin |2|
             C!Err;
             done;
           end; |2|
     
         W!Msg( NULL );
       end; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 18-1
     Prt: 06-Jun-84  13:53                                           Rtn GetChar

     
     ! Routines to twiddle things in C!Tab ;
     
     integer procedure GetChar( string What );
       begin "get char" |1|
         integer C;
     
         W!MsgF := true;
         W!Msg( "Char: " );
         C := C!GetC;
         W!MsgF := false;
         W!Msg( "Char: "& CvCmdChr( C ) &" "& What );
         return( C );
     
       end "get char"; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 19-1
     Prt: 06-Jun-84  13:53                                          Rtn C!SetNum

     
     procedure C!SetNum;
       begin |1|
         integer C;
         C := GetChar( "is in <number>" );
         C!Tab[ C ] := C!Tab[ C ] lor IsNum;
         C!ArgV := 0;
       end; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 20-1
     Prt: 06-Jun-84  13:53                                        Rtn C!ClearNum

     
     procedure C!ClearNum;
       begin |1|
         integer C;
         C := GetChar( "is not in <number>" );
         C!Tab[ C ] := C!Tab[ C ] xor IsNum;
         C!ArgV := 0;
       end; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 21-1
     Prt: 06-Jun-84  13:53                                        Rtn C!SetToken

     
     procedure C!SetToken;
       begin |1|
         integer C;
         C := GetChar( "is in <token>" );
         C!Tab[ C ] := C!Tab[ C ] lor IsToken;
         C!ArgV := 0;
       end; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 22-1
     Prt: 06-Jun-84  13:53                                      Rtn C!ClearToken

     
     procedure C!ClearToken;
       begin |1|
         integer C;
         C := GetChar( "is not in <token>" );
         C!Tab[ C ] := C!Tab[ C ] xor IsToken;
         C!ArgV := 0;
       end; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 23-1
     Prt: 06-Jun-84  13:53                                        Rtn C!SetDelim

     
     procedure C!SetDelim;
       begin |1|
         integer C;
         C := GetChar( "is in <delimeter>" );
         C!Tab[ C ] := C!Tab[ C ] lor IsDelim;
         C!ArgV := 0;
       end; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 24-1
     Prt: 06-Jun-84  13:53                                      Rtn C!ClearDelim

     
     procedure C!ClearDelim;
       begin |1|
         integer C;
         C := GetChar( "is not in <delimeter>" );
         C!Tab[ C ] := C!Tab[ C ] xor IsDelim;
         C!ArgV := 0;
       end; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 25-1
     Prt: 06-Jun-84  13:53                                      Rtn C!SetSpecial

     
     procedure C!SetSpecial;
       begin |1|
         integer C;
         C := GetChar( "is in <special>" );
         C!Tab[ C ] := C!Tab[ C ] lor IsSpecial;
         C!ArgV := 0;
       end; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 26-1
     Prt: 06-Jun-84  13:53                                    Rtn C!ClearSpecial

     
     procedure C!ClearSpecial;
       begin |1|
         integer C;
         C := GetChar( "is not in <special>" );
         C!Tab[ C ] := C!Tab[ C ] xor IsSpecial;
         C!ArgV := 0;
       end; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 27-1
     Prt: 06-Jun-84  13:53                                      Rtn C!EnvironStr

     
     ! Routine to implement 'environment' strings. ;
     ! ** hack ** hack ** hack ** hack ** ;
     
     simple procedure C!EnvironStr;
       begin "e var" |1|
         string S;
     
         C!ArgV := 0;
     
         if ( not ( C!ReadString( "I-Str: ", ESC, CR ))) then
           begin |2|
             W!Msg( "Aborted" );
             return;
           end; |2|
     
         if ( kequ( C!String, "USERNAME" )) then
           begin |2|
             S := C!UserName;
           end |2|
         else if ( kequ( C!String, "DATE" )) then
           S := DateStr
         else if ( kequ( C!String, "TIME" )) then
           S := TimeStr
         else
           begin |2|
             W!Msg( "I-Str: " & C!String & " is unknown" );
             T!Bell;
             return;
           end; |2|
     
         while ( length( S )) do B!Insert( lop( S ));
     
         W!Msg( NULL );
     
       end "e var"; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 28-1
     Prt: 06-Jun-84  13:53                                         Rtn C!MsgText

     
     ! Routine to put a string into the message line ;
     
     procedure C!MsgText;
       begin "msg" |1|
         string S; integer C, Delim;
     
         Delim := C!Cmd land '177;
         W!Msg( "Defining Text Message.  End with " & Delim );
     
         S := NULL;
     
         while ( ( C := C!GetC ) neq Delim ) do
         begin |2|
           if ( C!Dispatch[C] = location( C!Err ) ) then
           begin |3|
             S := NULL;
             C!Err;
             done;
           end |3|
           else
           begin |3|
             if ( C!Dispatch[C] = location( C!Quote ) ) then
               S := S & C!GetC
             else
               S := S & C;
           end; |3|
         end; |2|
     
         W!Msg( S );
         C!ArgV := 0;
     
       end "msg"; |1|
     Cre: 24-Jan-84  14:59  (PEAKX)COMM3.REQ                           Page 29-1
     Prt: 06-Jun-84  13:53                                     Rtn C!DateTimeMsg

     
     ! Routine to put the date and time into the message line ;
     
     procedure C!DateTimeMsg;
       begin |1|
         W!Msg( DateStr & "  " & TimeStr );
         C!ArgV := 0;
       end; |1|
     
     
     ! ************************** End of COMM3.REQ ****************************;





                                                      
                                                      
                                                      
                                          
                                          
                                          
                                    
                                    
                                    
                              
                              
                              
                              
                              
                              
                              
                              
                              
                                                      
                                                      
                                                      



                        
                        
                        
                                    
                                    
                                    
                              
                              
                              
                                          
                                          
                                          
                  
                  
                  
                  
                  
                  
                  
                  
                  




                         
                  
                
                      
              
               
                        

     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                            Page 1-1
     Prt: 06-Jun-84  13:54                             COMM4 - File I/O Commands

     
     ! *************************************************************************
     *                                                                         *
     *                                  COMM4                                  *
     *                            File I/O Commands                            *
     *                                                                         *
     ***************************************************************************
     
     
                This file is required as a source!file in COMAND.SAI.
     
     
     **************************************************************************;
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                            Page 2-1
     Prt: 06-Jun-84  13:54                                       Rtn C!NewBuffer

     
     ! Routine to build a work buffer ;
     
     simple procedure C!NewBuffer;
     begin |1|
       ifcr Tops20 thenc
         define
           CloseFile = true;
       endc
     
       C!ArgV _ 0;
     
       if (not B!FreeP) then
       begin |2|
         W!Msg("No Free Buffers!");
         return;
       end; |2|
     
       ifcr TymComX thenc
         B!CheckPoint;
         B!Make(NULL, "(Scratch)");
       endc
     
       ifcr Tops20 thenc
         B!CheckPoint(CloseFile);
           ! Close the Checkpoint File and free up B!Chan.
           ;
     
         B!CreateChkPntFile(null, "(Scratch)");
       endc
     
       W!NewS;
     end; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                            Page 3-1
     Prt: 06-Jun-84  13:54                                      Rtn C!KillBuffer

     
     ! Routine to kill a buffer ;
     
     simple procedure C!KillBuffer;
     begin |1|
       C!ArgV _ 0;
     
       if (W!Buf0 = W!Buf1) then
         W!Msg("You cannot kill a buffer while it is in two windows.")
       else if (B!Cnt) then
         ifcr TymComX thenc
           B!Kill
         endc
     
         ifcr Tops20 thenc
           B!DelCurrentBuffer
         endc
       else
         W!Msg("You cannot kill your only buffer.");
     
       W!NewS;
     end; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                            Page 4-1
     Prt: 06-Jun-84  13:54                                        Rtn C!ReadFile

     
     ! Prompt for a file spec and read a file. ;
     
     simple procedure C!ReadFile;
     begin "C!ReadFile" |1|
       string
         Prompt,
         Str,
         Switches;
       integer
         Error;
       define
         CloseFile      = true,
         F.OK           = 0,
         F.BAD.SWITCH   = 1,
         F.BAD.FILESPEC = 2;
     
     
       C!ArgV _ 0;
       Prompt _ "Read File: ";
     
       if (not B!FreeP) then
       begin |2|
         W!Msg("No Free Buffers!");
         T!Bell;
         return;
       end; |2|
     
       if (not C!ReadString(Prompt, CR, ESC)) then
         C!String _ null;
     
       if (C!String = null) then
       begin |2|
         W!Msg(Prompt & "[Aborted]");
         return;
       end; |2|
     
       if ((Error _ F!Scan(C!String)) neq F.OK) then
       begin |2|
         case (Error) of
         begin |3|
           [F.BAD.FILESPEC]
             W!Msg(Prompt & C!String & " [Bad FileSpec]");
     
           [F.BAD.SWITCH]
             W!Msg(Prompt & C!String & " [Bad Switch]")
         end; |3|
     
         T!Bell;
         return;
       end; |2|
     
       begin |2|
         string
           Dummy;            ! Dummy to fake out the oracle.
                             ;
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                            Page 4-2
     Prt: 06-Jun-84  13:54                                        Rtn C!ReadFile

     
         ifcr TymcomX thenc
           F!Decompose(C!String, Dummy, Dummy, Dummy, Dummy, Dummy, Switches);
         endc
     
         ifcr Tops20 thenc
           F!Decompose(C!String, Dummy, Dummy, Dummy, Dummy, Dummy, Dummy,
               Switches);
         endc
       end; |2|
     
       Str _ F!Parse(C!String);
       appnd(Prompt, Str & Switches);
     
       W!Msg(Prompt & " [Working]");
       W!MsgF _ true;
       W!Disp(true);
     
       ifcr TymComX thenc
         B!CheckPoint;
         B!Make(Str, null);
     
         if (F!Load(Str, -1, -1, -1)) then
           W!Msg(Prompt & "  [Complete]")
         else
           W!Msg(Prompt & "  [Failed]");
       endc
     
       ifcr Tops20 thenc
         B!CheckPoint(CloseFile);
     
           ! Close the Checkpoint File and free up B!Chan.
           ;
     
         if (B!CreateChkPntFile(Str)) then
           ! Successfully created the Checkpoint file.
           ;
     
           W!Msg(Prompt & "  [Complete]")
         else
           W!Msg(Prompt & "  [Failed]");
       endc
     
       B!Prot _ 0;
     
         ! Establish the file protection default.
         ;
     
       W!MsgF _ false;
       W!NewS;
       W!FixS;
     end "C!ReadFile"; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                            Page 5-1
     Prt: 06-Jun-84  13:54                                      Rtn C!InsertFile

     
     ! Prompt file a file spec and insert a file at the point. ;
     
     simple procedure C!InsertFile;
     begin |1|
       string
         Prompt,
         Str;
     
       if (B!Lock) then
         PuntCommand;
     
       C!ArgV _ 0;
       Prompt _ "Insert File: ";
     
       if (not C!ReadString(Prompt, CR, ESC)) then
         C!String _ null;
     
       if (C!String = null) then
       begin |2|
         W!Msg(Prompt & "[Aborted]");
         return;
       end; |2|
     
       Str _ F!Parse(C!String);
     
       if (not Str) then
       begin |2|
         W!Msg(Prompt & C!String & " [Bad FileSpec]");
         T!Bell;
         return;
       end; |2|
     
       appnd(Prompt, Str);
       W!Msg(Prompt & " [Working]");
     
       W!MsgF _ true;
       W!Disp(true);
     
       ifcr TymcomX thenc
         if (F!Read(Str)) then
           W!Msg(Prompt & "  [Complete]")
         else
           W!Msg(Prompt & "  [Failed]");
       endc
     
       ifcr Tops20 thenc
         if (B!FileInsert(Str)) then
           W!Msg(Prompt & "  [Complete]")
         else
           W!Msg(Prompt & "  [Failed]");
       endc
     
       W!MsgF _ false;
     end; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                            Page 6-1
     Prt: 06-Jun-84  13:54                                       Rtn C!WriteFile

     
     ! Write out the buffer to a file. ;
     
     procedure C!WriteFile;
     begin |1|
       string
         Prompt,
         Str;
     
       C!ArgV _ 0;
       Prompt _ "Write File [" & B!File & "]: ";
     
       if (not C!ReadString(Prompt, CR, ESC)) then
       begin |2|
         W!Msg(Prompt & "[Aborted]");
         return;
       end; |2|
     
       if (C!String) then
       begin |2|
         Str _ F!Parse(C!String);
     
         if (not Str) then
         begin |3|
           W!Msg(Prompt & C!String & " [Bad FileSpec]");
           T!Bell;
           return;
         end; |3|
     
         appnd(Prompt, Str);
         W!Msg(Prompt);
         appnd(Prompt, " ");
       end |2|
       else
         Str _ B!File;
     
       W!Msg(Prompt & "[Working]");
       W!MsgF _ true;
       W!Disp(true);
     
       if (F!Writ(Str)) then
       begin |2|
         W!Msg(Prompt & "[Complete]");
         B!ModP _ false;
       end |2|
       else
         W!Msg(Prompt & "[Failed]");
     
       W!MsgF _ false;
       W!FixS;
     end; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                            Page 7-1
     Prt: 06-Jun-84  13:54                                          Rtn C!Finish

     
     ! Finish by writing out the file and exiting ;
     
     simple procedure C!Finish;
     begin "C!Finish" |1|
       C!ArgV _ 0;
       W!MsgF _ true;
     
       if (not B!AnyM) then
       begin |2|
         W!Msg("No Buffers Modified");
         W!Disp(true);
         B!Fini(false);
       end |2|
       else
       begin |2|
         string
           Str;
     
         Str _ "Writing Modified Buffer";
     
         if (B!ModCnt > 1) then
           appnd(Str, "s");
     
         W!Msg(Str & "...");
     
           ! <<  We should list the buffer here.
           ;
     
         W!Disp(true);
         W!MsgF _ false;
         if (not B!Fini(true)) then
           return;
       end; |2|
     
       F!Exit;
       C!Quit _ true;
     end "C!Finish"; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                            Page 8-1
     Prt: 06-Jun-84  13:54                                          Rtn C!RunRPG

     
     ! Finish by writing out the file and calling RPG ;
     
     simple procedure C!RunRPG;
     begin |1|
       F!RPGFlag _ true;
       C!Finish;
       C!ArgV _ 0;
     end; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                            Page 9-1
     Prt: 06-Jun-84  13:54                                        Rtn C!SafeExit

     
     ! Just exit.  (The safe way). ;
     
     simple procedure C!SafeExit;
     begin |1|
       string
         Str;
       boolean
         ExitP;
     
     
       C!ArgV _ 0;
       ExitP  _ true;
     
       if (B!AnyM) then
       begin |2|
         Str _ "Buffer";
     
         if (B!ModCnt > 1) then
           appnd(Str, "s");
     
         appnd(Str, " modified.  Exit? ");
     
         if (not (ExitP _ C!Ask(Str))) then
           appnd(Str, "No")
         else
           appnd(Str, "Yes");
     
         ifcr Tops20 thenc
           T!FlshIBuf;
     
             ! Flush the terminal input buffer of a possible CR response.
             ;
         endc
       end; |2|
     
       W!Msg(Str);
       W!MsgF _ true;
       W!Disp(true);
     
       if (not ExitP) then
       begin |2|
         W!MsgF _ false;
         return;
       end; |2|
     
       B!Fini(false);
       F!Exit;
       C!Quit _ true;
     end; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                           Page 10-1
     Prt: 06-Jun-84  13:54                                        Rtn C!UnModify

     
     ! "Un"modify a buffer ;
     
     simple procedure C!UnModify;
     begin |1|
       define
         DontClose = {false};                        ! Don't close the
                                                     ! checkpoint file.
                                                     ;
     
       B!ModP _ false;
     
       ifcr TymcomX thenc
         B!CheckPoint;
       endc
     
       ifcr Tops20 thenc
         B!CheckPoint(DontClose);
       endc
     
       W!FixS;
       C!ArgV _ 0;
     end; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                           Page 11-1
     Prt: 06-Jun-84  13:54                                      Rtn C!Checkpoint

     
     ! Checkpoint the buffer ;
     
     simple procedure C!Checkpoint;
     begin |1|
       string
         Str;
     
       define
         DontClose = {false};                        ! Don't close the
                                                     ! checkpoint file.
                                                     ;
     
     
       Str _ "Checkpoint ";
       W!Msg(Str);
       C!ArgV _ 0;
       W!MsgF _ true;
       W!Disp(true);
       W!MsgF _ false;
     
       ifcr TymcomX thenc
         B!CheckPoint;
       endc
     
       ifcr Tops20 thenc
         B!CheckPoint(DontClose);
       endc
     
       W!Msg(Str & " [Complete]");
     end; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                           Page 12-1
     Prt: 06-Jun-84  13:54                                    Rtn C!UnCheckpoint

     
     ! Recover the last checkpoint ;
     
     simple procedure C!UnCheckpoint;
     begin |1|
       string
         Str;
     
       Str _ "Checkpoint ";
     
       if (B!CkPtSer) then
       begin |2|
         ! There has been a checkpoint done.
         ;
     
         C!ArgV _ 0;
         W!Msg(Str);
         W!MsgF _ true;
         W!Disp(true);
         W!MsgF _ false;
     
         ifcr Tops20 thenc
           B!RestoreFromEDT;
         endc
     
         ifcr TymcomX thenc
           B!Restore;
         endc
     
         W!Msg(Str & " [Restored]");
       end |2|
       else
         W!Msg("No checkpoint has been done.");
     end; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                           Page 13-1
     Prt: 06-Jun-84  13:54                                      Rtn C!NextBuffer

     
     ! step forward through the buffer chain ;
     
     simple procedure C!NextBuffer;
     begin |1|
       if (not C!ArgV) then
         C!ArgV _ 1
       else
         C!ArgV _ (C!ArgV min hr(B!Cnt)) max 1;
     
       while (C!ArgV) do
       begin |2|
         B!Step(FORWARDS);
         decr(C!ArgV);
       end; |2|
     
       W!NewS;
     end; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                           Page 14-1
     Prt: 06-Jun-84  13:54                                      Rtn C!LastBuffer

     
     ! step backwards ;
     
     simple procedure C!LastBuffer;
     begin |1|
       if (not C!ArgV) then
         C!ArgV _ 1
       else
         C!ArgV _ (C!ArgV min lh(B!Cnt)) max 1;
     
       while (C!ArgV) do
       begin |2|
         B!Step(BACKWARDS);
         decr(C!ArgV);
       end; |2|
     
       W!NewS;
     end; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                           Page 15-1
     Prt: 06-Jun-84  13:54                                         Rtn C!CmdFile

     
     ! Load commands from a file ;
     
     forward simple boolean procedure C!File(String F);
     
     procedure C!CmdFile;
     begin "C!CmdFile" |1|
       string
         Str,
         S,
         F;
     
       C!ArgV _ 0;
       Str _ "Command File: ";
     
       if (not C!ReadString(Str, CR, ESC)) then
         C!String _ null;
     
       if (C!String = null) then
       begin |2|
         T!Bell;
         W!Msg(Str & " [Aborted]");
         return;
       end; |2|
     
       S _ F!Parse(C!String);
     
       if (not S) then
       begin |2|
         W!Msg(Str & C!String & " [Bad FileSpec]");
         return;
       end; |2|
     
       F _ C!String;         ! because it may get clobbered ;
     
       if (C!File(S)) then
         W!Msg(Str & F & "  [Complete]")
       else
         W!Msg(Str & F & "  [Failed]");
     end "C!CmdFile"; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                           Page 16-1
     Prt: 06-Jun-84  13:54                                       Rtn C!PushFrame

     
     ! Push to another frame.  (POP back in /K14 and later monitors). ;
     
     procedure C!PushFrame;
     begin |1|
       integer
         Err,
         FD;
     
       C!ArgV _ 0;
     
       ifcr TymcomX thenc
         W!Msg("Type POP to return to " & DED!Alias);
         W!MsgF _ true;
         W!Disp(true);
         W!MsgF _ false;
     
         start!code |2|
           label lx;
             setzm   Err;
             hrlzi   1, '1;          ! 1 -> create new frame ;
             setz    2, ;
             frmop   1, 2;
               setom Err;
             skipe   Err;
               jrst  lx;
             movem   1, FD;
             hrro    1, FD;
             hrloi   2, '200000;     ! command level ;
             movei   3, 1;
             calli   3, -'135;       ! retach 3, ;
               setom Err;
             skipe   Err;
               jrst  lx;
             ttcall  '16, '7;        ! outchi 7 ;
           lx:
         end; |2|
       endc
     
       ifcr Tops20 thenc
         W!Msg("Push not implemented yet");
       endc
     
       C!Refresh;
     end; |1|
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                           Page 17-1
     Prt: 06-Jun-84  13:54                           Rtn C!RecoverCheckpointFile

     
     ! Recover from a checkpoint file. ;
     
     procedure C!RecoverCheckpointFile;
     begin "C!RecoverCheckpointFile" |1|
       ifcr TymcomX thenc
         string
           Ext,
           Dummy,
           Name,
           Str;
     
         C!ArgV _ 0;
         Str    _ "Checkpoint File: ";
     
         if (not C!ReadString(Str, CR, ESC)) then
         begin |2|
           W!Msg(Str & "[Aborted]");
           PuntCommand;
         end; |2|
     
         if (not F!Decompose(C!String, Dummy, Name, Ext, Dummy, Dummy, Dummy))
             then 
         begin |2|
           W!Msg(Str & C!String & " [Bad FileSpec]");
           PuntCommand;
         end; |2|
     
         B!CKFile(cvsix(Name), cvsix(Ext));
         W!Msg(Str & "  [Complete]");
         W!NewS;
       endc
     
       ifcr Tops20 thenc
         string
           Str,
           S;
     
     
         C!ArgV _ 0;
         Str    _ "Checkpoint File: ";
     
         if (not C!ReadString(Str, CR, ESC)) then
         begin |2|
           W!Msg(Str & "[Aborted]");
           PuntCommand;
         end; |2|
     
         if (not F!Scan(C!String)) then
         begin |2|
           W!Msg(Str & C!String & " [Bad FileSpec]");
           PuntCommand;
         end; |2|
     
         B!CKFile(C!String);
         W!Msg(Str & "  [Complete]");
     Cre: 05-Dec-83  14:26  (PEAKX)COMM4.REQ                           Page 17-2
     Prt: 06-Jun-84  13:54                           Rtn C!RecoverCheckpointFile

         W!NewS;
       endc
     end "C!RecoverCheckpointFile"; |1|
     
     
     ! *************************  End of COMM4.REQ  ***************************;

   g‹