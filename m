From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: RE: Is framebufer driver a replacement for video driver?
Date: Fri, 5 Nov 2004 17:14:10 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348111ECB8A@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ2TC-0001ey-Cl
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 03:41:30 -0800
Received: from [202.125.86.130] (helo=ns2.astrainfonets.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CQ2T9-0000Bg-Px
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 03:41:30 -0800
Content-class: urn:content-classes:message
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net, tonnerre@thundrix.ch


Hi Geert,

Thanks for that.
Please, try to give me more clarity on the framebuffer driver by solving
the below quires?

> > Are you talking about the vesafb driver? This being  a generic
driver,
> > Will this driver work on any video card?
>=20
> Yep, `VESA' means the vesafb driver. It works on any video card with a
> VESA 2.0
> compliant BIOS.

If vesafb module works for any card, what are the situations that make
me write a new framebuffer driver for a new video hardware in the
market?

Is it like, the vesafb driver does not explore the card to the fullest
extent?=20
A framebuffer driver specific to Video card is just to explore the card
features to maximum.

Can u please tell me why to call "scr_readw" in accel.c file of riva
directory doing?
Also, I found NO readl, writel calls in the riva directory( framebuffer
driver). Then, who is responsible for accessing the hardware here?

> > Let's make this clearer.
> > The video I get after startx is running just on framebuffer driver?
> > There is no other video driver involved in the running video.right?
>=20
> For unaccelerated operation, yes.

If accelerated operation is needed, then do we need video driver (nv for
nvidia card) apart from the framebuffer driver to manage the video?

> If you want hardware accelerated drawing operations, the X server
still
> has to
> known how to program the graphics chip. The frame buffer device takes
care
> about setting the video mode and color palette, and mapping video RAM
> only.

My question in this regard is :=20
Is there a video driver involved apart from the framebuffer driver why I
get the video from the startx command?

Ohh, Do u mean, to program the graphics chip in case of accelerated
operations we need a video driver apart from the framebuufer driver?
If so, is framebuffer driver not capable of programming the graphic card
for accelerated operations?


My assumption about framebuffer driver architecture is:

	X SERVER
-----------------
FRAMEBUFFER DRIVER
-----------------
HARDWARE ( VIDEO CARD)
-----------------

Please correct my assumptions if u find them faulty.
Thanks for ur support.

Regards,
Mukund jampala



> > > > Is there a generic low level driver that will interact with the
> > > > hardware?
> > >
> > > Yes and No. Yes, because there are platform drivers that may work
with
> > > many cards (VESA, VGA16, OF).  You can consider them as generic.
> >
> > Are you talking about the vesafb driver? this being  a generic
driver,
> > Will this driver work on any video card?
>=20
> Yep, `VESA' means the vesafb driver. It works on any video card with a
> VESA 2.0
> compliant BIOS.
>=20
> > If a card is VESA 2.0 complaint, is there a generic framebuffer
driver
> > that will work on it?
> >
> > I assume VESA 2.0 standards will define hardware registers.
>=20
> No, it's a BIOS standard. It standardizes how to talk to the BIOS to
set a
> (linear) graphics mode.
>=20
> > > However, the hardware specific specific driver will work only with
a
> > > particular chipset.
> >
> > What chages from framebuffer driver to framebuffer driver?
> > I think its just hardware accessing.
>=20
> Yep. But the way you program the graphics chip may differ a lot among
> different
> graphics chips.
>=20
> > > > What happens when I say startx at command prompt with
XF86Config-4
> > file
> > > > configured for framebuffer driver?
> > > >
> > > > Is it like, When I say startx with XF86Config-4 file configured
for
> > > > framebuffer driver, the video we get is a result of X server
using
> > the
> > > > framebuffer driver directly? Right?
> > > >
> > >
> > > Yes.
> > >
> > > > In this case, Is there a video driver involved in getting the
video
> > > > apart from the framebuffer driver?
> > > >
> > >
> > > The framebuffer driver itself touches the hardware, and usually
it's
> > one
> > > driver per chipset.  However, the interface that is used by the
> > > application
> > > is standard.
> >
> > Let's make this clearer.
> > The video I get after startx is running just on framebuffer driver?
> > There is no other video driver involved in the running video.right?
>=20
> For unaccelerated operation, yes.
>=20
> If you want hardware accelerated drawing operations, the X server
still
> has to
> known how to program the graphics chip. The frame buffer device takes
care
> about setting the video mode and color palette, and mapping video RAM
> only.
>=20
> Gr{oetje,eeting}s,
>=20
> 						Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-
> m68k.org
>=20
> In personal conversations with technical people, I call myself a
hacker.
> But
> when I'm talking to journalists I just say "programmer" or something
like
> that.
> 							    -- Linus
Torvalds
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=3D5588&alloc_id=3D12065&op=3Dclick
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
