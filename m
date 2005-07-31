From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/1 2.6.13-rc4] framebuffer: new
 driver for cyberblade/i1 core
Date: Sun, 31 Jul 2005 14:06:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0507311404410.31575@numbat.sonytel.be>
References: <42ECA05F.40401@t-online.de> <42ECBB4D.6020306@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DzCaX-0006Dx-9I
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Jul 2005 05:06:41 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DzCaV-0000M1-NA
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Jul 2005 05:06:41 -0700
In-Reply-To: <42ECBB4D.6020306@gmail.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Knut Petersen <Knut_Petersen@t-online.de>

On Sun, 31 Jul 2005, Antonino A. Daplas wrote:
> Knut Petersen wrote:
> > +    //
> > +    // interlaced modes are broken, fail if one is requested
> > +    //
> > +    if (var->vmode & FB_VMODE_INTERLACED)
> > +        return -EINVAL;
> 
> You are too strict :-)  You can always clear FB_VMODE_INTERLACED and
> return success.  This is acceptable behavior.

I would not try to modify the passed FB_VMODE_* flags.

> > +    //
> > +    // fail if requested resolution is higher than physical
> > +    // flatpanel resolution
> > +    //
> > +    if (flatpanel && nativex && var->xres > nativex)
> > +        return -EINVAL;
> > +
> 
> This is acceptable behavior, but you can always return
> with var->xres = nativex.
> 
> > +    //
> > +    // xres != xres_virtual is broken, fail if such an
> > +    // unusual mode is requested
> > +    //
> > +    if (var->xres != var->xres_virtual)
> > +        return -EINVAL;
> 
> Same here, var->xres = var->xres_virtual.

Only when rounding _up_. Rounding down is not allowed.

> > +    // calc max yres_virtual that would fit in memory
> > +    // and max yres_virtual that could be used for scrolling
> > +    // and use minimum of the results as maxvyres
> > +    //
> > +    // adjust vyres_virtual to maxvyres if necessary
> > +    // fail if requested yres is bigger than maxvyres
> > +    //
> > +    s = (0x1fffff / (var->xres * bpp/8)) + var->yres;
> > +    t = info->fix.smem_len / (var->xres * bpp/8);
> > +    maxvyres = t < s ? t : s;
> > +    if (maxvyres < var->yres_virtual)
> > +        var->yres_virtual=maxvyres;
> > +    if (maxvyres < var->yres)
> > +        return -EINVAL;
> > +
> > +    switch (bpp) {
> > +        case 8:
> > +            var->red.offset = 0;
> > +            var->green.offset = 0;
> > +            var->blue.offset = 0;
> > +            var->red.length = 6;
> > +            var->green.length = 6;
> > +            var->blue.length = 6;
> > +            break;
> > +        case 16:
> > +            var->red.offset = 11;
> > +            var->green.offset = 5;
> > +            var->blue.offset = 0;
> > +            var->red.length = 5;
> > +            var->green.length = 6;
> > +            var->blue.length = 5;
> > +            break;
> > +        case 32:
> > +            var->red.offset = 16;
> > +            var->green.offset = 8;
> > +            var->blue.offset = 0;
> > +            var->red.length = 8;
> > +            var->green.length = 8;
> > +            var->blue.length = 8;
> > +            break;
> > +        default:
> > +            return -EINVAL;
> 	Again, you can always round off bits_per_pixel to
> ones that the driver can support.

Only when rounding _up_.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
