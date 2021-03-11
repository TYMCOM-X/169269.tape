/* title Mdl SpanCopy */
/**************************************************************************
*                                                                         *
*                             Module SpanCopy                             *
*                                                                         *
***************************************************************************

        The necessary acoutrements to build the spanning string
        copy functionality.

**************************************************************************/

  #include
    "B:C.H"

  struct Parse
  {
    int
      ActLen,
      DstLen;
    char
      BrkChr,
      *Brk,
      EosFlg,
      *OrigSrc,
      *Src,
      *Dst;
    unsigned
      CMsk[WordsPerAsciiBitVector];
  };

  #define EOS_CH  '~'
  #define ERR_CH  '\377'


/*************************************************************************/
/* title Rtn GetParseRecord  */
/**************************************************************************
*									  *
*                           Rtn GetParseRecord                            *
*									  *
***************************************************************************

                             GetParseRecord ()

        Allocate memory for an instance of the Parse Record, and
        return a pointer to it.

**************************************************************************/

  struct Parse *GetParseRecord ()
  {
    return calloc(1, sizeof(struct Parse));
  }

/*************************************************************************/
/* title Rtn FreeParseRecord  */
/**************************************************************************
*									  *
*                           Rtn FreeParseRecord                           *
*									  *
***************************************************************************

                            FreeParseRecord (P)

        Free up a chunk of memory previously obtained from a call to
        GetParseRecord.  A return of 0 (zero) indicates that an
        error has occured.

**************************************************************************/

  int FreeParseRecord (P)
    struct Parse
      *P;
  {
    return free(P);
  }

/*************************************************************************/
/* title Rtn SpanCopy */
/**************************************************************************
*                                                                         *
*                              Rtn SpanCopy                               *
*                                                                         *
***************************************************************************

              SpanCopy (P, Src, Dst, Brk, DstLen, BrkOnMatch)

        If BrkOnMatch is true, copy the left substring of "Src"
        terminated (non-inclusively) by a character in "Brk" to
        "Dst", advance "Src" accordingly, and return the terminating
        character.

        If BrkOnMatch is false, copy the left substring of "Src"
        terminated (non-inclusively) by a character NOT in "Brk" to
        "Dst", advance "Src" accordingly, and return the terminating
        character.

        If the length of said substring exceeds "DstLen", or if the
        end of "Src" is found and the end-of-string character
        (EOS_CH) is not in "Brk", do not perform the copy, do not
        advance "Src", and return ERR_CH.

        (Note that the end-of-string character will be "quoted" if it
        occurs twice in a row in "Brk".  This means that it will also
        count as a break character.)

**************************************************************************/


  char SpanCopy (P, Src, Dst, Brk, DstLen, BrkOnMatch)
    struct Parse
      *P;
    char
      *Src,
      *Dst,
      *Brk;
    int
      DstLen;
    char
      BrkOnMatch;
  {
    int
      I;
    char
      Chr,
      *BPtr;

    if (P == null)
      error("Null P pointer to SpanCopy", ERR_FATAL);

    if (Src == null)
    {
      if (P->Src == null)
        error("Null Src pointer to SpanCopy", ERR_FATAL);
    }
    else
      P->OrigSrc = P->Src = Src;

    if (Dst == null)
    {
      if (P->Dst == null)
        error("Null Dst pointer to SpanCopy", ERR_FATAL);
    }
    else
      P->Dst = Dst;

    if (DstLen == 0)
    {
      if (P->DstLen == 0)
        error("Zero DstLen to SpanCopy", ERR_FATAL);
    }
    else
      P->DstLen = ((DstLen == infinity) ? maxinteger : DstLen);

    if (Brk == null)
    {
      if (P->Brk == null)
        error("Null Brk pointer to SpanCopy", ERR_FATAL);
    }
    else
    {
      P->Brk = Brk;

      for (_setmem(P->CMsk, sizeof(P->CMsk), 0), BPtr = P->Brk,
              clear(P->EosFlg);
          (Chr = *BPtr);
          BPtr++)
      {
        if (Chr == EOS_CH)
          if (BPtr[1] == EOS_CH)
            BPtr++;
          else
          {
            set(P->EosFlg);
            continue;
          }

        P->CMsk[Chr / BitsPerWord] |= bit(Chr % BitsPerWord);
      }
    }

    P->ActLen = 0;

    for (P->BrkChr = '\0', BPtr = P->Src, I = 0;
        (Chr = *BPtr) && I < P->DstLen;
        BPtr++, I++)

      if (P->CMsk[Chr / BitsPerWord] & bit(Chr % BitsPerWord))
      {
        if (BrkOnMatch)
        {
          P->BrkChr = Chr;
          break;
        }
      }
      else if (! BrkOnMatch)
      {
        P->BrkChr = Chr;
        break;
      }

    if (P->BrkChr == '\0' && I == strlen(P->Src) && P->EosFlg)
      P->BrkChr = EOS_CH;

    if (P->BrkChr != '\0')
    {
      P->ActLen = I;
      _move(I, P->Src, P->Dst);
      P->Src += ((P->BrkChr == EOS_CH) ? I : I+1);
    }
    else
      P->BrkChr = ERR_CH;

    return P->BrkChr;
  }


/*************************************************************************/
/* title Rtn Span */
/**************************************************************************
*                                                                         *
*                                  Rtn Span                               *
*                                                                         *
***************************************************************************

                       Span (P, Src, Brk, BrkOnMatch)

        If BrkOnMatch is true, by incrementing "Src", skip over the
        left substring of "Src" terminated (non-inclusively) by a
        character in "Brk" and return the terminating character.

        If BrkOnMatch is false, by incrementing "Src", skip over the
        left substring of "Src" terminated (non-inclusively) by a
        character NOT in "Brk" and return the terminating character.

        If no such substring is found and the end-of-string character
        (EOS_CH) is not in "Brk", return ERR_CH without doing
        anything.

        (Note that the end-of-string character will be "quoted" if it
        occurs twice in a row in "Brk".  This means that it will also
        count as a break character.)

**************************************************************************/


  char Span (P, Src, Brk, BrkOnMatch)
    struct Parse
      *P;
    char
      *Src,
      *Brk,
      BrkOnMatch;
  {
    char
      Chr,
      *BPtr;

    if (P == null)
      error("Null P pointer to Span", ERR_FATAL);

    if (Src == null)
    {
      if (P->Src == null)
        error("Null Src pointer to Span", ERR_FATAL);
    }
    else
      P->OrigSrc = P->Src = Src;

    if (Brk == null)
    {
      if (P->Brk == null)
        error("Null Brk pointer to Span", ERR_FATAL);
    }
    else
    {
      P->Brk = Brk;

      for (_setmem(P->CMsk, sizeof(P->CMsk), 0), BPtr = P->Brk,
              clear(P->EosFlg);
          (Chr = *BPtr);
          BPtr++)
      {
        if (Chr == EOS_CH)
          if (BPtr[1] == EOS_CH)
            BPtr++;
          else
          {
            set(P->EosFlg);
            continue;
          }

        P->CMsk[Chr / BitsPerWord] |= bit(Chr % BitsPerWord);
      }
    }

    for (P->BrkChr = '\0', BPtr = P->Src;
        (Chr = *BPtr);
        BPtr++)

      if (P->CMsk[Chr / BitsPerWord] & bit(Chr % BitsPerWord))
      {
        if (BrkOnMatch)
        {
          P->BrkChr = Chr;
          break;
        }
      }
      else if (! BrkOnMatch)
      {
        P->BrkChr = Chr;
        break;
      }

    if (P->BrkChr == '\0')
    {
      if (P->EosFlg)
      {
        P->BrkChr = EOS_CH;
        P->Src = BPtr;
      }
      else
        P->BrkChr = ERR_CH;
    }
    else
      P->Src = BPtr + 1;

    return P->BrkChr;
  }


/*************************************************************************/
/*************************  End Module SpanCopy  *************************/
