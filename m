From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: Is framebufer driver a replacement for video
 driver?
Date: Fri, 5 Nov 2004 09:53:17 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0411050949530.14575@waterleaf.sonytel.be>
References: <4EE0CBA31942E547B99B3D4BFAB348111ECB33@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPzqa-0004qc-Bt
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 00:53:28 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPzqV-0006FD-4X
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 00:53:28 -0800
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348111ECB33@mail.esn.co.in>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: adaplas@pol.net, tonnerre@thundrix.ch

On Fri, 5 Nov 2004, Mukund JB. wrote:
> > > Is there a generic low level driver that will interact with the
> > > hardware?
> > 
> > Yes and No. Yes, because there are platform drivers that may work with
> > many cards (VESA, VGA16, OF).  You can consider them as generic.
> 
> Are you talking about the vesafb driver? this being  a generic driver,
> Will this driver work on any video card? 

Yep, `VESA' means the vesafb driver. It works on any video card with a VESA 2.0
compliant BIOS.

> If a card is VESA 2.0 complaint, is there a generic framebuffer driver
> that will work on it? 
> 
> I assume VESA 2.0 standards will define hardware registers.

No, it's a BIOS standard. It standardizes how to talk to the BIOS to set a
(linear) graphics mode.

> > However, the hardware specific specific driver will work only with a
> > particular chipset.
> 
> What chages from framebuffer driver to framebuffer driver?
> I think its just hardware accessing.

Yep. But the way you program the graphics chip may differ a lot among different
graphics chips.

> > > What happens when I say startx at command prompt with XF86Config-4
> file
> > > configured for framebuffer driver?
> > >
> > > Is it like, When I say startx with XF86Config-4 file configured for
> > > framebuffer driver, the video we get is a result of X server using
> the
> > > framebuffer driver directly? Right?
> > >
> > 
> > Yes.
> > 
> > > In this case, Is there a video driver involved in getting the video
> > > apart from the framebuffer driver?
> > >
> > 
> > The framebuffer driver itself touches the hardware, and usually it's
> one
> > driver per chipset.  However, the interface that is used by the
> > application
> > is standard.
> 
> Let's make this clearer.
> The video I get after startx is running just on framebuffer driver?
> There is no other video driver involved in the running video.right?

For unaccelerated operation, yes.

If you want hardware accelerated drawing operations, the X server still has to
known how to program the graphics chip. The frame buffer device takes care
about setting the video mode and color palette, and mapping video RAM only.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
