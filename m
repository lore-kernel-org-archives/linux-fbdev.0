From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: RE: Is framebufer driver a replacement for video driver?
Date: Fri, 5 Nov 2004 11:37:18 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348111ECB33@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPxDB-0003ak-7u
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 22:04:37 -0800
Received: from [202.125.86.130] (helo=ns2.astrainfonets.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPxDA-0001Xg-0I
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 22:04:37 -0800
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
To: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net
Cc: tonnerre@thundrix.ch


Hi Adaplas,

> > I have a small query. I may be silly, but please help by make it
clear.
> >
> > Framebuffer definition :-
> >
> > The frame buffer device provides an abstraction for the graphics
> > hardware. It represents the frame buffer of some video hardware and
> > allows application software to access the graphics hardware through
a
> > well-defined interface, so the software doesn't need to know
anything
> > about the low-level (hardware register) stuff.
> >
> > Does a framebuffer driver directly interact with the hardware
registers
> > of the video card?
> Yes.
>
> > 					or
> >
> > Is there a generic low level driver that will interact with the
> > hardware?
>=20
> Yes and No. Yes, because there are platform drivers that may work with
> many cards (VESA, VGA16, OF).  You can consider them as generic.

Are you talking about the vesafb driver? this being  a generic driver,
Will this driver work on any video card?=20
If a card is VESA 2.0 complaint, is there a generic framebuffer driver
that will work on it?=20

I assume VESA 2.0 standards will define hardware registers.

> However, the hardware specific specific driver will work only with a
> particular chipset.

What chages from framebuffer driver to framebuffer driver?
I think its just hardware accessing.

> >
> > What happens when I say startx at command prompt with XF86Config-4
file
> > configured for framebuffer driver?
> >
> > Is it like, When I say startx with XF86Config-4 file configured for
> > framebuffer driver, the video we get is a result of X server using
the
> > framebuffer driver directly? Right?
> >
>=20
> Yes.
>=20
> > In this case, Is there a video driver involved in getting the video
> > apart from the framebuffer driver?
> >
>=20
> The framebuffer driver itself touches the hardware, and usually it's
one
> driver per chipset.  However, the interface that is used by the
> application
> is standard.

Let's make this clearer.
The video I get after startx is running just on framebuffer driver?
There is no other video driver involved in the running video.right?


Thanks for ur response.

Regards,
Mukund jampala



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
