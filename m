From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Fri, 26 Feb 2010 11:37:21 +0000
Subject: Re: [PATCH] Add sysfs support for fbdefio delay
Message-Id: <20100226123721.77cadd07@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201002252215.o1PMFnoP011425@mustang.cs.nmsu.edu>
	<45a44e481002251830j710e87bah52486a489eef04cb@mail.gmail.com>
	<20100226115305.3dcc1f5a@neptune.home>
	<45a44e481002260309of5b51c9t79302ec5fa132b9e@mail.gmail.com>
In-Reply-To: <45a44e481002260309of5b51c9t79302ec5fa132b9e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, linux-kernel@vger.kernel.org, npavel@ituner.com, tomi.valkeinen@nokia.com, tony@atomide.com, FlorianSchandinat@gmx.de, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, jkosina@suse.cz

On Fri, 26 February 2010 Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Fri, Feb 26, 2010 at 6:53 PM, Bruno Pr=C3=A9mont wrote:
> > For me the driver would start with a default delay that matches the
> > full-redraw throughput of the device but userspace could reduce the
> > delay when it knows it will mostly just refresh small parts of the
> > display (one or two tiles) and would like those done at a higher
> > rate.
>=20
> Who in userspace will know to reduce the delay? How will it know that
> the delay should be reduced?

The default (maybe even the largest) period would indicate what the
hardware can do in worst case and the smallest period what the hardware
can do in best/special cases (like single-tile update for PicoLCD)

Any application that wants to output information might want to know
how often the information can be displayed (what's the need to
calculate 1000 frames per second if only 2 of them will ever be seen
on display?). When possible and they know their display needs they
might benefit from ability to tune the result.

> > A sample application would be displaying a media player interface
> > like the one of XMMS and clones where Umeter (the part displaying
> > volume per frequency range) could be refreshed ten times a second,
> > the current position once a second and all the rest only on song
> > change.
>=20
> xmms/umeter will talk to this sysfs entry?

Probably not XMMS itself but either a plugin for it or a human
interface to player that takes input from a remote control and
displays status to LCD (instead of/in addition to OSD)

> > Knowing the size of the display, probability that it's being used
> > directly by X server is very small, it would rather be some
> > application using it as a sideport display.
> >
>=20
> Yes, I'd like to know which applications these are.

I don't have an example at hand. I would rather see plugins for media
players (like those that use LCD4Linux or LCDproc) benefit from such
a feature.

Thanks,
Bruno
