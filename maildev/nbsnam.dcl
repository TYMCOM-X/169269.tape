comment
! external declarations for NBSNAM ;

external Name!pointer procedure CVNList( string S );
external string procedure CV0List( Name!pointer N );
external Name!pointer procedure NLConcat( Name!pointer N1, N2 );
external procedure NLCombine( reference Name!pointer N1, N2 );
external procedure InitAliasList;
external boolean procedure IsAlias( String UserName );
external integer procedure CVPPN( string UserName );
external procedure ExpandNames( Name!pointer N );
  