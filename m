From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] atafb: test virtual screen range
 before subtraction on unsigned
Date: Thu, 24 Apr 2008 23:05:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804242304310.21224@anakin>
References: <480F6FF9.9000605@tiscali.nl> <480F8522.4090805@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jp8dq-0004VH-RV for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 24 Apr 2008 14:06:06 -0700
Received: from wilson.telenet-ops.be ([195.130.132.42])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jp8dp-0003tj-1S
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 24 Apr 2008 14:06:06 -0700
In-Reply-To: <480F8522.4090805@tiscali.nl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Roel Kluin <12o3l@tiscali.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>, adaplas@gmail.com

On Wed, 23 Apr 2008, Roel Kluin wrote:
> a bit similar to vga16fb,
> ---
> dx and dy are u32's, so the test should occur before the subtraction

Note that fb_copyarea.d[xy] are also u32, while there are many tests
that check for these fields being negative.

> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---
> diff --git a/drivers/video/atafb.c b/drivers/video/atafb.c
> index 5d4fbaa..8f60a8f 100644
> --- a/drivers/video/atafb.c
> +++ b/drivers/video/atafb.c
> @@ -2593,13 +2593,16 @@ static void atafb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
>  	width = x2 - dx;
>  	height = y2 - dy;
>  
> +	if (area->sx + dx < area->dx || area->sy + dy < area->dy)
> +		return;
> +
>  	/* update sx,sy */
>  	sx = area->sx + (dx - area->dx);
>  	sy = area->sy + (dy - area->dy);
>  
>  	/* the source must be completely inside the virtual screen */
> -	if (sx < 0 || sy < 0 || (sx + width) > info->var.xres_virtual ||
> -	    (sy + height) > info->var.yres_virtual)
> +	if (sx + width > info->var.xres_virtual ||
> +			sy + height > info->var.yres_virtual)
>  		return;
>  
>  	if (dy > sy || (dy == sy && dx > sx)) {
> 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
