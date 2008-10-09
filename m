From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] framebuffer: fix carminefb section
 mismatch
Date: Thu, 9 Oct 2008 09:29:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0810090927350.6769@anakin>
References: <48ED2431.40609@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@linux-m68k.org>) id 1Knpxm-0000vM-32
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 09 Oct 2008 07:29:34 +0000
Received: from wilson.telenet-ops.be ([195.130.132.42])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KnpxV-0004eH-6i for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 09 Oct 2008 07:29:34 +0000
In-Reply-To: <48ED2431.40609@oracle.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: akpm <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, Sebastian Siewior <bigeasy@linutronix.de>

On Wed, 8 Oct 2008, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Could fix a dangerous problem since
> 	info->fix = carminefb_fix;
> and info->fix can be used at any time later (in carmine_set_par()).

This is a full copy of the contents, not a pointer to the original.

> WARNING: drivers/video/carminefb.o(.text+0x81b): Section mismatch in reference from the function alloc_carmine_fb() to the variable .devinit.data:carminefb_fix
> The function alloc_carmine_fb() references
> the variable __devinitdata carminefb_fix.
> This is often because alloc_carmine_fb lacks a __devinitdata 
> annotation or the annotation of carminefb_fix is wrong.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> cc: Sebastian Siewior <bigeasy@linutronix.de>
> ---
>  drivers/video/carminefb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lin2627-r9g1-sections.orig/drivers/video/carminefb.c
> +++ lin2627-r9g1-sections/drivers/video/carminefb.c
> @@ -76,7 +76,7 @@ struct carmine_fb {
>  	u32 pseudo_palette[16];
>  };
>  
> -static struct fb_fix_screeninfo carminefb_fix __devinitdata = {
> +static struct fb_fix_screeninfo carminefb_fix = {
>  	.id = "Carmine",
>  	.type = FB_TYPE_PACKED_PIXELS,
>  	.visual = FB_VISUAL_TRUECOLOR,

alloc_carmine_fb() should be __devinit instead?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
