From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: scrollmode, accel_flags, fbcon.c ...
Date: Fri, 26 Mar 2004 16:03:25 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403261600580.409@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0403081323040.32244@rosencrantz.theboonies.us>
 <Pine.GSO.4.58.0403091111540.26626@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0403260040100.7037@rosencrantz.theboonies.us>
 <1080267697.3068.24.camel@gaston> <Pine.GSO.4.58.0403260802590.409@waterleaf.sonytel.be>
 <1080312167.1390.19.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6srp-0002wW-64
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Mar 2004 07:03:29 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B6sro-0004TW-Df
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Mar 2004 07:03:28 -0800
In-Reply-To: <1080312167.1390.19.camel@gaston>
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
Cc: David Eger <eger-dated-1080865620.ef4dea@theboonies.us>, Jakub Jelinek <jj@ultra.linux.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 27 Mar 2004, Benjamin Herrenschmidt wrote:
> > These are hints for fbcon to use different types of scrolling. Using special
> > hardware features is usually faster than doing dumb copies.
>
> Yes, that all make sense, but there isn't a simple way for the fbdev
> to set that now in 2.6 since it's in struct display which is now local
> to fbcon. fbcon itself will initialize that to some value picked based
> on the default var accel flags but I don't like that, espeically since
> I think those flags should be deprecated.

Ywrap/ypan capabilities are announced in fb_fix_screeninfo, so fbcon knows.

W.r.t. redraw vs. copy for scrolling, perhaps some heuristics like PCI/AGP are
known to be slow for reading? Fbcon can find out whether a fbdev is on a
PCI/AGP bus by checking the device (once new driver model/sysfsication is
complete), right?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
