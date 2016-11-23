From: Adam Borowski <kilobyte@angband.pl>
Date: Wed, 23 Nov 2016 17:33:40 +0000
Subject: Re: [PATCH v5 2/2] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20161123173340.GA24872@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161118005309.GC26324@dell-m4800.home>
 <1479679088-3015-1-git-send-email-manuel.schoelling@gmx.de>
 <1479679088-3015-3-git-send-email-manuel.schoelling@gmx.de>
 <20161121201704.GA29655@angband.pl>
 <1479833802.19820.8.camel@gmx.de>
In-Reply-To: <1479833802.19820.8.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrey_utkin@fastmail.com

On Tue, Nov 22, 2016 at 05:56:42PM +0100, Manuel Sch=F6lling wrote:
> On Mo, 2016-11-21 at 21:17 +0100, Adam Borowski wrote:
> > On Sun, Nov 20, 2016 at 10:58:08PM +0100, Manuel Sch=F6lling wrote:
> > > Add a scrollback buffers for each VGA console. The benefit is that
> > > the scrollback history is not flushed when switching between consoles
> > > but is persistent.
>=20
> > But alas, this commit breaks that very \e[3J.  It does only a \e[2J, le=
aving
> > the scrollback uncleared.  For comparison, both mainline and with just =
your
> > preparatory commit, \e[3J works as expected.
> Really? All my tests worked fine: I compiled the kernel with the latest p=
atches, started the kernel in QEMU and then did
>=20
>   $ openvt /bin/sh
>   $ echo -e '\e[3J' # scrollback buffer was flushed correctly
>   $ chvt 2
>   $ echo -e '\e[3J' # scrollback buffer was flushed correctly
>=20
> Can you tell me how you tested it? Maybe I can reproduce the bug.

(Re-tested on v6 of the patch.)

On bare metal: boot, log in on tty1, printf '\e[3J', screen clears but when
I scroll back, it still has bootup messages.  Switching to another tty then
back obviously doesn't clear it either.  Same on any other tty (after
putting something into the scrollback of).  Graphics card is nvidia GT240,
neither proprietary driver nor nouveau loaded; nouveau forces fbdev and your
patch is vgacon specific (hopefully just for now).

But then, I just reproduced this on qemu (-vga qxl) too, so it might be due
to a difference between our setups somehow.  In case it's something related
to .config, mine's at https://angband.pl/tmp/config-4.9.0-rc6-debug2+.xz


Meow!
--=20
An imaginary friend squared is a real enemy.
