/* title Mdl Util */
/**************************************************************************
*                                                                         *
*                               Module Util                               *
*                                                                         *
***************************************************************************

        Picture a bunch of really helpful and really wonderful
        utilities written in the language you are currently using.
        Imagine they have cute names, and friendly profiles.

        Instead, we offer the following:

**************************************************************************/

  #include
    "B:C.H"


/*************************************************************************/
/* title Rtn error  */
/**************************************************************************
*									  *
*                                Rtn error                                *
*									  *
***************************************************************************

                           error (Msg, Severity)

        Print a helpful or insulting message, and if the error
        severity is too bad, exit to the exec (if any).

**************************************************************************/

  error (Msg, Severity)
  char
    *Msg,
    Severity;
  {
    printf("?? %s\n", Msg);

    if (Severity == ERR_FATAL)
      exit(Severity);
  }

/*************************************************************************/
/* title Rtn PromptUser  */
/**************************************************************************
*									  *
*                             Rtn PromptUser                              *
*									  *
***************************************************************************

                   PromptUser (Prompt, Buffer, Silently)

        Print the prompt and return a pointer to the User's reply.
        If the boolean Silently is true, do not echo the response
        as you receive it.

**************************************************************************/

  char *PromptUser (Prompt, Buffer, Silently)
    char
      *Prompt,
      *Buffer,
      Silently;
  {
    if (! Buffer) 
      if ((Buffer = malloc(maxlinelength + 1)) == 0) 
        error("Buffer Allocation Error in Prompt User", ERR_FATAL);

    while (true)
    {
      outs(Prompt);

      if (GetString(Buffer, maxlinelength, Silently) == 0)
        error("Line Too Long", ERR_NONFATAL);
      else
        break;
    }
    
    return Buffer;
  }

/*************************************************************************/
/* title Rtn GetString  */
/**************************************************************************
*									  *
*                              Rtn GetString                              *
*									  *
***************************************************************************

                   GetString (Buffer, BufLen, Silently)

        Input a string from the TTY and place it in Buffer (whose
        length is BufLen), providing echo if Silently is true, and
        return the length of the string.

**************************************************************************/

  int GetString (Buffer, BufLen, Silently)
  char
    *Buffer;
  int
    BufLen;
  char
    Silently;
  {
    if (Silently)
    {
    }
    else
    {
      return _gets(Buffer, BufLen);
    }
  }

/*************************************************************************/
/***************************  End Module Util  ***************************/
  