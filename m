From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 10/12] fbdev: Static pseudocolor with
 depth less than 4 does exist
Date: Sat, 29 Apr 2006 09:38:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0604290935310.4557@pademelon.sonytel.be>
References: <4452B628.1020001@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZk27-0001tM-Nt
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Apr 2006 00:38:27 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZk27-0002vG-KG
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Apr 2006 00:38:27 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZk26-0001cp-24
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Apr 2006 00:38:27 -0700
In-Reply-To: <4452B628.1020001@gmail.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux/m68k <linux-m68k@vger.kernel.org>

On Sat, 29 Apr 2006, Antonino A. Daplas wrote:
> A static pseudocolor visual with depth less than 4 does exist, so let's
> not accidentally upscale the depth with this configuration

Yes it does, at least on Mac/m68k.

Now the real question is: why doesn't macfb set FB_VISUAL_STATIC_PSEUDOCOLOR if
there's no macfb_setpalette routine?

> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
> 
>  drivers/video/fbmem.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 1cb9acf..19cb4c5 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -432,7 +432,7 @@ int fb_prepare_logo(struct fb_info *info
>  			depth = info->var.green.length;
>  	}
>  
> -	if (info->fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR) {
> +	if (info->fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR && depth > 4) {
>  		/* assume console colormap */
>  		depth = 4;
>  	}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
