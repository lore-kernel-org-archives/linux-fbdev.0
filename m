From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [BK PATCHS] fbdev updates.
Date: Tue, 15 Oct 2002 10:00:24 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021015100024.A9771@flint.arm.linux.org.uk>
References: <Pine.GSO.4.21.0210141209590.9580-100000@vervain.sonytel.be> <Pine.LNX.4.33.0210140937040.4264-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 181NZ8-0003QL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Oct 2002 02:00:39 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210140937040.4264-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Mon, Oct 14, 2002 at 09:39:31AM -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Oct 14, 2002 at 09:39:31AM -0700, James Simmons wrote:
>  drivers/video/clps711xfb.c        |    2

Ok, this won't clash with the updates Linus pulled recently from me
that actually allow this driver to build again in 2.5.42.

> diff -Nru a/drivers/video/clps711xfb.c b/drivers/video/clps711xfb.c
> --- a/drivers/video/clps711xfb.c	Mon Oct 14 09:36:34 2002
> +++ b/drivers/video/clps711xfb.c	Mon Oct 14 09:36:34 2002
> @@ -194,7 +194,6 @@
>  	.owner		= THIS_MODULE,
>  	.fb_check_var	= clps7111fb_check_var,
>  	.fb_set_par	= clps7111fb_set_par,
> -	.fb_set_var	= gen_set_var,
>  	.fb_setcolreg	= clps7111fb_setcolreg,
>  	.fb_blank	= clps7111fb_blank,
>  	.fb_fillrect	= cfb_fillrect,
> @@ -322,7 +321,6 @@
>  		clps_writeb(clps_readb(PDDR) | EDB_PD3_LCDBL, PDDR);
>  	}
> 
> -	gen_set_var(&cfb->var, -1, cfb);
>  	err = register_framebuffer(cfb);
> 
>  out:	return err;

I'm not sure this "set var" business has been thought out as much as it
should be.

If can_soft_blank is not set, the driver will never, ever receive any
calls to perform blanking via the fb_blank callback.  Even the power
management blanking calls are blocked, and fbcon clears the screen
instead.  This in itself is fine.

However, since the set_var method has gone, drivers are now unable to
set can_soft_blank according to their capabilities because
fbgen.c:gen_set_disp will do it for them thusly:

        if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
            info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
                display->can_soft_blank = info->fbops->fb_blank ? 1 : 0;
                display->dispsw_data = NULL;
        } else {
                display->can_soft_blank = 0;
                display->dispsw_data = info->pseudo_palette;
        }

This sucks on devices where blanking can be performed by hardware means.
For example, on embedded devices, you can turn off the LCD controller
and LCD panel (and thereby save power).  There's no point in having both
these powered/running when the display is not in use, draining valuable
battery power.

This is also true of most, if not all VGA cards when VESA blanking is in
effect.  As the code currently stands, if the console is in pseudo colour
or direct colour mode, everything works as expected.  However, if it isn't,
you can't even power down your monitor when the screen blanks.

In 2.5.42, there is a work around possible - it is possible to intercept
the call to gen_set_var, and set con_soft_blank according to your driver
capabilities.  However, with the fb_set_var method going away, this is no
longer possible.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
