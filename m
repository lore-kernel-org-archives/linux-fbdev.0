From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 15 Jan 2013 18:41:40 +0000
Subject: Re: fb: Rework locking to fix lock ordering on takeover
Message-Id: <20130115184140.3c8fcdd2@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+icZUVJ5hbPJvV4LMFGgD3Sto5=EV=MO9nutYdJwkiRrmpNJQ@mail.gmail.com>
In-Reply-To: <CA+icZUVJ5hbPJvV4LMFGgD3Sto5=EV=MO9nutYdJwkiRrmpNJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sedat.dilek@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

> A disappeared/busy/not-answering maintainer is not an excuse for
> handling serious regressions (even here in this case there are fixes
> around),

It's *not* a regression - that's the horrible bit. If it was a regression
we'd just back the changes out, wait for (or switch) maintainer and be
happy a release later.

Its a piece of terrible design that is years old and a bug that is at
least two years old which caused random hangs on Fedora boxes during boot
up and so on for several releases. What has happened is Daniel's changes
made the bug *visible* as it's now lockdep splatted and can thus be
analyzed and worked upon.

We are pretty good at regression squashing because you can just rewind a
bit, and try again later. In this case rewinding the lockdep splat
simply turns it back into random silent hangs.

> Personally, I am still missing a mei-driver fix [2] and a libata-dev fix [3].
> Both issues are not new to the maintainers.
> Not sure if shouting louder is the best strategy here.

Really its a kernel summit question. IMHO we ought to have a policy
that anything of any relevance has *two* maintainers or more. That way
there is always someone to help pick a new maintainer if one drops out
and we are mostly not at the mercy of real world happenings. We also need
to be much more active in giving maintainers the boot if they vanish (and
having two maintainers will balance the effect nicely).

In practice I think most maintainers can offhand name the person they'd
pick to replace them, so they can pretty easily switch to two maintainers.

> It would be great to have a place like a "board of arbitration" where
> someone can send blames.

There is a ton of stuff in bugzilla including fixes for some years old
stuff (eg bluetooth on some dongle types that broke in 2.6.3x). It's not
a case of inventing bodies to handle stuff, it's a case of two things

- people getting off their backsides to fix it
- enabling those people to get the job done

Finger pointing statistics and shame lists such as Rafael did are just
tools to help. At the end of the day its about people doing stuff.

Alan
