From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: HP300 support checked in
Date: Wed, 14 Jul 2004 10:00:45 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0407140957470.17289@waterleaf.sonytel.be>
References: <1089576608.2555.35.camel@kars.perseus.home>
 <Pine.GSO.4.58.0407120923340.17199@waterleaf.sonytel.be>
 <200407141532.45514.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bkeh9-00020y-4v
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jul 2004 01:00:51 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bkeh8-00069f-Fz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jul 2004 01:00:51 -0700
In-Reply-To: <200407141532.45514.adaplas@hotpop.com>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Kars de Jong <jongk@linux-m68k.org>, Linux/m68k kernel mailing list <linux-m68k@lists.linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 14 Jul 2004, Antonino A. Daplas wrote:
> On Monday 12 July 2004 15:25, Geert Uytterhoeven wrote:
> > On Sun, 11 Jul 2004, Kars de Jong wrote:
> > > Support for <8 bit framebuffers is probably broken. I don't know how I'm
> > > going to support them yet. It used to be "special-cased" in
> > > drivers/video/fbcon.c.
> > >
> > > They are laid out in memory like normal 8 bit chunky framebuffers, but
> > > the upper bits are basically ignored.
> > >
> > > So for blitting purposes the bits_per_pixel == 8 code should be used,
> > > but just setting bits_per_pixel to 8 doesn't work because then the
> > > amount of colours is assumed to be 256.
> > >
> > > I think we basically need to distinguish between bpp and depth.
> >
>
> > What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
> > colors)?
> >
> > If it's just 1 (monochrome), you can probably get away with setting
> > var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).
>
> Or we can use the fields in var->green, var->red, var->blue, ie,  to describe a 4-color
> 8-bit chunky framebuffer:
>
> var->red.length = 2;
> var->red.offset = 0;
> var->green = var->blue = var->red.
> var->bits_per_pixel = 8;

This breaks something different, since for pseudocolor visuals, the *.lengths
indicate the sizes of the CLUT entries (e.g. 8 bit per component for modern
24-bit color, 6 bit for VGA-style 18-bit color).

> We still need to fix fbcon to handle this type of framebuffers, since fbcon always assumes
> a packed pixel format.  For instance, we have this kind of code in fbcon.c
>
> vc->vc_can_do_color = (var->bits_per_pixel != 1) ? 1 : 0;
>
> which is incorrect in this case. Better if we test fix->visual instead.

Yep, that one should test the visual. And in this case greyscale count as color
as well...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
