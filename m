From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: 2.6.7 still garbage upon start
Date: Fri, 18 Jun 2004 10:23:23 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406181013340.11779@waterleaf.sonytel.be>
References: <40D21E31.5070904@winischhofer.net> <200406180945.06335.adaplas@hotpop.com>
 <40D29FCD.7020602@winischhofer.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbEen-0005k5-K1
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 01:23:29 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BbEen-0002lp-0S
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 01:23:29 -0700
In-Reply-To: <40D29FCD.7020602@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 18 Jun 2004, Thomas Winischhofer wrote:
> Antonino A. Daplas wrote:
> > On Friday 18 June 2004 06:41, Thomas Winischhofer wrote:
> >> modprobing fbcon still paints a white rectangle. Difference to
> >> 2.6.6 is that this rectangle now fills the entire screen instead of
> >> a smaller area. As before, text is shown all correctly (painted
> >> upon the rectangle), and the white rectangle scrolls up just like
> >> text and in the end vanishes.
> >
> > The white screen is the result of fbdev being initialized before
> > vgacon is deinitialized.  I can't find a simple solution for this
> > except to disable vgacon if fbcon is compiled statically.  Currently
> > vgacon is always enabled in X86, so I use this in
> > drivers/video/console/Kconfig.
> >
> > config VGA_CONSOLE bool "VGA text console" if EMBEDDED || !X86
> > depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC32
> > &&	!SPARC64 && !M68K && FRAMEBUFFER_CONSOLE != y
>
> What the heck does vgacon when being deinitialized? Is it supposed to
> write to video memory at this stage? Granted, I haven't looked at the
> vgacon code but that seems a bit strange.

Lemme give some background: the virtual console subsystem keeps a copy of all
text+attributes (in VGA text mode format) for all VCs. This means that when
using vgacon, you actually have 2 copies of the same data: once in VGA text
memory, and a second copy in the VC subsystem buffers (called the `shadow
screen' when talking about the current VC).

Therefore, when using vgacon, an optimization is made by not always writing to
this `shadow screen' for the current VC, but only to the VGA text memory. And
when a VC switch is made, the `shadow screen' is updated by copying the VGA
text memory to it.

So when you initialize an fbdev (assuming a graphics chip with a VGA core, of
course ;-), there are some issues:
  - You cannot clear the frame buffer memory, since this is also used for the
    VGA text memory, and still contains the valid contents of the current VC,
    which haven't been updated in the `shadow screen' yet.
  - If you don't clear the frame buffer memory, you will see `random garbage',
    because to VGA text data is still there, and is being interpreted in a
    different way now (as graphics data).

Solution: before initializing and switching to a fbdev, save the contents of
the VGA text memory to the `shadow screen', so the fbdev can clear the frame
buffer memory, and fbcon can recover the current VC contents.

However, it makes things more complex and adds a vgacon dependency to some
code, since you want it to behave differently if people don't compile in
vgacon.

Final solution: VGA is obsolete ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
