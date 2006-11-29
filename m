From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] <linux/fb.h>: Use `unsigned int'
 instead of plain `unsigned'
Date: Wed, 29 Nov 2006 14:30:51 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611291430190.26581@pentafluge.infradead.org>
References: <Pine.LNX.4.62.0611241552130.15930@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GpQSm-0001cQ-JZ for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 29 Nov 2006 06:31:04 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GpQSg-0006Oi-Vu
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 29 Nov 2006 06:31:01 -0800
In-Reply-To: <Pine.LNX.4.62.0611241552130.15930@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


Acked-By: James Simmons <jsimmons@infradead.org>

On Fri, 24 Nov 2006, Geert Uytterhoeven wrote:

> 
> <linux/fb.h>: Use `unsigned int' instead of plain `unsigned'
> 
> Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> ---
>  include/linux/fb.h |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> --- linux.orig/include/linux/fb.h
> +++ linux/include/linux/fb.h
> @@ -581,8 +581,9 @@
>  	int (*fb_set_par)(struct fb_info *info);
>  
>  	/* set color register */
> -	int (*fb_setcolreg)(unsigned regno, unsigned red, unsigned green,
> -			    unsigned blue, unsigned transp, struct fb_info *info);
> +	int (*fb_setcolreg)(unsigned int regno, unsigned int red,
> +			    unsigned int green, unsigned int blue,
> +			    unsigned int transp, struct fb_info *info);
>  
>  	/* set color registers in batch */
>  	int (*fb_setcmap)(struct fb_cmap *cmap, struct fb_info *info);
> @@ -614,8 +615,8 @@
>  			unsigned long arg);
>  
>  	/* Handle 32bit compat ioctl (optional) */
> -	int (*fb_compat_ioctl)(struct fb_info *info, unsigned cmd,
> -			unsigned long arg);
> +	int (*fb_compat_ioctl)(struct fb_info *info, unsigned int cmd,
> +			       unsigned long arg);
>  
>  	/* perform fb specific mmap */
>  	int (*fb_mmap)(struct fb_info *info, struct vm_area_struct *vma);
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
