/* title Mdl Test */
/**************************************************************************
*                                                                         *
*                               Module Test                               *
*                                                                         *
***************************************************************************

        To test your favorite concept.

**************************************************************************/

  #include
    "B:C.H"


/*************************************************************************/
/* title Rtn main  */
/**************************************************************************
*									  *
*                                Rtn main                                 *
*									  *
***************************************************************************

        We want to test the viability of some of the stuff in our
        Utility Module.

**************************************************************************/

  main (argc, argv)
    int
      argc;
    char
      *argv[];
  {
    char
      *Str,
      *Brk,
      BrkChr,
      *BrkOnMatch,
      Dst;
    struct Parse
      *P;

    extern char
      *PromptUser(),
      *AskUser();
    extern struct Parse
      *GetParseRecord();

    P = GetParseRecord;

    while (true)
    {
      Str = PromptUser("\nEnter a string to be spanned: ", Str, false); 
      Brk = PromptUser("Enter the break string: ", Brk, false);

      BrkOnMatch = AskUser("Break on characters in the break string? ",
          null, false);

      BrkChr = SpanCopy(P, Str, Dst, Brk, infinity, BrkOnMatch);

      printf("Source: (%s)\nDst: (%s)\nBrkChr: (%c)\n", Str, Dst,
          BrkChr);

      if (! AskUser("\nAnother round? ", null, false))
        break;
    }
  }

/*************************************************************************/
/**************************************************************************
                              End Module Test
**************************************************************************/
