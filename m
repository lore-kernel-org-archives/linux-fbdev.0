From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Thu, 22 Apr 2004 10:22:43 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404221010080.23920@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404211903440.9207-100000@phoenix.infradead.org>
 <1082576159.2343.24.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGZUs-0003O5-Cy
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 01:23:50 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGZUr-0000F4-Sa
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 01:23:50 -0700
In-Reply-To: <1082576159.2343.24.camel@localhost.localdomain>
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 22 Apr 2004, Antonino A. Daplas wrote:
> On Thu, 2004-04-22 at 02:13, James Simmons wrote:
> > > > > This is true for PCI/AGP, but may not be true for unified memory systems.
> > > >
> > > > Right, but that confirms my opinion that the choice of the technique used
> > > > shall be under control of the driver
> > >
> > > Agreed. So a hint would be the most appropriate.
> >
> > Hi Antonino. Haven't heard from you in a while.
>
> Yeah, been busy.
>
> > I agree. What if we add to vmode in struct fb_screeninfo.
> > We have
> >
> > FB_VMODE_YWRAP		256
> > FB_VMODE_SMOOTH_XPAN	512
> >
> > We can add more fields. Of course we have to figure out what the common
> > case would be.
> >
>
> We can add:
>
> FB_VMODE_YPAN
> FB_VMODE_REDRAW /* will use imageblit */
> FB_VMODE_MOVE   /* will use copyarea */
>
> Personally, I think FB_VMODE_REDRAW should be the default as it is
> faster than FB_VMODE_MOVE for most PCI cards.
>
> Just to be clear.
>
> 1.  If without a ypan or ywrap, fbcon can either do a redraw or a move
>
> 2.  If with ypan or ywrap, then fbcon can only do a move.
>
> Ypan + redraw (FB_VMODE_MOVE | FB_VMODE_REDRAW) is not supported, and I
> consider this combination to give the fastest and smoothest scrolling
> action if driver does not have any hardware acceleration in most cards.
> Perhaps this can be added?

Perhaps a different approach in announcing these capabilities is more
appropriate? The above is very console-centric. And since it's set by the
fbdev, conceptually it does not belong in fb_var_screeninfo, but in
fb_fix_screeninfo.

What we really want to know here is whether redrawing is faster than copying,
i.e. whether reading from the frame buffer is fast or slow, and whether
fb_copyarea and fb_imageblit are fast or slow.

Right now we have in fb_fix_screeninfo:
  - [xy]panstep, for hardware panning
  - ywrapstep, for hardware ywrap

We can add a capability field with some flags that indicates that
  - fb_copyarea is accelerated or not
  - fb_imageblit is accelerated or not
  - fb_write is much faster than fb_read
(I don't think it matters much to announce an accelerated fb_fillrect, although
 we may want to do that for consistency)

I chose the above so we have reasonable defaults if the capability field is 0.

All other logic can be derived by fbcon from these capabilities, right?

E.g. wrap and pan are always faster than copying, since (usually) they involve
only one register access, while copying is O(n).

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
