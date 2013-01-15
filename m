From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 15 Jan 2013 22:15:57 +0000
Subject: Re: fb: Rework locking to fix lock ordering on takeover
Message-Id: <2134971.95J30N79hk@vostro.rjw.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+icZUVJ5hbPJvV4LMFGgD3Sto5=EV=MO9nutYdJwkiRrmpNJQ@mail.gmail.com>
In-Reply-To: <CA+icZUVJ5hbPJvV4LMFGgD3Sto5=EV=MO9nutYdJwkiRrmpNJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sedat.dilek@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Sunday, January 13, 2013 04:14:38 PM Sedat Dilek wrote:
> Hi Andrew,
>=20
> your patch from [1] - as far as I followed - misses a lot of
> Reported-by#s and Tested-by#s (Boris, Jiri, etc.).
> Just one new R-b I have seen yesterday.
>=20
> I have the original patch from Alan plus the two follow-ups from you
> in my patch-series against v3.8-{rc2,rc3} for quite a while.
> So, please feel free to add a Tested-by.
>=20
> Unfortunately, your patch has introduced some (unwanted) extra chars
> like "_*" (comments only).
> I appreciate one single (new) patch like this, but please in a proper way.

Why don't you prepare such a patch?  I suppose you know everything you need?

> A disappeared/busy/not-answering maintainer is not an excuse for
> handling serious regressions (even here in this case there are fixes
> around),
> Personally, I am still missing a mei-driver fix [2] and a libata-dev fix =
[3].
> Both issues are not new to the maintainers.
> Not sure if shouting louder is the best strategy here.

[2] seems to be in the Greg's tree, so I suppose it's on its way to Linus a=
nd
please note that we're after a several days vacation period and people need=
 to
process their backlogs.

Perhaps just ping the relevant maintainers when 3.8-rc4 is out (and do the =
same
after -rc5 and so on).

> It would be great to have a place like a "board of arbitration" where
> someone can send blames.
> And I remember vaguely Rafael had a nice list of issues (w/ reference
> to patches!).
> This was a real cool helpful innoivation!
> I can't remember why Rafael stopped his nice service to the
> Linux-kernel community.

Because I don't have the time to do that any more.  Yes, it was useful, but=
 it
also was quite a bit of work.  Would you volunteer to do that?

Rafael


> [1] https://patchwork.kernel.org/patch/1969391/
> [2] http://git.kernel.org/?p=3Dlinux/kernel/git/gregkh/char-misc.git;a=3D=
commitdiff;h=E6028db0146cf5a68dbd1508225ea49840997880
> [3] http://patchwork.ozlabs.org/patch/206897/
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
