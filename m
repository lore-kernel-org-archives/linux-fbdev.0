From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: scrollmode, accel_flags, fbcon.c ...
Date: Fri, 26 Mar 2004 08:14:35 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403260802590.409@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0403081323040.32244@rosencrantz.theboonies.us>
 <Pine.GSO.4.58.0403091111540.26626@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0403260040100.7037@rosencrantz.theboonies.us>
 <1080267697.3068.24.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6lYD-000612-H6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Mar 2004 23:14:45 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6lYB-0005mV-MH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Mar 2004 23:14:43 -0800
In-Reply-To: <1080267697.3068.24.camel@gaston>
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

On Fri, 26 Mar 2004, Benjamin Herrenschmidt wrote:
> On Fri, 2004-03-26 at 11:14, David Eger wrote:
> > are scrollmode or accel_flags meaningful to anyone here?
> >
> > Paging through fbcon.c, I've realized why the radeonfb driver is still
> > slow -- the accelerated functions are never being called!
> >
> > Hardwiring scrollmode to __SCROLL_YMOVE in updatescrollmode() makes my
> > console go a lot faster :)
>
> Heh, good catch ;)
>
> > So within fbcon.c why is there a "scrollmode" variable which can be set
> > to:  __SCROLL_YWRAP, __SCROLL_YPAN, __SCROLL_YREDRAW, or __SCROLL_YMOVE?
>
> Never been too sure about those. James ?

These are hints for fbcon to use different types of scrolling. Using special
hardware features is usually faster than doing dumb copies.

Examples:
  - Many drivers implement panning in a large virtual screen. This can be used
    to scroll and avoid copying in most copies.
  - With amifb you can not only pan, but also wrap the display by N lines
    (i.e. visible line i = physical line (i+N) % yres).
  - Some frame buffers are very slow to read, so it can be faster to just
    redraw the display instead of copying.

More info in drivers/video/console/fbcon.[ch].

> > Also accel_flags actually useful to anyone?  I see in the fb code some
> > half-hearted attempts to test for FB_ACCELF_TEXT, but it's not clear at
> > all to me where these accel flags are supposed to be set... are they even
> > relevant with the new accel interface?  It seems all this is properly
> > replaced by filling in the fbops to either the driver's custom fillrect()
> > or cfb_fillrect(), no?
>
> I think they are irrelevant, I removed most of the stuff using that
> in radeonfb, it would not work properly. I'm not sure what to do with
> the scrollmode though. I'll have to experiment.

It is (was?) mainly a flag to indicate the fbdev uses and thus owns the accel
engine. Userspace cannot mmap the MMIO registers and use the accel engine
unless it first clears this flag. It can also be used just to disable the accel
engine.

These days it seems like vt_cons[vc->vc_num]->vc_mode == KD_TEXT seems to
indicate the fbdev owns the accel engine, right James?

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
