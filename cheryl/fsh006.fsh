42XFORMAT01:Peak V2(301)   All Other Modules    06-Jun     6 1984       
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 5-6
     Prt: 06-Jun-84  13:57                                       Rtn F!Decompose

         if (gtjfn(Tst, (bit(12) lor bit(17))) = -1) then
     
           ! Parse-only gtjfn to verify the legitimacy of what we've got.
           ;
     
           goto SBad;
           
         Dev      _ LDev;
         UserName _ LUserName;
         File     _ LFile;
         Ext      _ LExt;
         Gen      _ LGen;
         Alias    _ LAlias;
         Switches _ LSwitches;
     
     !    print
         (
           "Dev: (", Dev, ")", crlf,
           "UserName: (", UserName, ")", crlf,
           "File: (", File, ")", crlf,
           "Ext: (", Ext, ")", crlf,
           "Gen: (", Gen, ")", crlf,
           "Alias: (", Alias, ")", crlf,
           "Switches: (", Switches, ")", crlf
         );
     
         return(true);
     
     
       SBad:
           ! Oops - something smells funny ;
     
         UserName _ File _ Ext _ Gen _ Alias _ Switches _ null;
     
         return(false);
     end "F!Decompose"; |2|
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 6-1
     Prt: 06-Jun-84  13:57                                           Rtn F!Parse

     
     ! Parse and sanctify a file name, returning a kosher-processed version of
     ! the input string, to be used by the caller for approved purposes.
     ;
     
     internal string procedure F!Parse(string FName);
     begin "F!Parse" |2|
       string
         JfnStr,
         Dev,
         Usr,
         Fn,
         Ext,
         Gen,
         Dummy;
     
       if (not F!Decompose(FName, Dev, Usr, Fn, Ext, Gen, Dummy, Dummy)) then
         return(null);
     
       JfnStr _ null;
     
       if (length(Dev)) then
         appnd(JfnStr, Dev & ":");
     
       if (length(Usr)) then
         appnd(JfnStr, "<" & Usr & ">");
     
       appnd(JfnStr, Fn);
     
       if (length(Ext) or length(Gen)) then
       begin |3|
         appnd(JfnStr, "." & Ext);
     
         if (length(Gen)) then
           appnd(JfnStr, "." & Gen);
       end; |3|
     
       return(JfnStr);
     end "F!Parse"; |2|
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 7-1
     Prt: 06-Jun-84  13:57                                            Rtn F!Writ

     
     ! Write the current Buffer to the specified Text file.
     ;
     
     internal boolean procedure F!Writ (string FName);
     begin "F!Writ" |2|
       if (FName = null) then
         FName _ B!File;
     
       if (not B!WriteTextFile(FName)) then
         return(false);
     
       W!FixS;
       return(true);
     end "F!Writ"; |2|
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 8-1
     Prt: 06-Jun-84  13:57                                            Rtn F!Scan

     
     ! Look at a command-line filespec and decide whether it is ok or not. In
     ! general, a filespec can be OK or have a BAD FILESPEC or have BAD
     ! SWITCHES.
     ;
     
     forward simple boolean procedure SetSwitches (string Switches);
     
     internal simple integer procedure F!Scan (string FName);
     begin "F!Scan" |2|
       string
         Dummy,
         Sw;
       define
         F.OK           = 0,
         F.BAD.SWITCH   = 1,
         F.BAD.FILESPEC = 2;
     
       if (not F!Decompose(FName, Dummy, Dummy, Dummy, Dummy, Dummy,
           Dummy, Sw)) then
         return(F.BAD.FILESPEC);
     
       if (length(Sw) and not SetSwitches(Sw)) then
         return(F.BAD.SWITCH);
     
       return(F.OK);
     end "F!Scan"; |2|
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                           Page 9-1
     Prt: 06-Jun-84  13:57                                         Rtn Elsewhere

     
     ! Give the luser somehwere else to go ...
     ;
     
     simple procedure Elsewhere;
     begin |2|
       runprg("Ps:[Emacs]Teco.Exe", 0, false);
                                             ! Run Teco in this fork,
                                             ;
       exit;                                 ! Just in case.
                                             ;
     end; |2|
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                          Page 10-1
     Prt: 06-Jun-84  13:57                                      Rtn SanctifyUser

     
     ! Verify the user's rights of passage.
     ;
     ! <<  Can we tell the pedigree of both caller and program on T20?
     !     Probably not.
     ;
     
     simple procedure SanctifyUser;
     begin |2|
     end; |2|
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                          Page 11-1
     Prt: 06-Jun-84  13:57                                          Rtn DoRescan

     
     ! Pick up and return the contents of the legendary ReScan Buffer.
     ;
     
     simple string procedure DoRescan;
     begin "DoRescan" |2|
       integer
         Byte,                               ! A character temporary.
                                             ;
         RescanBytes;                        ! The number of bytes in the
                                             ! ReScan Buffer.
                                             ;
       string
         Str;                                ! We form our reply in this
                                             ! string.
                                             ;
     
       start!code |3|
         setz        1,;
         rscan;
           setz      1,;
         movem       1, RescanBytes;
       end; |3|
     
       Str _ null;
     
       while (RescanBytes) do
       begin |3|
         start!code |4|
           movei     1, -1;
           bin;
           movem     2, Byte;
         end; |4|
     
         appnd(Str, Byte);
         decr(RescanBytes);
       end; |3|
     
       while (length(Str) and (Str[inf for 1] <= " ")) do
         Str _ Str[1 to inf - 1];
     
         ! Lop garbage off the end of Str.
         ;
     
       return(Str);
     end "DoRescan"; |2|
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                          Page 12-1
     Prt: 06-Jun-84  13:57                                       Rtn SetSwitches

     
     ! Analyse the specified switch string, set the appropriate global
     ! switches, and return true if all went well.
     ;
     
     simple boolean procedure SetSwitches (string Switches);
     begin "SetSwitches" |2|
       integer
         BC,                                 ! Suprizingly useful.
                                             ;
         C;
       string
         S;
     
       set(G!RNulls);
     
         ! Remove nulls from the Text file automatically by default.
         ;
     
       F!Page _
       F!Line _
       F!Char _ 0;
       C _ lop(Switches);
     
       while (true) do
       begin "get switch" |3|
         if (not (C = "/" or C = "%")) then
           done "get switch";
     
         if (Switches <= " ") then
           done "get switch";
     
         S _ null;
     
         while (length(Switches)) do
         begin "switch" |4|
           if not (C!Tab[Switches] land IsAlpha) then
             done "switch";
     
           appnd(S, lop(Switches));
         end "switch"; |4|
     
         if (kequ(S, "Nulls"[1 for length(S)])) then
           clear(G!RNulls)
         else if (kequ(S, "READ"[1 to length(S)])) then
           F!Lock _ -1
         else if (kequ(S, "RPG"[1 to length(S)])) then
           F!RPGFlag _ true
         else if (kequ(S, "P")) then
           F!Page _ intscan(Switches, BC)
         else if (kequ(S, "L")) then
           F!Line _ intscan(Switches, BC)
         else if (kequ(S, "C")) then
           F!Char _ intscan(Switches, BC)
         else if (length(S)) then
           return(false);
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                          Page 12-2
     Prt: 06-Jun-84  13:57                                       Rtn SetSwitches

     
         C _ lop(Switches);
       end "get switch"; |3|
     
       return(true);
     end "SetSwitches"; |2|
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                          Page 13-1
     Prt: 06-Jun-84  13:57                                             Rtn F!Rpg

     
     ! Determine the credentials of the user, the editor, and the invocation.
     ;
     
     internal simple procedure F!Rpg;
     begin "F!Rpg" |2|
       integer
         C;                                  ! A character temporary.
                                             ;
       string
         ReScanLine,                         ! A local copy of the contents of
                                             ! the ReScan line.
                                             ;
         Verb;                               ! The first token of the command
                                             ! line should be a 
                                             ;
     
       SanctifyUser;
     
       F!ReScanLine _
       ReScanLine   _ DoReScan;
     
       Verb _ null;
     
       while (length(ReScanLine)) do
         if ((C _ lop(ReScanLine)) > " ") then
           done;
     
       while (length(ReScanLine)) do
       begin |3|
         if ((C _ lop(ReScanLine)) = " ") then
           done;
     
         appnd(Verb, C);
       end; |3|
     
       if (not length(ReScanLine)) then
       begin |3|
         F!Name  _ "NoName.Txt";
         F!Alias _ null;
         return;
       end; |3|
     
       begin |3|
         string
           Alias,                            ! Magnum Alias.
                                             ;
           Dev,                              ! Device Name.
                                             ;
           Ext,                              ! File Extension.
                                             ;
           Gen,                              ! File Generation count.
                                             ;
           FName,                            ! File Name.
                                             ;
           Switches,                         ! User-specified switches.
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                          Page 13-2
     Prt: 06-Jun-84  13:57                                             Rtn F!Rpg

                                             ;
           User;                             ! File's Username
                                             ;
     
         if (F!Decompose(ReScanLine, Dev, User, FName, Ext, Gen, Alias,
             Switches)) then
         begin |4|
           if (not SetSwitches(Switches)) then
           begin |5|
             print(ReScanLine, " [bad switches]", crlf);
             exit;
           end; |5|
     
           F!Name  _ MakeFName(Dev, User, FName, Ext, Gen);
           F!Alias _ Alias;
         end |4|
         else
         begin |4|
           print(ReScanLine, " [bad command line]", crlf);
           exit;
         end; |4|
       end; |3|
     end "F!Rpg"; |2|
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                          Page 14-1
     Prt: 06-Jun-84  13:57                                      Rtn F!FileExists

     
     ! Determine whether a specified file exists.
     ;
     
     internal simple boolean procedure F!FileExists (string FName);
     begin "F!FileExists" |2|
       integer
         F!Chan;
       define
         ForInput = 0;
     
       if (not length(FName)) then
         return(false);
     
       F!Chan _ gtjfn(FName, ForInput);
     
       if (not !skip!) then
       begin |3|
         rljfn(F!Chan);
         return(true);
       end; |3|
     
       return(false);
     end "F!FileExists"; |2|
     Cre: 02-Apr-84  15:31  (PEAKX)XXFILE.SAI                          Page 15-1
     Prt: 06-Jun-84  13:57                                            Rtn F!Init

     
     ! Initialize the file I/O module.  (This assumes that F!Rpg has already
     ! been invoked, and that F!Name & Co. are set up.)
     ;
     
     internal procedure F!Init;
     begin "F!Init" |2|
       if (not B!CreateChkPntFile(F!Name, F!Alias, F!Page, F!Line,
           F!Char)) then
         exit;
     
       if (F!FileExists(F!Name)) then
         B!Lock _ F!Lock
       else
         W!Msg("New File");
     
       B!ModP _ false;
     end "F!Init"; |2|
     end "DED - File I/O"; |1|
     
     
     ! *************************  End of XXFile.Sai  ************************* ;

+`c