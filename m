From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 1/5]: logo fix
Date: Sun, 16 Feb 2003 16:40:06 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302161640010.10755-100000@phoenix.infradead.org>
References: <1045393909.1214.2.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kRqM-0005zN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 Feb 2003 08:40:43 -0800
In-Reply-To: <1045393909.1214.2.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Applied.

On 16 Feb 2003, Antonino Daplas wrote:

> On Sun, 2003-02-16 at 14:08, Antonino Daplas wrote:
> > The attached patch (linux-2.5.61 + James' fbdev.diff) fixes the following:
> > 
> > 1. compile error because of missing scripts/pmntologo.  
> > 
> > 2. Break up of fb_show_logo() to fb_prepare_logo()/fb_show_logo() to fix
> > weird "double drawing" or the "single draw, erase in a flash" of the
> > logo.
> > 
> > 3. Fixed all drivers affected by the (image.depth == 0) is color
> > expansion.
> > 
> 
> Here's an incremental diff to protect logo drawing code with an
> #ifdef CONFIG_FB_LOGO
> 
> Tony
> 
> diff -Naur linux-2.5.61-fbdev/drivers/video/fbmem.c linux-2.5.61-ad/drivers/video/fbmem.c
> --- linux-2.5.61-fbdev/drivers/video/fbmem.c	2003-02-16 11:08:40.000000000 +0000
> +++ linux-2.5.61-ad/drivers/video/fbmem.c	2003-02-16 11:08:19.000000000 +0000
> @@ -41,7 +41,6 @@
>  #include <asm/pgtable.h>
>  
>  #include <linux/fb.h>
> -#include <linux/linux_logo.h>
>  
>  #ifdef CONFIG_FRAMEBUFFER_CONSOLE
>  #include "console/fbcon.h"
> @@ -369,6 +368,9 @@
>  	return n < 0 ? d >> -n : d << n;
>  }
>  
> +#ifdef CONFIG_FB_LOGO
> +#include <linux/linux_logo.h>
> +
>  static void __init fb_set_logocmap(struct fb_info *info,
>  				   const struct linux_logo *logo)
>  {
> @@ -656,6 +658,10 @@
>  		kfree(logo_new);
>  	return fb_logo.logo->height;
>  }
> +#else
> +int fb_prepare_logo(struct fb_info *info) { return 0; }
> +int fb_show_logo(struct fb_info *info) { return 0; }
> +#endif /* CONFIG_FB_LOGO */
>  
>  static int fbmem_read_proc(char *buf, char **start, off_t offset,
>  			   int len, int *eof, void *private)
> 
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
