From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] radeonfb: screeninfo initialization cleanup
Date: Fri, 29 Oct 2004 20:49:09 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.61.0410292046380.23014@waterleaf.sonytel.be>
References: <200410281712.i9SHCxDe025312@hera.kernel.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNboP-00005o-0A
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Oct 2004 11:49:21 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CNboN-0006n7-55
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Oct 2004 11:49:20 -0700
In-Reply-To: <200410281712.i9SHCxDe025312@hera.kernel.org>
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
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Thu, 28 Oct 2004, Linux Kernel Mailing List wrote:
> ChangeSet 1.2265, 2004/10/28 08:23:51-07:00, penberg@cs.helsinki.fi
> 
> 	[PATCH] radeonfb: screeninfo initialization cleanup
> 	
> 	This patch changes the initialization of radeonfb_default_var to use named
> 	initializers and avoids explicitly setting fields that are automatically
> 	zeroed.

> --- a/drivers/video/aty/radeon_monitor.c	2004-10-28 10:13:09 -07:00
> +++ b/drivers/video/aty/radeon_monitor.c	2004-10-28 10:13:09 -07:00
> @@ -7,10 +7,25 @@
>  #endif /* CONFIG_PPC_OF */
>  
>  static struct fb_var_screeninfo radeonfb_default_var = {
> -        640, 480, 640, 480, 0, 0, 8, 0,
> -        {0, 6, 0}, {0, 6, 0}, {0, 6, 0}, {0, 0, 0},
> -        0, 0, -1, -1, 0, 39721, 40, 24, 32, 11, 96, 2,
> -        0, FB_VMODE_NONINTERLACED
> +	.xres		= 640,
> +	.yres		= 480,
> +	.xres_virtual	= 640,
> +	.yres_virtual	= 480,
> +	.bits_per_pixel = 8,
> +	.red		= { 0, 6, 0 },
                               ^
> +	.green		= { 0, 6, 0 },
                               ^
> +	.blue		= { 0, 6, 0 },
                               ^
Should be 8 these days (256 usable color palette entries).
And why not use `{ .length = 8 }' if you don't care about automatically zeroed
fields?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
