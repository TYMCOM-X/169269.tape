comment
! external ddeclarations for NBSXMT ;

external procedure NBSXmit (Name!pointer ToWho; NBS!pointer Msg);

external procedure Archive (NBS!pointer Msg; string FileName);

external integer procedure NBSRecieve (string MailBoxName);
    