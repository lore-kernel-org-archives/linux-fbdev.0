From: Ondrej Zary <linux@rainbow-software.org>
Date: Tue, 23 Aug 2011 09:58:18 +0000
Subject: Re: [RFC PATCH v2] Resurrect Intel740 driver: i740fb
Message-Id: <201108231158.18173.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201108212242.12717.linux@rainbow-software.org> <201108231103.30591.linux@rainbow-software.org> <1314091533.21860.289.camel@thor.local>
In-Reply-To: <1314091533.21860.289.camel@thor.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Michel =?utf-8?q?D=C3=A4nzer?= <michel@daenzer.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On Tuesday 23 August 2011, Michel D=C3=A4nzer wrote:
> On Die, 2011-08-23 at 11:03 +0200, Ondrej Zary wrote:
> > On Monday 22 August 2011, Alan Cox wrote:
> > > > - 24bpp modes still don't work in fbtest but it looks like fbtest
> > > > bug!
> > > >
> > > > Is there any better way to test fb drivers than fbtest?
> > >
> > > X11 fbdev driver ?
> >
> > Thanks, completely forgot about that. It works fine even in 24bpp.
>
> Beware that Xorg defaults to 32 bpp for depth 24; did you verify in
> Xorg.0.log that it was really using 24 bpp?

Yes, found that very quickly as I was testing at 1280x1024 and the card can=
not=20
do 32bpp there. I had to set both DefaultDepth and DefaultFbBpp to 24 for X=
11=20
to run.

--=20
Ondrej Zary
