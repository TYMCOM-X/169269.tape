- 5 -
Posted: February 28, 1983 09:52
To:   Carl
From: ADELE:930
Re:   MFDSCN.DOC

I took a brief look at MFDSCN.DOC.  I think the parameter info. is there --
it could be expanded, but I don't think it's worth it, especially now.  What
I don't see is an explanation of the file LOOKUP modes and defaults.  Do you
get UPDATE if you ask for output buffers? or what?  A BRIEF explanation is
worth putting in.  		/Thanks, Adele

- 6 -
Posted: March 27, 1983 17:52
To:   txs
From: CARL:930
Re:   (SPL)FINDIT.SAV

There is a "new" version of FNDFIL called FINDIT.  In addition to the
stuff FNDFIL used to print, FINDIT also prints file size and protection.

It accepts file specs separated by commas, single wildchar of ? and #,
wild remainder of field using *, usernames "or" PPNs, wildcard ? in PPNs
and maybe one day switches.

It is "as fast" as FNDFIL when searching the entire disk, and much
faster when specific directories or ppn wildcards are used.

If no username or ppn is specified, the default is the entire disk!
/Carl.

- 7 -
Posted: July 6, 1983 10:39
To:   Carl
From: ADELE:930
Cc:   Adele
Re:   Tops-20 Stream Scanner Proposal

I took a look at the stream scanner proposal.  It sounds very promising.
However, I need clarification on a couple of things.
  1.  Clue me in on the signficance of your reminder (1st paragraph).
  2.  Do you propose to read raw data into the relations on a routine
      basis, and keep the MAGNUM relations around for a while?  (That's the
      way I'm reading it.)

Anyway, what's needed at this point is a more detailed design which gets us
to the point where the schema and relations can be defined.  I think Vivian
could work on the templates for the stream record types if she has a clear
explanation of what she is doing and has supervision.

When we are both in this afternoon, let's talk briefly about what is on your
stack and how you feel about having this project and product list project
going simultaneously.

Before we get around to the schema and relations, the design should expand
to answer the following questions:
  1.  How will the sections of the scanner interact?
  2.  How will a user use it?  (To know this, you need to know what kind
      of information to keep and make available.)
  3.  Have a rough design of a report generator (probably an interactive one
      on the order of SCREAM.
Please be thinking about how long it will take you to get the design worked
out.

We can assume as an objective for now that we will have a scanning tool with
a simple report procedure.  This can be built upon.  So we are looking at
your phases 1-4 for the moment.

  