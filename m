From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: Is framebufer driver a replacement for video
 driver?
Date: Fri, 5 Nov 2004 13:24:11 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0411051317470.15464@waterleaf.sonytel.be>
References: <4EE0CBA31942E547B99B3D4BFAB348111ECB8A@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ38Y-0008Vb-0i
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 04:24:14 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CQ38X-00083c-1j
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 04:24:13 -0800
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348111ECB8A@mail.esn.co.in>
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
> > > Are you talking about the vesafb driver? This being  a generic
> driver,
> > > Will this driver work on any video card?
> > 
> > Yep, `VESA' means the vesafb driver. It works on any video card with a
> > VESA 2.0
> > compliant BIOS.
> 
> If vesafb module works for any card, what are the situations that make
> me write a new framebuffer driver for a new video hardware in the
> market?
>
> Is it like, the vesafb driver does not explore the card to the fullest
> extent? 
> A framebuffer driver specific to Video card is just to explore the card
> features to maximum.

Yes.

Limitations of vesafb:
  - Since the video mode must be changed by calling the BIOS, vesafb cannot
    change the video mode after boot up (the video mode is set just _before_
    the Linux kernel is started).
  - Limited to the video modes (and refresh rates) in the BIOS.
  - No text console acceleration.

A `native' driver removes these limitations.

> Can u please tell me why to call "scr_readw" in accel.c file of riva
> directory doing?

scr_readw() is used to read the data (character value + attributes) for a text
mode character cell from the shadow screen that is used to implement virtual
consoles.

> Also, I found NO readl, writel calls in the riva directory( framebuffer
> driver). Then, who is responsible for accessing the hardware here?

Probably rivafb still accesses the hardware by direct pointer manipulation,
which is not portable.

> > > Let's make this clearer.
> > > The video I get after startx is running just on framebuffer driver?
> > > There is no other video driver involved in the running video.right?
> > 
> > For unaccelerated operation, yes.
> 
> If accelerated operation is needed, then do we need video driver (nv for
> nvidia card) apart from the framebuffer driver to manage the video?

Yes. But I don't know whether nv supports that mode of operation.

> > If you want hardware accelerated drawing operations, the X server
> still
> > has to
> > known how to program the graphics chip. The frame buffer device takes
> care
> > about setting the video mode and color palette, and mapping video RAM
> > only.
> 
> My question in this regard is : 
> Is there a video driver involved apart from the framebuffer driver why I
> get the video from the startx command?
> 
> Ohh, Do u mean, to program the graphics chip in case of accelerated
> operations we need a video driver apart from the framebuufer driver?

You need a chipset-specific driver to issue drawing commands to the
acceleration engine. The frame buffer device provides an abstraction for the
frame buffer (= bunch of memory that represents the screen image) only.

> If so, is framebuffer driver not capable of programming the graphic card
> for accelerated operations?

Indeed. The sole exception is in-kernel accelerated drawing to increase the
emulated text console performance.

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
