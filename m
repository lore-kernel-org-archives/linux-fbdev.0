From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: fbdev cursor part 1.
Date: Mon, 23 Feb 2004 11:57:27 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0402231156040.14277@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0402222234120.2390-100000@phoenix.infradead.org>
 <1077496550.5960.9.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvDu2-0004LQ-0P
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 03:05:34 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvDmS-0007Sg-OR
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 02:57:44 -0800
In-Reply-To: <1077496550.5960.9.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Alexander Kern <alex.kern@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 23 Feb 2004, Benjamin Herrenschmidt wrote:
> > ment ;-)
> >
> > I plan to submit the latets mach64 driver from BK to linus as soon as the
> > first part of the cursor patch goes in. It gives enough of the new
> > cursor api to do a dump of all the drivers in the 2.5 fbdev tree. Could you
> > make your patch against the fbdev-2.5 bk tree? Try my patch
> >
> > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> >
> > If it doesn't work I will put a new one you there.
>
> Note that I'm having some troubles with James current mach64 bk on a
> wallstreet PowerBook (mach64 LT-G). There is an endian bug in the
> imageblt implementation, I don't know if the chip can be instructed
> to do the endian flip, so I modified the function storing to the
> fifo, that appear to work, at least with 8 bits mode ;)
>
> But I'm having lockups, very regular. I haven't been able to figure
> out why though. Adding a wait_for_idle() at the end of both fillrect
> and copyarea() seem to make them disappear (well, almost, I had _one_
> still once). It's weird as those shouldn't be necessary.
>
> Maybe we should add a timeout on the wait_* functions with an engine
> reset, that would be sub-optimal, but at least we wouldn't lockup the
> box (if that is possible of course).

IIRC, there's a big difference between the number of commands you can queue up
in the RAGE PRO and earlier chip. Perhaps the queue check always assumes a RAGE
PRO?

Hope this helps... (No, I didn't look at the code)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
