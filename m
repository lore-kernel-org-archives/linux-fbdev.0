From: Ondrej Zary <linux@rainbow-software.org>
Date: Fri, 26 Aug 2011 06:24:38 +0000
Subject: Re: [RFC PATCH v2] Resurrect Intel740 driver: i740fb
Message-Id: <201108260824.38352.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201108212242.12717.linux@rainbow-software.org> <CAPM=9tzF7C_gW44csqYwK+wdT9mwWBrA3O_9JQNfg=6aip4kag@mail.gmail.com>
In-Reply-To: <CAPM=9tzF7C_gW44csqYwK+wdT9mwWBrA3O_9JQNfg=6aip4kag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On Tuesday 23 August 2011, Dave Airlie wrote:
> On Sun, Aug 21, 2011 at 9:42 PM, Ondrej Zary <linux@rainbow-software.org>=
=20
wrote:
> > Hello,
> > this is an v2 attempt to resurrect an old (like 2.4.19) out-of-tree
> > driver for Intel740 graphics cards and modify it for recent kernels. The
> > old driver is located at:
> > http://sourceforge.net/projects/i740fbdev/files/
> >
> > It was easier to create a new driver based on skeletonfb, using most of
> > the low level HW code from the old driver. The DDC code is completely
> > new.
> >
> > The driver was tested on two 8MB cards: ManLi and Diamond Stealth II G4=
60
> >
> > The i740_calc_fifo() function formatting is nice but does not pass
> > checkpatch. Making it checkpatch-compliant makes the code look ugly. How
> > to make it both nice and compatible with Linux coding style?
> > (the remaining // comments mark things that need attention - missing xp=
an
> > and suspend/resume)
> >
> > Changes in v2:
> > - fixed 15bpp (16bpp 555) mode
> > - not working 1280x1024-32 is not a bug but card's feature, it's now
> > handled correctly by the driver
> > - 24bpp modes still don't work in fbtest but it looks like fbtest bug!
> >
> > Is there any better way to test fb drivers than fbtest?
> >
> > no signed-off-by yet
> >
> > --- linux-2.6.39-rc2-orig/drivers/video/Kconfig 2011-04-06
> > 03:30:43.000000000 +0200 +++ linux-2.6.39-rc2/drivers/video/Kconfig =A0=
 =A0
> > =A02011-07-30 11:34:10.000000000 +0200 @@ -1117,6 +1117,17 @@ config
> > FB_RIVA_BACKLIGHT
> > =A0 =A0 =A0 =A0help
> > =A0 =A0 =A0 =A0 =A0Say Y here if you want to control the backlight of y=
our display.
> >
> > +config FB_I740
> > + =A0 =A0 =A0 tristate "Intel740 support (EXPERIMENTAL)"
> > + =A0 =A0 =A0 depends on EXPERIMENTAL && FB && PCI && X86_32 && AGP_INT=
EL
> > + =A0 =A0 =A0 select FB_MODE_HELPERS
> > + =A0 =A0 =A0 select FB_CFB_FILLRECT
> > + =A0 =A0 =A0 select FB_CFB_COPYAREA
> > + =A0 =A0 =A0 select FB_CFB_IMAGEBLIT
> > + =A0 =A0 =A0 select VGASTATE
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 This driver supports graphics cards based on Intel740=
 chip.
> > +
>
> It shouldn't need AGP_INTEL, as its an AGP card not an integrated
> chipset, it might need just AGP.

Oops, I copied that from I810 and then forgot about it...will fix that to=20
really match the driver requirements.

BTW. i740 cards are really picky, they don't even POST with most boards tha=
t=20
don't have i440LX/EX or i440BX/ZX chipsets.


--=20
Ondrej Zary
