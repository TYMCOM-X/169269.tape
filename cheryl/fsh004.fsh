42XFORMAT01:Peak V2(301)   All Other Modules    06-Jun     4 1984       




                                          
                                          
                                          
                                    
                                    
                                    
                                    
                                    
                                    
                              
                              
                              
                                                      
                                                      
                                                      
                                    
                                    
                                    
                                                      
                                                      
                                                      



                                          
                                          
                                          
                              
                              
                              
                                    
                                    
                                    
                                    
                                    
                                    
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          




                        
               
                
                 
                       
                   
                           

     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                           Page 1-1
     Prt: 06-Jun-84  13:55  

     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                           Page 2-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 1-1|
          Prt: 06-Jun-84  11:05             AuxWin - An Auxiliary Circuit in a |
                                                                      ->|Window|
     
          entry;
          begin "AuxWin" |1| |1|
            require "DED.DEF" source!file;
            ifcr TymcomX thenc
          
          ! *******************************************************************|
                                                                      ->|******|
          *                                                                    |
                                                                      ->|     *|
          *                                 AuxWin                             |
                                                                 ->|     *|
          *                                                                    |
                                                                      ->|     *|
          *                Login somewhere via an Auxiliary Circuit            |
                                                                      ->|     *|
          *           and insert the proceedings into the current buffer       |
                                                                      ->|     *|
          *                   (written by Bill Soley - 12.16.83)               |
                                                                      ->|     *|
          *                                                                    |
                                                                      ->|     *|
          *********************************************************************|
                                                                      ->|*****;|
          
          
          !                         From the Command Module
          ;
          
            external integer
              C!CreEscChr;                        ! The identity of the CreAux |
                                                                      ->|escape|
                                                  ! character.
                                                  ;
          
          
          !                         From the Buffer Module
          ;
          
            external simple procedure
              B!Delete (integer Side);            ! delete character
                                                  ;
            external simple procedure
              B!Insert (integer Chr);             ! insert into buffer
                                                  ;
            external simple procedure
              B!Move (integer Dir);               ! move in buffer
                                                  ;
          
          
          !                         From the Window Module
          ;
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                           Page 2-2
     Prt: 06-Jun-84  13:55  

          
            external procedure
              W!Disp (boolean Punt);              ! redisplay the window
                                                  ;
            external procedure
              W!Msg (string MSG);                 ! print a message on the left
                                                  ! side of the message line.
                                                  ;
            external procedure
              W!Msg2 (string MSG);                ! print a message on the right
                                                  ! side of the message line.
                                                  ;
          
          
          !                          From SAIL in general
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                           Page 3-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 1-2|
          Prt: 06-Jun-84  11:05             AuxWin - An Auxiliary Circuit in a |
                                                                      ->|Window|
     
          ;
          
            external integer
              !skip!;                             ! the flag
                                                  ;
          
          
          ! -------------------------------------------------------------------|
                                                                      ->|-----;|
          
          
          !                            Internal Storage
          ;
          
            own boolean
              ChangingEscChr,                     ! True iff we are changing the
                                                  ! CreAux escape character.
                                                  ;
              CktZapped,                          ! True iff the aux circuit is
                                                  ! zapped.
                                                  ;
              EscFlg,                             ! True if an escape operation|
                                                                      ->| is to|
                                                  ! be performed.
                                                  ;
              EscSeen;                            ! True if the escape characte|
                                                                       ->|r has|
                                                  ! been seen once.
                                                  ;
            own integer
              Port,                               ! A local copy of the aux cir|
                                                                        ->|cuit|
                                                  ! port number.
                                                  ;
              WkupChrs,                           ! The characters sent to the |
                                                                         ->|aux|
                                                  ! circuit input buffer to ins|
                                                                         ->|ure|
                                                  ! that a character wait is re|
                                                                      ->|turned|
                                                  ! from when we enter an esc
                                                  ! condition.
                                                  ;
              WkupChrsPtr;                        ! Pointer to the wakeup chars.
                                                  ;
          
          
          ! -------------------------------------------------------------------|
                                                                      ->|-----;|
          
          
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                           Page 3-2
     Prt: 06-Jun-84  13:55  

          !                        Miscellaneous Definitions
          ;
          
            define
              !axi8c        = '0                  ! Input Image Character (wait|
                                                                        ->| for|
                                                  ! character).
                                                  ;,
              !axi8s        = '1                  ! Input Image Character (skip|
                                                                         ->| if|
                                                  ! character was returned).
                                                  ;,
              !axsi         = '33                 ! Simulate input on port.
                                                  ;,
              !axsic        = '10                 ! Skip if character in input
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                           Page 4-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 1-3|
          Prt: 06-Jun-84  11:05             AuxWin - An Auxiliary Circuit in a |
                                                                      ->|Window|
     
                                                  ! buffer.
                                                  ;,
              !axo8         = '3                  ! Output Image Character.
                                                  ;,
              !axo8i        = '4                  ! Output image character imme|
                                                                      ->|diate.|
                                                  ;,
              !axlde        = '11                 ! Leave Deferred Echo Mode.
                                                  ;,
              !iachr        = '1                  ! Receipt of a Character (cau|
                                                                          ->|se|
                                                  ! for an interrupt).
                                                  ;,
              !gtunm        = -'22                ! Username(1)
                                                  ;,
              !gtun1        = -'21                ! Username(2)
                                                  ;,
              !cnsys        = '33                 ! System Number Gettab Item
                                                  ! designator.
                                                  ;,
              !gtcnf        = '11                 ! System Configuration Data G|
                                                                       ->|ettab|
                                                  ! table number.
                                                  ;,
              calli!AuxRed  = -'46                ! Read AuxCircuit count funct|
                                                                         ->|ion|
                                                  ! code.
                                                  ;,
              calli!CreAux  = -'44                ! CreAux function code.
                                                  ;,
              calli!GetTab  = '41                 ! Gettab function code.
                                                  ;,
              calli!Hiber   = '72                 ! Hiber function code.
                                                  ;,
              calli!Wake    = '73                 ! Wake function code.
                                                  ;,
              calli!ZapCir  = -'45                ! Zap the aux circuit function
                                                  ! code.
                                                  ;;
          
          
                ! Miscellaneous monitor symbols from uuosym.def.
                ;
          
          
            define
              cxsup# = '0,
              cx2ax# = '1,
              cxlog# = '2,
              cxdcb# = '3,
              cxnrr# = '4,
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                           Page 4-2
     Prt: 06-Jun-84  13:55  

              cxnrl# = '5,
              cxnch# = '6,
              cxerr# = '7,
              cxsfe# = '1,
              cxsbu# = '2,
              cxsbm# = '3,
              cxshu# = '4,
              cxsdf# = '5,
              cxsto# = '6,
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                           Page 5-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 1-4|
          Prt: 06-Jun-84  11:05             AuxWin - An Auxiliary Circuit in a |
                                                                      ->|Window|
     
              cxsab# = '7,
              cxsis# = '10,
              cxslq# = '11;
          
                ! CreAux error condition symbols.
                ;
          
          ! -------------------------------------------------------------------|
                                                                      ->|-----;|
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                           Page 6-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 2-1|
          Prt: 06-Jun-84  11:05                              Interrupt Administ|
                                                                      ->|ration|
     
          
          ! -------------------------------------------------------------------|
                                                                      ->|------|
          !
          !                        Interrupt Administration
          !
          !       o  The interrupt is used to move keyboard data out to the
          !          circuit.  
          !       o  For efficiency, an immediate interrupt is used:
          !
          !                               - BEWARE -
          !                          no SAIL data structures
          !                      may be touched by this routine!
          !
          !       o  Channel 10 is used because SAIL uses some of the lower one|
                                                                          ->|s.|
          !
          ! -------------------------------------------------------------------|
                                                                      ->|------|
          !
          !                   Interrupt Administration functions
          ;
          
          ! Note: newenb below means "use the new (=NEWENB) as opposed to old
          ! (=APRENB) interrupt system for TymcomX".
          ;
          
          
            require "<><>" delimiters;
          
            define
              intass (cause, channel) =
                  <xwd((cause), (bit(20) + (channel)))>,
          
              tinass (port, cause, channel) =
                  <xwd((port), (bit(5, 20) + (cause lsh 9) + (channel)))>,
          
              intdev (device, cause, channel) =
                  <xwd((device), (bit(7, 20) + (cause lsh 9) + (channel)))>,
          
              newenb (channel) =
                  <(bit(26) + (channel))>;
          
            require unstack!delimiters;
          
          ! -------------------------------------------------------------------|
                                                                      ->|-----;|
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                           Page 7-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 3-1|
          Prt: 06-Jun-84  11:05                                            Rtn |
                                                                      ->|AuxIni|
     
          
          ! Initialize misc stuff in the Auxwin Module.
          ;
          
          simple procedure AuxIni;
          begin "AuxIni" |2| |2|
            WkupChrs    _ cvasc(SP & BS);
            WkupChrsPtr _ point(7, WkupChrs, -1);
          end "AuxIni"; |2| |2|
          require AuxIni initialization[0];
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                           Page 8-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 4-1|
          Prt: 06-Jun-84  11:05                                            Rtn |
                                                                      ->|TTYSvc|
     
          
          !
          !                             CAVEAT HACKER:
          !                                this is a
          !                  SAIL IMMEDIATE INTERRUPT PROCEDURE!!!
          !
          !
          !
          ! 
          ! Read as many characters as exist from the TTY input buffer (in image
          ! mode), and send them to the aux circuit.
          !
          ! If the CreAux escape character is seen, then the next character rec|
                                                                       ->|eived|
          ! should be among the following choices, or else the two characters
          ! together are rejected (ie, they are ignored):
          !
          !     "Q"          Quit from the aux circuit session, but leave the c|
                                                                      ->|ircuit|
          !                  open.
          !
          !     "C"          Change the indentity of the escape character - the|
                                                                       ->| next|
          !                  character received will be the new value.
          !                  
          !     "Z"          Zap the aux circuit.
          !
          !     <esc char>   Send the escape character through unchanged.
          !
          ! Issue a Leave Deferred Echo instruction when done to begin reflecti|
                                                                          ->|ng|
          ! yellow balls.  The return causes SAIL to DISMIS the interrupt.
          ;
          
          simple procedure TTYSvc;
          begin "TTYSvc" |2| |2|
            start!code |3| |3|
              define
               Ac13 = '13,
               Ac14 = '14,
               Ac15 = '15;
              label
                TTA,
                TTB,
                TTC,
                TTD,
                TTE,
                TTF,
                Loop,
                Done;
          
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                           Page 8-2
     Prt: 06-Jun-84  13:55  

          
              Loop:
                hrroi     Ac13, !axi8s;           ! Get a char from TTY ;
                auxcal    Ac13, Ac14;             ! and skip if successful ;
                 jrst     Done;                   ! Nothing there, get out ;
          
                andi      Ac14, '177;             ! Remove unsightly grime from|
                                                                       ->| it ;|
          
                skipn     ChangingEscChr;         ! Are we changing the esc cha|
                                                                        ->|r? ;|
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                           Page 9-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 4-2|
          Prt: 06-Jun-84  11:05                                            Rtn |
                                                                      ->|TTYSvc|
     
                jrst      TTA;                    ! No - go on ;
          
                movem     Ac14, C!CreEscChr;      ! Set the new esc char ;
                setzm     ChangingEscChr;         ! Clear the flag ;
                jrst      Loop;                   ! and continue ;
          
              TTA:
                skipn     EscSeen;                ! Have we seen the esc char? ;
                jrst      TTE;                    ! No - probably a normal char|
                                                                          ->| ;|
          
                setzm     EscSeen;                ! Clear the flag ;
                move      Ac15, Ac14;             ! Make a copy of the char ;
                trz       Ac15, '40;              ! Upshift the copy ;
          
                caie      Ac15, "Q";              ! Is this the Quit command? ;
                jrst      TTB;                    ! No - look for other command|
                                                                         ->|s ;|
          
                setom     EscFlg;                 ! Show that we're quitting ;
                hrl       Ac13, Port;             ! On the aux circuit ;
                hrri      Ac13, !axsi;            ! simulate receipt of SP, BS ;
                auxcal    Ac13, WkupChrsPtr;      ! to insure wakeup on char wa|
                                                                        ->|it ;|
                  jfcl    ;                       ! Do nothing with the error ;
                jrst      Done;                   ! and get out ;
          
              TTB:
                caie      Ac15, "C";              ! Change the esc char command|
                                                                         ->|? ;|
                jrst      TTC;                    ! No - look for other command|
                                                                         ->|s ;|
          
                setom     ChangingEscChr;         ! Show we're changing esc cha|
                                                                         ->|r ;|
                jrst      Loop;                   ! and continue ;
          
              TTC:
                caie      Ac15, "Z";              ! Zap circuit command? ;
                jrst      TTD;                    ! No - what else is there? ;
          
                move      Ac13, Port;             ! On the aux circuit ;
                calli     Ac13, calli!zapcir;     ! send a Zapper ;
                setom     CktZapped;              ! set the flag ;
                jrst      Done;                   ! and get out ;
          
              TTD:
                camn      Ac14, C!CreEscChr;      ! Is this the esc char? ;
                jrst      TTF;                    ! Yes - go output it ;
          
                hrroi     Ac13, !axo8i;           ! Output to the TTY ;
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                           Page 9-2
     Prt: 06-Jun-84  13:55  

                auxcal    Ac13, BEL;              ! an immediate Beep ;
                jrst      Loop;                   ! and continue ;
          
              TTE:
                came      Ac14, C!CreEscChr;      ! Is this the esc char? ;
                jrst      TTF;                    ! No - go output it ;
          
                setom     EscSeen;                ! Show we've seen the esc cha|
                                                                          ->|r;|
                jrst      Loop;                   ! and continue ;
          
              TTF:
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                          Page 10-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 4-3|
          Prt: 06-Jun-84  11:05                                            Rtn |
                                                                      ->|TTYSvc|
     
                hrl       Ac13, Port;             ! Going to the aux circuit ;
                hrri      Ac13, !axo8;            ! in image mode ;
                auxcal    Ac13, Ac14;             ! output the char ;
                jrst      Loop;                   ! and continue ;
          
              Done:
                hrroi     Ac13, !axlde;           ! Let the TTY echo yellow bal|
                                                                        ->|ls ;|
                auxcal    Ac13,;                  
            end; |3| |3|
          end "TTYSvc"; |2| |2|
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                          Page 11-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 5-1|
          Prt: 06-Jun-84  11:05                                        Rtn Enab|
                                                                      ->|le!TTY|
     
          
          ! Define an immediate interrupt for a character received from the TTY.
          ;
          
          simple procedure Enable!TTY;
          begin "Enable!TTY" |2| |2|
            intmap(tinass(-1, !iachr, 10), TTYSvc, 0);
            enable(newenb(10));
            auxclv(-1, 0, !axlde);                ! echo yellow balls;
          end "Enable!TTY"; |2| |2|
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                          Page 12-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 6-1|
          Prt: 06-Jun-84  11:05                                       Rtn Disab|
                                                                      ->|le!TTY|
     
          
          ! Deassign and disable the interrupt for a character received from TT|
                                                                          ->|Y.|
          ;
          
          simple procedure Disable!TTY;
          begin "Disable!TTY" |2| |2|
            intmap(tinass(-1, !iachr, 0), TTYSvc, 0);
            disable(newenb(10));
          end "Disable!TTY"; |2| |2|
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                          Page 13-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 7-1|
          Prt: 06-Jun-84  11:05                                            Rtn |
                                                                      ->|CreAux|
     
          
          !
          !                     Auxilary Circuit Administration
          !
          !       o  Build a circuit to the specified user name/host.
          !       o  The following defaults are handled by this procedure:
          !              <null>           defaults to LIUN:CSYS
          !              nnnn             defaults to nnnn:HSYS
          !                                   (won't work from uNodes)
          !              nnnn:            defaults to nnnn:CSYS
          !              nnnn:ssss                    nnnn:ssss
          !              :ssss            defaults to LIUN:ssss
          !          where
          !              LIUN = logged in user name
          !              CSYS = current system number
          !              HSYS = home system number
          !       o  returns port number if succesful, else -1, !skip! is also |
                                                                         ->|set|
          ;
          
          internal integer procedure A!CreAux (reference string LoginString);
          begin "CreAux" |2| |2|
            integer
              I,
              Port;
            integer array
              X[0:5];
            string
              S,
              ErrMsg;
          
          
          ! Convert to Upper Case
          ;
          
              S           _ LoginString;
              LoginString _ null;
          
              while (length(S)) do 
                appnd(LoginString,
                    (
                      if "a" <= (I _ lop(S)) <= "z" then
                        I - '40
                      else
                        I
                    )
                );
           
          
          ! Handle Defaults in the Login String
          ;
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                          Page 13-2
     Prt: 06-Jun-84  13:55  

          
              if (length(LoginString) = 0) then
                LoginString _ ":";
          
                ! Accept all defaults.
                ;
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                          Page 14-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 7-2|
          Prt: 06-Jun-84  11:05                                            Rtn |
                                                                      ->|CreAux|
     
          
              if (LoginString[1 for 1] = ":") then
                LoginString _
                    cv6str(calli(xwd(-1, !gtunm), calli!GetTab)) &
                    cv6str(calli(xwd(-1, !gtun1), calli!GetTab)) &
                    LoginString;
          
                ! Supply correct username.
                ;
          
              if (LoginString[inf for 1] = ":") then
                LoginString _
                    LoginString &
                    cvs(calli(xwd(!cnsys, !gtcnf), calli!GetTab));
          
                ! Supply correct host number.
                ;
          
          
          ! Keep the User Informed
          ;
          
              W!Msg("Login: " & LoginString & " [Working]");
              W!Disp(true);
          
          
          ! Pack the String into an Array and Call the Monitor to Build the Cir|
                                                                        ->|cuit|
          ;
          
              for I _ 0 step 1 until 5 do
                X[I] _ cvasc(LoginString[1+5*I to 5+5*I]);
          
              Port _
              I    _ calli(location(X[0]), calli!CreAux);
          
          
          ! If the Monitor Call Skipped, Return the Port Number to Our Caller
          ;
          
              if (!skip!) then
              begin |3| |3|
                W!Msg("Login: " & LoginString & " [Ok]");
                return(I);
              end; |3| |3|
          
          
          ! Otherwise, we got an error, print the message
          ;
          
              case (lh(I)) of
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                          Page 14-2
     Prt: 06-Jun-84  13:55  

              begin |3| |3|
                [cxsup#]
                  case (rh(I)) of
                  begin |4| |4|
                    [cxsfe#]
                      ErrMsg _ "?format error";
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                          Page 15-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 7-3|
          Prt: 06-Jun-84  11:05                                            Rtn |
                                                                      ->|CreAux|
     
                    [cxsbu#]
                      ErrMsg _ "?not in MUD";
                    [cxsbm#]
                      ErrMsg _ "?bad MUD";
                    [cxshu#]
                      ErrMsg _ "?host unavailable";
                    [cxsdf#]
                      ErrMsg _ "?download/dialout failure";
                    [cxsto#]
                      ErrMsg _ "?timeout";
                    [cxsab#]
                      ErrMsg _ "?access barred";
                    [cxsis#]
                      ErrMsg _ "?error in ISIS";
                    [cxslq#]
                      ErrMsg _ "?long queue in supervisor";
                    else
                      ErrMsg _ "?supervisor error: '" & cvos(rh(I))
                  end; |4| |4|
          
              [cx2ax#]
                ErrMsg _ "?too many circuits";
              [cxlog#]
                ErrMsg _ "?not your username";
              [cxdcb#]
                ErrMsg _ "?no room in monitor";
              [cxnrr#]
                ErrMsg _ "?sup ignored original req";
              [cxnrl#]
                ErrMsg _ "?sup ignored login message";
              [cxnch#]
                ErrMsg _ "?sup supplied no circuit";
              [cxerr#]
                ErrMsg _ "?sup error on original request";
              else
                ErrMsg _ "?unknown error: '" & cvos(lh(I))
            end; |3| |3|
          
            W!Msg("Login: " & LoginString & " [failed]");
            W!Msg2("[" & ErrMsg & "]");
            clear(!skip!);
            return(-1);
          end "CreAux"; |2| |2|
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                          Page 16-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 8-1|
          Prt: 06-Jun-84  11:05                                              Rt|
                                                                      ->|n OutC|
     
          
          ! Insert characters into the buffer.  (^H is interpreted, nulls are
          ! ignored, and all other characters are inserted verbatim.
          ;
          
          simple procedure OutC (integer C);
          begin "OutC" |2| |2|
            case (C land !mask(7)) of
            begin |3| |3|
              [NUL]
                ;
              [BS]
                begin |4| |4|
                  B!Move(BACKWARDS);
                  B!Delete(FORWARDS);
                end; |4| |4|
              else
                B!Insert(C)
            end; |3| |3|
          end "OutC"; |2| |2|
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                          Page 17-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                           Pa|
                                                                      ->|ge 9-1|
          Prt: 06-Jun-84  11:05                                   Rtn TakeCareO|
                                                                      ->|fChars|
     
          
          ! Take care of inserting characters received on the aux circuit into |
                                                                         ->|the|
          ! buffer.
          ;
          
          simple procedure TakeCareOfChars;
          begin "TakeCareOfChars" |2| |2|
            start!code |3| |3|
              define
                Ac13 = '13,
                Ac14 = '14,
                P    = '17;
              label
                Loop,
                Done,
                Zapped;
          
                hrl       Ac13, Port;             ! Taking from the aux circuit|
                                                                          ->| ;|
                hrri      Ac13, !axI8C;           ! Get a char - wait if necess|
                                                                       ->|ary ;|
                auxcal    Ac13, Ac14;             ! Put it in Ac14 ;
                  jrst    Zapped;                 ! Circuit is hosed - go away ;
          
                push      P, Ac14;                ! Output the char ;
                pushj     P, OutC;                ! using OutC ;
          
              Loop:
                hrl       Ac13, Port;             ! Taking from the aux circuit|
                                                                          ->| ;|
                hrri      Ac13, !axI8S;           ! Get a char ;
                auxcal    Ac13, Ac14;             ! Put it in Ac14 ;
                  jrst    Done;                   ! None exists - go away ;
          
                push      P, Ac14;                ! Output the char ;
                pushj     P, OutC;                ! using OutC ;
                jrst      Loop;                   ! Go get another char ;
          
              Zapped:
                setom     CktZapped;              ! Flag loss of the circuit ;
          
              Done:
            end; |3| |3|
          end "TakeCareOfChars"; |2| |2|
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                          Page 18-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                          Pag|
                                                                      ->|e 10-1|
          Prt: 06-Jun-84  11:05                                       Rtn A!Aux|
                                                                      ->|Window|
     
          
          !                               A!AuxWindow
          !
          !       assumes echo is off on command port
          !       takes over terminal for duration of circuit
          !       uses SAIL immediate interrupts - beware!
          ;
          
          internal procedure A!AuxWindow (reference integer AuxPort);
          begin "A!AuxWindow" |2| |2|
            Port _ AuxPort;
          
              ! A local copy for local uses.
              ;
          
            if (Port >= 0) then
            begin "OK" |3| |3|
              clear(ChangingEscChr);
              clear(EscFlg);
              clear(EscSeen);
              clear(CktZapped);
          
              Enable!TTY;                       ! enable interrupts;
          
              do
              begin |4| |4|
                W!Disp(true);                   ! Redisplay before getting char|
                                                                         ->|s ;|
                TakeCareOfChars;                ! Input and insert characters ;
              end |4| |4|
              until (EscFlg or CktZapped);
          
              Disable!TTY;                      ! disable interrupts;
          
              if (CktZapped) then
                AuxPort _ Port _ -1;
          
                ! <<  Otherwise: is there anything we should do to the aux circ|
                                                                         ->|uit|
                !     to handle backpressure, funny colored balls, etc?
                ;
          
              W!Disp(true);
            end "OK"; |3| |3|
          end "A!AuxWindow"; |2| |2|
     Cre: 06-Jun-84  11:05  (PEAKX)AUXWIN.SAI                          Page 19-1
     Prt: 06-Jun-84  13:55  

          Cre: 25-Apr-84  14:44  (PEAKX)AUXWIN.SAI                          Pag|
                                                                      ->|e 11-1|
          Prt: 06-Jun-84  11:05                                            Rtn |
                                                                      ->|A!Fini|
     
          
          ! Close down shop before exitting for good.
          ;
          
          internal simple procedure A!Fini;
          begin "A!Fini" |2| |2|
            if (Port >= 0) then
              calli(Port, calli!ZapCir);
          
              ! Zap the circuit if it remains open.
              ;
          end "A!Fini"; |2| |2|
          end "AuxWin"; |1| |1|
          endc
          
          
          ! *************************  End of AuxWin.Sai  *********************|
                                                                      ->|*****;|


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
                       
         
         
              
            
           
                        

     Cre: 02-May-84  11:40  (PEAKX)DED.SAI                              Page 1-1
     Prt: 06-Jun-84  13:55                                      PEAK Main Module

     begin "DED - Top Level Logic" |1|
       require "DED.DEF" source!file;
     
     
     ! *************************************************************************
     *                                                                         *
     *                         DED - A Display EDitor.                         *
     *                 Dave W. Smith,  September-October, '81                  *
     *                 Ken Dawson:  Version 1.0  (6..82 - ??)                  *
     *                                                                         *
     **************************************************************************;
     
     
     ! Herein contained is the top level logic of PEAK.  We analyse the
     ! command line, call the initialization routines for each module and
     ! invoke the command loop.
     ;
     
     !                  The necessary external declarations.
     ;
     
       external integer
         B!DedVer;                           ! Editor version word.
                                             ;
       ifcr TymcomX thenc
         external simple procedure
           A!Fini;                           ! Close up shop in the aux circuit
                                             ! module.
                                             ;
       endc
     
       external procedure
         C!Loop;                             ! Execute the main command loop.
                                             ;
       external procedure
         F!RPG;                              ! Interface to RPG.
                                             ;
       external procedure
         T!Fini;                             ! Reset the terminal.
                                             ;
       external procedure
         F!Init;                             ! Initialize the file I/O module.
                                             ;
       external procedure
         C!Init;                             ! Initialize the Command module.
                                             ;
       external boolean
         T!IntP;                             ! Indicate that the Terminal has
                                             ! been initialized.
                                             ;
       external procedure
         T!Init;                             ! Initialize the Terminal
                                             ! abstraction.
                                             ;
       external boolean
         W!IntP;                             ! Indicate that the Window Module
     Cre: 02-May-84  11:40  (PEAKX)DED.SAI                              Page 1-2
     Prt: 06-Jun-84  13:55                                      PEAK Main Module

                                             ! has been initialized.
                                             ;
       external procedure
         W!Init;                             ! Initialize the Window
                                             ! abstraction.
                                             ;
       external procedure
         R!Init;                             ! Initialize the Redisplay
                                             ! module.
                                             ;
       external procedure
         C!Ini;                              ! Execute the Peak.Ini file, if
                                             ! there is one.
                                             ;
     
     
     ! ************************************************************************;
     Cre: 02-May-84  11:40  (PEAKX)DED.SAI                              Page 2-1
     Prt: 06-Jun-84  13:55                              Rtn InitializeEverything

     
     ! Perform all module initializations for the manifold components of Peak.
     ! Also initialize global variables which don't necessarily belong to any
     ! particular module.
     ;
     
     simple procedure InitializeEverything;
     begin "InitializeEverything" |2|
       B!DedVer _ DED!Version!Word;
     
         ! Identify this version of Peak.
         ;
     
       C!Init;
       T!Init;
       W!Init;
       R!Init;
       F!Init;
       C!Ini;
     
         ! Initialize the world.
         ;
     end "InitializeEverything"; |2|
     Cre: 02-May-84  11:40  (PEAKX)DED.SAI                              Page 3-1
     Prt: 06-Jun-84  13:55                                     Rtn Mainline Code

     
     ! Note that by the time we get here, the following routines have been
     ! initialized via the Sail "require ... initialization" mechanism:
     !
     !     InitSymCmdAddr                    in the Command Module
     !     InitVarLocs                       in the Command Module
     !     B!Init                            in the Buffer  Module
     ;
     
       clear(W!IntP);
       clear(T!IntP);
     
         ! Indicate that the Window and Redisplay Modules have not been
         ! initialized.
         ;
     
       F!Rpg;
     
         ! Pickup up and parse the command line or text from RPG.
         ;
     
     
       print
       (
         DED!Alias, " Version ",
         DED!Major!Version, ".",
         DED!Minor!Version,
         " (", DED!Edit!Version, ") ",
         DED!Version!String, "..."
       );
     
         ! Tell the world who we are.
         ;
     
     
       InitializeEverything;
     
         ! Initialize the World.
         ;
     
     
       C!Loop;
     
         ! Edit away happily...
         ;
     
       ifcr TymcomX thenc
         A!Fini;
       endc
     
       T!Fini;
     
       while (true) do
         exit;
     
         ! End of execution.  Reset the terminal and exit.
     Cre: 02-May-84  11:40  (PEAKX)DED.SAI                              Page 3-2
     Prt: 06-Jun-84  13:55                                     Rtn Mainline Code

         ;
     end "DED - Top Level Logic"; |1|
     
     
     ! ****************************  End Ded.Sai  *****************************;


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
                                                            
                                                            
                                                            
                              
                              
                              
                              
                              
                              
                                                                  
                                                                  
                                                                  



                                                                  
                                                                  
                                                                  
                        
                        
                        
                        
                        
                        
                                                
                                                
                                                
                  
                  
                  
                  
                  
                  
                                                
                                                
                                                




                                  
             
             
                        
               
              
                              

     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                           Page 1-1
     Prt: 06-Jun-84  13:55                         Redisplay for a Canonical CRT

     Entry;
     begin "Redisplay for a Canonical CRT" |1|
     require "Ded.Def" source!file;
     
     ! *************************************************************************
     *                                                                         *
     *                               Redisp.Sai                                *
     *                                                                         *
     ***************************************************************************
     
             Peak Terminal Abstraction and Redisplay Module.
     
     **************************************************************************;
     
     
     external boolean
       C!Debug;
     
     external procedure
       W!BAdd (string S);
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                           Page 2-1
     Prt: 06-Jun-84  13:55                                      Internal Storage

     
     ! The following information "lives" in this module, and is shared
     ! between the terminal abstraction and the redisplay.
     ;
     
     internal boolean
       T!IntP;                              ! Flag indicating that the Terminal
                                             ! has been initialized.
                                             ;
     
     
     ! Name and enumerated type of the terminal. ;
     
     internal string
       T!Name;
     
     integer
       T!Enum;
     
     
     ! We make certain information about the terminal available to the world. ;
     
     internal integer
       T!Lines,              ! # lines on screen for this terminal ;
       T!MaxS,               ! # lines max to try scrolling  ;
       T!Width;              ! # characters on a line ;
     
     integer
       T!Row,                ! Last row we left the cursor on ;
       T!Col;                ! Last column we left the cursor on ;
     
     
     ! For the insert/delete character/line operations, it is assumed that
     ! the terminal can do deletes if it can do inserts. ;
     
     internal boolean
       T!ICP,                ! The terminal can do insert char ops ;
       T!ILP,                ! The terminal can do insert line ops ;
       T!ELP;                ! The terminal can erase to end-of-line ;
     
     integer
       T!CPC,                ! The cost of doing cursor positioning ;
       T!ELC,                ! The cost of erasing lines ;
       T!ICC,                ! The cost of inserting characters ;
       T!ILC;                ! The cost of inserting lines ;
     
     
     ! Other information hidden in this module ;
     
     ifcr TymcomX thenc
       own integer
         T!LCH,                      ! terminal line characteristics ;
         T!XON;                      ! terminal XON setting ;
     endc
     
     ifcr Tops20 thenc
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                           Page 2-2
     Prt: 06-Jun-84  13:55                                      Internal Storage

       own integer
         SaveRTIW,                   ! character interrupt word ;
         SaveRFMOD;                  ! terminal mode word ;
     endc
     
     
     ! Characters are buffered to make i/o a bit more efficient. ;
     
     define
       TERMBUFFERSIZE = 125;
     
     integer array
       T!Buffer[0:(TERMBUFFERSIZE / 5) + 1];
     
     integer
       T!Buf!BP,
       T!Buf!Cnt;
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                           Page 3-1
     Prt: 06-Jun-84  13:55                                  Terminal Definitions

     
     ! The following set of macros set up the terminal definition tables.
     ! Take care not to move semicolons around if changing things.
     !  (Thanks here to Ken Dawson) ;
     
     define
       !!Cnt   = 0,
       !!Term  = {preload!with },
       !!Alias = {preload!with },
       !!Enum  = {preload!with },
       !!Lines = {preload!with },
       !!MaxS  = {preload!with },
       !!Width = {preload!with },
       !!CPC   = {preload!with },
       !!ELP   = {preload!with },
       !!ELC   = {preload!with },
       !!ILP   = {preload!with },
       !!ICP   = {preload!with };
     
     define
       TTY(Term, Alias, Enum, Lines, MaxS, Width, CPC, ELP, ELC, ILP, ICP) =
       { |2|
     
         redefine Term!Idx!}&{Alias = Enum;
     
         redefine
           !!Cnt   = !!Cnt + 1,
           !!Term  = cvms(!!Term)  & {Term, },
           !!Alias = cvms(!!Alias) & {"} & cvps(Alias) & {", },
           !!Enum  = cvms(!!Enum ) & {Enum, },
           !!Lines = cvms(!!Lines) & {Lines, },
           !!MaxS  = cvms(!!MaxS ) & {MaxS, },
           !!Width = cvms(!!Width) & {Width, },
           !!CPC   = cvms(!!CPC  ) & {CPC, },
           !!ELP   = cvms(!!ELP  ) & {ELP, },
           !!ELC   = cvms(!!ELC  ) & {ELC, },
           !!ILP   = cvms(!!ILP  ) & {ILP, },
           !!ICP   = cvms(!!ICP  ) & {ICP, };
       }; |2|
     
     define
       TTX(Term, Alias, Enum, Lines, MaxS, Width, CPC, ELP, ELC, ILP, ICP) =
       { |2|
     
         redefine Term!Idx!}&{Alias = Enum;
     
         redefine
           !!Cnt   = !!Cnt + 1,
           !!Term  = cvms(!!Term ) & {Term;  string  array T!!Term  [1:!!Cnt];},
           !!Alias = cvms(!!Alias) & {"} & cvps(Alias) & {";
                                             string  array T!!Alias [1:!!Cnt];},
           !!Enum  = cvms(!!Enum ) & {Enum;  integer array T!!Enum  [1:!!Cnt];},
           !!Lines = cvms(!!Lines) & {Lines; integer array T!!Lines [1:!!Cnt];},
           !!MaxS  = cvms(!!MaxS ) & {MaxS;  integer array T!!MaxS  [1:!!Cnt];},
           !!Width = cvms(!!Width) & {Width; integer array T!!Width [1:!!Cnt];},
           !!CPC   = cvms(!!CPC  ) & {CPC;   integer array T!!CPC   [1:!!Cnt];},
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                           Page 3-2
     Prt: 06-Jun-84  13:55                                  Terminal Definitions

           !!ELP   = cvms(!!ELP  ) & {ELP;   integer array T!!ELP   [1:!!Cnt];},
           !!ELC   = cvms(!!ELC  ) & {ELC;   integer array T!!ELC   [1:!!Cnt];},
           !!ILP   = cvms(!!ILP  ) & {ILP;   integer array T!!ILP   [1:!!Cnt];},
           !!ICP   = cvms(!!ICP  ) & {ICP;   integer array T!!ICP   [1:!!Cnt];};
     
         !!Term
         !!Alias
         !!Enum
         !!Lines
         !!MaxS
         !!Width
         !!CPC
         !!ELP
         !!ELC
         !!ILP
         !!ICP
       }; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                           Page 4-1
     Prt: 06-Jun-84  13:55                                 Build Terminal Tables

     
     ! Now build the terminal tables.  If you change anything here be careful
     ! about not placing semicolons after the macro invocations.  Also, the
     ! last macro, and ONLY the last macro, MUST be a TTX().
     !
     !   Terminal Type Specification Acceptable as Input
     !   |          Displayed Terminal Type Alias
     !   |          |        Enumerated Terminal Type Class
     !   |          |        |  Lines Per Screen
     !   |          |        |  |   Maximum Scoll Region
     !   |          |        |  |   |   Screen Width
     !   |          |        |  |   |   |   Cost of Positioning Cursor
     !   |          |        |  |   |   |   |  Can we Erase Lines?
     !   |          |        |  |   |   |   |  |  Cost of Erasing Lines
     !   |          |        |  |   |   |   |  |  |  Can We Insert Lines?
     !   |          |        |  |   |   |   |  |  |  |  Cost of Inserting
     !   |          |        |  |   |   |   |  |  |  |  |  Characters
     !   |          |        |  |   |   |   |  |  |  |  ;
     TTY("H19",     H19,     1, 24, 24, 80, 4, 1, 2, 1, 0)
     TTY("Z19",     H19,     1, 24, 24, 80, 4, 1, 2, 1, 0)
     TTY("VT52",    VT52,    1, 24, 24, 80, 4, 1, 2, 0, 0)
     TTY("*15*",    VT52,    1, 24, 24, 80, 4, 1, 2, 0, 0)
     TTY("*17*",    VT52,    1, 24, 24, 80, 4, 1, 2, 0, 0)
     
     TTY("TYM444",  Tym444,  2, 24, 24, 80, 8, 1, 2, 1, 0)
     TTY("444",     Tym444,  2, 24, 24, 80, 8, 1, 2, 1, 0)
     TTY("HP2621",  Tym444,  2, 24, 24, 80, 8, 1, 2, 1, 0)
     TTY("*5*",     Tym444,  2, 24, 24, 80, 8, 1, 2, 1, 0)
     TTY("*33*",    Tym444,  2, 24, 24, 80, 8, 1, 2, 1, 0)
     
     TTY("TYM425",  Tym425,  3, 24, 10, 80, 4, 1, 2, 1, 1)
     TTY("425",     Tym425,  3, 24, 10, 80, 4, 1, 2, 1, 1)
     TTY("ADM31",   Tym425,  3, 24, 10, 80, 4, 1, 2, 1, 1)
     TTY("ADM31A",  Tym425,  3, 24, 10, 80, 4, 1, 2, 1, 1)
     TTY("*4*",     Tym425,  3, 24, 10, 80, 4, 1, 2, 1, 1)
     
     TTY("TYM420",  Tym420,  3, 24, 24, 80, 4, 1, 2, 0, 0)
     TTY("420",     Tym420,  3, 24, 24, 80, 4, 1, 2, 0, 0)
     TTY("ADM1",    Tym420,  3, 24, 24, 80, 4, 1, 2, 0, 0)
     TTY("ADM1A",   Tym420,  3, 24, 24, 80, 4, 1, 2, 0, 0)
     
     TTY("ADDS",    ADDS,    4, 24, 24, 80, 4, 1, 2, 0, 0)
     
     TTY("VT100",   VT100,   5, 24, 10, 80, 8, 1, 3, 1, 0)
     TTY("*20*",    VT100,   5, 24, 10, 80, 8, 1, 3, 1, 0)
     TTY("VT102",   VT102,   6, 24, 10, 80, 8, 1, 3, 1, 1)
     TTY("*37*",    VT102,   6, 24, 10, 80, 8, 1, 3, 1, 1)
     
     TTY("Tym430",  Tym430,  7, 24,  0, 80, 4, 0, 0, 0, 0)
     TTY("430",     Tym430,  7, 24,  0, 80, 4, 0, 0, 0, 0)
     TTY("ADM3A",   Tym430,  7, 24,  0, 80, 4, 0, 0, 0, 0)
     
     TTY("SCANSET", Scanset, 8, 24,  0, 80, 4, 1, 2, 0, 0)
     
     TTY("940",     Ti940,   9, 24,  5, 80, 4, 1, 2, 1, 0)
     TTX("Ti940",   Ti940,   9, 24,  5, 80, 4, 1, 2, 1, 0)
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                           Page 5-1
     Prt: 06-Jun-84  13:55                                            Rtn DelStr

     
     ! Return some number of DELs.
     ;
     
     simple string procedure DelStr (integer Cnt);
     begin "DelStr" |2|
       own string
         DelString;
     
       while (length(DelString) < Cnt) do
         DelString _ DelString & DEL & DelString;
     
       return(DelString[1 for Cnt]);
     end "DelStr"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                           Page 6-1
     Prt: 06-Jun-84  13:55                                           Rtn TermIdx

     
     ! Determine the magic index if the supplied terminal type.  If none
     ! matches, return -1.
     ;
     
     simple integer procedure TermIdx (string Term);
     begin "TermIdx" |2|
       integer
         I;
     
       for I _ 1 step 1 until !!Cnt do
         if (kequ(Term, T!!Term[I][1 for length(Term)])) then
           return(I);
     
       return(-1);
     end "TermIdx"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                           Page 7-1
     Prt: 06-Jun-84  13:55                                     Rtn T!GetTermType

     
     ! Get the user's terminal type, and set up some information about the
     ! terminal, such as its screen size, capabalities, ... ;
     
     forward internal integer procedure T!GetC;
     
     internal simple procedure T!GetTermType (boolean AskTheMonitor(true));
     begin "T!GetTermType" |2|
       string
         Term;
       integer
         I;
     
     
       if (AskTheMonitor) then
       begin |3|
         I _ -1;
     
         ifcr TymcomX thenc
           Term _ cv6str(auxclv(-1, I, '100));       ! get tty type ;
     
           if (equ(Term, "______")) then
             Term _ null;                            ! not implemented ;
         endc
     
         ifcr Tops20 thenc
           start!code |4|
             movei     1, -1;
             gttyp;
             movem     2, I;
           end; |4|
     
           Term _ "*" & cvos(I) & "*";
         endc
       end |3|
       else
         Term _ null;
     
       while (true) do
       begin "ask for terminal type" |3|
         if (Term = null) then
         begin |4|
           print("Terminal Type? ");
     
           ifcr TymcomX thenc
             if (T!IntP) then
             begin |5|
               integer
                 C;
     
               while ((C _ T!GetC) neq CR and C neq ESC) do
               begin |6|
                 appnd(Term, C);
                 auxclv(-1, C, '003);        ! .axo8 (image output)
                                             ;
               end; |6|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                           Page 7-2
     Prt: 06-Jun-84  13:55                                     Rtn T!GetTermType

             end |5|
             else
               Term _ inchwl;
           endc
     
           ifcr Tops20 thenc
             Term _ InTTY;
           endc
         end; |4|
     
         if ((I _ TermIdx(Term)) > 0) then
         begin |4|
           T!Enum  _ T!!Enum[I];
           T!Name  _ T!!Alias[I];
           T!Lines _ T!!Lines[I];
           T!MaxS  _ T!!MaxS[I];
           T!Width _ T!!Width[I];
           T!CPC   _ T!!CPC[I];
           T!ELP   _ T!!ELP[I];
           T!ELC   _ T!!ELC[I];
           T!ILP   _ T!!ILP[I];
           T!ICP   _ T!!ICP[I];
           return;
         end; |4|
     
         if (equ(Term, "?") or kequ(Term, "help")) then
         begin |4|
           print(crlf & "Supported terminals are:" & crlf);
     
           for I _ 1 upto !!Cnt do
             if (not kequ(T!!Alias[I], Term)) then
             begin |5|
               print("  ", T!!Alias[I], crlf);
               Term _ T!!Alias[I];
             end; |5|
     
           print(crlf);
         end |4|
         else
         begin |4|
           print(crlf & "Unknown terminal type: ", Term, crlf);
           print("Type ? for a list of supported types." & crlf&crlf);
         end; |4|
     
         Term _ NULL;
       end "ask for terminal type"; |3|
     end "T!GetTermType"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                           Page 8-1
     Prt: 06-Jun-84  13:55                                            Rtn T!Init

     
     ! Initialize the module.  This involves saving the current state of
     ! the monitor with respect to the terminal, turning off the echo ... ;
     
     internal procedure T!Init;
     begin |2|
       define
         AskTheMonitor = {true};
     
       T!GetTermType(AskTheMonitor);
     
       ifc TymcomX thenc
         begin!code |3|
           seto      1, ;
           ttcall    6, 1;           ! getlch 1;
           movem     1, T!LCH;       ! save them ;
           tlo       1, '220;        ! set some magic bits ;
           ttcall    7, 1;           ! setlch 1;
           hrroi     1, '64;
           auxcal    1, '714;        ! set no-echo, break on all bits ;
           setzm     T!XON;          ! want the xon bit off ;
           hrroi     1, '55;
           auxcal    1, T!XON;       ! turn it off, save old value ;
           jfcl;
         end; |3|
       endc
     
       ifcr Tops20 thenc
         start!code |3|
           movei     1, -5;
           rtiw;
           movem     2, SaveRTIW;
           tlz       2, '040004;             ! turn off ^C, ^O interrupts ;
           trz       2, '100000;             ! turn off ^T interrupt ;
           hrrzi     1, -5;
           stiw;
           hrrzi     1, -1;
           rfmod;
           movem     2, SaveRFMOD;
           hrrzi     1, -1;
           trz       2, '300;                ! 8 bit image i/o ;
           sfmod;
         end; |3|
       endc
     
       T!Buf!BP  _ point(7, T!Buffer[0], -1);
       T!Buf!Cnt _ 0;
     
       set(T!IntP);
     end; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                           Page 9-1
     Prt: 06-Jun-84  13:55                                        Rtn T!FlshIBuf

     
     ! On Tops-20 (as of V5.0), there is a bug in the transition from image
     ! mode I/O to "normal", monitor-supervised I/O.  Basically, if the last
     ! character input in image mode was a CR, the monitor feels compelled to
     ! insert a LF into the terminal input buffer, regardless of whether the
     ! character has already been read.
     !
     ! At the monitor level, upon exiting Peak, this is manifested as a repeat
     ! of the prompt.  At MAGNUM level, a LF causes the last command issued to
     ! be repeated (and naturally, this repeats the edit command).
     !
     ! We therefore force another character (a space) into the terminal input
     ! buffer, and read it immediately.
     ;
     
     ifcr Tops20 thenc
       internal simple procedure T!FlshIBuf;
       begin "T!FlshIBuf" |2|
         start!code |3|
           hrrzi     1, -1;
           hrrzi     2, '40;
           sti;
           hrrzi     1, -1;
           bin;
         end; |3|
       end "T!FlshIBuf"; |2|
     endc
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 10-1
     Prt: 06-Jun-84  13:55                                            Rtn T!Fini

     
     ! Reset the terminal (or at least the line characteristics) to roughly
     !  how we found it.  Position the cursor to the bottom of screen. ;
     
     forward internal simple procedure T!CPos(integer Row, Col);
     forward internal simple procedure T!Flush;
     
     internal procedure T!Fini;
     begin |2|
       T!Cpos(T!Lines, 1);
       T!Flush;
     
       ifcr TymcomX thenc
         begin!code |3|
           hrli      1, '41;         ! wait for output to complete ;
           hrri      1, 5;           ! wait 5 seconds before timeout ;
           calli     1, '72;         ! hiber will send yellow ball ;
            jfcl;                    ! ignore timeout (so we lose...) ;
           move      1, T!LCH;       ! restore original line characteristics ;
           ttcall    7, 1;           ! setlch 1;
           hrroi     1, '64;         ! turn off bits in file status word ;
           auxcal    1, 0;           ! clear the bits ;
            jfcl;
           hrroi     1, '55;
           auxcal    1, T!XON;       ! restore xon setting ;
            jfcl;
         end; |3|
       endc
     
       ifcr Tops20 thenc
         start!code |3|
           movei     1, - 5;
           move      2, SaveRTIW;
           stiw;
           hrrzi     1, -1;
           move      2, SaveRFMOD;
           sfmod;
         end; |3|
       endc
     end; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 11-1
     Prt: 06-Jun-84  13:55                                            Rtn T!RSet

     
     ! Oops, re-init the terminal ;
     
     internal procedure T!RSet;
     begin "reset the terminal" |2|
       ifcr TymcomX thenc
         begin!code |3|
           seto      1, ;
           ttcall    6, 1;                   ! getlch 1;
           tlo       1, '220;                ! set some magic bits ;
           ttcall    7, 1;                   ! setlch 1;
           hrroi     1, '64;
           auxcal    1, '714;                ! set no-echo, break on all bits ;
           setz      2, ;
           hrroi     1, '55;
           auxcal    1, 2;
           jfcl;
         end; |3|
       endc
     
       ifcr Tops20 thenc
         start!code |3|
           movei     1, -5;
           move      2, SaveRTIW;
           tlz       2, '040004;             ! turn off ^C, ^O interrupts ;
           trz       2, '100000;             ! turn off ^T interrupt ;
           stiw;
           hrrzi     1, -1;
           move      2, SaveRFMOD;
           trz       2, '300;                ! 8 bit image i/o ;
           sfmod;
         end; |3|
       endc
     end "reset the terminal"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 12-1
     Prt: 06-Jun-84  13:55                                            Rtn T!ChrP

     
     ! Routine to tell if typeahead is present ;
     
     internal boolean procedure T!ChrP;
     begin "T!ChrP" |2|
       own integer
         CharThere;
     
       ifcr TymcomX thenc
         start!code |3|
           hrroi     1, '10;         ! 1/  -1,,10 ;
           auxcal    1, ;            ! skip if input ;
            tdca     1, 1;           !  zero t1 and skip ;
           seto      1, ;            ! set 1 to -1 ;
           movem     1, CharThere;   ! store the result ;
         end; |3|
       endc
     
       ifcr Tops20 thenc
         start!code |3|
           setzm     CharThere;
           hrrzi     1, -1;
           sibe;                             ! skip if buffer empty ;
           movem     2, CharThere;           !  not empty, save count ;
         end; |3|
       endc
     
       return(CharThere);
     end "T!ChrP"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 13-1
     Prt: 06-Jun-84  13:55                                            Rtn T!GetC

     
     ! Routine to get a 7 bit image character from the terminal. ;
     
     internal integer procedure T!GetC;
     begin "T!GetC" |2|
       integer
         C;
     
       ifcr TymcomX thenc
         start!code |3|
           label
             getc,
             waitc,
             gotc;
     
           getc:
             hrroi   1, 1;           ! -1,,1 (.axi8s) ;
             auxcal  1, 2;           ! input image character and skip ;
               jrst  waitc;          ! no character, block for one ;
             jrst    gotc;           ! have a character, go home ;
     
           waitc:
             hrroi   1, 0;           ! -1,,0 (.axi8c) ;
             auxcal  1, 2;           ! block until input ;
               jfcl;
     
           gotc:
             andi    2, '177;        ! and to 7 bits ;
             movem   2, C;           ! Save the character ;
         end; |3|
       endc
     
       ifcr Tops20 thenc
         start!code |3|
             hrrzi 1, -1;            ! read from the console ;
             bin;                    ! get a byte ;
             andi 2, '177;           ! mask to 7 bits ;
             movem 2, C;             ! save ;
         end; |3|
       endc
     
       return(C);
     end "T!GetC"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 14-1
     Prt: 06-Jun-84  13:55                                           Rtn T!Flush

     
     ! Routine to flush the terminal buffer ;
     
     internal simple procedure T!Flush;
     begin "T!Flush" |2|
       idpb(0, T!Buf!BP);
     
       ifcr TymcomX thenc
         auxclr(-1, T!Buffer[0], '52);       ! pseudo outstr ;
       endc
     
       ifcr Tops20 thenc
         start!code |3|
           hrroi     2,access(T!Buffer[0]);
           setz      3,;
           hrrzi     1,-1;                   ! write to our console ;
           sout;                             ! dump the string ;
         end; |3|
       endc
     
       T!Buf!BP  _ point(7, T!Buffer[0], -1);
       T!Buf!Cnt _ 0;
     end "T!Flush"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 15-1
     Prt: 06-Jun-84  13:55                                            Rtn T!SBuf

     
     ! Send a string of stuff to the terminal, regardless of size.
     ;
     
     simple procedure T!SBuf (string Str);
     begin "T!SBuf" |2|
       if ((length(Str) + T!Buf!Cnt) < TERMBUFFERSIZE) then
       begin |3|
         ! The string and the current contents of the buffer both fit in the
         ! buffer.
         ;
     
         while (length(Str)) do
         begin |4|
           integer
             Char;
     
           idpb(Char _ lop(Str), T!Buf!BP);
           incr(T!Buf!Cnt);
         end; |4|
       end |3|
       else 
       begin |3|
         ! String and buffer won't both fit in the buffer.
         ;
     
         define
           T1 = 1,
           T2 = 2,
           T3 = 3,
           Sp = '16;
     
           T!Flush;
     
             ! Output the buffer.
             ;
     
         ifcr TymcomX thenc
           begin |4|
             own integer array
               ArgBlk [0:1];                 ! Argument block we give to
                                             ! auxclr. 
                                             ;
             start!code |5|
               hrrz          T1, -1(Sp);
               movem         T1, ArgBlk[0];
               move          T1, (Sp);
               movem         T1, ArgBlk[1];
             end; |5|
     
             auxclr(-1, ArgBlk[0], '67);
     
               ! Output the string, regardless of length.
               ;
           end; |4|
         endc
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 15-2
     Prt: 06-Jun-84  13:55                                            Rtn T!SBuf

     
         ifcr Tops20 thenc
           start!code |4|
             hrrzi   T1, -1;                 ! Our console designator ;
             move    T2, (Sp);               ! Byte pointer ;
             hrrz    T3, -1(Sp);             ! -Byte Count ;
             movns   T3;
             sout;                           ! Output the string ;
           end; |4|
         endc
       end; |3|
     end "T!SBuf"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 16-1
     Prt: 06-Jun-84  13:55                                             Rtn T!Buf

     
     ! Routine to buffer a character for output ;
     
     internal simple procedure T!Buf(integer Char);
     begin "T!Buf" |2|
       if (T!Buf!Cnt = (TERMBUFFERSIZE - 1)) then
         T!Flush;
     
       idpb(Char, T!Buf!BP);
       incr(T!Buf!Cnt);
     end "T!Buf"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 17-1
     Prt: 06-Jun-84  13:55                                            Rtn T!NBuf

     
     ! Convert the supplied integer into ascii characters and insert them into
     ! the terminal buffer.
     ;
     
     simple procedure T!NBuf (integer N);
     begin "T!NBuf" |2|
       string
         Str;
     
       Str _ null;
     
       while (N) do
       begin |3|
         Str _ ((N mod 10) + "0") & Str;
         N   _ N div 10;
       end; |3|
     
       T!SBuf(Str);
     end "T!NBuf"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 18-1
     Prt: 06-Jun-84  13:55                                       Rtn Vt100Region

     
     ! Set the VT100's scrolling region.
     ;
     
     simple procedure Vt100Region (integer Top, Bottom);
     begin "Vt100Region" |2|
       T!SBuf(ESC & "[");
     
       if (Top > 1) then
         T!NBuf(Top);
     
       if (Bottom > 1) then
       begin |3|
         T!Buf(";");
         T!NBuf(Bottom);
       end; |3|
     
       T!Buf("r");
     end "Vt100Region"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 19-1
     Prt: 06-Jun-84  13:55                                            Rtn T!OutC

     
     ! Routine to output a 7 bit character to the terminal ;
     
     internal simple procedure T!OutC(integer Char);
     begin "T!OutC" |2|
       if (Char < " ") then
       begin |3|
         if (Char = CR) then
           T!Col _ 1
         else if (Char = LF) then
           incr(T!Row)
         else if (Char = BS) then
           decr(T!Col);
       end |3|
       else
       begin |3|
         incr(T!Col);
     
         if (T!Col > T!Width) then           ! we just got lost ;
           T!Col _ -999;
       end; |3|
     
       T!Buf(Char);
     end "T!OutC"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 20-1
     Prt: 06-Jun-84  13:55                                            Rtn T!Bell

     
     ! Routine to beep the bell
     ;
     
     internal simple procedure T!Bell;
     begin "T!Bell" |2|
     
       ifcr TymcomX thenc
         auxclv(-1, '7, '3);
       endc
     
       ifcr Tops20 thenc
         start!code |3|
           hrrzi 1, -1;              ! aim at our console ;
           hrrzi 2, '7;              ! with a bell ;
           bout;                     ! launch it ;
         end; |3|
       endc
     end "T!Bell"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 21-1
     Prt: 06-Jun-84  13:55                                              Rtn T!ES

     
     ! Routine to erase the screen for a T!Enum terminal.
     ;
     
     internal simple procedure T!ES;
     begin "T!ES" |2|
       integer
         pad;
     
       T!Row _ 1;            ! update state variables ;
       T!Col _ 1;
     
       case (T!Enum) of
       begin |3|
         [Term!Idx!H19]
         [Term!Idx!Scanset]
         [Term!Idx!VT52]
     
             T!SBuf(ESC & "H" & ESC & "J");
     
         [Term!Idx!TYM444]
     
             T!SBuf(ESC & "&a0r0C" & ESC & "J");
     
         [Term!Idx!Tym425]
         [Term!Idx!Tym420]
     
             T!SBuf(('36) & ESC & "Y" & ESC & ":");
     
         [Term!Idx!Adds]
     
             T!Buf(FF);
     
         [Term!Idx!VT100]
         [Term!Idx!VT102]
     
             T!SBuf(ESC & "[H" & ESC & "[2J" & DelStr(16));
     
         [Term!Idx!Tym430]
     
           T!Buf('32);
     
         [Term!Idx!Ti940]
     
           T!SBuf(ESC & "p")
       end; |3|
     end "T!ES"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 22-1
     Prt: 06-Jun-84  13:55                                              Rtn T!EL

     
     ! Routine to erase to end of line. ;
     
     internal simple procedure T!EL;
     begin "T!EL" |2|
       case (T!Enum) of
       begin |3|
         [Term!Idx!H19]
         [Term!Idx!Tym444]
         [Term!Idx!Adds]
     
             T!SBuf(ESC & "K");
     
         [Term!Idx!Tym425]
         [Term!Idx!Tym420]
     
             T!SBuf(ESC & "T");
     
         [Term!Idx!VT100]
         [Term!Idx!VT102]
     
             T!SBuf(ESC & "[K" & DEL);
     
         [Term!Idx!Scanset]
         [Term!Idx!VT52]
     
           T!SBuf(ESC & "K");
     
         [Term!Idx!Ti940]
     
             T!SBuf(ESC & "I")
       end; |3|
     end "T!EL"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 23-1
     Prt: 06-Jun-84  13:55                                            Rtn T!CPos

     
     ! Routine to position the cursor. ;
     
     internal simple procedure T!CPos(integer Row, Col);
     begin "T!CPos" |2|
       case (T!Enum) of
       begin |3|
         [Term!Idx!Adds]
         [Term!Idx!H19]
         [Term!Idx!Scanset]
         [Term!Idx!Ti940]
         [Term!Idx!VT52]
     
             T!SBuf(ESC & "Y" & (Row + '37) & (Col + '37));
     
         [Term!Idx!Tym444]
           begin |4|
             T!SBuf(ESC & "&a");
     
             T!NBuf(Row - 1);
             T!Buf("y");
     
             T!NBuf(Col - 1);
             T!Buf("C");
           end; |4|
     
         [Term!Idx!Tym425]
         [Term!Idx!Tym420]
         [Term!Idx!Tym430]
     
             T!SBuf(ESC & "=" & (Row + '37) & (Col + '37));
     
         [Term!Idx!VT100]            ! vt100 ;
         [Term!Idx!VT102]            ! vt102 - rainbow 100, pro 350 ;
           begin |4|
             T!SBuf(ESC & "[");
             T!NBuf(Row);
             T!Buf(";");
     
             T!NBuf(Col);
             T!Buf("H");
           end |4|
       end; |3|
     
       T!Row _ Row;
       T!Col _ Col;
     end "T!CPos"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 24-1
     Prt: 06-Jun-84  13:55                                              Rtn T!IC

     
     ! Insert N spaces at the cursor ;
     
     internal simple procedure T!IC(integer N);
     begin "T!IC" |2|
       case (T!Enum) of
       begin |3|
         [Term!Idx!H19]
           begin |4|
           end; |4|
     
         [Term!Idx!Tym444]
           begin |4|
             T!SBuf(ESC & "Q");
     
             while (N) do
             begin |5|
               T!Buf(SP);
               decr(N);
             end; |5|
     
             T!SBuf(ESC & "R");
           end; |4|
     
         [Term!Idx!Tym425]
         [Term!Idx!Tym420]
     
           while (N) do
           begin |4|
             T!SBuf(ESC & "Q");
             decr(N);
           end; |4|
     
         [Term!Idx!VT102]
           begin |4|
             T!SBuf(ESC & "[4h");
     
             while (N) do
             begin |5|
               T!Buf(SP);
               decr(N);
             end; |5|
     
             T!SBuf(ESC & "[4l");
           end |4|
       end; |3|
     end "T!IC"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 25-1
     Prt: 06-Jun-84  13:55                                              Rtn T!DC

     
     ! Delete N characters at the cursor ;
     
     internal simple procedure T!DC(integer N);
       begin "delete spaces" |2|
     
         case T!Enum of
           begin |3|
     
             [Term!Idx!H19]
               begin |4|
               end; |4|
     
             [Term!Idx!Tym444]
                 while (N) do
                   begin |4|
                     T!SBuf(ESC & "P");
                     decr(N);
                   end; |4|
     
             [Term!Idx!Tym425]
             [Term!Idx!Tym420]
                 while (N) do
                   begin |4|
                     T!SBuf(ESC & "W");
                     decr(N);
                   end; |4|
     
             [Term!Idx!VT102]
                 begin |4|
                   T!SBuf(ESC & "[");
     
                   T!NBuf(N);
                   T!Buf("P");
                 end |4|
           end; |3|
     
       end "delete spaces"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 26-1
     Prt: 06-Jun-84  13:55                                              Rtn T!IL

     
     ! Routine to insert a blank line at the cursor. ;
     
     internal simple procedure T!IL;
     begin "T!IL" |2|
       case (T!Enum) of
       begin |3|
         [Term!Idx!Tym444]
         [Term!Idx!H19]
     
             T!SBuf(ESC & "L");
     
         [Term!Idx!Tym425]
         [Term!Idx!Tym420]
     
             T!SBuf(ESC & "E");
     
         [Term!Idx!VT100]
     
           ! <<  This would benefit from a repeat count.
           ;
     
             begin |4|
               T!SBuf(ESC & "7");
               Vt100Region(T!Row, T!Lines);
               T!SBuf(ESC & "8");
     
               T!SBuf(ESC & "M" & DelStr(2));
     
               Vt100Region(1, T!Lines);
               T!SBuf(ESC & "8");
             end; |4|
     
         [Term!Idx!VT102]
     
             ! <<  This would benefit by a repeat count.
             ;
     
             T!SBuf(ESC & "[L" & DelStr(16)); 
     
         [Term!Idx!Ti940]
     
             T!SBuf(ESC & "N")
       end; |3|
     end "T!IL"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 27-1
     Prt: 06-Jun-84  13:55                                              Rtn T!DL

     
     ! Routine to delete the line at the cursor. ;
     
     internal simple procedure T!DL;
     begin "T!DL" |2|
       case (T!Enum) of
       begin |3|
         [Term!Idx!Tym444]
         [Term!Idx!H19]
     
             T!SBuf(ESC & "M");
     
         [Term!Idx!Tym425]
         [Term!Idx!Tym420]
     
             T!SBuf(ESC & "R");
     
         [Term!Idx!VT100]
     
             begin |4|
               T!SBuf(ESC & "7");
               Vt100Region(T!Row, T!Lines);
               T!SBuf(ESC & "8");
               T!SBuf(ESC & "[");
               T!NBuf(T!Lines);
               T!Buf("H");
     
               T!SBuf(LF & DelStr(2));
     
               Vt100Region(1, T!Lines);
               T!SBuf(ESC & "8");
             end; |4|
     
     
         [Term!Idx!VT102]
     
             T!SBuf(ESC & "[M" & DelStr(16));
     
         [Term!Idx!Ti940]
     
             T!SBuf(ESC & "O")
       end; |3|
     end "T!DL"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 28-1
     Prt: 06-Jun-84  13:55                                  The Redisplay Proper

     
     ! ************************  R E D I S P L A Y  *************************
     ! *                                                                    *
     ! *  Herein is an implementation of the D.W.S. Redisplay algorithm,    *
     ! *  which incorporates some of the ideas from the FINE redisplay,     *
     ! *  the UNIX EMACS redisplay, and from James Gosling's talk on re-    *
     ! *  displays at the 1981 ACM SIGPLAN conference on Text Manipulation, *
     ! *  but tries to be less CPU intensive, as people here in the "real   *
     ! *  world" get charged for the cycles they use.  So it goes.          *
     ! *                                                                    *
     ! *  Dave W. Smith,  September '81                                     *
     ! *                                                                    *
     ! **********************************************************************
     !
     ! The Redisplay works roughly as follows:
     !
     ! 1.  Slide the old hash vector along the new hash vector to find an
     !     adjustment where the number of matches is a maximum.  (This will
     !     be 0 is nothing has scrolled, -n if text is to be scrolled down,
     !     +n if text is to be scrolled up).
     !
     ! 2.  Adjust the physical screen vertically, using insert/delete line
     !     operations if available.
     !
     ! 3.  For each line do:
     !
     !     A.  Scan new and old lines to find the character position, if any,
     !         where the lines begin to differ.  If the lines don't differ,
     !         then proceed to the next line.
     !
     !     B.  Slide the remaining section of the old line along the remaining
     !         section of the new line, looking an for an adjustment which
     !         maximizes character matches.
     !
     !     C.  Adjust the line horizontally, using insert/delete character if
     !         available.
     !
     !     D.  Proceeding from the point of initial difference, fix characters
     !         as needed.
     !
     !     Various heuristics are applyed here and there to minimize the number
     !     of characters which must be sent to fix the screen.
     ! ;
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 29-1
     Prt: 06-Jun-84  13:55                              Internal Data Structures

     
     ! *********************  Internal data structures *********************** ;
     
     ! The Redisplay's image of the screen is kept as a packed array of
     ! integers (with 5 characters packed into a word), which is accessed by
     ! pointing a byte pointer into it. ;
     
       safe integer array R!Buf[1 : 25, 1 : 27];
     
     ! Each line of text on the screen has an associated hash value which is
     ! used as an efficient way of telling when lines should be moved up or
     ! down on the screen by comparing it against the hash vector for the
     ! desired screen image. ;
     
       safe integer array R!Hash[1 : 25];
       safe integer array W!Hash[1 : 25];
     
     ! We want to keep the hash for a blank line around. ;
     
       integer BlankHash;
     
     ! Weights for hashes ;
     
       internal integer R!WB, R!WNB,         ! weights for blank, non-blank ;
                        R!WX;                ! threshold for scrolling ;
     
     ! we also want to keep track of the cursor ;
     
       internal integer R!Row, R!Col;
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 30-1
     Prt: 06-Jun-84  13:55                                            Rtn R!Init

     
     ! (Re)Initialize the Redisplay by clearing the physical screen, setting
     ! the cursor pointers to home, filling the internal screen with <CR>s,
     ! and reinitializing the hash vector. ;
     
     internal procedure R!Init;
       begin "init" |2|
         integer I;
     
         R!WB _ 0;
         R!WNB _ 1;
         R!WX _ 1;
     
         T!ES;                               ! clear the screen ;
     
         for R!Row _ 1 upto 25 do
           for R!Col _ 1 upto 27 do
             R!Buf[R!Row, R!Col] _ cvasc("     ");
     
         for R!Row _ 1 upto 25 do R!Hash[R!Row] _ BlankHash;
     
       end "init"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 31-1
     Prt: 06-Jun-84  13:55                                       Rtn R!SetCursor

     
     ! routine to get the cursor to (R!Row, R!Col) by whatever devious and
     !  nefarious means we see fit. ;
     
     simple procedure R!SetCursor(integer array Buffer);
       begin "move cursor" |2|
         own integer Dist, BP;
     
         ! If we're moving up, punt.  Few terminals can handle this. ;
         ! Also, if we're lost, punt. ;
     
         if ((R!Row < T!Row) or (T!Col < 0)) then
           begin |3|
             T!CPos(R!Row, R!Col);
             return;
           end; |3|
     
         ! if we want the cursor to move down, see if we can't get there
         ! using line feeds, then let the 'same row' code do the rest ;
     
         if (R!Row > T!Row) then
           begin |3|
             Dist _ (R!Row - T!Row) + abs(R!Col - T!Col);
             if (Dist > T!CPC) then
               begin |4|
                 T!CPos(R!Row, R!Col);
                 return;
               end; |4|
             Dist _ R!Row - T!Row;           ! get us to the correct row ;
             while (Dist) do
               begin |4|
                 T!OutC(LF);
                 Dist _ Dist - 1;
               end; |4|
           end; |3|
     
         ! Here we handle cursor movement within a row.  Checks are made to
         ! see if it may be cheaper to use backspaces or character rewrites
         ! to get us where we want to go. ;
     
         if (T!Col = R!Col) then             ! the trivial case ;
           return
         else if (R!Col < T!Col) then        ! do the backspace check ;
           begin |3|
             Dist _ T!Col - R!Col;
             if (Dist < T!CPC) then  ! cheaper to backspace? ;
               while (Dist) do                ! yes - use backspaces ;
                 begin |4|
                   T!OutC(BS);
                   Dist _ Dist - 1;
                 end |4|
             else
               T!CPos(R!Row, R!Col);  ! no - punt ;
           end |3|
         else  ! R!Col > T!Col ;
           begin |3|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 31-2
     Prt: 06-Jun-84  13:55                                       Rtn R!SetCursor

             Dist _ R!Col - T!Col;
             if (Dist < T!CPC) then  ! cheaper to rewrite characters? ;
               begin |4|
                 BP _ point(7, Buffer[R!Row, 1], -1);         ! yes, do it ;
                 Dist _ T!Col;
                 while (Dist) do
                   begin |5|
                     ibp(BP);
                     Dist _ Dist - 1;
                   end; |5|
                 Dist _ R!Col - T!Col;
                 while (Dist) do
                   begin |5|
                     T!OutC(ldb(BP));
                     ibp(BP);
                     Dist _ Dist - 1;
                   end; |5|
               end |4|
             else
               T!CPos(R!Row, R!Col);  ! no - punt ;
           end; |3|
     
       end "move cursor"; |2|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 32-1
     Prt: 06-Jun-84  13:55                                            Rtn R!Disp

     
     ! **********************  The ReDisplay proper  ********************** ;
     
     ! It is extremely dangerous to even consider touching this.  Think twice,
     ! then decide not to.  If a particular type of terminal is having problems,
     ! you are better off looking in the terminal abstraction.
     ;
     
     internal simple procedure R!Disp (integer array Buffer; boolean PuntIfKeyH|
                                         ->|it; integer FinalRow, FinalColumn);|
     begin "redisplay" |2|
       own integer
         Old!BP,
         Old!C,
         New!BP,
         New!C,
         Cursor!BP,
         Line,
         FirstLineChanged,
         LineAdjustment,
         LinesChanged,
         Sweep,
         SweepSize,
         SweepCnt,
         ScanHi,
         ScanLow,
         ThisAdj,
         ThisAdjCnt,
         BestAdj,
         ThisWeight,
         BestWeight,
         NewIdx,
         OldIdx,
         ChangeP,
         BufferLength,
         BufferWidth;
     
       if (PuntIfKeyHit and T!ChrP) then
         return;
     
       BufferLength _ arrinfo(Buffer, 2);
       BufferWidth  _ arrinfo(Buffer, 4);
     
       BlankHash _ 0;
     
       for Line _ 1 upto BufferWidth do
         BlankHash _ (BlankHash rot 3) xor cvasc("     ");
     
       for Line _ 1 upto BufferLength do
       begin "hash" |3|
         own integer
           Hash,
           Chunk;
     
         Hash _ 0;
     
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 32-2
     Prt: 06-Jun-84  13:55                                            Rtn R!Disp

         for Chunk _ 1 upto BufferWidth do
           Hash _ (Hash rot 3) xor Buffer[Line, Chunk];
     
         W!Hash[Line] _ Hash;
       end "hash"; |3|
     
       if (T!ILP) then
       begin "vertical adjustment" |3|
         label
           EndOfVerticalAdjustment;
     
         ! Find first, and number of, lines changed. ;
     
         FirstLineChanged _ 0;
         LinesChanged     _ 0;
     
         for Line _ (T!Lines - 2) downto 1 do
           if (R!Hash[Line] neq W!Hash[Line]) then
           begin |4|
             FirstLineChanged _ Line;
             incr(LinesChanged);
           end; |4|
     
         if (LinesChanged and
             (Buffer[FirstLineChanged,1] = R!Buf[FirstLineChanged,1])) then
         begin |4|
           incr(FirstLineChanged);
           decr(LinesChanged);
         end; |4|
     
         if (LinesChanged <= 2) then
           goto EndOfVerticalAdjustment;
     
         ! Find the best adjustment factor by comparing the hash vectors ;
     
         SweepSize  _ (T!Lines - 1) - FirstLineChanged;
         BestAdj    _ 0;
         BestWeight _ 0;
         ScanHi     _ (SweepSize - 1);
         ScanLow    _ - ScanHi;
     
         for ThisAdj _ ScanHi downto ScanLow do
         begin "comb" |4|
           NewIdx _ FirstLineChanged;
     
           if (ThisAdj > 0) then
             incr(NewIdx, ThisAdj);
     
           OldIdx _ FirstLineChanged;
     
           if (ThisAdj < 0) then
             decr(OldIdx, ThisAdj);
     
           SweepCnt   _ SweepSize - abs(ThisAdj);
           ThisWeight _ 0;
     
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 32-3
     Prt: 06-Jun-84  13:55                                            Rtn R!Disp

           for Sweep _ 1 upto SweepCnt do
           begin "sweep" |5|
             if (R!Hash[OldIdx] = W!Hash[NewIdx]) then
               if (R!Hash[OldIdx] = BlankHash) then
                 incr(ThisWeight, R!WB)
               else
                 incr(ThisWeight, R!WNB);
     
             incr(OldIdx);
             incr(NewIdx);
           end "sweep"; |5|
     
           if (ThisWeight > BestWeight) then
           begin |5|
             BestWeight _ ThisWeight;
             BestAdj    _ ThisAdj;
           end; |5|
         end "comb"; |4|
     
         ! Is the best weight good enough? ;
     
         if (BestWeight < R!WX) then
           goto EndOfVerticalAdjustment;
     
         ! Don't exceed T!MaxS ;
     
         if (abs(BestAdj) > T!MaxS) then
           goto EndOfVerticalAdjustment;
     
         ! Adjust the screen with insert/delete line ops ;
     
         if (BestAdj < 0) then
         begin |4|
           T!CPos(FirstLineChanged, 1);
     
           for Line _ -1 downto BestAdj do
             T!DL;
     
           T!CPos(T!Lines - 1 + BestAdj, 1);
     
           for Line _ -1 downto BestAdj do
             T!IL;
     
           for R!Row _ FirstLineChanged upto (T!Lines - 2) do
           begin |5|
             Line _ R!Row - BestAdj;
     
             if (Line < (T!Lines - 1)) then
             begin |6|
               for R!Col _ 1 upto BufferWidth do
                 R!Buf[R!Row, R!Col] _ R!Buf[Line, R!Col];
     
               R!Hash[R!Row] _ R!Hash[Line];
             end |6|
             else
             begin |6|
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 32-4
     Prt: 06-Jun-84  13:55                                            Rtn R!Disp

               for R!Col _ 1 upto BufferWidth do
                 R!Buf[R!Row, R!Col] _ cvasc("     ");
     
               R!Hash[R!Row] _ BlankHash;
             end; |6|
           end; |5|
         end |4|
         else if (BestAdj > 0) then
         begin |4|
           T!CPos(T!Lines - 1 - BestAdj , 1);
     
           for Line _ 1 upto BestAdj do
             T!DL;
     
           T!CPos(FirstLineChanged, 1);
     
           for Line _ 1 upto BestAdj do
             T!IL;
     
           for R!Row _ (T!Lines - 2) downto FirstLineChanged do
           begin |5|
             Line _ R!Row - BestAdj;
     
             if (Line < FirstLineChanged) then
             begin |6|
               for R!Col _ 1 upto BufferWidth do
                 R!Buf[R!Row, R!Col] _ cvasc("     ");
     
               R!Hash[R!Row] _ BlankHash;
             end |6|
             else
             begin |6|
               for R!Col _ 1 upto BufferWidth do
                 R!Buf[R!Row, R!Col] _ R!Buf[Line, R!Col];
     
               R!Hash[R!Row] _ R!Hash[Line];
             end; |6|
           end; |5|
         end; |4|
     
         T!Flush;
     
         EndOfVerticalAdjustment:
       end "vertical adjustment"; |3|
     
     
       ! Now do fixups on a line by line basis ;
     
       for R!Row _ 1 upto (T!Lines min (BufferLength * 5)) do
       begin "each row" |3|
         own integer
           NewLength,
           OldLength,
           I,
           Temp!New!BP,
           Temp!Old!BP;
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 32-5
     Prt: 06-Jun-84  13:55                                            Rtn R!Disp

         label
           EndOfLine;
     
         if (PuntIfKeyHit and T!ChrP) then
         begin |4|
           T!Flush;
           return;
         end; |4|
     
         OldIDX _ location(R!Buf[R!Row, 1]);
         NewIDX _ location(Buffer[R!Row, 1]);
     
         start!code |4|
           label
             loop;
     
           setzm     ChangeP;        ! no changes seen yet ;
           move      1, BufferWidth;
           move      2, OldIDX;      ! point to old words ;
           move      3, NewIDX;      ! point to new words ;
     
           loop:
           move      4, (2);         ! pick up old value ;
           came      4, (3);         ! compare with new value ;
            setom    ChangeP;        ! a change! ;
           addi      2, 1;
           addi      3, 1;
           sojg      1, loop;
         end; |4|
     
         if (not ChangeP) then
           goto EndOfLine;
     
         New!BP _ point(7, Buffer[R!Row, 1], 6);
         Old!BP _ point(7, R!Buf[R!Row, 1], 6);
     
         Temp!New!BP _ New!BP;
         Temp!Old!BP _ Old!BP;
         NewLength   _ OldLength _ 0;
     
         for I _ 1 upto (T!Width min (BufferWidth * 5)) do
         begin |4|
           if (ldb(Temp!New!BP) neq " ") then NewLength _ I;
           if (ldb(Temp!Old!BP) neq " ") then OldLength _ I;
           ibp(Temp!New!BP);
           ibp(Temp!Old!BP);
         end; |4|
     
     
         ! look for the first difference between the two lines ;
         ! compute the adjustment factor ;
         ! adjust the line with insert/delete character ;
     
         ! now fix the rest of the line ;
     
         Cursor!BP _ 0;
     Cre: 06-Apr-84  11:59  (PEAKX)REDISP.SAI                          Page 32-6
     Prt: 06-Jun-84  13:55                                            Rtn R!Disp

         R!Col     _ 1;
     
         while (R!Col <= (T!Width min (BufferWidth * 5))) do
         begin "fix a line" |4|
           Old!C _ ldb(Old!BP);
           New!C _ ldb(New!BP);
     
           if ((R!Col > NewLength) and (Old!C neq " " ) and T!ELP) then
           begin |5|
             if (R!Col <= OldLength) then
             begin |6|
               R!SetCursor(Buffer);
               T!El;
             end; |6|
     
             done "fix a line";
           end |5|
           else if (New!C neq Old!C) then
           begin |5|
             R!SetCursor(Buffer);
             T!OutC(New!C);
             Cursor!BP _ New!BP;
             ibp(Cursor!BP);
           end; |5|
     
           ibp(Old!BP);
           ibp(New!BP);
           incr(R!Col);
         end "fix a line" ; |4|
     
         ! here do do end of line bookkeeping ;
     
         EndOfLine:
     
         for R!Col _ 1 upto BufferWidth do
           R!Buf[R!Row, R!Col] _ Buffer[R!Row, R!Col];
     
         R!Hash[R!Row] _ W!Hash[R!Row];
       end "each row" ; |3|
     
     
       ! Now put the cursor to rest ;
     
       if (FinalRow and FinalColumn) then
       begin |3|
         R!Row _ FinalRow;
         R!Col _ FinalColumn;
         R!SetCursor(Buffer);
       end; |3|
     
       T!Flush;
     end "redisplay"; |2|
     end "Redisplay for a Canonical CRT"; |1|
     
     
     ! **************************  End Redisp.Sai  ****************************;





                                                            
                                                            
                                                            
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                                                      
                                                      
                                                      



      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
                              
                              
                              




                     
         
         
           
            
           
                         

     Cre: 16-Feb-84  14:05  (PEAKX)UTIL.SAI                             Page 1-1
     Prt: 06-Jun-84  13:55                                   Peak Utility Module

     Entry;
     begin "Peak Utility Module" |1|
       require "Ded.Def" source!file;
     
     
     ! *************************************************************************
     *                                                                         *
     *                         Utilities used commonly                         *
     *                     throughout the Corpus Collosum                      *
     *                                 of Peak                                 *
     *                                                                         *
     **************************************************************************;
     
       external simple procedure
         W!Msg (string S);                   ! Put a message in the message
                                             ! line.
                                             ;
     Cre: 16-Feb-84  14:05  (PEAKX)UTIL.SAI                             Page 2-1
     Prt: 06-Jun-84  13:55                                             Rtn ffffp

     
     ! Find the first free file page in the specified file starting with the
     ! specified page number, and return its index.
     ;
     
     ifcr Tops20 thenc
       internal simple integer procedure ffffp (integer Jfn, StartPage(0));
       begin "ffffp" |2|
         integer
           Result;
     
         start!code |3|
           hrl         1, StartPage;
           hrr         1, Jfn;
           ffffp;
           movem       1, Result;
         end; |3|
     
         if (Result = -1) then
           return(-1)
         else
           return(rh(Result));
       end "ffffp"; |2|
     endc
     Cre: 16-Feb-84  14:05  (PEAKX)UTIL.SAI                             Page 3-1
     Prt: 06-Jun-84  13:55                                             Rtn ufpgs

     
     ! Update File Page(s), forcing them to disk right now.
     ;
     
     ifcr Tops20 thenc
       internal simple procedure ufpgs (integer AC1, AC2);
       begin "ufpgs" |2|
         start!code |3|
           move      1, AC1;
           move      2, AC2;
           ufpgs;
             jfcl;
         end; |3|
       end "ufpgs"; |2|
     endc
     Cre: 16-Feb-84  14:05  (PEAKX)UTIL.SAI                             Page 4-1
     Prt: 06-Jun-84  13:55                                         Rtn MoveBytes

     
     ! Move the specified number of bytes from the source to the target.
     ;
     ! <<  Who uses this?
     ;
     
     internal simple procedure MoveBytes (integer SrcPtr, TgtPtr, BytCnt);
     begin "MoveBytes" |2|
       start!code |3|
         protect!acs
           1, 2, 3;
         label
           NoWork,
           Loop;
     
           skipg       3, BytCnt;
           jrst        NoWork;
     
           move        2, SrcPtr;
           move        4, TgtPtr;
           ldb         1, 2;
           dpb         1, 4;
           sosg        3, BytCnt;
           jrst        NoWork;
     
         Loop:
           ildb        1, 2;
           idpb        1, 4;
           sojg        3, Loop;
     
         NoWork:
       end; |3|
     end "MoveBytes"; |2|
     Cre: 16-Feb-84  14:05  (PEAKX)UTIL.SAI                             Page 5-1
     Prt: 06-Jun-84  13:55                                             Rtn DoBlt

     
     ! Perfrom a BLT for the folks.
     ;
     
     simple procedure DoBlt (integer Src, Dst, DstEnd);
     begin "DoBlt" |2|
       start!code |3|
         hrl     1, Src;
         hrr     1, Dst;
         blt     1, DstEnd;
       end; |3|
     end "DoBlt"; |2|
     Cre: 16-Feb-84  14:05  (PEAKX)UTIL.SAI                             Page 6-1
     Prt: 06-Jun-84  13:55                                               Rtn Blt

     
     ! Move words of stuff from one place to the other in the most efficient
     ! manner possible.
     !
     !   SrcStart    - Starting address in memory of the source region.
     !   DstStart    - Starting address in memory of the destination region.
     !   SrcLen      - Length in words of the source region.
     ;
     
     ! <<  This routine is open to severe and subtle optimization.
     ;
     
     internal simple procedure Blt (integer SrcStart, DstStart, SrcLen);
     begin "Blt" |2|
       integer
         I,
         J;
     
       if (SrcStart = DstStart) then
         return
       else if ((SrcStart > DstStart) or ((SrcStart + SrcLen) < DstStart)) then
       begin |3|
         ! Source does not overlap the destination.
         ;
     
         arrblt(memory[DstStart], memory[SrcStart], SrcLen);
       end |3|
       else
       begin |3|
         ! Source overlaps destination. Work from the back forwards.
         ;
     
         J _ DstStart + SrcLen - 1;
     
         for I _ SrcStart + SrcLen - 1 step -1 until SrcStart do
         begin |4|
           memory[J] _ memory[I];
           decr(J);
         end; |4|
       end; |3|
     end "Blt"; |2|
     Cre: 16-Feb-84  14:05  (PEAKX)UTIL.SAI                             Page 7-1
     Prt: 06-Jun-84  13:55                                            Rtn DecrBP

     
     ! Semi-magic routine to decrement a byte pointer.  Don't worry about it.
     ;
     
     internal simple integer procedure DecrBP (integer BP);
     begin "DecrBP" |2|
       begin!code |3|
         move        T1, BP;                 ! Get the pointer ;
         add         T1, [bit(7,5)];         ! Decrement the pointer ;
         skipge      T1;                     ! If the pointer went negative ;
           sub       T1, [xwd('430000,1)];   !  subtract the backup offset ;
         movem       T1, BP;                 ! Store the result ;
       end; |3|
     
       return(BP);
     end "DecrBP"; |2|
     Cre: 16-Feb-84  14:05  (PEAKX)UTIL.SAI                             Page 8-1
     Prt: 06-Jun-84  13:55                                           Rtn DoErstr

     
     ! Get error info from Tops-20, and print it out.
     ;
     
     ifcr Tops20 thenc
       internal simple procedure DoErstr;
       begin "DoErstr" |2|
         integer
           C,
           BP;
         own integer array
           Buf[0:29];
         string
           S;
     
         arrclr(Buf);
         S _ null;
     
         start!code |3|
           hrroi       1, access(Buf[0]);
           hrloi       2, '400000;           ! last error in current process ;
           setz 3,;
           erstr;
           jfcl;
           jfcl;
         end; |3|
     
         BP _ point(7, Buf[0], -1);
     
         while (C _ ildb(BP)) do
           appnd(S, C);
     
         W!Msg(S);
       end "DoErstr"; |2|
     endc
     Cre: 16-Feb-84  14:05  (PEAKX)UTIL.SAI                             Page 9-1
     Prt: 06-Jun-84  13:55                                              Rtn kequ

     
     ! Perform a case-independent string comparison and return the results.
     ! (This heavy-handedness is only necessary on Tops-20 since the SAIL
     ! compiler there is of more questionable pedigree than that of its
     ! Tymcom-X counterpart).
     ! (This code was ripped off from the Tymcom-X FAIL sources for SAIL.)
     ;
     
     ifcr Tops20 thenc
       internal simple boolean procedure kequ (string Str1, Str2);
       begin "kequ" |2|
         start!code |3|
           define
             A    = 1,
             B    = 2,
             Lpsa = '13,
             Temp = '14,
             User = '15,
             Sp   = '16,
             P    = '17;
           label
             Kaschk,
             Klup,
             Notkeq,
             Keqret;
     
     
             hrrz    A, -3(Sp);      ! Length of one string;
             exch    B, -1(Sp);      ! Length of the other, save extra AC;
             caie    A, (B);         ! Same length? (ignore lh of B);
              jrst   Notkeq;         ! No, not equal strings;
             move    Lpsa, (Sp);     ! One byte pointer;
             move    User, -2(Sp);   ! The other byte pointer;
             jrst    klup;           ! Go start the loop;
     
           Kaschk:
             trz     B, '40;         ! Clear case bit and check for alphabetic;
             cail    B, "A";         ! This makes it upper case when it was;
             caile   B, "Z";         !  either upper case or lower case;
             jrst    Notkeq;         ! Not alphabetic - must be mismatch;
     
           Klup:
             sojl    A, Keqret;      ! A will be -1 (=true) on loop termination;
             ildb    Temp, User;     ! One character;
             ildb    B, Lpsa;        ! Another;
             xor     Temp, B;        ! Compare values;
             jumpe   Temp, Klup;     ! Exactly equal;
             cain    Temp, '40;      ! Differ only by case bit?;
             jrst    Kaschk;         ! Yes - Go check more carefully;
     
           Notkeq:
             movei   A, 0;           ! Character mismatch - Return false;
     
           Keqret:
             move    B, -1(Sp);      ! Restore AC;
         end; |3|
     Cre: 16-Feb-84  14:05  (PEAKX)UTIL.SAI                             Page 9-2
     Prt: 06-Jun-84  13:55                                              Rtn kequ

       end "kequ"; |2|
     endc
     Cre: 16-Feb-84  14:05  (PEAKX)UTIL.SAI                            Page 10-1
     Prt: 06-Jun-84  13:55                                           Rtn chsizef

     
     ! Return the size in characters of the file open on the specified
     ! channel.
     ;
     
     ifcr Tops20 thenc
       internal simple integer procedure chsizef (integer Chan);
       begin "chsizef" |2|
         integer
           OldPos,
           Siz;
     
         OldPos _ rchptr(Chan);
         schptr(Chan, -1);
         Siz    _ rchptr(Chan);
         schptr(Chan, OldPos);
         return(Siz);
       end "chsizef"; |2|
     endc
     end "Peak Utility Module"; |1|
     
     
     ! **************************  End of Util.Sai  ************************** ;





                                          
                                          
                                          
                              
                              
                              
                                    
                                    
                                    
                                    
                                    
                                    
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          



                                                      
                                                      
                                                      
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                          
                                          
                                          
                                                
                                                
                                                
                                                      
                                                      
                                                      




                          
               
                
                  
                     
                     
                           

     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                           Page 1-1
     Prt: 06-Jun-84  13:56                                   Peak Window Manager

     Entry;
     begin "DED - window manager" |1|
       require "DED.DEF" source!file;
     
     ! *************************************************************************
     *                                                                         *
     *                               Window.Sai                                *
     *                                                                         *
     ***************************************************************************
     
             The Peak Window Manager.
     
     **************************************************************************;
     
     
     !                         From the Command Module
     ;
     
       external boolean procedure
         C!ChrP;                             ! Is there a character ready
                                             ! anywhere?
                                             ;
       external integer
         C!Debug;                            ! True if we are debugging.
                                             ;
       external boolean
         G!CRCtl;                            ! true if lonely CRs appear as
                                             ! "^m"
                                             ;
     
     !                         From the Buffer Module
     ;
     
       external boolean
         B!BegP,                             ! True if point is at the
                                             ! beginning of the buffer.
                                             ;
         B!EndP,                             ! True if point is at the end of
                                             ! the buffer.
                                             ;
         B!ModP;                             ! True if the buffer has been
                                             ! modified. 
                                             ;
       external integer
         B!Lock;                             ! State of the Buffer Lock.
                                             ;
       external string
         B!Mode,                             ! Current editing mode.
                                             ;
         B!File,                             ! The name of the file we are
                                             ! editing. 
                                             ;
         B!Alias;                            ! An alternate display name for
                                             ! the current buffer.
                                             ;
       external integer
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                           Page 1-2
     Prt: 06-Jun-84  13:56                                   Peak Window Manager

         B!WS0,                              ! Index of the Mark indicating
                                             ! the start of Window 0.
                                             ;
         B!WS1;                              ! Index of the Mark indicating
                                             ! the start of Window 1.
                                             ;
     
       external simple integer procedure
         B!GetM (integer M);                 !  Return the location of a
                                             !  certain Mark. 
                                             ;
       external simple procedure
         B!SetM (integer M, P);              ! Set the location associated
                                             ! with a certain Mark.
                                             ;
       external simple procedure
         B!SetB (integer BufNum);            ! Go to a particular buffer.
                                             ;
       external simple integer procedure
         B!Cnt;                              ! Return the number of buffers in
                                             ! the chain.
                                             ;
       external simple procedure
         B!Move (integer Direction);         ! Move one buffer in some
                                             ! direction. 
                                             ;
       external simple integer procedure
         B!GetP;                             ! Get the location of the point.  
                                             ;
       external simple integer procedure
         B!GetC;                             ! Get the character after the
                                             ! point. 
                                             ;
       external simple procedure
         B!SetP (integer Position);          ! Move the point to a particular
                                             ! location. 
                                             ;
       external simple integer procedure
         B!GetL;                             ! Get the location of the "last"
                                             ! point. 
                                             ;
       external simple procedure
         B!SetL (integer Position);          ! Set the location of the "last"
                                             ! point. 
                                             ;
       external simple integer procedure
         B!Pcnt;                             ! Return the distance in percent
                                             ! of the point into the buffer.
                                             ;
     
     !                        From the Redisplay Module
     ;
     
       external integer
         T!Lines,
         T!Width;
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                           Page 1-3
     Prt: 06-Jun-84  13:56                                   Peak Window Manager

       external string
         T!Name;
     
       external procedure
         T!Bell;
     
       external procedure
         R!Disp (integer array Buffer;
             boolean PuntIfKeyHit;
             integer CursorRow, CursorCol);
     
       ! global state stuff ;
     
       external integer
         G!ESCF,
         G!OverStrikeP,
         G!WrapP,
         C!TABWidth,
         G!FFBreak;
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                           Page 2-1
     Prt: 06-Jun-84  13:56                              Internal Data Structures

     
     ! Internal data and structures ;
     
       ! The screen buffer is available to the redisplay, and *must* be declared
       !  the same size and shape.  ;
     
       own trusted integer array W!Buf[ 1 : 25, 1 : 27 ];
     
       ! the help "box" is overlaid on W!Buf iff W!BoxP is true ;
     
       own internal boolean W!BoxP;
       own trusted integer array W!Box[ 1 : 20, 1 : 12 ];
       own integer W!BoxPnt;
     
       ! information about the window(s) ;
     
       internal boolean
         W!IntP;                             ! True iff the window module has
                                             ! been initialized.
                                             ;
       own boolean W!SplitP;                 ! true iff split window ;
       own integer W!Num;                    ! window we're in [ 0..1 ] ;
       own internal integer W!Buf0, W!Buf1;  ! corresponding buffer # ;
       own integer W!BufNum;                 ! current buffer # ;
       own integer W!Size0, W!Size1;         ! size of the windows ;
       own internal string W!Bar;            ! bar to use when split ;
     
       ! some handy byte pointers and lengths that we want to keep around ;
     
       own integer W!WindowBP;
       own integer W!StatusLine, W!MsgLine;
       own integer W!StatusBP, W!FixStatusBP, W!FixStatusLen;
       own integer W!MsgBP, W!MsgLen;
     
       ! for remembering where to put the cursor ;
     
       own integer SavedCursorRow, SavedCursorColumn;
     
       ! for forcing the cursor to the end of the message line ;
     
       internal own boolean W!MsgF;
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                           Page 3-1
     Prt: 06-Jun-84  13:56                                            Rtn W!Init

     
     ! Initialize the Window module by doing whatever. ;
     
       forward simple internal procedure W!Badd( string Text );
       forward simple internal procedure W!BClr;
     
     internal simple procedure W!Init;
       begin "init" |2|
     
         T!Lines := 24;      ! ** kludge ** ;
     
         ! start out with one clean window and one clean box ;
     
         arrclr( W!Buf, cvasc( "     " ));
         W!BClr;
     
         ! set up some fresh byte pointers ;
     
         W!WindowBP := point( 7, W!Buf[ 1, 1 ], -1 );
         W!StatusLine := T!Lines - 1;
         W!StatusBP := point( 7, W!Buf[ W!StatusLine, 1 ], -1 );
         W!MsgLine := T!Lines;
         W!MsgBP := point( 7, W!Buf[ W!MsgLine, 1 ], -1 );
     
         W!BoxP := false;
         W!SplitP := false;
         W!Num := 0;
         W!Size0 := T!Lines - 2;
         W!Size1 := 0;
         W!Bar := "+-------";
     
         set(W!IntP);
     
           ! Indicate to the world that the window has been initialized.
           ;
       end "init"; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                           Page 4-1
     Prt: 06-Jun-84  13:56                                            Rtn W!SetB

     
     ! Routine used by the buffer module to tell us what buffer #
     ! corresponds to the current window. ;
     
     internal simple procedure W!SetB( integer BufNum );
       begin |2|
     
         if ( C!Debug ) then
           W!BAdd( "W!SetB(" & cvs(BufNum) & "), W!Num=" & cvs(W!Num) );
     
         if ( W!Num ) then
           W!Buf1 := BufNum
         else
           W!Buf0 := BufNum;
     
         W!BufNum := BufNum;
     
       end; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                           Page 5-1
     Prt: 06-Jun-84  13:56                                         Rtn AppendStr

     
     ! Routines to build and update the status line ;
     
     simple procedure AppendStr( string S; reference integer BP, Len );
       while ( length( S )) do
         begin |2|
           idpb( lop( S ), BP );
           Len := Len + 1;
         end; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                           Page 6-1
     Prt: 06-Jun-84  13:56                                            Rtn W!FixS

     
     ! This routine fixes the fixable part of a status line.  (Where we are,
     !  if the buffer has been modified, if we have mail). ;
     
     internal simple procedure W!FixS;
     begin |2|
       own boolean
         NewMailBit,
         OldMailBit;
       own integer
         Bp,
         Len;
     
       Bp  _ W!FixStatusBP;
       Len _ W!FixStatusLen;
     
       if (B!BegP and B!EndP) then
         AppendStr("Empty", Bp, Len)
       else if (B!BegP) then
         AppendStr("Top", Bp, Len)
       else if (B!EndP) then
         AppendStr("Bottom", Bp, Len)
       else
       begin |3|
         AppendStr(cvs(B!Pcnt), Bp, Len);
         AppendStr("%", Bp, Len);
       end; |3|
     
       AppendStr("-", Bp, Len);
     
       if (B!ModP) then
         AppendStr(" *", Bp, Len);
     
       ifcr TymcomX thenc
         begin!code |3|
           setzm     NewMailBit;
           setzm     OldMailBit;
     
           hrroi     t1, '6;
           calli     t1, '41;
            setz     t1, ;
     
           trne      t1, '10000;             ! jp.mal (old mail) ;
             setom   OldMailBit;
           tlne      t1, '001000;            ! jp.mai (new mail) ;
             setom   NewMailBit;
         end; |3|
     
         if (OldMailBit or NewMailBit) then
           AppendStr(" Mail", Bp, Len);
     
         if (NewMailBit) then
           AppendStr("!", Bp, Len);
     
         if (OldMailBit) then
           AppendStr(".", Bp, Len);
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                           Page 6-2
     Prt: 06-Jun-84  13:56                                            Rtn W!FixS

       endc
     
       while (Len <= T!Width) do
         AppendStr(" ", Bp, Len);
     end; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                           Page 7-1
     Prt: 06-Jun-84  13:56                                            Rtn W!NewS

     
     ! Routine to build the more permanent part of the status line.
     ;
     
     internal simple procedure W!NewS;
     begin |2|
       own integer
         Bp,
         Len,
         L,
         R;
     
       Bp  _ W!StatusBP;
       Len _ 0;
     
       AppendStr(DED!Alias, Bp, Len);
       AppendStr(" " & DED!Major!Version, Bp, Len);
       AppendStr("." & DED!Minor!Version, Bp, Len);
       AppendStr(" (" & DED!Edit!Version & ")", Bp, Len);
     
       AppendStr(" (", Bp, Len);
       AppendStr(T!Name, Bp, Len);
       AppendStr(" ", Bp, Len);
       AppendStr(B!Mode, Bp, Len);
     
       if (G!WrapP) then
         AppendStr(",Wrap", Bp, Len);
     
       if (G!OverStrikeP) then
         AppendStr(",Over", Bp, Len);
     
       AppendStr(") ", Bp, Len);
     
       L _ B!Cnt;
       R _ rh(L);
       L _ lh(L);
     
       if (L) then
       begin |3|
         integer
           I;
     
         for I _ 1 step 1 until L do
           AppendStr("<", Bp, Len);
     
         AppendStr(" ", Bp, Len);
       end; |3|
     
       if (B!Alias) then
         AppendStr(B!Alias, Bp, Len)
       else
         AppendStr(B!File, Bp, Len);
     
       if (B!Lock) then
         AppendStr(" $", Bp, Len);
     
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                           Page 7-2
     Prt: 06-Jun-84  13:56                                            Rtn W!NewS

       if (R) then
       begin |3|
         integer
           I;
     
         AppendStr(" ", Bp, Len);
     
         for I _ 1 step 1 until R do
           AppendStr(">", Bp, Len);
       end; |3|
     
       AppendStr(" -", Bp, Len);
     
       ! the remainder of the status line is more readily changeable ;
     
       W!FixStatusBP _ Bp;
       W!FixStatusLen _ Len;
       W!FixS;
     end; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                           Page 8-1
     Prt: 06-Jun-84  13:56                                             Rtn W!Msg

     
     ! If the Window Module has been initialized,
     !   put something in the message line, and remember how long it is
     ! otherwise
     !   print the message using a standard SAIL print statement.
     ;
     
     internal simple procedure W!Msg(string S);
     begin "W!Msg" |2|
       own integer
         len,
         c,
         bp;
     
       if (W!IntP) then
       begin |3|
         ! The Window Module has been initialized.
         ;
     
         W!FixS;
     
           ! While we're here, insure current status.
           ;
     
         for len _ 1 upto 27 do
           W!Buf[W!MsgLine, len] _ cvasc("     ");
     
         bp  _ W!MsgBP;
         len _ 0;
     
         while (length(S)) do
         begin |4|
           c _ lop(s);
     
           if ((c >= " ") and (c < DEL)) then
             idpb(c, bp)
           else if (c = ESC) then
           begin |5|
             if (G!ESCF) then
               idpb("$", bp)
             else
             begin |6|
               idpb("^", bp);
               idpb("[", bp);
               incr(len);
             end; |6|
           end |5|
           else
           begin |5|
             idpb("^", bp);
     
             if (c = NULL) then
               idpb("@", bp)
             else if (c = DEL) then
               idpb("#", bp)
             else
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                           Page 8-2
     Prt: 06-Jun-84  13:56                                             Rtn W!Msg

               idpb(c + '100, bp);
     
             incr(len);
           end; |5|
     
           incr(len);
     
           if (len >= T!Width) then
             done;
         end; |4|
     
         W!MsgLen _ len;
       end |3|
       else
         ! The Window Module has not been initialized.
         ;
     
         print(S);
     end "W!Msg"; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                           Page 9-1
     Prt: 06-Jun-84  13:56                                            Rtn W!Msg2

     
     ! Put something at the right margin of the message line.
     ! by convention, the string *must* be printable ascii ;
     
     internal procedure W!Msg2( string S );
       begin |2|
         integer BP, L, I;
         BP := W!MsgBP;
         L := length( S );
         for I := 1 upto ( T!Width - L - 1 ) do ibp( BP );
         while ( length( S )) do idpb( lop( S ), BP );
       end; |2|
     
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 10-1
     Prt: 06-Jun-84  13:56                                            Rtn W!GetS

     
     ! Return the start of the current window ;
     
     internal simple integer procedure W!GetS;
     begin |2|
       return
       (
         if (W!Num = 1) then
           B!GetM(B!WS1)
         else
           B!GetM(B!WS0)
       );
     end; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 11-1
     Prt: 06-Jun-84  13:56                                            Rtn W!SetS

     
     ! Set the start of the current window ;
     
     internal simple procedure W!SetS (integer Position);
     begin |2|
       if (W!Num = 1) then
         B!SetM(B!WS1, Position)
       else
         B!SetM(B!WS0, Position);
     end; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 12-1
     Prt: 06-Jun-84  13:56                                            Rtn W!Size

     
     ! Return the size of the current window ;
     
     internal simple integer procedure W!Size;
       begin |2|
         if ( W!Num = 1 ) then
           return( W!Size1 )
         else
           return( W!Size0 );
       end; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 13-1
     Prt: 06-Jun-84  13:56                                           Rtn ReFrame

     
     ! Reframe a window whose point has gone wandering off.  Try to put the
     !  point in the middle of the current window, unless we run into the
     !  beginning of the buffer, or a <FF>, first.  Allow for line wrap,
     !  if set.  Unfortunately, TABs are very hard to allow for at this point.
     !
     ! 10/27/82/DWS  CharCount is a foolish attempt to keep reframe from
     !  failing (resulting in the 'W!BSet lost big' errors).
     ;
     
     simple procedure ReFrame;
       begin "reframe" |2|
         own integer SavePoint, C, CharCount, LineCount, SizeDiv2;
     
         SizeDiv2 := W!Size div 2;
         LineCount := 1;
         CharCount := 1;
     
         SavePoint := B!GetP;
     
         while ( LineCount < SizeDiv2 ) do
           begin "line" |3|
     
             C := NULL;
             if ( B!BegP ) then done "line";
     
             B!Move( BACKWARDS );
             C := B!GetC;
     
             if ( C = FF ) then
               done "line"
             else if ( C = LF ) then
               begin |4|
                 LineCount := LineCount + 1;
                 CharCount := 1;
               end |4|
             else
               CharCount := CharCount + 1;
     
             if ( CharCount = T!Width ) then
               begin |4|
                 Linecount := Linecount + 1;
                 CharCount := 1;
               end; |4|
     
           end "line"; |3|
     
         if (( C = LF ) or ( C = FF )) then
           B!Move( FORWARDS )
         else if ( not B!BegP ) then
           B!Move( FORWARDS );
     
         W!SetS( B!GetP );
         B!SetP( SavePoint );
     
       end "reframe"; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 14-1
     Prt: 06-Jun-84  13:56                                          Rtn BuildBar

     
     ! Put up the bar in the window ;
     
     procedure BuildBar;
       begin |2|
         integer P, C, W;  string Bar;
     
         P := point( 7, W!Buf[ ( W!Size0 + 1 ), 1 ], -1 );
         Bar := NULL;
     
         W := 0;
         while ( W < T!Width ) do
           begin |3|
             if ( not length( Bar )) then
               Bar := W!Bar;
             C := lop( Bar );
             if (( C < " " ) or ( C > '176 )) then C := "?";
             idpb( C, P );
             W := W + 1;
           end; |3|
     
       end; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 15-1
     Prt: 06-Jun-84  13:56                                            Rtn W!BSet

     
     ! Routine to turn on/off the box ;
     
     internal procedure W!BSet( boolean OnFlag );
       begin |2|
         W!BoxP := OnFlag;
         if (( not OnFlag ) and W!SplitP ) then
           BuildBar;
       end; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 16-1
     Prt: 06-Jun-84  13:56                                            Rtn W!BClr

     
     ! Routine to rebuild the box ;
     
     simple internal procedure W!BClr;
       begin "clear the box" |2|
         integer I;
     
         arrclr( W!Box, cvasc( "     " ));
     
         for I := 2 upto 11 do
           W!Box[1,I] := W!Box[20,I] := cvasc( "-----" );
     
         for I := 2 upto 19 do
           begin |3|
             W!Box[I,1] := cvasc( "!    " );
             W!Box[I,12] := cvasc( "    !" );
           end; |3|
     
         W!Box[1,1] := W!Box[20,1] := cvasc( "+----" );
         W!Box[1,12] := W!Box[20,12] := cvasc( "----+" );
     
         W!BoxPnt := 1;
     
       end "clear the box"; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 17-1
     Prt: 06-Jun-84  13:56                                            Rtn W!BMsg

     
     ! Routine to put text into the box.  Note that to the outside
     ! world the inside of the box is 18x56, not 20x60. ;
     
     simple internal procedure W!BMsg( integer Line; string Text );
       begin "put a message into the box" |2|
         integer Width, C, BP;
     
         if (( Line < 1 ) or ( Line > 18 )) then
           usererr( 0,0,"Bad call to W!BMsg, Line="&cvs(Line),"x" );
     
         BP := point( 7, W!Box[ 1 + Line, 1 ], -1 );
         ibp( BP ); ibp( BP );
     
         Width := 1;
         while (( Width <= 56 ) and length( Text )) do
           begin |3|
             C := lop( Text );
             if (( C < " " ) or ( C > '176 )) then C := "?"; ! ** hack ** ;
             idpb( C, BP );
             Width := Width + 1;
           end; |3|
     
         W!BoxPnt := Line;
     
       end "put a message into the box"; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 18-1
     Prt: 06-Jun-84  13:56                                            Rtn W!BAdd

     
     ! Routine to "append" text to the bottom of the box, scrolling
     ! other text up. ;
     
     internal simple procedure W!BAdd( string Text );
       begin |2|
         own integer I, J;
     
         W!BoxPnt := W!BoxPnt + 1;
         if ( W!BoxPnt < 19 ) then
           W!BMsg( W!BoxPnt, Text )
         else
           begin |3|
             for I := 2 upto 18 do
               for J := 1 upto 12 do
                 W!Box[ I, J ] := W!Box[ 1 + I, J ];
             for J := 2 upto 11 do W!Box[ 19, J ] := cvasc( "     " );
             W!Box[ 19, 1 ] := cvasc( "!    " );
             W!Box[ 19,12 ] := cvasc( "    !" );
             W!BMsg( 18, Text );
           end; |3|
       end; |2|
     
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 19-1
     Prt: 06-Jun-84  13:56                                            Rtn W!Fill

     
     ! Rebuild the pertinent part of the window.  Return true iff we've seen
     ! the point while rebuilding.
     ;
     
     simple boolean procedure W!Fill (integer WindowToFill);
     begin "W!Fill" |2|
       own boolean
         PointSeen;
       own integer
         C,
         Column,
         CurrentLine,
         I,
         J,
         Line!BP,
         LinesToFill,
         SavePoint;
     
       PointSeen _ false;
       SavePoint _ B!GetP;
     
       if (WindowToFill = 0) then
       begin |3|
         B!SetP(B!GetM(B!WS0));
         CurrentLine _ 1;
         LinesToFill _ W!Size0;
       end |3|
       else
       begin |3|
         B!SetP(B!GetM(B!WS1));
         CurrentLine _ W!Size0 + 2;
         LinesToFill _ W!Size1;
       end; |3|
     
       for I _ CurrentLine upto (CurrentLine + LinesToFill - 1) do
         for J _ 1 upto 27 do
           W!Buf[I, J] _ cvasc("     ");
     
       Line!BP _ point(7, W!Buf[CurrentLine, 1], -1);
       Column  _ 1;
     
       while (true) do
       begin "fill a window" |3|
         if (Column >= T!Width) then
         begin "wrap" |4|
           boolean
             AlreadyAtEol;
     
           clear(AlreadyAtEol);
     
           if ((Column = T!Width) and (B!GetC neq CR)) then
             idpb("|", Line!BP)
           else
           begin |5|
             if ((B!GetP = SavePoint) and (WindowToFill = W!Num)) then
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 19-2
     Prt: 06-Jun-84  13:56                                            Rtn W!Fill

             begin |6|
               PointSeen         _ true;
               SavedCursorRow    _ CurrentLine;
               SavedCursorColumn _ Column;
             end; |6|
             B!Move(FORWARDS);
             if (B!GetC = LF) then
               B!Move(FORWARDS)
             else if (G!CRCtl) then
               idpb("^", Line!BP)
             else
               idpb("&", Line!BP);
     
             set(AlreadyAtEol);
           end;       |5|
     
           if (not G!WrapP and not AlreadyAtEol) then
             while (true) do
             begin "move to EOL"; |5|
               if ((B!GetP = SavePoint) and (WindowToFill = W!Num)) then
               begin |6|
                 PointSeen         _ true;
                 SavedCursorRow    _ CurrentLine;
                 SavedCursorColumn _ Column;
               end; |6|
     
               if (B!EndP) then
                 done "fill a window";
     
               C _ B!GetC;
               B!Move(FORWARDS);
     
               if (C = FF) then
                 done "fill a window";
     
               if (C = CR) then
               begin |6|
                 if (B!GetC = LF) then
                   B!Move(FORWARDS);
     
                 done "move to EOL";
               end; |6|
             end "move to EOL"; |5|
     
           decr(LinesToFill);
     
           if (not LinesToFill) then
             done "fill a window";
     
           incr(CurrentLine);
           Line!BP _ point(7, W!Buf[CurrentLine, 1], -1);
           Column  _ 1;
         end "wrap" ; |4|
     
         if (B!GetP = SavePoint and WindowToFill = W!Num) then
         begin |4|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 19-3
     Prt: 06-Jun-84  13:56                                            Rtn W!Fill

            PointSeen         _ true;
            SavedCursorRow    _ CurrentLine;
            SavedCursorColumn _ Column;
         end; |4|
     
         if (B!EndP) then
           done "fill a window";
     
         C _ B!GetC;
         B!Move(FORWARDS);
     
         if (C = CR) then
         begin "CR" |4|
           if (B!GetC = LF) then
           begin "CRLF" |5|
             if (B!GetP = SavePoint) then
             begin |6|
                PointSeen         _ true;
                SavedCursorRow    _ CurrentLine;
                SavedCursorColumn _ Column;
             end; |6|
     
             B!Move(FORWARDS);
           end "CRLF" |5|
           else
           begin |5|
             if (G!CRCtl) then
             begin |6|
               idpb("^", Line!BP);
               idpb("M", Line!BP);
             end |6|
             else
             begin "overstrike" |6|
               while (Column < T!Width) do
               begin |7|
                 ibp(Line!BP);
                 incr(Column);
               end; |7|
     
               idpb("&", Line!BP);
             end "overstrike"; |6|
           end; |5|
     
           decr(LinesToFill);
     
           if (not LinesToFill) then
             done "fill a window";
     
           incr(CurrentLine);
           Line!BP _ point(7, W!Buf[CurrentLine, 1], -1);
           Column  _ 1;
         end "CR" |4|
         else if (C = FF) then
         begin "FF" |4|
           idpb("^", Line!BP);  idpb("L", Line!BP);
     
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 19-4
     Prt: 06-Jun-84  13:56                                            Rtn W!Fill

           if (G!FFBreak) then
             done "fill a window";
     
           decr(LinesToFill);
     
           if (not LinesToFill) then
             done "fill a window";
     
           incr(CurrentLine);
           Line!BP _ point(7, W!Buf[CurrentLine, 1], -1);
           Column  _ 1;
         end "FF" |4|
         else if ((C = TAB) and (C!TABWidth)) then
         begin "tab" |4|
           while (Column mod C!TABWidth) do
           begin |5|
             ibp(Line!BP);
             incr(Column);
           end; |5|
     
           ibp(Line!BP);
           incr(Column);
         end "tab" |4|
         else if ((C = ESC) and (G!ESCF)) then
         begin "ESC" |4|
           idpb("$", Line!BP);
           incr(Column);
         end "ESC" |4|
         else if ((C < " ") or (C = '177)) then
         begin "control character" |4|
           if (Column = (T!Width - 1)) then
           begin |5|
             idpb("|", Line!BP);
             incr(Column);
             B!Move(BACKWARDS);
           end |5|
           else
           begin |5|
             idpb("^", Line!BP);
     
             if (C = 0) then
               idpb("@", Line!BP)
             else if (C = '177) then
               idpb("#", Line!BP)
             else
               idpb(C + '100, Line!BP);
     
             incr(Column, 2);
           end; |5|
         end "control character" |4|
         else
         begin "normal character" |4|
           idpb(C, Line!BP);
           incr(Column);
         end "normal character"; |4|
       end "fill a window" ; |3|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 19-5
     Prt: 06-Jun-84  13:56                                            Rtn W!Fill

     
       B!SetP(SavePoint);
       return(PointSeen);
     end "W!Fill"; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 20-1
     Prt: 06-Jun-84  13:56                                           Rtn W!Frame

     
     ! check the framing for the current window ;
     
     internal simple procedure W!Frame;
       begin |2|
         if ( not W!Fill( W!Num ) ) then
           ReFrame;
       end; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 21-1
     Prt: 06-Jun-84  13:56                                             Rtn W!Set

     
     ! Set things up for the redisplay. ;
     
     internal simple procedure W!Set;
       begin "set up the windows" |2|
         own integer I, J;
     
         if (( W!Buf0 = W!BufNum ) and ( not W!Fill( 0 )) and ( W!Num = 0 )) th|
                                                                          ->|en|
           begin |3|
             W!Frame;
             W!FixS;
             if ( not W!Fill( 0 ) ) then
               usererr( 0,0, "W!Set lost big!" );
           end; |3|
     
         if ( W!SplitP and
             ( W!Buf1 = W!BufNum ) and ( not W!Fill( 1 )) and ( W!Num = 1 )) th|
                                                                          ->|en|
           begin |3|
             W!Frame;
             W!FixS;
             if ( not W!Fill( 1 ) ) then
               usererr( 0,0, "W!Set lost big!" );
           end; |3|
     
         ! overlay the help box, if W!BoxP is true ;
     
         if ( W!BoxP ) then
           begin "box" |3|
             for I := 1 upto 20 do
               for J := 1 upto 12 do
                 W!Buf[ 1 + I, 2 + J ] := W!Box[ I, J ];
           end "box"; |3|
     
       end "set up the windows"; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 22-1
     Prt: 06-Jun-84  13:56                                               Rtn W!2

     
     ! Split the screen into two windows ;
     
     internal procedure W!2;
       begin |2|
     
         if ( W!SplitP ) then
           T!Bell
         else
           begin |3|
             W!SplitP := true;
             W!Num := 1;             ! just for kicks, put us in the bottom ;
             W!Buf1 := W!Buf0;
             W!Size1 := W!Size0 div 2;
             W!Size0 := W!Size0 - W!Size1 - 1;
             B!SetM(B!WS1, B!GetM(B!WS0));
             BuildBar;
             B!SetL( B!GetP );
             if ( C!Debug ) then
               W!BAdd( "[split screen]" );
           end; |3|
       end; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 23-1
     Prt: 06-Jun-84  13:56                                               Rtn W!1

     
     ! Remove the "other" window of a split screen ;
     
     internal procedure W!1;
     begin |2|
       integer
         T;
     
       if (not W!SplitP) then
         T!Bell
       else
       begin |3|
         W!SplitP _ false;
     
         if (W!Num = 1) then 
           if (W!Buf0 = W!Buf1) then
             B!SetM(B!WS0, B!GetM(B!WS1))
           else
             W!Buf0 _ W!Buf1;
     
         B!SetM(B!WS1, -2);                  ! Window 1 is now undefined ;
         W!Buf1 _ 0;
     
         W!Num _ 0;
         W!Size0 _ W!Size0 + W!Size1 + 1;
         W!Size1 _ 0;
       end; |3|
     end; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 24-1
     Prt: 06-Jun-84  13:56                                            Rtn W!Grow

     
     ! Routine to grow a window ;
     
     internal simple procedure W!Grow;
       begin |2|
         if ( not W!SplitP ) then
           T!Bell
         else if ( W!Num ) then
           begin |3|
             if ( W!Size0 > 2 ) then
               begin |4|
                 W!Size0 := W!Size0 - 1;
                 W!Size1 := W!Size1 + 1;
                 BuildBar;
               end |4|
             else
               T!Bell;
           end |3|
         else
           begin |3|
             if ( W!Size1 > 2 ) then
               begin |4|
                 W!Size1 := W!Size1 - 1;
                 W!Size0 := W!Size0 + 1;
                 BuildBar;
               end |4|
             else
               T!Bell;
           end; |3|
       end; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 25-1
     Prt: 06-Jun-84  13:56                                          Rtn W!Switch

     
     ! Routine to switch between windows. ;
     
     internal procedure W!Switch;
     begin |2|
       integer
         T;
     
       if (not W!SplitP) then
         W!Msg("Window is not split.")
       else
       begin |3|
         if (W!Buf0 = W!Buf1) then
         begin |4|
           T _ B!GetP;
           B!SetP(B!GetL);
           B!SetL(T);
           W!Num _ 1 - W!Num;
           W!NewS;
         end |4|
         else
         begin |4|
           W!Num _ 1 - W!Num;
     
           if (W!Num = 0) then
             B!SetB(W!Buf0)
           else
             B!SetB(W!Buf1);
     
           W!NewS;
         end; |4|
       end; |3|
     end; |2|
     Cre: 03-Apr-84  15:26  (PEAKX)WINDOW.SAI                          Page 26-1
     Prt: 06-Jun-84  13:56                                            Rtn W!Disp

     
     ! The editor interfaces to the redisplay through W!Disp.  It is
     ! responsible for building the correct image to present to the
     ! redisplay.
     ;
     
       internal procedure W!Disp (boolean PuntFlag);
       begin "W!Disp" |2|
         ;
         if (not C!ChrP) then
         begin |3|
           ! If there is not a character waiting for input from some source.
           ;
     
           W!Set;
     
           if (W!MsgF) then
             R!Disp(W!Buf, PuntFlag, T!Lines, W!MsgLen + 1)
           else
             R!Disp(W!Buf, PuntFlag, SavedCursorRow, SavedCursorColumn);
           
         end; |3|
       end "W!Disp"; |2|
     end "DED - window manager" ; |1|
     
     
     ! **************************  End Window.Sai  ****************************;





                                                
                                                
                                                
                                    
                                    
                                    
                                    
                                    
                                    
                                          
                                          
                                          
                                    
                                    
                                    
                                    
                                    
                                    
                                                                  
                                                                  
                                                                  



                                                            
                                                            
                                                            
            
            
            
            
            
            
                                                
                                                
                                                
            
            
            
            
            
            
            
            
            




                            
            
            
                     
               
              
                        

     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                            Page 1-1
     Prt: 06-Jun-84  13:56                           Tymcom-X Buffer/Gap Manager

     Entry;
     begin "DED - buffer manager" |1|
       require "DED.DEF" source!file;
     
     
     ifcr Tops20 thenc
       require "!!!! You're compiling the wrong buffer module !!!!" message;
       require "!!!! This one is for Tymcom-X only.           !!!!" message;
       TryAgainWithTheCorrectModule
     endc
     
     
     ! *************************************************************************
     *                                                                         *
     *               The buffer/gap manager.  Tymcom-X version.                *
     *                      Dave W. Smith,  September '81                      *
     *                                                                         *
     **************************************************************************;
     
     
     ! <<  Open does not allow '.' in usernames.  This is a SAIL bug.  We must
     !     work around by doing chanios or callis ourselves.
     ! <<  Reformat this page!!!
     ;
     
     !                         From the Command Module
     ;
     
       external boolean
         G!TextMode;                                 ! True if we are in Text
                                                     ! Mode.
                                                     ;
       external safe integer array
         C!Tab ['0:'177];
     
       external         integer      !skip!;         ! skip-return flag for
                                                     !  startcode;
       external         integer      C!Debug;        ! True if we are debugging;
     
     
       external simple integer procedure
         DecrBP (integer BP);
     
       external boolean procedure    F!Writ( string FileName );
     
     
       external         procedure    W!SetB( integer BufNum );
       external         procedure    W!Msg( string Msg );  ! display a message ;
       external         procedure    W!FixS;         ! to cause update of
                                                     !  status line ;
       external         procedure    W!NewS;         ! set to build new status |
                                                                       ->|line;|
       external         procedure    W!BClr;
       external         procedure    W!BAdd( string Msg );
     
     
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                            Page 1-2
     Prt: 06-Jun-84  13:56                           Tymcom-X Buffer/Gap Manager

       external         procedure    T!Bell;
       external         integer      T!Lines;        ! size of physical window ;
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                            Page 2-1
     Prt: 06-Jun-84  13:56                                      Internal Storage

     
     ! Internal storage and such ;
     
       own integer B!Addr;           ! address of buffer space ;
       own integer B!Pages;          ! number of pages mapped ;
       own boolean B!NullFlag;       ! true if Nulls in buffer ;
     
     
     ! Storage for buffer descriptors ;
     
       own integer B!!Head;          ! head of active buffer list ;
       own integer B!!List;          ! pointer into list ;
       own integer B!!Free;          ! head of free list ;
     
       own trusted integer array B!!Next   [1:BUFMAX];
       own trusted integer array B!!Last   [1:BUFMAX];
       own trusted string  array B!!Mode   [1:BUFMAX];
       own trusted string  array B!!File   [1:BUFMAX];
       own trusted string  array B!!Alias  [1:BUFMAX];
       own trusted boolean array B!!ModP   [1:BUFMAX];
       own trusted integer array B!!Lock   [1:BUFMAX];
       own trusted integer array B!!Size   [1:BUFMAX];
       own trusted integer array B!!Point  [1:BUFMAX];
       own trusted integer array B!!GStart [1:BUFMAX];
       own trusted integer array B!!GSize  [1:BUFMAX];
       own trusted integer array B!!WS0    [1:BUFMAX];
       own trusted integer array B!!WS1    [1:BUFMAX];
     
     ! ------------------------------------------------------------------------;
     
     !                    Regarding User and Internal Marks
     !
     !
     !       We define two areas in the array which contains all marks
     !       maintained by Peak, the User Marks area (in the range [0,
     !       #UserMarks - 1]) and the Real Marks area ([FirstMark,
     !       MaxMarks-1]).
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
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                            Page 2-2
     Prt: 06-Jun-84  13:56                                      Internal Storage

     !       allocated, and its index placed in the appropriate User Mark
     !       slot.
     !
     !       When an internal routine allocates a mark, the index in the Real
     !       Marks range of the allocated mark is returned.
     !
     !       Mark-updating procedures in the insert and delete operations deal
     !       only with marks allocated in the Real Marks area, thus keeping the
     !       amount of maintenance work done to a minimum.
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
     
       own trusted integer array
         Marks[0 : MaxMarks - 1];
     
           ! The array containing the entire Mark structure.
           ;
     
     
     ! ------------------------------------------------------------------------;
     
     
     ! Static per-buffer storage ;
     
       internal integer B!Chan;      ! channel used for swapping, i/o ;
       internal string  B!Mode;      ! mode(s) that apply to this buffer ;
       internal string  B!File;      ! filename the buffer came from ;
       internal integer B!Prot;      ! buffer's protection code ;
       internal string  B!Alias;     ! "alias" for filename ;
     
       own integer B!Size;           ! size of buffer in characters ;
       own integer B!Point;          ! pointer into the buffer ;
       own integer B!LastP;          ! Mark Index of the Last Position pointer
                                     ;
     
       internal boolean B!BegP;      ! true iff point is at 0 ;
       internal boolean B!EndP;      ! true iff point is at B!Size ;
       internal boolean B!ModP;      ! true iff buffer has been modified ;
       internal integer B!Lock;
     
       internal integer B!WS0;       ! Mark Index of the starting point of the
                                     ! first window.
                                     ;
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                            Page 2-3
     Prt: 06-Jun-84  13:56                                      Internal Storage

       internal integer B!WS1;       ! Mark Index of the starting point of the
                                     ! second window.
                                     ;
     
       internal integer B!CkPtSer;   ! serial number of the checkpoint file ;
       internal integer B!DedVer;    ! version number of the editor that
                                     !  created the checkpoint file;
     
     
       own integer B!GapStart;       ! beginning of gap ;
       own integer B!GapSize;        ! size of gap ;
     
     
     ! ************************************************************************;
     
     
     ! Storage for things other than buffers ;
     
       ! static storage for byte pointers ;
     
       own integer
         B!GapPriorBP,       ! byte pointer to character before gap ;
         B!GapStartBP,       ! byte pointer to first byte of gap ;
         B!GapEndBP,         ! byte pointer to end of gap ;
         B!GapNextBP,        ! byte pointer to character after gap ;
         B!PntBP;            ! byte pointer to character at point ;
     
     
     ! the following magic is used to build byte pointers.  The five numbers
     !  point to the 0th, 1st, ... 4th 7 bit characters in a 36 bit word. ;
     
       preset!with
           hl('350700),
           hl('260700),
           hl('170700),
           hl('100700),
           hl('010700);
     
       own safe integer array B!BPLeft [0:4];
     
     
     ! ************************************************************************;
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                            Page 3-1
     Prt: 06-Jun-84  13:56                                           Rtn VCreate

     
     ! =========================================================================
     =====================================+=====================================
     =                                                                         =
     =                                                                         =
     =                               Rtn VCreate                               =
     =                                                                         =
     =                                                                         =
     =====================================+=====================================
     
     
                                     yamm (4-3)
     
             Create a range of pages in a process's Virtual Memory Map.
     
     
     ==========================================================================;
     
     
       simple integer procedure VCreate (integer VMPage, Count(1), Prot(3); boo|
                                                    ->|lean OtherFrame(false));|
       begin "VCreate" |2|
         integer
           Tmp;
     
         Tmp _
             calli(
               ((if (OtherFrame) then bit(1) else 0) lor
                   bit((Prot land !mask(2)), 7) lor
                   xwd((Count land !mask(10)), VMPage)),
               -'67
             );
     
         return(if (!skip!) then 0 else Tmp);
       end "VCreate"; |2|
     
     
     ! ===================================+=====================================
     ==========================================================================;
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                            Page 4-1
     Prt: 06-Jun-84  13:56                                            Rtn VClear

     
     ! =========================================================================
     =====================================+=====================================
     =                                                                         =
     =                                                                         =
     =                               Rtn VClear                                =
     =                                                                         =
     =                                                                         =
     =====================================+=====================================
     
     
                                     yamm (4-4)
     
             Remove a range of pages from a process's Virtual Memory Map.
             Ignores "page does not exist" errors.
     
     
     ==========================================================================;
     
     
       simple integer procedure VClear (integer VMPage, Count(1); boolean RefBi|
                                                ->|t(true), OtherFrame(false));|
       begin "VClear" |2|
         integer
           Tmp;
     
         Tmp _
             calli(
               ((if (OtherFrame) then bit(1) else 0) lor
                   (if (RefBit) then bit(7) else 0) lor
                   xwd((Count land !mask(10)), VMPage)),
               -'66
             );
     
         return(if (!skip!) then 0 else Tmp);
       end "VClear"; |2|
     
     
     ! ===================================+=====================================
     ==========================================================================;
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                            Page 5-1
     Prt: 06-Jun-84  13:56                                          Rtn B!GtChan

     
     ! Open the next availible disk channel for dump mode I/O and return that
       channel's identity.  (Note that this channel number will be in the range
       [1, '17] and will not collide with other channel allocations.) ;
     
     simple integer procedure B!GtChan;
     begin "B!GtChan" |2|
       integer
         Channel,
         Flag;
     
       if ((Channel _ getchan) = -1) then
         usererr(0, 0, "Out of channels in B!GtChan!", "x");
     
       open(Channel, "DSK", bit(23)+'17, 0, 0, 0, 0, Flag _ true);
     
       if (Flag) then
         usererr(0, 0, "Open Error in B!GtChan!", "x");
     
       return(Channel);
     end "B!GtChan"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                            Page 6-1
     Prt: 06-Jun-84  13:56                                          Rtn B!RlChan

     
     ! Release the specified channel ;
     
     simple procedure B!RlChan (integer Channel);
     begin "B!RlChan" |2|
       release(Channel);
     end "B!RlChan"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                            Page 7-1
     Prt: 06-Jun-84  13:56                                            Rtn B!Init

     
     ! Initialize the buffer system by grounding the active list pointer and
     !  linking all buffers into the free list. ;
     
     internal simple procedure B!Init;
     begin "init" |2|
       own integer
         I;
     
       B!DedVer   _ DED!Version!Word;        ! The current version of PEAK ;
       B!Addr     _ BasePage * 512;          ! ** hack ** start with page 100 ;
       B!Pages    _ 0;                       ! ** hack ** and nothing mapped ;
       B!!Head    _ 0;                       ! no list, yet ;
       B!!List    _ 0;                       ! no buffers on active list ;
       B!!Free    _ 1;                       ! link all buffers to free list ;
     
       for I _ 1 upto BUFMAX - 1 do
         B!!Next[I] _ I + 1;
     
       B!!Next[BUFMAX] _ 0;
     
       B!Chan _ B!GtChan;            ! Establish the buffer I/O channel ;
     end "init"; |2|
     require B!Init initialization;
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                            Page 8-1
     Prt: 06-Jun-84  13:56                                      Rtn DeleteBuffer

     
     ! Delete the buffer file open on the specified channel ;
     
     simple procedure DeleteBuffer (integer Channel);
     begin "DeleteBuffer" |2|
       start!code |3|
         move        1, Channel;
         hrli        1, '11;         ! .CHREN == 11 ;
         setzb       2, 3;
         setzb       4, 5;
         chanio      1, 2;           ! delete the file ;
           jfcl;
       end; |3|
     end "DeleteBuffer"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                            Page 9-1
     Prt: 06-Jun-84  13:56                                           Rtn B!FreeP

     
     ! Routine to tell us if we have any free buffers left. ;
     
     internal simple boolean procedure B!FreeP;
       return( B!!Free neq NULL );
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 10-1
     Prt: 06-Jun-84  13:56                                Rtn NameCheckpointFile

     
     ! Return the components of the checkpoint file name in sixbit. ;
     
     simple procedure NameCheckpointFile (reference integer FName, Ext);
     begin |2|
       FName := cvsix(cvs(1000 + call(0, "Pjob"))[2 for 3] &
           DED!Alias[1 for 3]);
       Ext := cvsix(cvs(1000 + B!!List)[2 for 3]);
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 11-1
     Prt: 06-Jun-84  13:56                               Rtn CloseCheckpointFile

     
     ! Close a checkpoint file ;
     
     simple procedure CloseCheckpointFile;
     begin |2|
       start!code |3|
         move        1, B!Chan;
         hrli        1, 1;                   ! .CHCLS == 1 ;
         chanio      1, 0;                   ! close the file ;
       end; |3|
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 12-1
     Prt: 06-Jun-84  13:56                               Rtn EnterCheckpointFile

     
     ! Enter a checkpoint file ;
     
     simple boolean procedure EnterCheckpointFile( integer Name, Ext );
     begin |2|
       integer
         Error;
     
       start!code |3|
         setzm       Error;
         move        1, B!Chan;
         hrli        1, 5;                   ! .CHENT == 5 ;
         move        2, Name;
         move        3, Ext;
         setzb       4, 5;
         chanio      1, 2;
           movem     3, Error;               ! error code is in rh( 3 ) ;
       end; |3|
     
       return( not Error );
         ! <<  You lose the identity of the error condition this way ;
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 13-1
     Prt: 06-Jun-84  13:56                              Rtn LookupCheckpointFile

     
     ! Lookup a checkpoint file ;
     
     simple boolean procedure LookupCheckpointFile( integer Name, Ext );
     begin |2|
       integer
         Error;
     
       start!code |3|
         move        1, B!Chan;              ! channel ;
         hrli        1, 4;                   ! .CHLK == 4  (lookup) ;
         move        2, Name;
         hllz        3, Ext;
         setzb       4, 5;
         setzm       Error;
         chanio      1, 2;
           setom     Error;
       end; |3|
     
       return( not Error );
         ! <<  You lose the identity of the error condition this way ;
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 14-1
     Prt: 06-Jun-84  13:56                              Rtn CreateCheckpointFile

     
     ! Create a checkpoint file ;
     
     simple procedure CreateCheckpointFile;
     begin |2|
       integer
         Name, Ext;
     
       NameCheckpointFile(Name,Ext);
     
       if ( LookupCheckpointFile( Name, Ext ) ) then
         print( crlf & "Checkpoint file already exists!" &
             "  Continue at your own peril." );
     
       CloseCheckpointFile;
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 15-1
     Prt: 06-Jun-84  13:56                                      Rtn B!Checkpoint

     
     ! Flush information that we keep in static locations back
     !  into the buffer descriptor block.  Also flush the in-core image
     !  to a "checkpoint file" on disk. ;
     
     internal simple procedure B!Checkpoint;
     begin |2|
       integer
         I,
         Size, Name, Ext;
       own safe integer array
         IOWDlist[0:2],
         CheckRec[0:127];
     
       arrclr(CheckRec);
     
       B!!File[B!!List]    _ B!File;
       B!!Alias[B!!List]   _ B!Alias;
     
                             CheckRec[0] _ cvsix("*PEAK*");
       B!!Point[B!!List]   _ CheckRec[1] _ B!Point;
       B!!Size[B!!List]    _ CheckRec[2] _ B!Size;
       B!!ModP[B!!List]    _ CheckRec[3] _ B!ModP;
       B!!Lock[B!!List]    _ CheckRec[4] _ B!Lock;
       B!!GStart[B!!List]  _ CheckRec[5] _ B!GapStart;
       B!!GSize[B!!List]   _ CheckRec[6] _ B!GapSize;
       B!!WS0[B!!List]     _ CheckRec[7] _ B!WS0;
       B!!WS1[B!!List]     _ CheckRec[8] _ B!WS1;
     
       ! now expand the name & alias into the record ;
     
       CheckRec[9]  _ cvasc(B!File[1 for 5]);
       CheckRec[10] _ cvasc(B!File[6 for 5]);
       CheckRec[11] _ cvasc(B!File[11 for 5]);
       CheckRec[12] _ cvasc(B!File[16 for 5]);
       CheckRec[13] _ cvasc(B!File[21 for 5]);
     
       CheckRec[14] _ cvasc(B!Alias[1 for 5]);
       CheckRec[15] _ cvasc(B!Alias[6 for 5]);
       CheckRec[16] _ cvasc(B!Alias[11 for 5]);
       CheckRec[17] _ cvasc(B!Alias[16 for 5]);
       CheckRec[18] _ cvasc(B!Alias[21 for 5]);
       CheckRec[19] _ cvasc(B!Alias[26 for 5]);
       CheckRec[20] _ cvasc(B!Alias[31 for 5]);
     
       CheckRec[21] _ incr(B!CkPtSer);
       CheckRec[22] _ B!DedVer;
       CheckRec[23] _ B!Prot ;
     
       B!!Mode[B!!List] _ B!Mode;
       CheckRec[24] _ cvasc(B!Mode[1 for 5]);
       CheckRec[25] _ cvasc(B!Mode[6 for 5]);
     
       CheckRec[26] _ MarkCnt;
     
       for I _ 0 step 1 until MaxMarks - 1 do
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 15-2
     Prt: 06-Jun-84  13:56                                      Rtn B!Checkpoint

         CheckRec[27 + I] _ Marks[I];
     
         ! Stash the Marks away too.
         ;
     
       CheckRec[127] _ cvasc(">>>>>");
     
     
       ! now flush the image to disk ;
     
       NameCheckpointFile(Name, Ext);
       EnterCheckpointFile(Name, Ext);
     
       start!code |3|
         protect!acs 1, 2;
         move                1, B!Chan;
         hrli                1, '32;                 ! .CHPSO == 32 ;
         movei               2, 1;
         chanio              1, 2;                   ! set to output at page 1 ;
           jfcl;
         move                1, B!Chan;
         hrli                1, 2;                   ! .CHOPT == 2 ;
         movei               2, access(CheckRec[0]);
         subi                2, 1;
         hrli                2, -128;                ! -128,,addr-1 ;
         setz                3, ;
         chanio              1, 2;                   ! do the output ;
       end; |3|
     
     
       ! now build the IOWD list for output ;
     
       Size _ (B!Size + B!GapSize + 4) div 5;
       IOWDList[1] _ IOWDList[2] _ 0;
     
       if (Size < '400000) then
         IOWDList[0] _ xwd(-Size, B!Addr-1)
       else
       begin |3|
         IOWDList[0] _ xwd(-'377000, B!Addr-1);
         IOWDList[1] _ xwd(-(Size - '377000),(B!Addr + '377000 - 1));
       end; |3|
     
       start!code |3|
         protect!acs 1, 2, 3, 4;
         move                1, B!Chan;
         hrli                1, '2;            ! .CHOPT == 2 ;
         move                2, access(IOWDList[0]);
         move                3, access(IOWDList[1]);
         move                4, access(IOWDList[2]);
         chanio              1, 2;             ! do the output ;
       end; |3|
     
       CloseCheckpointFile;
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 16-1
     Prt: 06-Jun-84  13:56                                 Rtn RestoreCheckpoint

     
     ! Restore from a Checkpoint File ;
     
     internal simple procedure RestoreCheckpoint (integer Name, Ext);
     begin "restore" |2|
       own safe integer array
         IOWDList [0:2],
         CheckRec [0:127];
       integer
         I,
         WrdSize;
     
     
       LookupCheckpointFile(Name, Ext);
     
     
       ! read the checkpoint header ;
     
       start!code |3|
         protect!acs 1, 2;
         move        1, B!Chan;
         hrli        1, '31;                 ! .CHPSI == 31 ;
         movei       2, 1;
         chanio      1, 2;                   ! set to input at page 1 ;
           jfcl;
         move        1, B!Chan;
         hrli        1, 3;                   ! .CHIPT == 3 ;
         movei       2, access(CheckRec[0]);
         subi        2, 1;
         hrli        2, -128;                ! -128,,add-1 ;
         setz        3, ;
         chanio      1, 2;                   ! read the checkpoint header ;
       end; |3|
     
     
       ! now restore various facts of interest about this buffer ;
     
       B!Point    _ B!!Point[B!!List]  _ CheckRec[1];
       B!Size     _ B!!Size[B!!List]   _ CheckRec[2];
       B!ModP     _ B!!ModP[B!!List]   _ CheckRec[3];
       B!Lock     _ B!!Lock[B!!List]   _ CheckRec[4];
       B!GapStart _ B!!GStart[B!!List] _ CheckRec[5];
       B!GapSize  _ B!!GSize[B!!List]  _ CheckRec[6];
       B!WS0      _ B!!WS0[B!!List]    _ CheckRec[7];
       B!WS1      _ B!!WS1[B!!List]    _ CheckRec[8];
     
       B!BegP     _ (B!Point = 0);
       B!EndP     _ (B!Point = B!Size);
       B!CkPtSer  _ CheckRec[21];
       B!DedVer   _ CheckRec[22];
       B!Prot     _ CheckRec[23];
     
       B!Mode _ B!!Mode[B!!List] _
           cvastr(CheckRec[24]) &
           cvastr(CheckRec[25]);
     
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 16-2
     Prt: 06-Jun-84  13:56                                 Rtn RestoreCheckpoint

       set (G!TextMode, kequ(B!Mode[1 for 4], "Text"));
     
       B!File _ B!!File[B!!List] _
           cvastr(CheckRec[9]) &
           cvastr(CheckRec[10]) &
           cvastr(CheckRec[11]) &
           cvastr(CheckRec[12]) &
           cvastr(CheckRec[13]);
     
       B!Alias _ B!!Alias[B!!List] _
           cvastr(CheckRec[14]) &
           cvastr(CheckRec[15]) &
           cvastr(CheckRec[16]) &
           cvastr(CheckRec[17]) &
           cvastr(CheckRec[18]) &
           cvastr(CheckRec[19]) &
           cvastr(CheckRec[20]);
     
       MarkCnt _ CheckRec[26];
     
       for I _ 0 step 1 until MaxMarks - 1 do
         Marks[I] _ CheckRec[27 + I];
     
         ! Restore the Mark System.
         ;
     
     
       ! Do some memory management first.  Kill the pages used by the last
       ! buffer, and create some for this one to be read back into. ;
     
       WrdSize  _ ceiling(B!Size + B!GapSize, 5);
     
       if (VClear(BasePage, 512 - BasePage)) then
         usererr(0, 0, "VClear Error in RestoreCheckpoint", "x");
     
       B!Pages _ ceiling(WrdSize, 512);
     
       if (VCreate(BasePage, B!Pages)) then
         usererr(0, 0, "VCreate Error in RestoreCheckpoint", "x");
     
     
       ! now restore the in-memory image for this buffer ;
       ! build the IOWD list for input ;
     
       IOWDList[1] _ IOWDList[2] _ 0;
     
       if (WrdSize < '400000) then
         IOWDList[0] _ xwd(-WrdSize, (B!Addr - 1))
       else
       begin |3|
         IOWDList[0] _ xwd(-'377000,(B!Addr - 1));
         IOWDList[1] _ xwd(-(WrdSize - '377000), (B!Addr + '377000 - 1));
       end; |3|
     
       start!code |3|
         protect!acs 1, 2, 3, 4;
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 16-3
     Prt: 06-Jun-84  13:56                                 Rtn RestoreCheckpoint

         move        1, B!Chan;
         hrli        1, '3;            ! .CHIPT == 3 ;
         move        2, access(IOWDList[0]);
         move        3, access(IOWDList[1]);
         move        4, access(IOWDList[2]);
         chanio      1, 2;             ! do the input ;
       end; |3|
     
       CloseCheckpointFile;
     end "restore"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 17-1
     Prt: 06-Jun-84  13:56                                         Rtn B!Restore

     
     ! Routine to reset the static definitions from a descriptor ;
     
     internal simple procedure B!Restore;
     begin |2|
       integer Name, Ext;
     
       NameCheckpointFile( Name, Ext );
       RestoreCheckpoint( Name, Ext );
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 18-1
     Prt: 06-Jun-84  13:56                                           Rtn B!Setup

     
     ! Routine to set up a fresh buffer descriptor by unlinking one from the
     !  free list and adding it to the buffer chain.  It becomes the current
     !  buffer in the doubly linked list. ;
     
     simple procedure B!Setup;
     begin "setup" |2|
       integer
         Error, Next, Flag;
     
       if ( B!!Free = 0 ) then
         usererr( 0,0, "Out of buffers in B!Setup" );
     
         ! <<  Should this be a death condition? ;
     
       Next := B!!Free;                      ! get a free buffer ;
       B!!Free := B!!Next[ B!!Free ];
     
       if ( B!!List = 0 ) then               ! link into chain ;
         begin |3|
           B!!Head := Next;
           B!!Next[ Next ] := B!!Last[ Next ] := NULL;
           B!!List := Next;
         end |3|
       else
         begin |3|
           B!!Next[ Next ] := B!!Next[ B!!List ];
           B!!Last[ Next ] := B!!List;
           if ( B!!Next[ B!!List ] neq 0 ) then
             B!!Last[ B!!Next[ B!!List ] ] := Next;
           B!!Next[ B!!List ] := Next;
           B!!List := Next;
         end; |3|
     
     
       ! Now allocate a channel and file for swapping ;
     
       CreateCheckpointFile;
     
       W!SetB( B!!List );                    ! tell the window manager the ;
                                             !  identity of the current buffer ;
     end "setup"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 19-1
     Prt: 06-Jun-84  13:56                                          Rtn B!CKFile

     
     ! Routine to load the specified checkpoint file back into a buffer.
     ;
     
     internal simple boolean procedure B!CKFile( integer Name, Ext );
     begin "recover checkpoint" |2|
       integer Error;
     
       DeleteBuffer(B!Chan);
     
       if ( LookupCheckpointFile( Name, Ext ) ) then
       begin |3|
         RestoreCheckpoint( Name, Ext );
         W!Msg( "Restore Complete" );
       end |3|
       else
       begin |3|
         W!Msg( "Lookup Failed!  Further editing may be fatal!" );
         T!Bell;
       end; |3|
     
       return( not Error );
     end "recover checkpoint"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 20-1
     Prt: 06-Jun-84  13:56                                            Rtn B!Kill

     
     ! Routine to "B!Kill" the current buffer by adding it to the free list
     ! and resetting the current buffer to the next buffer if possible (or the
     ! last buffer if not).
     ;
     ! <<  Buffer chain s/b a pushdown list, so that the buffer returned to is
     !     the last buffer exitted.
     ;
     
     internal simple procedure B!Kill;
     begin "B!Kill" |2|
       own integer
         Next;
     
     
       DeleteBuffer(B!Chan);
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       if (B!!Head = B!!List) then B!!Head _ B!!Next[B!!List];
     
       if (B!!Next[B!!List]) then
       begin |3|
         Next _ B!!Next[B!!List];
         B!!Last[Next] _ B!!Last[B!!List];
     
         if (B!!Last[B!!List] neq 0) then
           B!!Next[B!!Last[B!!List]] _ Next;
       end |3|
       else if (B!!Last[B!!List]) then
       begin |3|
         Next _ B!!Last[B!!List];
         B!!Next[Next] _ B!!Next[B!!List];
       end |3|
       else
         Next _ 0;   ! into the void ... ;
     
       B!!Next[B!!List] _ B!!Free;
       B!!Free _ B!!List;
       B!!List _ Next;
     
     ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;
     
       if (B!!List) then
         B!Restore;
     
       W!SetB(B!!List);
     end "B!Kill"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 21-1
     Prt: 06-Jun-84  13:56                                            Rtn B!SetB

     
     ! Routine to position to a specified buffer ;
     
     internal simple procedure B!SetB( integer BufNum );
       begin |2|
         if ( BufNum = B!!List ) then return;
         B!CheckPoint;
         B!!List := BufNum;
         W!SetB( BufNum );
         B!Restore;
         W!NewS;
       end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 22-1
     Prt: 06-Jun-84  13:56                                            Rtn B!Step

     
     ! Routine to step forwards or backwards along the buffer chain ;
     
     internal simple procedure B!Step( integer Dir );
       begin |2|
         if ( Dir = FORWARDS ) then
           begin |3|
             if ( B!!Next[ B!!List ] neq NULL ) then
               begin |4|
                 B!CheckPoint;
                 B!!List := B!!Next[ B!!List ];
                 W!SetB( B!!List );
                 B!Restore;
                 W!NewS;
               end |4|
             else
               W!Msg( "No buffers left >" );
           end |3|
         else if ( Dir = BACKWARDS ) then
           begin |3|
             if ( B!!Last[ B!!List ] neq NULL ) then
               begin |4|
                 B!CheckPoint;
                 B!!List := B!!Last[ B!!List ];
                 W!SetB( B!!List );
                 B!Restore;
                 W!NewS;
               end |4|
             else
               W!Msg( "No buffers left <" );
           end; |3|
     
       end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 23-1
     Prt: 06-Jun-84  13:56                                             Rtn B!Cnt

     
     ! Routine to tell us how many buffers to the left and right of the
     !  current buffer are active. Returns [ #left,,#right ] ;
     
     internal simple integer procedure B!Cnt;
       begin |2|
         own integer Left, Right, Chain;
     
         Chain := B!!List;
         Left := 0;
         while ( B!!Last[ Chain ] neq NULL ) do
           begin |3|
             Left := Left + 1;
             Chain := B!!Last[ Chain ];
           end; |3|
         Chain := B!!List;
         Right := 0;
         while ( B!!Next[ Chain ] neq 0 ) do
           begin |3|
             Right := Right + 1;
             Chain := B!!Next[ Chain ];
           end; |3|
         return( XWD( Left, Right ) );
       end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 24-1
     Prt: 06-Jun-84  13:56                                            Rtn B!Make

     
     ! Build a new buffer descriptor by setting one up and filling it in.
     ;
     
     forward internal simple procedure B!SetM (integer M, P);
     forward internal simple integer procedure B!AllocateMark;
     
     internal simple procedure B!Make(string FileNam, Alias);
     begin |2|
       integer
         I;
     
       if (B!!List neq 0) then
         B!CheckPoint;
     
       B!Setup;
     
       if (not length(B!Mode)) then
         B!Mode _ "Normal";
     
       B!!Mode[B!!List]   _ B!Mode;
       B!!File[B!!List]   _ B!File     _ FileNam;
       B!!Alias[B!!List]  _ B!Alias    _ Alias;
       B!!Point[B!!List]  _ B!Point    _ 0;
       B!!Size[B!!List]   _ B!Size     _ 0;
       B!!ModP[B!!List]   _ B!ModP     _ false;
       B!!Lock[B!!List]   _ B!Lock     _ 0;
       B!!GStart[B!!List] _ B!GapStart _ 0;
       B!!GSize[B!!List]  _ B!GapSize  _ (GAPMAX - GAPMIN) div 2;
     
       for I _ 0 step 1 until MaxMarks - 1 do
         Marks[I] _ -1;
     
         ! Initialize our Mark Structure.
         ;
     
       B!SetM((B!LastP _ B!AllocateMark), 0);
       B!SetM((B!WS0   _ B!AllocateMark), 0);
       B!SetM((B!WS1   _ B!AllocateMark), -1);
       
       B!!WS0[B!!List] _ B!WS0;
       B!!WS1[B!!List] _ B!WS1;
     
         ! Initialize some important Marks.
         ;
     
       B!CkPtSer _ 0;
       B!BegP _ B!EndP _ true;
     
     
       ! now build an empty gap for the buffer ;
     
       B!Pages _ 2;
     
       if (VClear(BasePage, B!Pages)) then
         usererr(0, 0, "VClear Error in B!Make", "x");
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 24-2
     Prt: 06-Jun-84  13:56                                            Rtn B!Make

     
       if (VCreate(BasePage, B!Pages)) then
         usererr(0, 0, "VCreate Error in B!Make", "x");
     
       B!!GSize[B!!List] _ B!GapSize _ 2 * 512;
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 25-1
     Prt: 06-Jun-84  13:56                                         Rtn ExpandGap

     
     ! Routine to expand the gap.  ;
     
     simple procedure ExpandGap;
     begin |2|
       own integer
         WordsUsed, WordsToMove, MoveFrom, MoveTo;
     
       WordsUsed _ ceiling(B!Size + B!GapSize, 5);
     
       if (VClear(BasePage + B!Pages, 1)) then
         usererr(0, 0, "VClear Error in ExpandGap", "x");
     
       if (VCreate(BasePage + B!Pages, 1)) then
         usererr(0, 0, "VCreate Error in ExpandGap", "x");
     
       B!Pages _ B!Pages + 1;
     
     
       ! shuffle memory if the gap isn't at the end of the buffer ;
     
       if (B!GapStart < B!Size) then
       begin |3|
         MoveFrom _ WordsUsed - 1;
         MoveTo _ WordsUsed - 1 + 512;
         WordsToMove _ WordsUsed - (B!GapStart + B!GapSize) div 5;
     
         while (WordsToMove > 0) do
         begin |4|
           memory[B!Addr + MoveTo] _ memory[B!Addr + MoveFrom];
           MoveTo _ MoveTo - 1;
           MoveFrom _ MoveFrom - 1;
           WordsToMove _ WordsToMove - 1;
         end; |4|
       end; |3|
     
       B!GapSize _ B!GapSize + (5 * 512);
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 26-1
     Prt: 06-Jun-84  13:56                                         Rtn ShrinkGap

     
     ! Routine to shrink the gap when it gets above GAPMAX bytes long. ;
     
     simple procedure ShrinkGap;
       begin |2|
         own integer WordsUsed, MoveFrom, MoveTo, WordsToMove;
     
         if ( B!GapStart < B!Size ) then
           begin |3|
             WordsUsed := ( B!Size + B!GapSize + 4 ) div 5;
             MoveFrom := ( B!GapStart + B!GapSize ) div 5;
             MoveTo := MoveFrom - GAPSHRINK;
             WordsToMove := WordsUsed - MoveFrom;
     
             while ( WordsToMove > 0 ) do
               begin |4|
                 memory[ B!Addr + MoveTo ] := memory[ B!Addr + MoveFrom ];
                 MoveTo := MoveTo + 1;
                 MoveFrom := MoveFrom + 1;
                 WordsToMove := WordsToMove - 1;
               end; |4|
           end; |3|
         B!GapSize := B!GapSize - 5 * GAPSHRINK;
     ! W!Msg( "ShrinkGap, B!GapSize = " & cvs( B!GapSize ) );
       end; |2|
     
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 27-1
     Prt: 06-Jun-84  13:56                                    Rtn MakeGapPriorBP

     
     ! Routines to make byte pointers.  These guys ar good targets for eventual
     !  recoding into assembly language. ;
     
     ! Make a byte pointer to the character before the gap ;
     
     simple integer procedure MakeGapPriorBP;
       begin |2|
         own integer Temp1, Temp2;
         Temp1 := B!GapStart - 1;
         Temp2 := B!Addr + ( Temp1 div 5 );
         return( Temp2 lor B!BPLeft[ Temp1 mod 5 ] );
       end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 28-1
     Prt: 06-Jun-84  13:56                                    Rtn MakeGapStartBP

     
     ! Make a byte pointer to the first gap character ;
     
     simple integer procedure MakeGapStartBP;
       begin |2|
         own integer Temp1;
         Temp1 := B!Addr + ( B!GapStart div 5 );
         return( Temp1 lor B!BPLeft[ B!GapStart mod 5 ] );
       end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 29-1
     Prt: 06-Jun-84  13:56                                      Rtn MakeGapEndBP

     
     ! Make a byte pointer to the last character in the gap ;
     
     simple integer procedure MakeGapEndBP;
       begin |2|
         own integer Temp1, Temp2;
         Temp1 := B!GapStart + B!GapSize - 1;
         Temp2 := B!Addr + ( Temp1 div 5 );
         return( Temp2 lor B!BPLeft[ Temp1 mod 5 ] );
       end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 30-1
     Prt: 06-Jun-84  13:56                                     Rtn MakeGapNextBP

     
     ! Make a byte pointer to the first character after the gap ;
     
     simple integer procedure MakeGapNextBP;
       begin |2|
         own integer Temp1, Temp2;
         Temp1 := B!GapStart + B!GapSize;
         Temp2 := B!Addr + ( Temp1 div 5 );
         return( Temp2 lor B!BPLeft[ Temp1 mod 5 ] );
       end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 31-1
     Prt: 06-Jun-84  13:56                                       Rtn MakePointBP

     
     ! More routines to make byte pointers ;
     
     ! Make a byte pointer to the character to the right of the point ;
     
     simple integer procedure MakePointBP;
       begin |2|
         own integer Temp1, Temp2;
         Temp1 := B!Point + ( if ( B!Point >= B!GapStart ) then
                                     B!GapSize else 0 );
         Temp2 := B!Addr + ( Temp1 div 5 );
         return( Temp2 lor B!BPLeft[ Temp1 mod 5 ] );
       end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 32-1
     Prt: 06-Jun-84  13:56                                      Rtn MakeBufEndBP

     
     ! Make a byte pointer to the slot past the end of the buffer ;
     
     simple integer procedure MakeBufEndBP;
       begin |2|
         own integer Temp1, Temp2;
         Temp1 := B!Size + B!GapSize;
         Temp2 := B!Addr + ( Temp1 div 5 );
         return( Temp2 lor B!BPLeft[ Temp1 mod 5 ] );
       end; |2|
     
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 33-1
     Prt: 06-Jun-84  13:56                                        Rtn B!ForceGap

     
     ! Force the gap to the right of the point. ;
     
     simple procedure B!ForceGap;
       begin |2|
         own integer Count, ToMove;
         if ( B!Point = B!GapStart ) then
           return
         else if ( B!Point > B!GapStart ) then
           begin |3|
             B!GapNextBP := MakeGapNextBP;
             B!GapStartBP := MakeGapStartBP;
             ToMove := ( B!Point - B!GapStart );
             for Count := 1 upto ToMove do
               begin |4|
                 dpb( ldb( B!GapNextBP ), B!GapStartBP );
                 ibp( B!GapNextBP );
                 ibp( B!GapStartBP );
               end; |4|
             B!GapStart := B!Point;
           end |3|
         else ! if ( B!Point < B!GapStart ) then ;
           begin |3|
             B!GapEndBP := MakeGapEndBP;
             B!GapPriorBP := MakeGapPriorBP;
             ToMove := ( B!GapStart - B!Point );
             for Count := 1 upto ToMove do
               begin |4|
                 dpb( ldb( B!GapPriorBP ), B!GapEndBP );
                 B!GapPriorBP := DecrBP( B!GapPriorBP );
                 B!GapEndBP := DecrBP( B!GapEndBP );
               end; |4|
             B!GapStart := B!Point;
           end; |3|
       end; |2|
     
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 34-1
     Prt: 06-Jun-84  13:56                                            Rtn B!Pcnt

     
     ! Return the percentage that the point is into the buffer ;
     
     internal simple integer procedure B!Pcnt;
       begin |2|
         return( ( B!Point * 100 ) div B!Size );
       end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 35-1
     Prt: 06-Jun-84  13:56                                            Rtn B!GetP

     
     ! Return the current value of the point. ;
     
     internal simple integer procedure B!GetP;
       return( B!Point );
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 36-1
     Prt: 06-Jun-84  13:56                                            Rtn B!SetP

     
     ! Set the point to an absolute position in the buffer.  If set to beginning
     !  and/or end, set the appropriate flags. ;
     
     internal simple procedure B!SetP( integer Position );
       begin |2|
         B!BegP := B!EndP := false;
         B!Point := Position;
         if ( B!Point <= 0 ) then
           begin |3|
             B!Point := 0;
             B!BegP := true;
           end; |3|
         if ( B!Point >= B!Size ) then
           begin |3|
             B!Point := B!Size;
             B!EndP := true;
           end; |3|
       end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 37-1
     Prt: 06-Jun-84  13:56                                            Rtn B!GetL

     
     ! Return the "last" point. ;
     
     forward internal simple integer procedure B!GetM (integer M);
     
     internal simple integer procedure B!GetL;
     begin |2|
       return(B!GetM(B!LastP));
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 38-1
     Prt: 06-Jun-84  13:56                                            Rtn B!SetL

     
     ! Set the "Last" point.  (Used by the split window code). ;
     
     internal simple procedure B!SetL( integer Position );
     begin |2|
       B!SetM(B!LastP, Position);
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 39-1
     Prt: 06-Jun-84  13:56                                    Rtn B!AllocateMark

     
     ! Allocate the first availible Real Mark to the caller and return its
     ! index.  A return of -1 indicates that there are no more Marks
     ! availible.
     ;
     
     internal simple integer procedure B!AllocateMark;
     begin "B!AllocateMark" |2|
       integer
         I;
     
       for I _ FirstMark step 1 until MaxMarks - 1 do
         if (Marks[I] = -1) then
         begin |3|
           Marks[I] _ -2;
     
           if (I - FirstMark = MarkCnt) then
             incr(MarkCnt);
     
           return(I);
         end; |3|
     
       return(-1);
     end "B!AllocateMark"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 40-1
     Prt: 06-Jun-84  13:56                                  Rtn B!DeAllocateMark

     
     ! Remove a given Mark from circulation, and if possible decrease MarkCnt.
     ;
     
     internal simple procedure B!DeAllocateMark (integer M);
     begin "B!DeAllocateMark" |2|
       integer
         I;
     
       if (M < 0 or M >= FirstMark + MarkCnt) then
         usererr(0, 0, "Error in B!DeAllocateMark", "x")
       else if (M < #UserMarks) then
       begin |3|
         if (Marks[M] neq -1) then
         begin |4|
           Marks[Marks[M]] _ -1;
           Marks[M]        _ -1;
         end; |4|
       end |3|
       else
         Marks[M] _ -1;
     
       for I _ FirstMark + MarkCnt - 1 step -1 until FirstMark do
         if (Marks[I] = -1) then
           decr(MarkCnt)
         else
           done;
     end "B!DeAllocateMark"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 41-1
     Prt: 06-Jun-84  13:56                                            Rtn B!GetM

     
     ! Return the current position of the mark ;
     
     internal simple integer procedure B!GetM (integer M);
     begin |2|
       if (M < 0 or M >= FirstMark + MarkCnt) then
         usererr(0, 0, "Bad call to B!GetM, M = " & cvs(M), "x" )
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
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 42-1
     Prt: 06-Jun-84  13:56                                            Rtn B!SetM

     
     ! Set the mark to some position within the buffer ;
     
     internal simple procedure B!SetM (integer M, P);
     begin |2|
       if (P < 0) then
         P _ 0
       else if (P > B!Size) then
         P _  B!Size;
     
       if (M < 0 or M >= FirstMark + MarkCnt) then
         usererr(0, 0, "Bad call to B!SetM, M = " & cvs(M), "x" )
       else
         if (M < #UserMarks) then
         begin |3|
           if (Marks[M] = -1) then
             Marks[M] _ B!AllocateMark;
     
           Marks[Marks[M]] _ P;
         end |3|
         else
           Marks[M] _ P;
     end; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 43-1
     Prt: 06-Jun-84  13:56                                            Rtn B!Move

     
     ! Move forward or backward through the buffer.  If we reach the beginning
     ! and/or reach the end, set appropriate flags.  Note that with an empty
     ! buffer the point will be both at the beginning and the end. (This code
     ! has been optimized since it is central to almost all buffer-related
     ! work.)
     ;
     
     internal simple procedure B!Move (integer Dir);
     begin "B!Move" |2|
       start!code |3|
         define
           Ac13 = {'13};
         label
           Labl1,
           Labl2;
     
           setzm     B!BegP;
           setzm     B!EndP;
     
           move      Ac13, Dir;
           addb      Ac13, B!Point;
     
           jumpg     Ac13, Labl1;
           setzb     Ac13, B!Point;
           setom     B!BegP;
     
         Labl1:
           camge     Ac13, B!Size;
             jrst    Labl2;
     
           setom     B!EndP;
           move      Ac13, B!Size;
           movem     Ac13, B!Point;
     
         Labl2:
       end; |3|
     end "B!Move"; |2|
     Cre: 13-Apr-84  14:46  (PEAKX)XBUFF.SAI                           Page 44-1
     Prt: 06-Jun-84  13:56                                          Rtn B!Delete

     
     ! Delete a character from the buffer.  The side of the point from
     !  which the character is deleted depends on the flag Side. ;
     
     internal simple procedure B!Delete( integer Side );
       begin |2|
     
         if ( B!Lock ) then return;
     
         B!ForceGap;
     !   if ( B!GapSize >= GAPMAX ) then ShrinkGap; 
     
         if ( Side > 0 ) then        ! delete from right of the gap ;
           begin |3|
             if ( B!Point < B!Size ) then
               begin |4|
                 start!code |5|
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
                 end; |5|
     
                 B!GapSize := B!GapSize + 1;
                 B!Size := B!Size - 1;
     
                 if ( B!Point = B!Size ) then
                   B!EndP := true;
               end; |4|
           end |3|
         else                        ! delete from left of the gap ;
           begin |3|
             if ( B!Point > 0 ) then
               begin |4|
                 start!code |5|
                   define
                     AC1 = 1,
V É