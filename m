From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: scrollmode, accel_flags, fbcon.c ...
Date: Sun, 28 Mar 2004 10:16:04 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403281014010.364@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0403081323040.32244@rosencrantz.theboonies.us>
 <Pine.GSO.4.58.0403091111540.26626@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0403260040100.7037@rosencrantz.theboonies.us>
 <1080267697.3068.24.camel@gaston> <Pine.GSO.4.58.0403260802590.409@waterleaf.sonytel.be>
 <1080312167.1390.19.camel@gaston> <Pine.GSO.4.58.0403261600580.409@waterleaf.sonytel.be>
 <1080350682.1333.59.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7VSm-00089D-J0
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 28 Mar 2004 00:16:12 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7VSl-00085v-Lo
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 28 Mar 2004 00:16:11 -0800
In-Reply-To: <1080350682.1333.59.camel@gaston>
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
> > W.r.t. redraw vs. copy for scrolling, perhaps some heuristics like PCI/AGP are
> > known to be slow for reading? Fbcon can find out whether a fbdev is on a
> > PCI/AGP bus by checking the device (once new driver model/sysfsication is
> > complete), right?
>
> But an fbdev that implements an accelerated copyarea ?
>
> I don't want such heuristics in fbcon, they are just asking for trouble,
> I think we should redraw on non-accelerated and copy on accelerated,

You mean, if ywrap/ypan is not available/not possible (e.g. partial screen
scrolls)? Yes, that makes sense.

> but then, it should be under more direct driver control. Also, fbcon

Which means additional flags to fb_fix_screeninfo...

> keeps "losing" the accel_flags for me.
>
> One thing I don't like in the new fbcon is the way it deals with the
> var structure anyway. I think it should have one var per VC.

I agree.

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
