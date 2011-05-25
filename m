From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Wed, 25 May 2011 18:57:07 +0000
Subject: Re: [PATCH] fbmem: fix race condition between
Message-Id: <20110525205707.12abc68c@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306266871-12464-1-git-send-email-lxnay@sabayon.org>
	<20110524224545.08c53b1d@neptune.home>
	<20110525181917.12cf97b8@neptune.home>
	<BANLkTimxi-LZFzwv=z6RRBCX098hr-ViUg@mail.gmail.com>
	<20110525204648.58983270@neptune.home>
	<BANLkTi=207-bVi3pnOWk7zG61u4=YU4GFg@mail.gmail.com>
In-Reply-To: <BANLkTi=207-bVi3pnOWk7zG61u4=YU4GFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Fabio Erculiani <lxnay@sabayon.org>
Cc: linux-fbdev@vger.kernel.org, lethal@linux-sh.org, linux-kernel@vger.kernel.org

On Wed, 25 May 2011 Fabio Erculiani <lxnay@sabayon.org> wrote:
> On Wed, May 25, 2011 at 8:46 PM, Bruno Pr=C3=A9mont wrote:
> > On Wed, 25 May 2011 Fabio Erculiani <lxnay@sabayon.org> wrote:
> >> I'm not a fbdev expert. So I leave the real fix to real men ( ;-) ).
> >> It is causing deadlock during boot, so I would consider it quite criti=
cal.
> >> Users using any fb driver will get into troubles.
> >> The workaround is to boot with vga=3Dnormal.
> >
> > What is your system doing during boot? I've never seen it here but maybe
> > my boot sequence is too simple.
>=20
> I'm using vesafb and vgay1. It is quite simple to reproduce.
> Also see: http://bugs.gentoo.org/show_bug.cgi?id68109

Looks like gentoo kernel, might be splash is related to the hang

> > Could you tell if it deadlocks before init gets started or afterwards,
> > which fb drivers (and extra kernel patches if any) are in use.
>=20
> Exactly when register_framebuffer() is called, in my case, early in
> the boot phase, before init.
>=20
> >
> > If you have the complete backtrace of the deadlocked processes it would
> > help getting a better idea of what is affected and how (and why just the
> > framebuffer's lock is not causing trouble with earlier kernel versions).
>=20
> Because that code got a HUGE rewrite in the latest cycle, where
> registration_lock has been introduce.
> Just make a diff between 2.6.38 and 2.6.39. It will be easy to see
> that SO MANY lines have changed ;-)
> Anyway, since I'm out of office these days, I won't be able to send
> you the traceback this week, but since so many people have run into
> it, I guess it's fairly simple to reproduce.

Rewrite was not so huge, and I'm not affected here (running with KMS
compiled in though and vanilla kernel).
Probably the cause is related to one of the extra patches provided by
Gentoo and subscribing to framebuffer registration notifications.

Will have a look.

Bruno
