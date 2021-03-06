Message 115   498  4 Mar 82  UNSEEN
From: WRS at OFFICE-2 (William R. Soley)
To: gobbel at PARC
Subject: date expressions


We are starting to work on PERP finally.  Could you send me a
copy of the documentation and any interesting code from the stuff
you did after the REMIND stuff I gave you a few months ago.
Would greatly appreciate it.

-Bill
Message 118  1813  4 Mar 82  
Mail from PARC-MAXC rcvd at 4-Mar-82 1846-PST
From: Gobbel at PARC-MAXC
Subject: Re: date expressions
In-Reply-To: Your message of 4 Mar 1982 1755-PST, <[OFFICE-2] 4-Mar-82 17:55:41.WRS>

Funny you should ask about that - I've just been thinking about
getting back to it.

The REMIND stuff turned out to be full of gross and disgusting
bugs.  If you examine its documentation and code carefully,
you'll discover that there are all sorts of totally nonsensical
things that you can say to it, and it will go ahead and
cheerfully give you garbage results, without complaining.  It
gets a lot of mileage out of the fact that most people will never
try to do that.  What's worse is that there are also lots of
things that you WOULD like to be able to tell it, but that it
won't let you do, but that it LOOKS like you could do from a
cursory look at the documentation.  There also turns out to be a
lot of genuine honest-to-god ambiguity in the grammar, etc.,
etc., etc.

So I ended up redoing almost all of it.  I have the whole thing
coded and half debugged, so I'll send you a) the grammar, b) the
program that prints a parsed date expression, c) the expression
compiler, d) the scanner.  The hard part, and the part that's not
fully debugged, is the interpreter, but it probably wouldn't be
of much use anyway without an explanation.  We could get together
sometime and talk about it - it's pretty simple once you've got
the basic idea, but the algorithm I finally came up with has
ZILCH to do with the way REMIND's interpreter works.

I'll store the stuff on your directory on Office-2.  The files
are:

grammar: PhoenixTable.grammar printer: DatePrinter.mesa compiler:
PhoenixCompile.mesa scanner: PhoenixScanner.mesa

        -Randy
Message 119  2253  4 Mar 82  
Mail from PARC-MAXC rcvd at 4-Mar-82 1922-PST
From: Gobbel at PARC-MAXC
To: WRS at OFFICE-2
Subject: Date expressions

On second thought, here's the interpreter too, since it's the
most interesting part of the thing.  The file is
PhoenixUtil.mesa.  Bear in mind that it's not debugged, and that
I left off working on it halfway through converting from dates
expressed in seconds to dates expressed in days.  The really
hairy part of it is in EvalDispl, which handles things like "3
days before the 9th Wednesday after the 7th full moon before June
7th" and so on.  The problem is that some displacement
expressions don't have a simple one-to-one mapping between start
date and target date.  It's easy enough to manage if you just
take a base date and compute successive offsets from that to come
up with AN instance of a day that matches the expression, but
usually what you're trying to do is take today (or some specific
day) and see if it satisfies a particular expression, which isn't
quite so simple.  The solution I came up with is to generate, at
each step, a "window" of new targets for the next level of the
displacement.

Example: say our expression is "2 weeks before the 3rd Wednesday
after the ninth day before 3 weeks after June 7th".  Starting
from today, we first go forward 2 weeks.  If it's not Wednesday,
fail.  NOW, the interesting part: the 3rd Wednesday before
<mumble> will work for all six days after 3 weeks before the
Wednesday we're at now.  So we now have a "window" six days wide,
and ANY day that falls within that window will satisfy our
expression at this point.  So at the next stage of the
evaluation, we check to see if any of the days in the window is a
full moon.  If none are, fail, otherwise throw out all but the
day that is a full moon, and generate a window 28 days wide for
the next stage.  If we now move our window forward 7 moons, and
see that June 7th falls anywhere within the 28-day window, then
the expression succeeds.

Anyway, that's the guts of it - all the other stuff is pretty
straightforward.  If I get a chance to work on it, I could
probably get it back to a demo-able state fairly quickly....

        -Randy
Message 145   589  9 Mar 82  UNSEEN RECENT
From: WRS at OFFICE-2 (William R. Soley)
To: Gobbel at PARC-MAXC
Subject: Re: date expressions
In-Reply-To: Your message of  4-Mar-82 18:45:23 PST (Thursday)

Thanks very much!  I'll take a look at everything and if it
sounds like it would be helpful to talk about it we might get
together with Dave (the guy who'll be doing the code) over lunch
sometime soon.  I'll let you know.

Thanks again.  -Bill
 